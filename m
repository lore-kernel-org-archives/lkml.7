Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2DFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242DE2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLQWeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfLQWeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:34:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47A921582;
        Tue, 17 Dec 2019 22:34:05 +0000 (UTC)
Date:   Tue, 17 Dec 2019 17:34:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: ftrace trace_raw_pipe format
Message-ID: <20191217173403.61f4e2d8@gandalf.local.home>
In-Reply-To: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
References: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/3h3h=_Tt4nYu/iqRNCVGTR0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/3h3h=_Tt4nYu/iqRNCVGTR0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 17 Dec 2019 17:44:40 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> I'm trying to 'grok' the trace_raw_pipe data that ftrace generates.
> I've some 3rd party code that post-processes it, but doesn't like wrapped traces
> because (I think) the traces from different cpus start at different times.
> 
> I can't seem to find any documentation at all...
> 
> I can find the format of the trace entries (I only need the length) from the 'format' files.
> There seems to be 4 bytes between the entries that looks like a time difference.
> I presume this is the interval before the trace item that follows.
> (There is a time-delta of 1 before the first entry.)
> 
> The overall file seems to be a series of 4k blocks.
> All but the first have a 16 byte header (possibly) described by 'header_page'
> that has a timestamp and length (and a sign extended flag).
> 
> The first 4k page is confusing me.
> The first 8 bytes might be the time the actual trace started.
> The next 8 contain a length (short for a wrapped trace).
> I've no idea what the next 8 are, they look like count of something.
> 
> Given that I've stopped tracing before reading the files I'd
> expect the last buffer to be the partial one, not the first.
> I'm also pretty sure the partial block contains the last trace data
> (it seems to refer to the shell script sleep used to time the trace.)
> 
> I did find some old mailing list messages about these files being
> corrupt - but that was about the time the splice code was
> added to read them out - best part of 10 years ago.
> 
> If I can sort the headers for the 4k block (and reorder them??),
> then delete entries so the start times match I should be able to
> make the post-processing code work.
>

You may want to use libtraceevent (which will, hopefully, soon
be in debian!). Attached is a simple program that reads the data using
it and prints out the format.

I should add this file to the libtraceevent source code, which is found
in the Linux kernel source under tools/lib/traceevent. To build this,
use:

 $ cd linux.git/tools/lib/traceevent
 $ make
 $ sudo make install
 $ cd to-path-of-attached-file
 $ gcc -g -Wall read-trace-pipe-raw.c -o read-trace-pipe-raw -ltraceevent -ldl

Now you may need to add the path of libtraceevent into /etc/ld.so.conf
and run ldconfig to get it to work.

Let me know if this helps.

Note, this tool requires there to be data in the ring buffers (all of
them, as it will block on the first empty buffer). I just wrote this
for sample code. I'll fix this blocking and also add more comments for
when I add this to the source code.

-- Steve

--MP_/3h3h=_Tt4nYu/iqRNCVGTR0
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=read-trace-pipe-raw.c

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

static void load_format(const char *system, const char *format)
{
	char *line;
	char *buf = NULL;
	FILE *fp;
	size_t len = 0;
	size_t size = 0;
	int s;
	int ret;

	fp = fopen(format, "r");
	if (!fp)
		die("Could not open %s to read", format);

	while ((ret = getline(&line, &len, fp)) > 0) {
		s = strlen(line);
		buf = realloc(buf, size + s + 1);
		if (!buf)
			pdie("Allocating memory to read %s\n", format);
		strcpy(buf + size, line);
		size += s;
	}
	free(line);
	ignore_warning = 1;
	tep_parse_event(tep, buf, size, system);
	ignore_warning = 0;
	free(buf);
	fclose(fp);
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

static void read_system(const char *system)
{
	struct dirent *dent;
	struct stat st;
	DIR *dir;
	int ret;

	dir = opendir(system);
	if (!dir)
		pdie("Can't read directory '%s'", system);

	while ((dent = readdir(dir))) {
		char *event;

		if (strcmp(dent->d_name, ".") == 0 ||
		    strcmp(dent->d_name, "..") == 0)
			continue;

		ret = asprintf(&event, "%s/%s", system, dent->d_name);
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

	fd = open(buffer, O_RDONLY);
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

int main(int argc, char *argv[])
{
	char *tracefs = find_tracing_dir();
	enum kbuffer_long_size lsize;
	enum kbuffer_endian endian;
	struct dirent *dent;
	struct stat st;
	char *per_cpu;
	char *events;
	char *comms;
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

		read_system(system);
		free(system);
	}
	closedir(dir);
	free(events);

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

--MP_/3h3h=_Tt4nYu/iqRNCVGTR0--
