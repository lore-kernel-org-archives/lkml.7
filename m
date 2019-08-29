Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C0EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B50722CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfH2TCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51572 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbfH2TCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgO-0005Hg-3E; Thu, 29 Aug 2019 21:02:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CCAAA1C0DE8;
        Thu, 29 Aug 2019 21:02:02 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:02:02 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Use unshare(CLONE_FS) in sb threads to
 let setns(CLONE_NEWNS) work
Cc:     Karl Rister <krister@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        "Thomas-Mich Richter" <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-g79k0jz41adiaeuqud742t2l@git.kernel.org>
References: <tip-g79k0jz41adiaeuqud742t2l@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156710532273.10613.17523598587553872854.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b397f8468fa27f08b83b348ffa56a226f72453af
Gitweb:        https://git.kernel.org/tip/b397f8468fa27f08b83b348ffa56a226f72453af
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 28 Aug 2019 16:48:50 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:12 -03:00

perf evlist: Use unshare(CLONE_FS) in sb threads to let setns(CLONE_NEWNS) work

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
 tools/perf/util/evlist.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5ad92fa..253dd8d 100644
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
