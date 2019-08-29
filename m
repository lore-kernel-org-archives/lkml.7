Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2411C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEE5233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089696;
	bh=OkGdYQ+jb6Urbgx1I+LLHkVZvdQaVelXMNy0Rd3ZAAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rsGCeJh4TI/vZ9NlsX66TtbOXFcRc0WydYoSctgLnvpYtjjmDlZfPr02QnFD245qJ
	 Sgo6zomEztReOvHcnOrceGkj1xUzI+H+bcR81AfhjA60UZWt7HVlDnZCKq00/2srYt
	 70J6DWirLIgvEBB0MP/xBm6p6dFA/miD7dl9BTcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfH2Ole (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbfH2Olb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248C123407;
        Thu, 29 Aug 2019 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089690;
        bh=OkGdYQ+jb6Urbgx1I+LLHkVZvdQaVelXMNy0Rd3ZAAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlxL/LDN3gS8V3snTV0c9EIs0zduD0i0esGkSI22RT8d0ZSraYLW99lmg0rRVqwPe
         iMs3/dbgAsPQHwC4Kqvw+wW4nHhlIo/OZASLERTtzjYa3JODBAAHNTChI2172j+1ga
         EBiW3Zfr9+LxnqI3zI9P64qzsPQgan0OU0A1E99M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Karl Rister <krister@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 35/37] perf evlist: Use unshare(CLONE_FS) in sb threads to let setns(CLONE_NEWNS) work
Date:   Thu, 29 Aug 2019 11:39:15 -0300
Message-Id: <20190829143917.29745-36-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we started using a thread to catch the PERF_RECORD_BPF_EVENT meta
data events to then ask the kernel for further info (BTF, etc) for BPF
programs shortly after they get loaded, we forgot to use
unshare(CLONE_FS) as was done in:

  868a832918f6 ("perf top: Support lookup of symbols in other mount namespaces.")

Do it so that we can enter the namespaces to read the build-ids at the
end of a 'perf record' session for the DSOs that had hits.

Before:

Starting a 'stress-ng --cpus 8' inside a container and then, outside the
container running:

  # perf record -a --namespaces sleep 5
  # perf buildid-list | grep stress-ng
  #

We would end up with a 'perf.data' file that had no entry in its
build-id table for the /usr/bin/stress-ng binary inside the container
that got tons of PERF_RECORD_SAMPLEs.

After:

  # perf buildid-list | grep stress-ng
  f2ed02c68341183a124b9b0f6e2e6c493c465b29 /usr/bin/stress-ng
  #

Then its just a matter of making sure that that binary debuginfo package
gets available in a place that 'perf report' will look at build-id keyed
ELF files, which, in my case, on a f30 notebook, was a matter of
installing the debuginfo file for the distro used in the container,
fedora 31:

  # rpm -ivh http://fedora.c3sl.ufpr.br/linux/development/31/Everything/x86_64/debug/tree/Packages/s/stress-ng-debuginfo-0.07.29-10.fc31.x86_64.rpm

Then, because perf currently looks for those debuginfo files (richer ELF
symtab) inside that namespace (look at the setns calls):

  openat(AT_FDCWD, "/proc/self/ns/mnt", O_RDONLY) = 137
  openat(AT_FDCWD, "/proc/13169/ns/mnt", O_RDONLY) = 139
  setns(139, CLONE_NEWNS)                 = 0
  stat("/usr/bin/stress-ng", {st_mode=S_IFREG|0755, st_size=3065416, ...}) = 0
  openat(AT_FDCWD, "/usr/bin/stress-ng", O_RDONLY) = 140
  fcntl(140, F_GETFD)                     = 0
  fstat(140, {st_mode=S_IFREG|0755, st_size=3065416, ...}) = 0
  mmap(NULL, 3065416, PROT_READ, MAP_PRIVATE, 140, 0) = 0x7ff2fdc5b000
  munmap(0x7ff2fdc5b000, 3065416)         = 0
  close(140)                              = 0
  stat("stress-ng-0.07.29-10.fc31.x86_64.debug", 0x7fff45d71260) = -1 ENOENT (No such file or directory)
  stat("/usr/bin/stress-ng-0.07.29-10.fc31.x86_64.debug", 0x7fff45d71260) = -1 ENOENT (No such file or directory)
  stat("/usr/bin/.debug/stress-ng-0.07.29-10.fc31.x86_64.debug", 0x7fff45d71260) = -1 ENOENT (No such file or directory)
  stat("/usr/lib/debug/usr/bin/stress-ng-0.07.29-10.fc31.x86_64.debug", 0x7fff45d71260) = -1 ENOENT (No such file or directory)
  stat("/root/.debug/.build-id/f2/ed02c68341183a124b9b0f6e2e6c493c465b29", 0x7fff45d711e0) = -1 ENOENT (No such file or directory)

