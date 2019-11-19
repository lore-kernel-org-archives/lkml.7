Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D0C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B04223D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfKSQ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:58:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52901 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfKSQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oF-0007VH-JO; Tue, 19 Nov 2019 17:56:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 48ED31C19D9;
        Tue, 19 Nov 2019 17:56:50 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: No need to adjust the long name of modules
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-jlfew3lyb24d58egrp0o72o2@git.kernel.org>
References: <tip-jlfew3lyb24d58egrp0o72o2@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157418261023.12247.11040815051939157652.tip-bot2@tip-bot2>
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

Commit-ID:     f068435d9bb2d825d59e3c101bc579f09315ee01
Gitweb:        https://git.kernel.org/tip/f068435d9bb2d825d59e3c101bc579f09315ee01
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 14 Nov 2019 10:46:45 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 11:21:32 -03:00

perf map: No need to adjust the long name of modules

At some point in the past we needed to make sure we would get the long
name of modules and not just what we get from /proc/modules, but that
need, as described in the cset that introduced the adjustment function:

Fixes: c03d5184f0e9 ("perf machine: Adjust dso->long_name for offline module")

Without using the buildid-cache:

  # lsmod | grep trusted
  # insmod trusted.ko
  # lsmod | grep trusted
  trusted                24576  0
  # strace -e open,openat perf probe -m ./trusted.ko key_seal |& grep trusted
  openat(AT_FDCWD, "/sys/module/trusted/notes/.note.gnu.build-id", O_RDONLY) = 4
  openat(AT_FDCWD, "/sys/module/trusted/notes/.note.gnu.build-id", O_RDONLY) = 7
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/.debug/root/trusted.ko/dd3d355d567394d540f527e093e0f64b95879584/probes", O_RDWR|O_CREAT, 0644) = 3
  openat(AT_FDCWD, "/usr/lib/debug/root/trusted.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/lib/debug/root/trusted.ko", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/.debug/trusted.ko", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "trusted.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, ".debug/trusted.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "trusted.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 4
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
    probe:key_seal       (on key_seal in trusted)
  # perf probe -l
    probe:key_seal       (on key_seal in trusted)
  #

No attempt at opening '[trusted]'.

Now using the build-id cache:

  # rmmod trusted
  # perf buildid-cache --add ./trusted.ko
  # insmod trusted.ko
  # strace -e open,openat perf probe -m ./trusted.ko key_seal |& grep trusted
  openat(AT_FDCWD, "/sys/module/trusted/notes/.note.gnu.build-id", O_RDONLY) = 4
  openat(AT_FDCWD, "/sys/module/trusted/notes/.note.gnu.build-id", O_RDONLY) = 7
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/.debug/root/trusted.ko/dd3d355d567394d540f527e093e0f64b95879584/probes", O_RDWR|O_CREAT, 0644) = 3
  openat(AT_FDCWD, "/usr/lib/debug/root/trusted.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/lib/debug/root/trusted.ko", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/.debug/trusted.ko", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "trusted.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, ".debug/trusted.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "trusted.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 4
  openat(AT_FDCWD, "/root/trusted.ko", O_RDONLY) = 3
  #

Again, no attempt at reading '[trusted]'.

Finally, adding a probe to that function and then using:

[root@quaco ~]# perf trace -e probe_perf:*/max-stack=16/ --max-events=2
     0.000 perf/13456 probe_perf:dso__adjust_kmod_long_name(__probe_ip: 5492263)
                                       dso__adjust_kmod_long_name (/home/acme/bin/perf)
                                       machine__process_kernel_mmap_event (/home/acme/bin/perf)
                                       machine__process_mmap_event (/home/acme/bin/perf)
                                       perf_event__process_mmap (/home/acme/bin/perf)
                                       machines__deliver_event (/home/acme/bin/perf)
                                       perf_session__deliver_event (/home/acme/bin/perf)
                                       perf_session__process_event (/home/acme/bin/perf)
                                       process_simple (/home/acme/bin/perf)
                                       reader__process_events (/home/acme/bin/perf)
                                       __perf_session__process_events (/home/acme/bin/perf)
                                       perf_session__process_events (/home/acme/bin/perf)
                                       process_buildids (/home/acme/bin/perf)
                                       record__finish_output (/home/acme/bin/perf)
                                       __cmd_record (/home/acme/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
                                       run_builtin (/home/acme/bin/perf)
     0.055 perf/13456 probe_perf:dso__adjust_kmod_long_name(__probe_ip: 5492263)
                                       dso__adjust_kmod_long_name (/home/acme/bin/perf)
                                       machine__process_kernel_mmap_event (/home/acme/bin/perf)
                                       machine__process_mmap_event (/home/acme/bin/perf)
                                       perf_event__process_mmap (/home/acme/bin/perf)
                                       machines__deliver_event (/home/acme/bin/perf)
                                       perf_session__deliver_event (/home/acme/bin/perf)
                                       perf_session__process_event (/home/acme/bin/perf)
                                       process_simple (/home/acme/bin/perf)
                                       reader__process_events (/home/acme/bin/perf)
                                       __perf_session__process_events (/home/acme/bin/perf)
                                       perf_session__process_events (/home/acme/bin/perf)
                                       process_buildids (/home/acme/bin/perf)
                                       record__finish_output (/home/acme/bin/perf)
                                       __cmd_record (/home/acme/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
                                       run_builtin (/home/acme/bin/perf)
  #

This was the only path I could find using the perf tools that reach at this
function, then as of november/2019, if we put a probe in the line where the
actuall setting of the dso->long_name is done:

  # perf trace -e probe_perf:*
  ^C[root@quaco ~]
  # perf stat -e probe_perf:*  -I 2000
       2.000404265                  0      probe_perf:dso__adjust_kmod_long_name
       4.001142200                  0      probe_perf:dso__adjust_kmod_long_name
       6.001704120                  0      probe_perf:dso__adjust_kmod_long_name
       8.002398316                  0      probe_perf:dso__adjust_kmod_long_name
      10.002984010                  0      probe_perf:dso__adjust_kmod_long_name
      12.003597851                  0      probe_perf:dso__adjust_kmod_long_name
      14.004113303                  0      probe_perf:dso__adjust_kmod_long_name
      16.004582773                  0      probe_perf:dso__adjust_kmod_long_name
      18.005176373                  0      probe_perf:dso__adjust_kmod_long_name
      20.005801605                  0      probe_perf:dso__adjust_kmod_long_name
      22.006467540                  0      probe_perf:dso__adjust_kmod_long_name
  ^C    23.683261941                  0      probe_perf:dso__adjust_kmod_long_name

  #

Its not being used at all.

To further test this I used kvm.ko as the offline module, i.e. removed
if from the buildid-cache by nuking it completely (rm -rf ~/.debug) and
moved it from the normal kernel distro path, removed the modules, stoped
the kvm guest, and then installed it manually, etc.

  # rmmod kvm-intel
  # rmmod kvm
  # lsmod | grep kvm
  # modprobe kvm-intel
  modprobe: ERROR: ctx=0x55d3b1722260 path=/lib/modules/5.3.8-200.fc30.x86_64/kernel/arch/x86/kvm/kvm.ko.xz error=No such file or directory
  modprobe: ERROR: ctx=0x55d3b1722260 path=/lib/modules/5.3.8-200.fc30.x86_64/kernel/arch/x86/kvm/kvm.ko.xz error=No such file or directory
  modprobe: ERROR: could not insert 'kvm_intel': Unknown symbol in module, or unknown parameter (see dmesg)
  # insmod ./kvm.ko
  # modprobe kvm-intel
  modprobe: ERROR: ctx=0x562f34026260 path=/lib/modules/5.3.8-200.fc30.x86_64/kernel/arch/x86/kvm/kvm.ko.xz error=No such file or directory
  modprobe: ERROR: ctx=0x562f34026260 path=/lib/modules/5.3.8-200.fc30.x86_64/kernel/arch/x86/kvm/kvm.ko.xz error=No such file or directory
  # lsmod | grep kvm
  kvm_intel             299008  0
  kvm                   765952  1 kvm_intel
  irqbypass              16384  1 kvm
  #
  # perf probe -x ~/bin/perf machine__findnew_module_map:12 mname=m.name:string filename=filename:string 'dso_long_name=map->dso->long_name:string' 'dso_name=map->dso->name:string'
  # perf probe -l
    probe_perf:machine__findnew_module_map (on machine__findnew_module_map:12@util/machine.c in /home/acme/bin/perf with mname filename dso_long_name dso_name)
  # perf record
  ^C[ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 3.416 MB perf.data (33956 samples) ]
  # perf trace -e probe_perf:machine*
  <SNIP>
       6.322 perf/23099 probe_perf:machine__findnew_module_map(__probe_ip: 5492493, mname: "[salsa20_generic]", filename: "/lib/modules/5.3.8-200.fc30.x86_64/kernel/crypto/salsa20_generic.ko.xz", dso_long_name: "/lib/modules/5.3.8-200.fc30.x86_64/kernel/crypto/salsa20_generic.ko.xz", dso_name: "[salsa20_generic]")
       6.375 perf/23099 probe_perf:machine__findnew_module_map(__probe_ip: 5492493, mname: "[kvm]", filename: "[kvm]", dso_long_name: "[kvm]", dso_name: "[kvm]")
  <SNIP>

The filename doesn't come with the path, no point in trying to set the dso->long_name.

  [root@quaco ~]# strace -e open,openat perf probe -m ./kvm.ko kvm_apic_local_deliver |& egrep 'open.*kvm'
  openat(AT_FDCWD, "/sys/module/kvm_intel/notes/.note.gnu.build-id", O_RDONLY) = 4
  openat(AT_FDCWD, "/sys/module/kvm/notes/.note.gnu.build-id", O_RDONLY) = 4
  openat(AT_FDCWD, "/lib/modules/5.3.8-200.fc30.x86_64/kernel/arch/x86/kvm", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 7
  openat(AT_FDCWD, "/sys/module/kvm_intel/notes/.note.gnu.build-id", O_RDONLY) = 8
  openat(AT_FDCWD, "/root/kvm.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/.debug/root/kvm.ko/5955f426cb93f03f30f3e876814be2db80ab0b55/probes", O_RDWR|O_CREAT, 0644) = 3
  openat(AT_FDCWD, "/usr/lib/debug/root/kvm.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/lib/debug/root/kvm.ko", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/.debug/kvm.ko", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/kvm.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "kvm.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, ".debug/kvm.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "kvm.ko.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/root/kvm.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/kvm.ko", O_RDONLY) = 3
  openat(AT_FDCWD, "/root/kvm.ko", O_RDONLY) = 4
  openat(AT_FDCWD, "/root/kvm.ko", O_RDONLY) = 3
  [root@quaco ~]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jlfew3lyb24d58egrp0o72o2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6a0f5c2..6804c82 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -772,24 +772,6 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	return machine__process_ksymbol_register(machine, event, sample);
 }
 
-static void dso__adjust_kmod_long_name(struct dso *dso, const char *filename)
-{
-	const char *dup_filename;
-
-	if (!filename || !dso || !dso->long_name)
-		return;
-	if (dso->long_name[0] != '[')
-		return;
-	if (!strchr(filename, '/'))
-		return;
-
-	dup_filename = strdup(filename);
-	if (!dup_filename)
-		return;
-
-	dso__set_long_name(dso, dup_filename, true);
-}
-
 struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 					const char *filename)
 {
@@ -801,15 +783,8 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 		return NULL;
 
 	map = map_groups__find_by_name(&machine->kmaps, m.name);
-	if (map) {
-		/*
-		 * If the map's dso is an offline module, give dso__load()
-		 * a chance to find the file path of that module by fixing
-		 * long_name.
-		 */
-		dso__adjust_kmod_long_name(map->dso, filename);
+	if (map)
 		goto out;
-	}
 
 	dso = machine__findnew_module_dso(machine, &m, filename);
 	if (dso == NULL)
