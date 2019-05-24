Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5710AC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B84A2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="BDPx+/WU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbfEXPOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:14:52 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36702 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfEXPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:14:52 -0400
Received: by mail-wr1-f42.google.com with SMTP id s17so10431046wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uugXwYBw6qrNzPiz5k482oyz6t67aADXcqRGiVXbx48=;
        b=BDPx+/WUWs1crEIdTHcicYAWTugLioOAvrlk0qubVFZzRa1cIQGR/brzPpm6Lf+ysu
         EX3OHDbPtOKWtsLxyAmuaX8gO0PhRZpqZndl+V1Hjc9ZmQB3pAUVAdAKy9ReEVd3VONQ
         8YcueSxdVQewSG4JowqGp+31NayZxIac+jtgkzdBUQ0vz8uy31AvSNc4wMoHn00kZeoc
         g2kPEbxokxnca1PD6Dgdkljxqhrzl2miPz3coawNKtZLcd8V7HnI+QXqUe1eFxjabXkr
         NaD3S+wUd9nwxVAqIUdiRS14Fp+kDwKz3hAqdNh+4LeiL0nuOYSreD7bKt3he3WEbD3Q
         i6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uugXwYBw6qrNzPiz5k482oyz6t67aADXcqRGiVXbx48=;
        b=IZXon4Jgmj2rhNinhZy4jTVMUcIb+0T8XNR68HwNz+Kx1lJk7OlDgLolvqQmExzjIY
         IRMZ0QAd1eRYL8Gycv65tCtvIXSAGCMxTfu/DUER+tx1dXU0o5aV6lrJ7U4v7bqb08Jk
         GrGRaKyg0sA+f9R0wvDJBLfFLda8vRse0Pt9t8k+9REkHqeJCP0ORxNKOrE5+goNeoyr
         iQQpGMsOL5dJspMXQy44dcSEnhjaM49H6+l0pbz3bzwZ5aDj+GgNn+0TI7UVQUMrKwLN
         LkLjl6FFUYDlcI5LtYwUY0TO+wYy4YhQw1Z3qxq5v05cuHABb+jsQ22feMzq/pzGNLgT
         DG6w==
X-Gm-Message-State: APjAAAV6Tn434T775UKkAMJ2P+NLVH+KYF+NXq4+RCgnYm831/RjO/ry
        yaqJU69fBYq1GCIlGAxOiSxQlnPv+PKxBgvpmxWeo7tQcxY=
X-Google-Smtp-Source: APXvYqybpS5/RBY/KMp9Et5ZD4baUpiLOXoyQntSe/3tsjycFioeZMaEZK2TdzoZyJn1mNf0Jb3HEKhBte8O/e9LsLw=
X-Received: by 2002:adf:f250:: with SMTP id b16mr32332393wrp.24.1558710889763;
 Fri, 24 May 2019 08:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEkQmdrrH3+UChZx_Af6WcFFQFw6fz3Ti4CRUau-wq7jow@mail.gmail.com>
 <20190524141732.GA4412@kroah.com> <7B9F565D-EE66-432B-9D29-E494BFD24683@gmail.com>
In-Reply-To: <7B9F565D-EE66-432B-9D29-E494BFD24683@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 24 May 2019 17:14:38 +0200
Message-ID: <CAMGffEmmtJhQE04xt84QHrDxUFa0OqbKfZZT_mhXN6P6D99-WA@mail.gmail.com>
Subject: Re: Is 2nd Generation Intel(R) Xeon(R) Processors (Formerly Cascade
 Lake) affected by MDS
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Elmar Gerdes <elmar.gerdes@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 4:45 PM Tony Luck <tony.luck@gmail.com> wrote:
>
> Stepping 5 is preproduction of cascade lake. MDS mitigation is in production parts (stepping >= 6)
>
> Sent from my iPhone
>
> > On May 24, 2019, at 07:17, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> >> On Fri, May 24, 2019 at 03:19:34PM +0200, Jinpu Wang wrote:
> >> Resend with plain text, and remove confidential unnecessary signature.
> >> sorry for spam.
> >>
> >> Hi Thomas, hi Greg, hi Tony, hi Arjan, hi other expert on the list
> >>
> >> I noticed on our Cascade lake with 4.14.120,  the kernel is reporting
> >> vulnerable:
> >> jwang@ps401a-912:~$ head /sys/devices/system/cpu/vulnerabilities/mds
> >> Vulnerable: Clear CPU buffers attempted, no microcode; SMT vulnerable
> >>
> >> But according to INTEL,  they have built the mitigation in hardware
> >> for Cascade Lake:
> >> https://www.intel.com/content/www/us/en/architecture-and-technology/engineering-new-protections-into-hardware.html
> >>
> >> We are using latest microcode from debian:
> >> https://metadata.ftp-master.debian.org/changelogs//non-free/i/intel-microcode/intel-microcode_3.20190514.1~deb9u1_changelog
> >> lscpu:
> >> jwang@ps401a-912:~$ lscpu
> >> Architecture:          x86_64
> >> CPU op-mode(s):        32-bit, 64-bit
> >> Byte Order:            Little Endian
> >> CPU(s):                96
> >> On-line CPU(s) list:   0-95
> >> Thread(s) per core:    2
> >> Core(s) per socket:    24
> >> Socket(s):             2
> >> NUMA node(s):          2
> >> Vendor ID:             GenuineIntel
> >> CPU family:            6
> >> Model:                 85
> >> Model name:            Intel(R) Xeon(R) Platinum 8268 CPU @ 2.90GHz
> >> Stepping:              5
> >> CPU MHz:               3228.226
> >> CPU max MHz:           3900.0000
> >> CPU min MHz:           1000.0000
> >> BogoMIPS:              5800.00
> >> Virtualization:        VT-x
> >> L1d cache:             32K
> >> L1i cache:             32K
> >> L2 cache:              1024K
> >> L3 cache:              33792K
> >> NUMA node0 CPU(s):     0-23,48-71
> >> NUMA node1 CPU(s):     24-47,72-95
> >> Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
> >> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
> >> tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs
> >> bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
> >> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
> >> pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
> >> xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3
> >> cdp_l3 invpcid_single intel_ppin ssbd mba ibrs ibpb stibp tpr_shadow
> >> vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2
> >> erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap
> >> clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec
> >> xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
> >> dtherm ida arat pln pts pku ospke flush_l1d arch_capabilities
> >>
> >> Clearly we want to buy Cascade Lake if the hardware mitigations are in
> >> place, but the information on the internet is quite limited and
> >> misleading.
> >>
> >> Could anyone of you could clarify it for us?
> >> Does it mean 4.14.120 is missing patches for detecting Cascade Lake
> >> mitigation, Or maybe only small set of cascade lake has mitigation?
> >> Or the community/intel are not sure about it yet?
> >
> > Did you try 4.19 or 5.1?  Try those and see if anything changes.
> >
> > If not, odds are you need a microcode update from Intel, please contact
> > them, nothing we can do about that.
> >
> > If 4.14 works different from 4.19 or 5.1, please let us know.
> >
> > thanks,
> >
> > greg k-h

Thanks, Greg, thanks Tony,

I tried also 4.19.46 kernel, it show the same.

As Tony mentioned, it's due to the stepping difference, our test
machine is a preproduction one.
I would expect the production Cascade Lake supports md-clear feature,
so VM migration works from old generation.
Could some one give me an answer?

Thanks a lot.
-- 
Jack Wang
Linux Kernel Developer @ 1 & 1 Cloud IONOS GmbH