To only then go back to the "host" namespace to look just in the users's
~/.debug cache:

  setns(137, CLONE_NEWNS)                 = 0
  chdir("/root")                          = 0
  close(137)                              = 0
  close(139)                              = 0
  stat("/root/.debug/.build-id/f2/ed02c68341183a124b9b0f6e2e6c493c465b29/elf", 0x7fff45d732e0) = -1 ENOENT (No such file or directory)

It continues to fail to resolve symbols:

  # perf report | grep stress-ng | head -5
     9.50%  stress-ng-cpu    stress-ng    [.] 0x0000000000021ac1
     8.58%  stress-ng-cpu    stress-ng    [.] 0x0000000000021ab4
     8.51%  stress-ng-cpu    stress-ng    [.] 0x0000000000021489
     7.17%  stress-ng-cpu    stress-ng    [.] 0x00000000000219b6
     3.93%  stress-ng-cpu    stress-ng    [.] 0x0000000000021478
  #

To overcome that we use:

  # perf buildid-cache -v --add /usr/lib/debug/usr/bin/stress-ng-0.07.29-10.fc31.x86_64.debug
  Adding f2ed02c68341183a124b9b0f6e2e6c493c465b29 /usr/lib/debug/usr/bin/stress-ng-0.07.29-10.fc31.x86_64.debug: Ok
  #
  # ls -la /root/.debug/.build-id/f2/ed02c68341183a124b9b0f6e2e6c493c465b29/elf
  -rw-r--r--. 3 root root 2401184 Jul 27 07:03 /root/.debug/.build-id/f2/ed02c68341183a124b9b0f6e2e6c493c465b29/elf
  # file /root/.debug/.build-id/f2/ed02c68341183a124b9b0f6e2e6c493c465b29/elf
  /root/.debug/.build-id/f2/ed02c68341183a124b9b0f6e2e6c493c465b29/elf: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter \004, BuildID[sha1]=f2ed02c68341183a124b9b0f6e2e6c493c465b29, for GNU/Linux 3.2.0, with debug_info, not stripped, too many notes (256)
  #

Now it finally works:

  # perf report | grep stress-ng | head -5
    23.59%  stress-ng-cpu    stress-ng    [.] ackermann
    23.33%  stress-ng-cpu    stress-ng    [.] is_prime
    17.36%  stress-ng-cpu    stress-ng    [.] stress_cpu_sieve
     6.08%  stress-ng-cpu    stress-ng    [.] stress_cpu_correlate
     3.55%  stress-ng-cpu    stress-ng    [.] queens_try
  #

I'll make sure that it looks for the build-id keyed files in both the
"host" namespace (the namespace the user running 'perf record' was a the
time of the recording) and in the container namespace, as it shouldn't
matter where a content based key lookup finds the ELF file to use in
resolving symbols, etc.

Reported-by: Karl Rister <krister@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
Link: https://lkml.kernel.org/n/tip-g79k0jz41adiaeuqud742t2l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5ad92fa72e78..253dd8dd0e12 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -21,6 +21,7 @@
 #include "bpf-event.h"
 #include <signal.h>
 #include <unistd.h>
+#include <sched.h>
 
 #include "parse-events.h"
 #include <subcmd/parse-options.h>
@@ -1824,6 +1825,14 @@ static void *perf_evlist__poll_thread(void *arg)
 	struct evlist *evlist = arg;
 	bool draining = false;
 	int i, done = 0;
+	/*
+	 * In order to read symbols from other namespaces perf to needs to call
+	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
+	 * unshare(2) the fs so that we may continue to setns into namespaces
+	 * that we're observing when, for instance, reading the build-ids at
+	 * the end of a 'perf record' session.
+	 */
+	unshare(CLONE_FS);
 
 	while (!done) {
 		bool got_data = false;
-- 
2.21.0

