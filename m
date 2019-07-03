Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B36C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849142054F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124553;
	bh=fFP8/xQpsCr50gT3UsgaVb/LRww2jtZsKaXMPRHhOGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2rEFOp49iSWMXlCcWkIIYCDrFK2gX5qMCy2xIQ0SAZvQl+pA3+/vumpbw2rr0wHVo
	 Q4d/XBIQpL4F+L9m5Q1ctA+FW3qmvMYf5GCWYtzDTWiV07iLgX8MC2hiXdztLUfous
	 f+kCL6WOFeGSWAwPvoRrwvj9gcJb0rORNxKQJXnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGCD3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfGCD3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:29:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70FC8218BA;
        Wed,  3 Jul 2019 03:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124548;
        bh=fFP8/xQpsCr50gT3UsgaVb/LRww2jtZsKaXMPRHhOGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVXS0zS0+c3R1csdFK5enbds2nwmERMrK2du5o8GgSuabzJugVvejXHOsxu60cpU4
         I7MhMWN3SRUyQ38xcSF3sHBf9Q3AjWfEMqk/ylsMwexkWvzAkQ9pYHVy3X5FRreCya
         SmD0Dm1kXEcq3oHY4qkEGtgsYK4cZPSFqA+m3FH8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mariano Pache <npache@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Yarygin <yarygin@linux.vnet.ibm.com>,
        Ali Raza <alirazabhutta.10@gmail.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Joe Mario <jmario@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        Orran Krieger <okrieger@redhat.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 18/18] perf script: Allow specifying the files to process guest samples
Date:   Wed,  3 Jul 2019 00:27:46 -0300
Message-Id: <20190703032746.21692-19-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'perf kvm' command set up things so that we can record, report, top,
etc, but not 'script', so make 'perf script' be able to process samples
by allowing to pass guest kallsyms, vmlinux, modules, etc, and if at
least one of those is provided, set perf_guest to true so that guest
samples get properly resolved.

Testing it:

  # perf kvm --guest --guestkallsyms /wb/rhel6.kallsyms --guestmodules /wb/rhel6.modules record -e cycles:Gk
^C[ perf record: Woken up 7 times to write data ]
  [ perf record: Captured and wrote 3.602 MB perf.data.guest (10492 samples) ]

  #
  # perf evlist -i perf.data.guest
cycles:Gk
  # perf evlist -v -i perf.data.guest
cycles:Gk: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, exclude_user: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, task: 1, sample_id_all: 1, exclude_host: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
  #
  # perf kvm --guestkallsyms /wb/rhel6.kallsyms --guestmodules /wb/rhel6.modules report --stdio -s sym | head -30
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 10K of event 'cycles:Gk'
  # Event count (approx.): 2434201408
  #
  # Overhead  Symbol
  # ........  ..............................................
  #
      11.93%  [g] avtab_search_node
       3.95%  [g] sidtab_context_to_sid
       2.41%  [g] n_tty_write
       2.20%  [g] _spin_unlock_irqrestore
       1.37%  [g] _aesni_dec4
       1.33%  [g] kmem_cache_alloc
       1.07%  [g] native_write_cr0
       0.99%  [g] kfree
       0.95%  [g] _spin_lock
       0.91%  [g] __memset
       0.87%  [g] schedule
       0.83%  [g] _spin_lock_irqsave
       0.76%  [g] __kmalloc
       0.67%  [g] avc_has_perm_noaudit
       0.66%  [g] kmem_cache_free
       0.65%  [g] glue_xts_crypt_128bit
       0.59%  [g] __d_lookup
       0.59%  [g] __audit_syscall_exit
       0.56%  [g] __memcpy
  #

Then, when trying to use perf script to generate a python script and
then process the events after adding a python hook for non-tracepoint
events:

  # perf script -i perf.data.guest -g python
  generated Python script: perf-script.py
  # vim perf-script.py
  # tail -2 perf-script.py
  def process_event(param_dict):
        print(param_dict["symbol"])
  #
  # perf script -i perf.data.guest -s perf-script.py  | head
  in trace_begin
  vmx_vmexit
  vmx_vmexit
  vmx_vmexit
  vmx_vmexit
  vmx_vmexit
  vmx_vmexit
  vmx_vmexit
  vmx_vmexit
  vmx_vmexit
  231
  #

We'd see just the vmx_vmexit, i.e. the samples from the guest don't show
up.

After this patch:

  # perf script --guestkallsyms /wb/rhel6.kallsyms --guestmodules /wb/rhel6.modules -i perf.data.guest -s perf-script.py 2> /dev/null | head -30
  in trace_begin
  apic_timer_interrupt
  apic_timer_interrupt
  apic_timer_interrupt
  apic_timer_interrupt
  apic_timer_interrupt
  save_args
  do_timer
  drain_array
  inode_permission
  avc_has_perm_noaudit
  run_timer_softirq
  apic_timer_interrupt
  apic_timer_interrupt
  apic_timer_interrupt
  apic_timer_interrupt
  apic_timer_interrupt
  kvm_guest_apic_eoi_write
  run_posix_cpu_timers
  _spin_lock
  handle_pte_fault
  rcu_irq_enter
  delay_tsc
  delay_tsc
  native_read_tsc
  apic_timer_interrupt
  sys_open
  internal_add_timer
  list_del
  rcu_exit_nohz
  #

Jiri Olsa noticed we need to set 'perf_guest' to true if we want to
process guest samples and I made it be set if one of the guest files
settings get set via the command line options added in this patch, that
match those present in the 'perf kvm' command.

We probably want to have 'perf record', 'perf report' etc to notice that
there are guest samples and do the right thing, which is to look for
files with some suffix that make it be associated with the guest used to
collect the samples, i.e. if a vmlinux file is passed, we can get the
build-id from it, if not some other identifier or simply looking for
"kallsyms.guest", for instance, in the current directory.

Reported-by: Mariano Pache <npache@redhat.com>
Tested-by: Mariano Pache <npache@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Cc: Ali Raza <alirazabhutta.10@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Mario <jmario@redhat.com>
Cc: Larry Woodman <lwoodman@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Orran Krieger <okrieger@redhat.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Yunlong Song <yunlong.song@huawei.com>
Link: https://lkml.kernel.org/n/tip-d54gj64rerlxcqsrod05biwn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 520e5b6b9ef9..2f6232f1bfdc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3522,6 +3522,15 @@ int cmd_script(int argc, const char **argv)
 		   "Time span of interest (start,stop)"),
 	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
 		    "Show inline function"),
+	OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "directory",
+		   "guest mount directory under which every guest os"
+		   " instance has a subdir"),
+	OPT_STRING(0, "guestvmlinux", &symbol_conf.default_guest_vmlinux_name,
+		   "file", "file saving guest os vmlinux"),
+	OPT_STRING(0, "guestkallsyms", &symbol_conf.default_guest_kallsyms,
+		   "file", "file saving guest os /proc/kallsyms"),
+	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
+		   "file", "file saving guest os /proc/modules"),
 	OPT_END()
 	};
 	const char * const script_subcommands[] = { "record", "report", NULL };
@@ -3541,6 +3550,16 @@ int cmd_script(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (symbol_conf.guestmount ||
+	    symbol_conf.default_guest_vmlinux_name ||
+	    symbol_conf.default_guest_kallsyms ||
+	    symbol_conf.default_guest_modules) {
+		/*
+		 * Enable guest sample processing.
+		 */
+		perf_guest = true;
+	}
+
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
-- 
2.20.1

