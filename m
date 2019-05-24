Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB5BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23248204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JktF32OU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404119AbfEXOpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:45:34 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44818 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390885AbfEXOpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:45:33 -0400
Received: by mail-pl1-f176.google.com with SMTP id c5so4265924pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MHvHrkxq2UZnF7o26TUMkBSgD+CCAEdyDhJ6RlRxDq4=;
        b=JktF32OUwIUFyGZjeQ3YmXTO0LTptYRLgl4mxzlfIS18qqzPT0JbakeLqSiXgj8iU5
         /AjUqhVb5fxrnJGRBg0Op/qEO+r66Ie27ZQzeRU/7XQTgU7Ydmi9vosEOm9X+AXJSUK1
         98HoGyR1LBgyej4GrYbxShLddFcGIgxOqpNluCNGEqLs0cRNByuEGAPMizULWNinHVY4
         YT/nRCimaS8UPNixhkDLPdo8qrcQ7ZcfqwGAGlG56q5dvM6QsjyWP0mbAmhckshJy+uT
         9BMqeVg4loc+rLskjjw6h3+nThebKPOBbMZMnHbWMH2gI+VK4CgofIQIEDrmGRchk0uq
         7Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MHvHrkxq2UZnF7o26TUMkBSgD+CCAEdyDhJ6RlRxDq4=;
        b=UHQKj3kFP89M8zzAPYZFlmSoBWMpELsm1uZTc6rLf8KDI4WEgmNOVNtQsW+szulafN
         HniGLHdWtFK+tilrtN0KlvG+QXcnGXd8V5bX04Vwa+2LJdAIcDjFQ7b3Q1m5bwshkbWy
         eNL4ZE80ThGn9ZowkyfN4kbTJfL1FfkgHj/KtsebKg8ymTvdwAEGHxJlbWQGn0hDteOq
         4WV3/Xgld3Nu9wFVclBbOJ3LxEeI2UBuiSZ3AH68QQQwntDJ4hlGeVWxRTVlfzi+lsNz
         a4/YdOt1WciDWi/+PssM7xP6Vh8AENZORt4ExDwGVejhGW0umdjju4UZs55V6RR5d2VS
         pGFQ==
X-Gm-Message-State: APjAAAXsEcCj2gbjOxdP6ApYFWR6ex/+iD0tVDviCxj50W1zyLBuHYaI
        xBDSPbZE336fCLDuPC0HyXA=
X-Google-Smtp-Source: APXvYqydly2nntodiLgnYLq/vhdMvgJqXc5van8JufMPzJRkBw6YKEUFoYnDLEe8GTc3tJzJVxfcrg==
X-Received: by 2002:a17:902:2d03:: with SMTP id o3mr71181543plb.309.1558709133220;
        Fri, 24 May 2019 07:45:33 -0700 (PDT)
Received: from [192.168.1.80] (c-71-202-18-166.hsd1.ca.comcast.net. [71.202.18.166])
        by smtp.gmail.com with ESMTPSA id k6sm3100014pfi.86.2019.05.24.07.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 07:45:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Is 2nd Generation Intel(R) Xeon(R) Processors (Formerly Cascade Lake) affected by MDS
From:   Tony Luck <tony.luck@gmail.com>
X-Mailer: iPhone Mail (16F156)
In-Reply-To: <20190524141732.GA4412@kroah.com>
Date:   Fri, 24 May 2019 07:45:31 -0700
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Elmar Gerdes <elmar.gerdes@cloud.ionos.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B9F565D-EE66-432B-9D29-E494BFD24683@gmail.com>
References: <CAMGffEkQmdrrH3+UChZx_Af6WcFFQFw6fz3Ti4CRUau-wq7jow@mail.gmail.com> <20190524141732.GA4412@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stepping 5 is preproduction of cascade lake. MDS mitigation is in production=
 parts (stepping >=3D 6)

Sent from my iPhone

> On May 24, 2019, at 07:17, Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
 wrote:
>=20
>> On Fri, May 24, 2019 at 03:19:34PM +0200, Jinpu Wang wrote:
>> Resend with plain text, and remove confidential unnecessary signature.
>> sorry for spam.
>>=20
>> Hi Thomas, hi Greg, hi Tony, hi Arjan, hi other expert on the list
>>=20
>> I noticed on our Cascade lake with 4.14.120,  the kernel is reporting
>> vulnerable:
>> jwang@ps401a-912:~$ head /sys/devices/system/cpu/vulnerabilities/mds
>> Vulnerable: Clear CPU buffers attempted, no microcode; SMT vulnerable
>>=20
>> But according to INTEL,  they have built the mitigation in hardware
>> for Cascade Lake:
>> https://www.intel.com/content/www/us/en/architecture-and-technology/engin=
eering-new-protections-into-hardware.html
>>=20
>> We are using latest microcode from debian:
>> https://metadata.ftp-master.debian.org/changelogs//non-free/i/intel-micro=
code/intel-microcode_3.20190514.1~deb9u1_changelog
>> lscpu:
>> jwang@ps401a-912:~$ lscpu
>> Architecture:          x86_64
>> CPU op-mode(s):        32-bit, 64-bit
>> Byte Order:            Little Endian
>> CPU(s):                96
>> On-line CPU(s) list:   0-95
>> Thread(s) per core:    2
>> Core(s) per socket:    24
>> Socket(s):             2
>> NUMA node(s):          2
>> Vendor ID:             GenuineIntel
>> CPU family:            6
>> Model:                 85
>> Model name:            Intel(R) Xeon(R) Platinum 8268 CPU @ 2.90GHz
>> Stepping:              5
>> CPU MHz:               3228.226
>> CPU max MHz:           3900.0000
>> CPU min MHz:           1000.0000
>> BogoMIPS:              5800.00
>> Virtualization:        VT-x
>> L1d cache:             32K
>> L1i cache:             32K
>> L2 cache:              1024K
>> L3 cache:              33792K
>> NUMA node0 CPU(s):     0-23,48-71
>> NUMA node1 CPU(s):     24-47,72-95
>> Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
>> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
>> tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs
>> bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
>> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
>> pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
>> xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3
>> cdp_l3 invpcid_single intel_ppin ssbd mba ibrs ibpb stibp tpr_shadow
>> vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2
>> erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap
>> clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec
>> xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
>> dtherm ida arat pln pts pku ospke flush_l1d arch_capabilities
>>=20
>> Clearly we want to buy Cascade Lake if the hardware mitigations are in
>> place, but the information on the internet is quite limited and
>> misleading.
>>=20
>> Could anyone of you could clarify it for us?
>> Does it mean 4.14.120 is missing patches for detecting Cascade Lake
>> mitigation, Or maybe only small set of cascade lake has mitigation?
>> Or the community/intel are not sure about it yet?
>=20
> Did you try 4.19 or 5.1?  Try those and see if anything changes.
>=20
> If not, odds are you need a microcode update from Intel, please contact
> them, nothing we can do about that.
>=20
> If 4.14 works different from 4.19 or 5.1, please let us know.
>=20
> thanks,
>=20
> greg k-h
