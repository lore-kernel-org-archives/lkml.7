Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC29C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B51217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="dnpdFPlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbfEXJXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:23:53 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44551 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389732AbfEXJXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:23:53 -0400
Received: by mail-wr1-f44.google.com with SMTP id w13so859751wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2kGzkquFZxRXiPohBCWwk+omoU2cXHNChnmCRZaGvS8=;
        b=dnpdFPlOHCSCMZZQBwBqIfS3UzfiwCKeCp/dpM5bwEN4pVc8RZXEriKz42Y4cpd2EO
         CdtEvJq+5BY0OHRjbzX568zen1fpL6kbKBvHYhmsGu/W9BObXfnct687fiKO11uuaw7D
         Ohsw9o+zhydzkpN6TyP/1mdSnB51O71KxIcbRiPnu5Lr+HaT8DIs6F9/T4msDgGF/DgV
         EUlBodavRK+5bHv02xLOpwwpzR3F+FWYyb1zh+P/jhq1oGJb/hyMQTaFC1FbR/KyqgTb
         KGTLbE8K0CCG4zAzl900LILJ425jrjrip2kO309sMscA53ySJyKzdkKQbY5uSZereEM0
         6e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2kGzkquFZxRXiPohBCWwk+omoU2cXHNChnmCRZaGvS8=;
        b=GLIpxGMXqBAFxkHx5VRJGjwDSkQYmVAcTz81xoWt0utcOosTGViChYXms1X8JKL3yo
         BD7LpxTQmZ8UriQFaqQNPVlUYK9qcz9Y+2G524qVYtrhpQVYUJT7aB9WePZMJWFBuLl5
         9Vm8ZLyMaPpEP7ZD4rPlUE2a28dd4adWjvaoRuboMr8dk1lSxD5tTaFgwDo7uEWIgGzx
         GHG2D6UvXs78ELPqw9KrwiRBol7pYdMw/l4PPgRy3w6uJ3ZJRgOmjB5UWvOX0gIcl8R8
         KwsfDi0FoTh42w2dkk9j7+NKjI/9sKn5yOktlVOcGhRGmmmp87biInYt/FmZN/C2bUGs
         2JpA==
X-Gm-Message-State: APjAAAXGTlO0Uqp9D3ut1AOTSdCXIx3W97pwHOUlRmuU4afR8ECJiLcy
        Yb0GKxxMH+NPP250kyIwE26dh9mGGCbjUecnp5Xxlg==
X-Google-Smtp-Source: APXvYqySYyyldPSHuz+IJkkpcJacrgyJKid6Md2JUHR1vLO4+wPMKsRsiaE4H1/0OnL+omKm790A2lfd4C5oEGtsTWM=
X-Received: by 2002:adf:ec42:: with SMTP id w2mr11931400wrn.77.1558689830871;
 Fri, 24 May 2019 02:23:50 -0700 (PDT)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 24 May 2019 11:23:40 +0200
Message-ID: <CAMGffE=xsHWMNoGn75wzv9CLrQ81OizgLiwDEwqKw14i_eVj8Q@mail.gmail.com>
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

Resend with plain text, sorry for spam.

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
Do it mean 4.14.120 is missing patches for detecting Cascade Lake
mitigation, Or maybe only small set of cascade lake has mitigation?
Or the community/intel are not sure about it yet?

Thanks,
-- 
Jack Wang
Linux Kernel Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 30 57700-8042 | Fax: +49 30 57700-8598
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de


Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim Weiss

Member of United Internet

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.

-- 
Jack Wang
Linux Kernel Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 30 57700-8042 | Fax: +49 30 57700-8598
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de


Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim Weiss

Member of United Internet

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
