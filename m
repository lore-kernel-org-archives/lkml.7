Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018FBC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF452230B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuNOMTdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKSHMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:12:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46093 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKSHMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:12:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id r18so10872662pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 23:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOkEaxvoeuRDKKO9iEeAXK3d8jDrm2+Y0YFp9RHvoAo=;
        b=nuNOMTdV6cqA5xhs04CNCftYPLjSdTjJ0ePCPMCc3uiZcs4YCBMy9ZamdEurSipKqb
         B7qbTtqSkuv+cFtd5XGfPFzEAOygMAUU6PfcUq9+XWmSNfghnDQd5F7MZO2RpEtgPBO4
         pY9GDSzO29EdOQ3rQOPPXttJfNyhL/qzEK/UbIBzD0EktqXFkIZukEz6uYOhqO/XpJSv
         CZVM33HewLSdQwXu5Sk//1CSz1ZkVkWtwDNAv2TM14cIkWzrIAXJHvymtQVGDfQtyKZ4
         Gy6ZtONETM6pOH2ZXJaQ3hbDHkgWZ1LaHoK8pE6aiIh13lYEHwfU8H2bnK85SCTR2yLA
         qJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SOkEaxvoeuRDKKO9iEeAXK3d8jDrm2+Y0YFp9RHvoAo=;
        b=S00C7MV2fEqCfU8B1wJBPBDwnf8vPlmJ0gEHxPo3Cpf6j9SiZMlos/LzzI+PmUjnvK
         2HoJ0VikaQxcMfe3wbaQVBj1crQMUy/MFH2CzqryG6AqClmt66+SjNHhnDo5ue08VWRv
         iAgw6yOgnY+xsHjp1dmi0q2AwrmvKwLQobKkPa0XohKCpMj+E2oolS4q6QuSJF6MSqGt
         JoO92+57mhpu0le/GtXnGYQuAK7FS8oxbKmbMcQTcX3RfYwab8k3A4n/IQL54jwLLCOq
         lUOBZxOe7ExN1SGNdAEMTzdrnKGoa/y6d4QRd1K/rIsuyL5zAK/zDafjrO4xYV+NoWCU
         9cmg==
X-Gm-Message-State: APjAAAWjQ/LY2DyMRz394s+rYtbJmQ65l1URFxSX4KhQLvYruMWpMWe6
        5F77vaRoW/L3Z8GlMWLtlyVMkg==
X-Google-Smtp-Source: APXvYqwFnemtfhSeFTtXNTKp5S2y3O1/8DNvV3VlNu9ve+aPwic4dTdlBLzDttqWkR7TRM8xvN2dTQ==
X-Received: by 2002:a63:68c3:: with SMTP id d186mr3516436pgc.301.1574147559580;
        Mon, 18 Nov 2019 23:12:39 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id j7sm1931994pjz.12.2019.11.18.23.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 23:12:38 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:13:42 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
Subject: Re: [PATCH v4 0/3] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191119071341.GW22427@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
References: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
 <20191113063858.GE22427@linaro.org>
 <CACi5LpP54d9DKW63G5W6X4euBjAm2NwkHOiM01dB7g8d60s=4w@mail.gmail.com>
 <20191115015959.GI22427@linaro.org>
 <CAJ2QiJJOSspLKRh+jRB_o0o9nmeAsiFKzxGJ8R0pYPRM4iptmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2QiJJOSspLKRh+jRB_o0o9nmeAsiFKzxGJ8R0pYPRM4iptmw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Nov 19, 2019 at 12:02:46PM +0530, Prabhakar Kushwaha wrote:
> Hi Akashi,
> 
> On Fri, Nov 15, 2019 at 7:29 AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Bhupesh,
> >
> > On Fri, Nov 15, 2019 at 01:24:17AM +0530, Bhupesh Sharma wrote:
> > > Hi Akashi,
> > >
> > > On Wed, Nov 13, 2019 at 12:11 PM AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >
> > > > Hi Bhupesh,
> > > >
> > > > Do you have a corresponding patch for userspace tools,
> > > > including crash util and/or makedumpfile?
> > > > Otherwise, we can't verify that a generated core file is
> > > > correctly handled.
> > >
> > > Sure. I am still working on the crash-utility related changes, but you
> > > can find the makedumpfile changes I posted a couple of days ago here
> > > (see [0]) and the github link for the makedumpfile changes can be seen
> > > via [1].
> > >
> > > I will post the crash-util changes shortly as well.
> > > Thanks for having a look at the same.
> >
> > Thank you.
> > I have tested my kdump patch with a hacked version of crash
> > where VA_BITS_ACTUAL is calculated from tcr_el1_t1sz in vmcoreinfo.
> >
> 
> I also did hack to calculate VA_BITS_ACTUAL is calculated from
> tcr_el1_t1sz in vmcoreinfo. Now i am getting error same as mentioned
> by you in other thread last month.
> https://www.mail-archive.com/crash-utility@redhat.com/msg07385.html
> 
> how this error was overcome?
> 
> I am using
>  - crashkernel: https://github.com/crash-utility/crash.git  commit:
> babd7ae62d4e8fd6f93fd30b88040d9376522aa3
> and
>  - Linux: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> commit: af42d3466bdc8f39806b26f593604fdc54140bcb

# I am rather reluctant to cross-post non-kernel patch to lkml/lakml,

The only change I made to crash utility was:
===8<===
diff --git a/arm64.c b/arm64.c
index 5ee5f1a29a41..84e40aeb561b 100644
--- a/arm64.c
+++ b/arm64.c
@@ -3857,8 +3857,8 @@ arm64_calc_VA_BITS(void)
 		} else if (ACTIVE())
 			error(FATAL, "cannot determine VA_BITS_ACTUAL: please use /proc/kcore\n");
 		else {
-			if ((string = pc->read_vmcoreinfo("NUMBER(VA_BITS_ACTUAL)"))) {
-				value = atol(string);
+			if ((string = pc->read_vmcoreinfo("NUMBER(tcr_el1_t1sz)"))) {
+				value = 64 - strtoll(string, NULL, 0);
 				free(string);
 				machdep->machspec->VA_BITS_ACTUAL = value;
 				machdep->machspec->VA_BITS = value;
===>8===

Thanks,
-Takahiro Akashi

> --pk
