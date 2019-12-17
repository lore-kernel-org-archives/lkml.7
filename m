Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF2BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F44F21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLQXgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfLQXgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 18:36:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950842176D;
        Tue, 17 Dec 2019 23:36:43 +0000 (UTC)
Date:   Tue, 17 Dec 2019 18:36:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: ftrace trace_raw_pipe format
Message-ID: <20191217183641.1729b821@gandalf.local.home>
In-Reply-To: <20191217173403.61f4e2d8@gandalf.local.home>
References: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
        <20191217173403.61f4e2d8@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/RQsfmPIZXzeywzjN1kZBs1x"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/RQsfmPIZXzeywzjN1kZBs1x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 17 Dec 2019 17:34:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> static void read_raw_buffer(int i, const char *buffer)
> {
> 	struct trace_seq s;
> 	char buf[page_size];
> 	int fd;
> 	int r;
> 
> 	printf("Parsing CPU %d buffer\n", i);
> 
> 	fd = open(buffer, O_RDONLY);
> 	if (fd < 0)
> 		pdie("Failed to open %s", buffer);
> 
> 	while ((r = read(fd, buf, page_size)) > 0) {
> 		kbuffer_load_subbuffer(kbuf, buf);
> 
> 		for (;;) {
> 			struct tep_record record;
> 
> 			record.data = kbuffer_read_event(kbuf, &record.ts);
> 			if (!record.data)
> 				break;
> 			kbuffer_next_event(kbuf, NULL);
> 

Also note, once you are here, you don't need to use the
tep_print_event() to print out the fields of record. You can also
extract the data from the event directly. Or you could register a
handler that will get called via the tep_print_event().

Attached is a new version that has some fixes as well as adds its own
sched_switch handler.

-- Steve


> 			trace_seq_init(&s);
> 			tep_print_event(tep, &s, &record,
> 					"%s-%d %9d\t%s: %s\n",
> 					TEP_PRINT_COMM,
> 					TEP_PRINT_PID,
> 					TEP_PRINT_TIME,
> 					TEP_PRINT_NAME,
> 					TEP_PRINT_INFO);
> 			trace_seq_do_printf(&s);
> 		}
> 	}
> 
> 	close(fd);
> }


--MP_/RQsfmPIZXzeywzjN1kZBs1x
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=read-trace-pipe-raw.c

// SPDX-License-Identifier: LGPL-2.1
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/mount.h>
#include <traceevent/event-parse.h>
#include <traceevent/kbuffer.h>
#include <traceevent/trace-seq.h>

struct tep_handle *tep;
struct kbuffer *kbuf;
static int page_size;

#define __weak __attribute__((weak))
#define __noreturn __attribute__((noreturn))

#define TRACEFS_PATH "/sys/kernel/tracing"

#define _STR(x) #x
#define STR(x) _STR(x)

static int ignore_warning;

void warning(const char *fmt, ...)
{
	va_list ap;

	if (ignore_warning)
		return;

	va_start(ap, fmt);
	fprintf(stderr, "Warning:  ");
	vfprintf(stderr, fmt, ap);
	va_end(ap);

	fprintf(stderr, "\n");
}

void __noreturn __vdie(const char *fmt, va_list ap)
{
	int ret = errno ? errno : -1;

	fprintf(stderr, "Error:  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void __noreturn __die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap);
	va_end(ap);
}

void __weak __noreturn die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap);
	va_end(ap);
}

void __weak __noreturn pdie(const char *fmt, ...)
{
	va_list ap;

	if (errno)
		perror("read-trace-pipe-raw");

	va_start(ap, fmt);
	__vdie(fmt, ap);
	va_end(ap);
}

static int mount_tracefs(void)
{
	struct stat st;
	int ret;

	/* make sure debugfs exists */
	ret = stat(TRACEFS_PATH, &st);
	if (ret < 0)
		return -1;

	ret = mount("nodev", TRACEFS_PATH,
		    "tracefs", 0, NULL);

	return ret;
}

static char *find_tracing_dir(void)
{
	char fspath[PATH_MAX+1];
	char *tracing_dir;
	char type[100];
	FILE *fp;

	if ((fp = fopen("/proc/mounts","r")) == NULL) {
		warning("Can't open /proc/mounts for read");
		return NULL;
	}

	while (fscanf(fp, "%*s %"
		      STR(PATH_MAX)
		      "s %99s %*s %*d %*d\n",
		      fspath, type) == 2) {
		if (strcmp(type, "tracefs") == 0)
			break;
	}
	fclose(fp);

	if (strcmp(type, "tracefs") != 0) {
		if (mount_tracefs() < 0) {
			warning("tracefs not mounted, please mount");
			return NULL;
		} else
			strcpy(fspath, TRACEFS_PATH);
	}
	tracing_dir = strdup(fspath);
	if (!tracing_dir)
		return NULL;

	return tracing_dir;
}

