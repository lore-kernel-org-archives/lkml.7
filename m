Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143B5C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63F92183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euE0xGco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfDRH4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:56:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33795 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRH4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:56:22 -0400
Received: by mail-io1-f67.google.com with SMTP id n11so1252434ioh.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2UzSdixNk5LWdluaehtIOu/3hv6Vm+FwUTb5Vp0FEw=;
        b=euE0xGco1DXEV1QQ5sha4h8W2L/PWygfo/KrvW3rvqm++PHhqArlp6dp2mnK/ZehcH
         gvT15HN8cP2HW2YoH6CzID0g5EyPdPIQNPDtEQdP4/nPMT5LA+O4lcBUDIHg6NJR+zIv
         NZI0nqVmZPb8f54Y5Vo4z2mrDwwG5OOW3kfIwW/Jp8AlD0GYoeDANa+i49spKPPYuq0K
         eB2q7mi+AUKjvaxgor9qta7XaOnMLss1YevB/WCYSPTxSGOVsineu7ZKP+afNpmzmJtB
         Jq5f4QamHLO64M9ASxRjjsSD9NJv/ijEIyLmTRmo1YjA0BMIpZFbgnNd1T6fYlPxCnCO
         dLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2UzSdixNk5LWdluaehtIOu/3hv6Vm+FwUTb5Vp0FEw=;
        b=HqiBw3MwjHR49fZzc11fFRKDhJzF1XL/ajc0uelOVgbOlanAgUMF9PWMRJhqGxlxgA
         O7GnVW2zqr/bHX98NohiKwDfV5FkHyWGZfIvecEuY8Y4822RNvbDRFx8KCTNg+KrEQWW
         oEbDvb2gbgI0AAPwEAAJGVk4W+rOxOdB9+vCX91tHVjegadd3uz07yQZrxQo7RsBIzKg
         wtlehRFPNEcuLklhdiH8NWHptPhbQxFtS4ZBKANC0hS0KxH1ulB/ykGi4aHiOrkwpCiO
         /iYY2qXTh9CymZRMYAeEwSp/Jrcl9YqFG1ReIgzCPbCu6qHPXp405ehdsfD8N4NXd041
         yjyA==
X-Gm-Message-State: APjAAAVRNl6kVT/rGuFkSUOiRqcijbU+2iAOweG2hLTLwkHljSRlQmA7
        NVvoz/NELL5DeoDJocvaYGXyX3DhlaDD02mW1g==
X-Google-Smtp-Source: APXvYqy3/AiWFLtl7DdxK+orv3X+LLlJ5M7DuZrDjkgy4gAb9uUUoV7e4CdWVTIOA/wW8yUeMEjVNV3Nvr94ZaHieWs=
X-Received: by 2002:a6b:ed0c:: with SMTP id n12mr8498551iog.259.1555574181252;
 Thu, 18 Apr 2019 00:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
 <1554703115-15299-3-git-send-email-kernelfans@gmail.com> <20190416190128.GL31772@zn.tnic>
 <CAFgQCTuDVk+Zav0v-WfPmEjmuOW-P+n3x9SmZj54ky-FJ82_+Q@mail.gmail.com> <20190417160618.GG20492@zn.tnic>
In-Reply-To: <20190417160618.GG20492@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 18 Apr 2019 15:56:09 +0800
Message-ID: <CAFgQCTsPGp3vwDYndXR2Qk=t2X9Gqg-82KicoAKLon+TgkkAWg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86/boot/KASLR: skip the specified crashkernel region
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:06 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Apr 17, 2019 at 01:53:37PM +0800, Pingfan Liu wrote:
> > Take __parse_crashkernel()->parse_crashkernel_simple() for example. If
> > no offset given, then it still return 0, but crash_base is dangling.

Sorry for misleading, I made a mistake. In
parse_crashkernel()->__parse_crashkernel(), { *crash_size = 0;
*crash_base = 0;}. Hence no need to initialize crash_base in
handle_crashkernel_options().
>
> Well, that is bad design. parse_crashkernel_simple() should return a
> *separate* distinct value which denotes that @offset hasn't been passed.

Then in my case, either no @offset or invalid argument will keep
"*crash_base = 0", and KASLR does not care about either of them.
>
> Please fix that by having it return 1 or something else positive to
> denote that there wasn't an [@offset] given.
>
> And then correct that crap here:
>
> static void __init reserve_crashkernel(void)
> {
>         ...
>
>         ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
>         if (ret != 0 || crash_size <= 0) {
It is not elegant. Will try a separate patch to fix it firstly.

Thanks,
Pingfan
>
> where *two*! variables are used as return values from a single function.
> That's just sloppy.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
