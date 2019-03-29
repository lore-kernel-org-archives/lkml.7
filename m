Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FCCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4AE20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpQ8UfJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfC2RdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:33:07 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53204 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2RdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:33:06 -0400
Received: by mail-it1-f193.google.com with SMTP id g17so4994103ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HocMLJBbVzAgBs+xylFVdouRdmxq8t5QzvhR7VCy7R0=;
        b=rpQ8UfJSC9Qw8PtpDH8b14HfCpHkxWOSORdBAJcAAaGHBHgoFwP6hPjHzhmDRAuUy+
         o/piIG+cgNvxXMLCQ2nxfDOFAVy8v+dK5mpOdNHRdCqDiD7zNxw00sGP8xB2dA3Bm2Sa
         H5xQqq55H0wL0dNeypSZWSXrOUU++mnY+wSXgf7FoTvbtw2pYfriEQAvjJ/SdQykCn1S
         lS00dk+C+psu60wqj++/+QExGlXmJ4gMAG3M3BEDMGxbZ4iNZZJTMq85ADNN2oDp16T7
         bNukb509DXrkM9g9chv0aifgfZjiTKQmD4Q6QOViPQJyy8AD6b0Muuj0Qefl83wYqzL8
         Ox6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HocMLJBbVzAgBs+xylFVdouRdmxq8t5QzvhR7VCy7R0=;
        b=aBlcIDqm82PXKtjO4Iy5QjtoyBSr8CJmOWFIOX1vKL1FSn2i6fliSehzZFOrq58Rzf
         h2xuSZwjH7tbzY1av42LKI2EIrTcHi/bgCNSRXrm7KPNDIXPcgDISvvXgSL0mizvgxpj
         BgqArpjXAnLD6wSwNLEMFfqLwwOQq0o6JzlpYRMfJtvTd7eixqM+In5DYzIu2UQsKdFC
         Q12ht3xRwO1JFm1OBeBtAdDDiYPCOlt2ZCDS4ziFVpZLQ7Z4yjfwh/N+b1JkEsRE66c3
         +QoWnE72t1DOHYp+bY6pGb0mOTmSGPXALsNEa9Xcz7o2L7Oo7gTgYXxphLOwPdKSECyM
         3qLw==
X-Gm-Message-State: APjAAAWZfj6Mt6HWXqm9/u5p/Hw71D6A6Pie0Zq5df3EnqL+Ib/Oao3q
        2rqJYqwhPsF5rB63PBGdA+78GHlp9mxpc6Kf/maizQ==
X-Google-Smtp-Source: APXvYqzN7owRmriALBZIhc6C4dp618i9IsQzYaOLotviCjw/82XtMd/iq3Bf2wPNG2LKiBh2rMkFZrZ4bW0DqGNa3Ec=
X-Received: by 2002:a24:2441:: with SMTP id f62mr5036919ita.155.1553880785756;
 Fri, 29 Mar 2019 10:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190328235752.334462-1-tmaimon77@gmail.com> <20190328235752.334462-2-tmaimon77@gmail.com>
In-Reply-To: <20190328235752.334462-2-tmaimon77@gmail.com>
From:   Benjamin Fair <benjaminfair@google.com>
Date:   Fri, 29 Mar 2019 10:32:29 -0700
Message-ID: <CADKL2t5VuWA=Cx9q9Ddx+rZGbe1YoRKMWwfdFOCyxuGiMCOiPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Add maintainer and replacing reviewer
 ARM/NUVOTON NPCM
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     joe@perches.com, avifishman70@gmail.com,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Tali Perry <tali.perry1@gmail.com>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 4:58 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Adding Tali Perry as Nuvoton NPCM maintainer
> Replacing Brendan Higgins Nuvoton NPCM reviewer with
> Benjamin Fair.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Benjamin Fair <benjaminfair@google.com>

> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b305d2f2a8a..4ece87fcc166 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1893,9 +1893,10 @@ T:       git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
>  ARM/NUVOTON NPCM ARCHITECTURE
>  M:     Avi Fishman <avifishman70@gmail.com>
>  M:     Tomer Maimon <tmaimon77@gmail.com>
> +M:     Tali Perry <tali.perry1@gmail.com>
>  R:     Patrick Venture <venture@google.com>
>  R:     Nancy Yuen <yuenn@google.com>
> -R:     Brendan Higgins <brendanhiggins@google.com>
> +R:     Benjamin Fair <benjaminfair@google.com>
>  L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
>  S:     Supported
>  F:     arch/arm/mach-npcm/
> --
> 2.14.1
>