static char *read_file(const char *file, size_t *file_size)
{
	char *line;
	char *buf = NULL;
	FILE *fp;
	size_t len = 0;
	size_t size = 0;
	int s;
	int ret;

	fp = fopen(file, "r");
	if (!fp)
		die("Could not open %s to read", file);

	while ((ret = getline(&line, &len, fp)) > 0) {
		s = strlen(line);
		buf = realloc(buf, size + s + 1);
		if (!buf)
			pdie("Allocating memory to read %s\n", file);
		strcpy(buf + size, line);
		size += s;
	}
	free(line);
	fclose(fp);

	*file_size = size;
	return buf;
}

static void load_format(const char *system, const char *format)
{
	size_t size;
	char *buf = read_file(format, &size);

	ignore_warning = 1;
	tep_parse_event(tep, buf, size, system);
	ignore_warning = 0;
	free(buf);
}

static void read_event(const char *system, const char *event)
{
	struct stat st;
	char *format;
	int ret;

	ret = asprintf(&format, "%s/format", event);
	if (ret < 0)
		pdie("Could not allocate memory for %s format\n", event);

	ret = stat(format, &st);
	if (ret < 0 /* ? */ || !S_ISREG(st.st_mode))
		return;

	load_format(system, format);
	free(format);
}

static void read_system(const char *system, const char *system_path)
{
	struct dirent *dent;
	struct stat st;
	DIR *dir;
	int ret;

	dir = opendir(system_path);
	if (!dir)
		pdie("Can't read directory '%s'", system_path);

	while ((dent = readdir(dir))) {
		char *event;

		if (strcmp(dent->d_name, ".") == 0 ||
		    strcmp(dent->d_name, "..") == 0)
			continue;

		ret = asprintf(&event, "%s/%s", system_path, dent->d_name);
		if (ret < 0)
			pdie("could not allocate memory for event name %s\n",
			     dent->d_name);
		ret = stat(event, &st);
		if (ret < 0 /* ? */ || !S_ISDIR(st.st_mode))
			continue;

		read_event(system, event);
		free(event);
	}
}

static void read_raw_buffer(int i, const char *buffer)
{
	struct trace_seq s;
	char buf[page_size];
	int fd;
	int r;

	printf("Parsing CPU %d buffer\n", i);

	fd = open(buffer, O_RDONLY|O_NONBLOCK);
	if (fd < 0)
		pdie("Failed to open %s", buffer);

	while ((r = read(fd, buf, page_size)) > 0) {
		kbuffer_load_subbuffer(kbuf, buf);

		for (;;) {
			struct tep_record record;

			record.data = kbuffer_read_event(kbuf, &record.ts);
			if (!record.data)
				break;
			kbuffer_next_event(kbuf, NULL);

			trace_seq_init(&s);
			tep_print_event(tep, &s, &record,
					"%s-%d %9d\t%s: %s\n",
					TEP_PRINT_COMM,
					TEP_PRINT_PID,
					TEP_PRINT_TIME,
					TEP_PRINT_NAME,
					TEP_PRINT_INFO);
			trace_seq_do_printf(&s);
		}
	}

	close(fd);
}

static void load_cmdlines(const char *cmdlines)
{
	FILE *fp;
	char *line = NULL;
	size_t len = 0;
	char comm[1024];
	int pid;
	int ret;

	printf("read %s\n", cmdlines);
	fp = fopen(cmdlines, "r");
	if (!fp)
		pdie("Opening %s", cmdlines);

	while ((ret = getline(&line, &len, fp)) > 0) {
		if (sscanf(line, "%d %1024s", &pid, comm) == 2)
			tep_register_comm(tep, comm, pid);
	}

	free(line);
	fclose(fp);
}

static void write_state(struct trace_seq *s, int val)
{
	const char states[] = "SDTtZXxW";
	int found = 0;
	int i;

	for (i=0; i < (sizeof(states) - 1); i++) {
		if (!(val & (1 << i)))
			continue;

		if (found)
			trace_seq_putc(s, '|');

		found = 1;
		trace_seq_putc(s, states[i]);
	}

	if (!found)
		trace_seq_putc(s, 'R');
}

static void write_and_save_comm(struct tep_format_field *field,
				struct tep_record *record,
				struct trace_seq *s, int pid)
{
	const char *comm;
	int len;

	comm = (char *)(record->data + field->offset);
	len = s->len;
	trace_seq_printf(s, "%.*s",
			 field->size, comm);

	/* make sure the comm has a \0 at the end. */
	trace_seq_terminate(s);
	comm = &s->buffer[len];

