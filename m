Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA1122311
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163214;
	bh=3ddu5QVxyGIk6W7UKdItO2YVwGQCZTha3WJFIAop07M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kd714zFfKi1u0NZpBVxjF56WwO/q8jfA0p/uD8wZBH3gaa7odhpQ7WorVV/2TbmjN
	 q/7YNjoIwglpzyE1AeEzR/ijjYizWL1EV7q0K/v68fTAX6Wq4n4EkVmxqvsqYsWHG8
	 zjjIH32D0lhFLV2SxVaOIvfjy1ZoE+m/r0pLeNZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfKSLdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfKSLdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:32 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D20D22304;
        Tue, 19 Nov 2019 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163210;
        bh=3ddu5QVxyGIk6W7UKdItO2YVwGQCZTha3WJFIAop07M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iy4uLBZ4JrFoSiqHqe6yZRdUItvxxQNumid5Yhof0JkV1HFBRKY76aN2ZtqPFmxkk
         fGn1X5el8mScRq8gVu+9BuOdnQ/UmzuRP3/yUqmaEEJbvHUVBWXdw6qjsZF3ZlCaz+
         EBF2XBD2SvfNNZLrYrALq06IhdmT3d8BnYD5AUpo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/25] perf map: No need to adjust the long name of modules
Date:   Tue, 19 Nov 2019 08:32:28 -0300
Message-Id: <20191119113245.19593-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 6a0f5c25ce3e..6804c8247782 100644
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
-- 
2.21.0

