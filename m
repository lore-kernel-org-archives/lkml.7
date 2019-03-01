Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E72C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4RD2EOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfCAXaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:30:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55467 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAXaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:30:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so14005181wme.5;
        Fri, 01 Mar 2019 15:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQBoDmCD8InlcftL2FFK0oDOOCsdTH5YyavHlmMeLTU=;
        b=H4RD2EOPtj+J1Riv8UfYDmejm7XT86tIL43eoYGTyjttJ0KfJonsfQ8X+pEPU8AQao
         zdsUwO7Fhb+FFlh2cTwYJ5LpSz6tr7IttuxNT1RQhVNEf3bgQSwiXH3Arq4EO7xAhlYz
         5Xb3fAsQSw693eE0JqIyxPWGL/91gsymtpyyJVPnZeeqlG2wGXRQNFZijw3pBPR1i5VQ
         qFD+oTEnyLEfPwG/QD/iYQnqBLh8iFwyVyADdTQzOGJshUtNRCahOkr+kqSDTfuFTlt8
         SyLwuMaRutddZxyh+fM0r90FWO4acOYH8eJ2vBjlbkG4S+qqgh1TavdPV3vZnKhKXKKk
         k06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQBoDmCD8InlcftL2FFK0oDOOCsdTH5YyavHlmMeLTU=;
        b=ABkCuAPx7Du43rvkIQC6wNdhHhuloTUmppoMDNicoMCrB0qn3luiW88uFawWl5n4i9
         ZbaN58N34MdC8eLT1T2h2CmPPVUWJzGbo8bqgl2JfoTso8R48nxqLVhfsxBDcY6mXdik
         Ouku6d/3N1kgECavKusmxnqs72z8x5MyRA43KuEFdoF6CKd3HDug4+kFulRZzRNWmXHC
         zI/N68O76Nmf89F6vmvT22TdY+3LEfrrmuwYGspUBIWV0XRxiTNxyxY+9ABAzGwO9umP
         m7dGSASZ18SAXbS5mEkAjwWDijua/XQM5CsbPqa56j7GRfkYe34qhJO9u+/eobbAmZVQ
         Pj0A==
X-Gm-Message-State: AHQUAuZ2rSkjvNahRUQGSTOT1qF/9bH5OI5k2x9lLwxdmbGVbEY3wJiS
        vEwiY6iaRCO6Yest3DlzULQllJ0RbhI5DXsBJ8g=
X-Google-Smtp-Source: APXvYqw5J9nP9Wv35RdKav1p1ycSAvPSQ52V0tN8Wt59NTdue0GmxsxvLKglC5dQY7SQbvY1ueBdo/8O2VnfKq9CND4=
X-Received: by 2002:a1c:47:: with SMTP id 68mr4388333wma.89.1551483010430;
 Fri, 01 Mar 2019 15:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20190301132351.6f4e815f@canb.auug.org.au>
In-Reply-To: <20190301132351.6f4e815f@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Mar 2019 18:29:58 -0500
Message-ID: <CADnq5_PXqjcQeH1vh9ftpPfoCzD5SfdcXQSqAh2BPgrs1V28LQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the drm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Francis <David.Francis@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 9:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>
> between commit:
>
>   d63716658ac1 ("drm/amd/display: Use vrr friendly pageflip throttling in DC.")
>
> from the drm-fixes tree and commits:
>
>   8a48b44cd00f ("drm/amd/display: Call into DC once per multiplane flip")
>   bc7f670ee04c ("drm/amd/display: Perform plane updates only when needed")
>
> from the drm tree.
>
> I had no idea how to resolve this, so I just effectively reverted the
> drm-fixes commit.
>
> I fixed it up (see above) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

d63716658ac1 ("drm/amd/display: Use vrr friendly pageflip throttling
in DC.") should be reverted and this should be applied instead for
drm-next:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next-5.2-wip&id=5d5f43c235d02e4d8e9d50d012f3b21f380486eb

Alex

>
>
>
> --
> Cheers,
> Stephen Rothwell
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