	/* Help out the comm to ids. This will handle dups */
	tep_register_comm(field->event->tep, comm, pid);
}

static int my_sched_switch(struct trace_seq *s, struct tep_record *record,
			   struct tep_event *event, void *context)
{
	struct tep_format_field *field;
	unsigned long long val;

	if (tep_get_field_val(s, event, "prev_pid", record, &val, 1))
		return trace_seq_putc(s, '!');

	field = tep_find_any_field(event, "prev_comm");
	if (field) {
		write_and_save_comm(field, record, s, val);
		trace_seq_putc(s, ':');
	}
	trace_seq_printf(s, "%lld ", val);

	if (tep_get_field_val(s, event, "prev_prio", record, &val, 0) == 0)
		trace_seq_printf(s, "[%lld] ", val);

	if (tep_get_field_val(s,  event, "prev_state", record, &val, 0) == 0)
		write_state(s, val);

	trace_seq_puts(s, " ==> ");

	if (tep_get_field_val(s, event, "next_pid", record, &val, 1))
		return trace_seq_putc(s, '!');

	field = tep_find_any_field(event, "next_comm");
	if (field) {
		write_and_save_comm(field, record, s, val);
		trace_seq_putc(s, ':');
	}
	trace_seq_printf(s, "%lld", val);

	if (tep_get_field_val(s, event, "next_prio", record, &val, 0) == 0)
		trace_seq_printf(s, " [%lld]", val);

	return 0;
}

int main(int argc, char *argv[])
{
	char *tracefs = find_tracing_dir();
	enum kbuffer_long_size lsize;
	enum kbuffer_endian endian;
	struct dirent *dent;
	struct stat st;
	size_t size;
	char *header_page;
	char *per_cpu;
	char *events;
	char *comms;
	char *buf;
	DIR *dir;
	int ret;
	int i;

	page_size = getpagesize();

	if (!tracefs)
		die("Can not find tracefs");

	tep = tep_alloc();
	if (!tep)
		pdie("Could not allocate tep handle");

	lsize = sizeof(long) == 4 ? KBUFFER_LSIZE_4 : KBUFFER_LSIZE_8;
	endian = tep_is_bigendian() ? KBUFFER_ENDIAN_BIG : KBUFFER_ENDIAN_LITTLE;

	kbuf = kbuffer_alloc(lsize, endian);
	if (!kbuf)
		pdie("Could not allocate kbuffer handle");

	ret = asprintf(&comms, "%s/saved_cmdlines", tracefs);
	if (ret < 0)
		pdie("Could not allocate saved_cmdlines path name");

	load_cmdlines(comms);
	free(comms);

	ret = asprintf(&events, "%s/events", tracefs);
	if (ret < 0)
		pdie("Could not allocate memory for events path");

	ret = asprintf(&header_page, "%s/header_page", events);
	if (ret < 0)
		pdie("Could not allocate memory for header page");

	buf = read_file(header_page, &size);
	tep_parse_header_page(tep, buf, size, sizeof(long));
	free(header_page);

	dir = opendir(events);
	if (!dir)
		pdie("Can't read directory '%s'", events);

	while ((dent = readdir(dir))) {
		char *system;

		if (strcmp(dent->d_name, ".") == 0 ||
		    strcmp(dent->d_name, "..") == 0)
			continue;

		ret = asprintf(&system, "%s/%s", events, dent->d_name);
		if (ret < 0)
			pdie("could not allocate memory for system name %s\n",
			     dent->d_name);
		ret = stat(system, &st);
		if (ret < 0 /* ? */ || !S_ISDIR(st.st_mode))
			continue;

		read_system(dent->d_name, system);
		free(system);
	}
	closedir(dir);
	free(events);

	ret = tep_register_event_handler(tep, -1, "sched", "sched_switch",
				   my_sched_switch, NULL);
	if (ret < 0)
		die("register event handle?");

	asprintf(&per_cpu, "%s/per_cpu", tracefs);
	if (!per_cpu)
		pdie("Could not allocate memory for per_cpu path");

	for (i = 0; ; i++) {
		char *raw_buf;
		char *cpu;

		ret = asprintf(&cpu, "%s/cpu%d", per_cpu, i);
		if (ret < 0)
			pdie("Could not allocate memory for cpu buffer %d name", i);

		ret = stat(cpu, &st);
		if (ret < 0 || !S_ISDIR(st.st_mode))
			break;

		ret = asprintf(&raw_buf, "%s/trace_pipe_raw", cpu);
		if (ret < 0)
			pdie("Could not allocate memory for cpu %d raw buffer name", i);

		read_raw_buffer(i, raw_buf);
		free(raw_buf);
		free(cpu);
	}
	free(per_cpu);
}

--MP_/RQsfmPIZXzeywzjN1kZBs1x--
