Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CB8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED2F21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="XmzyFhnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391610AbfEXNTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:19:47 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34972 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391124AbfEXNTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:19:46 -0400
Received: by mail-wr1-f47.google.com with SMTP id m3so10020803wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jzQHkJ/pBgBZFWEflJGA8oAilvAER1cbh7aG0kbKgEg=;
        b=XmzyFhnq54xA5wcGkqE0Kvl/lYMjYymazK+mvs1c0g90yx8Lg8+hKjcbUD0i055Xg2
         hxMdOSOlLn7r4TLzQ92lSmTMiJyy+9KsbJ6D1v2pdC6Ih1AkeU8PiHvXwLzjbsLMW1hG
         HOsmR9ks7c8FKeHQRKqg2OYj/2RVVh331YB0Gl2H7aJ0T85Btyo3YEq8/4ZPbPfsXs0W
         uxsMjSkxdRF7Nm8GXW1X5tZCHW6fc/7lXIpKroYqmw8Jb/tRvmec1/1s6SEVhKv3XhyP
         uAbnHnJojuMdq3mWZA2byZwGVuGvAxY5Wp2y5//PHuyRWnBNvItQ3feaMVdJTOQ9fJOO
         TTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jzQHkJ/pBgBZFWEflJGA8oAilvAER1cbh7aG0kbKgEg=;
        b=XowwSK3gbPhyUiiZxznFh/Zh0xS6rX4evI99fO3ia1p8xWhnBA2Y9ZAQEkjIBZbORE
         EFjS/kVYg5YNRcrlBleUpcNTeon0ZYQIdBqV5rhmSE2+OtWwcxdlH1s8iVbFRsmVMML4
         fPxi5HSdiHNOfcIY6uU5+esGu7lDWO1HA3HNw7LSYhG9pYKSIOEUNA+/I6nKzNindrC+
         EcjEpkqBsog1qQ9UgB1odOgamZMseAoYHEkYyQBpJj3Nl3KFR3aBaguNjLBcyen6By6L
         KtwbMzpcC7UKoDShuM88KzhESBSjgPfOmMzDn+/Vp//S+tPBxH1JH+U00l41865V3bWk
         gtwQ==
X-Gm-Message-State: APjAAAWZqiZdIsQzQ+GtKYHmrKCmTo5GUamtouQucYWrdQBbvw/h7RxW
        D7ujdGqpqjxquTgt+wxwZ7xLztRUlsINa29ewoiyPl5SCoN33Q==
X-Google-Smtp-Source: APXvYqymYAYbhZJ6X39VTu/pMd+I2/jr8Buobp/bgOkPFW19s+WOOob3SGrFPknEjdEgr7o5X5AWhZP+4qEil/gGnsQ=
X-Received: by 2002:a5d:440d:: with SMTP id z13mr2119880wrq.263.1558703985074;
 Fri, 24 May 2019 06:19:45 -0700 (PDT)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 24 May 2019 15:19:34 +0200
Message-ID: <CAMGffEkQmdrrH3+UChZx_Af6WcFFQFw6fz3Ti4CRUau-wq7jow@mail.gmail.com>
Subject: Is 2nd Generation Intel(R) Xeon(R) Processors (Formerly Cascade Lake)
 affected by MDS
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tony.luck@intel.com, Arjan van de Ven <arjan@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Elmar Gerdes <elmar.gerdes@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend with plain text, and remove confidential unnecessary signature.
sorry for spam.

Hi Thomas, hi Greg, hi Tony, hi Arjan, hi other expert on the list

I noticed on our Cascade lake with 4.14.120,  the kernel is reporting
vulnerable:
jwang@ps401a-912:~$ head /sys/devices/system/cpu/vulnerabilities/mds
Vulnerable: Clear CPU buffers attempted, no microcode; SMT vulnerable

But according to INTEL,  they have built the mitigation in hardware
for Cascade Lake:
https://www.intel.com/content/www/us/en/architecture-and-technology/engineering-new-protections-into-hardware.html

We are using latest microcode from debian:
https://metadata.ftp-master.debian.org/changelogs//non-free/i/intel-microcode/intel-microcode_3.20190514.1~deb9u1_changelog
lscpu:
jwang@ps401a-912:~$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                96
On-line CPU(s) list:   0-95
Thread(s) per core:    2
Core(s) per socket:    24
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 85
Model name:            Intel(R) Xeon(R) Platinum 8268 CPU @ 2.90GHz
Stepping:              5
CPU MHz:               3228.226
CPU max MHz:           3900.0000
CPU min MHz:           1000.0000
BogoMIPS:              5800.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              33792K
NUMA node0 CPU(s):     0-23,48-71
NUMA node1 CPU(s):     24-47,72-95
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs
bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3
cdp_l3 invpcid_single intel_ppin ssbd mba ibrs ibpb stibp tpr_shadow
vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2
erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap
clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec
xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
dtherm ida arat pln pts pku ospke flush_l1d arch_capabilities

Clearly we want to buy Cascade Lake if the hardware mitigations are in
place, but the information on the internet is quite limited and
misleading.

Could anyone of you could clarify it for us?
Does it mean 4.14.120 is missing patches for detecting Cascade Lake
mitigation, Or maybe only small set of cascade lake has mitigation?
Or the community/intel are not sure about it yet?

Looking forward for your reply.

Thanks,

-- 
Jack Wang
Linux Kernel Developer
