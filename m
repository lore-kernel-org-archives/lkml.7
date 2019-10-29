Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAB2CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2438321479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="W4St5kFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfJ2UzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:55:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34807 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfJ2UzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:55:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id c25so370014qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=tERKWf/1Xu1im9q7r+ig2lLKsk3IvLZx8S1aHOjz10s=;
        b=W4St5kFc/38oruG0qhYD+3ioPogCmMNGjOVNdGJUwOlP+h+R5Vz2RaAR3yf8Y1hi96
         W5lRTeEq7Chy48Hk7bvra0dbKhh+3SnyUocC4T1FUbed2a42eXsZso4qvrfxcWA0qj9J
         usFoaRip2BF9LxxCm/034C02zEDmORgm2T3/vIk8H/A6/dwWyO4YK3Yp2Ay6DhnsdwCw
         V2WKcde7mJJEZlJx/SiSFfwa9Y/6gGB0XHn+wjiGs1kwcxctj+djx5clY2VLuRVCcHCH
         R8Aowg7zYpT+HzqMLDUflHFnZ9Qi2fG50e8hPUNTqeLwyI0wlHxr6vDsE/mAlaMv6K7S
         uhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=tERKWf/1Xu1im9q7r+ig2lLKsk3IvLZx8S1aHOjz10s=;
        b=NRVzZ1OVbXQEODRNEmtD0gyJVnc28xBpQFxfgRlhF0WReO9rt+CcNm0qygeiZ9GK6m
         PTR30N1bzSaMykQsv2pHveNNhW61dVmvhhblgp/htfNbV3tbtMyv9MwhE+lxr95xqCyY
         06KQzzuO+PTbAhONeieMW4uC6z/5p56IJ0DtD+FSfBymmkNWvfZvlOq/g0KEPTwezFu9
         ZjN5AuSljFpCoR4cS9sAkIuyzXlc/t6Q77SniUwKIjeD57cnV+wv5CPS+i80fSCclzpn
         DA4rL3MOWyos6Wh3j0Gm8ad6mfxJEcnTOALpHBbCp0kyX1kSjYkWvAPAQU30j3N3lZLO
         v5jQ==
X-Gm-Message-State: APjAAAUXBRgHVrS17tUPBlZ0SyUOOH7y/XH349Ia94wvEvkD9FzF5mpm
        Ip4NZXp3phMHy/netCDYrMLzsA==
X-Google-Smtp-Source: APXvYqza96z7Rghw1pAfKUrIgA7dBSsDB9dM7LJfs1mZwUdlrm3aSoAFZovzALN2m9P78h9T7gg8Cg==
X-Received: by 2002:ae9:e50f:: with SMTP id w15mr5496025qkf.436.1572382507722;
        Tue, 29 Oct 2019 13:55:07 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r7sm157768qkf.124.2019.10.29.13.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 13:55:06 -0700 (PDT)
Message-ID: <1572382505.5937.97.camel@lca.pw>
Subject: "Force HWP min perf before offline" triggers unchecked MSR access
 errors
From:   Qian Cai <cai@lca.pw>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 29 Oct 2019 16:55:05 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit af3b7379e2d7 ("cpufreq: intel_pstate: Force HWP min perf before
offline") triggers an error below while doing CPU hotplug. Reverted it (on the
top of the linux-next) fixed it.

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              144
On-line CPU(s) list: 0-143
Thread(s) per core:  2
Core(s) per socket:  18
Socket(s):           4
NUMA node(s):        4
Vendor ID:           GenuineIntel
CPU family:          6
Model:               85
Model name:          Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz
Stepping:            4
CPU MHz:             1200.001
CPU max MHz:         3700.0000
CPU min MHz:         1200.0000
BogoMIPS:            6000.00
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            1024K
L3 cache:            25344K
NUMA node0 CPU(s):   0-17,72-89
NUMA node1 CPU(s):   18-35,90-107
NUMA node2 CPU(s):   36-53,108-125
NUMA node3 CPU(s):   54-71,126-143
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2
ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
cpuid_fault epb cat_l3 cdp_l3 invpcid_single pti intel_ppin ssbd mba ibrs ibpb
stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle
avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap
clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1
xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts
hwp hwp_act_window hwp_pkg_req pku ospke md_clear flush_l1d

[17670.190223][T69701] LTP: starting cpuhotplug02 (cpuhotplug02.sh -c 1 -l 1)
[17676.195430][   T15] unchecked MSR access error: WRMSR to 0x1b0 (tried to
write 0x00000000000000c0) at rIP: 0xffffffff82b0a97c (__wrmsr_on_cpu+0xbc/0x130)
[17676.209251][   T15] Call Trace:
[17676.212410][   T15]  ? rdmsrl_on_cpu+0xf0/0xf0
[17676.216882][   T15]  generic_exec_single+0x13e/0x1d0
[17676.221876][   T15]  ? rdmsrl_on_cpu+0xf0/0xf0
[17676.226344][   T15]  smp_call_function_single+0x1aa/0x200
[17676.231774][   T15]  ? generic_exec_single+0x1d0/0x1d0
[17676.236942][   T15]  ? rdmsrl_on_cpu+0xb1/0xf0
[17676.241410][   T15]  wrmsrl_on_cpu+0xa6/0xe0
[17676.245705][   T15]  ? wrmsr_on_cpu+0xf0/0xf0
[17676.250091][   T15]  ? kasan_slab_free+0xe/0x10
[17676.254650][   T15]  ? intel_pstate_get_epp+0x168/0x190
[17676.259905][   T15]  ? store_energy_performance_preference+0x370/0x370
[17676.266469][   T15]  intel_pstate_set_epb+0xc8/0x110
[17676.271463][   T15]  ? show_status+0x80/0x80
[17676.275760][   T15]  ? down_write_killable+0x160/0x160
[17676.280927][   T15]  intel_pstate_stop_cpu+0x126/0x150
[17676.286094][   T15]  cpufreq_offline+0x17c/0x3a0
[17676.290737][   T15]  ? cpufreq_offline+0x3a0/0x3a0
[17676.295556][   T15]  cpuhp_cpufreq_offline+0xe/0x20
[17676.300464][   T15]  cpuhp_invoke_callback+0x197/0x1120
[17676.305724][   T15]  ? lock_acquire+0x126/0x280
[17676.310280][   T15]  ? cpuhp_thread_fun+0x69/0x2f0
[17676.315098][   T15]  cpuhp_thread_fun+0x252/0x2f0
[17676.319830][   T15]  ? __cpuhp_state_remove_instance+0x350/0x350
[17676.325876][   T15]  smpboot_thread_fn+0x255/0x440
[17676.330695][   T15]  ? smpboot_register_percpu_thread+0x110/0x110
[17676.336824][   T15]  ? __kasan_check_read+0x11/0x20
[17676.341731][   T15]  ? __kthread_parkme+0xc6/0xe0
[17676.346463][   T15]  ? smpboot_register_percpu_thread+0x110/0x110
[17676.352590][   T15]  kthread+0x1e6/0x210
[17676.356534][   T15]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[17676.362314][   T15]  ret_from_fork+0x3a/0x50
[17676.895221][   T16] IRQ 273: no longer affine to CPU1
[17676.901373][   T16] process 69725 (cpuhotplug_do_s) no longer affine to cpu1


