Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB23C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B819E24074
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1/b3YNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfE2SbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:31:01 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44705 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2SbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:31:00 -0400
Received: by mail-ua1-f67.google.com with SMTP id i48so1398031uae.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Icd3S6fysa6PQB1IvdBLYuy5pEg+pRKkO0zAPB11e+s=;
        b=h1/b3YNFUzwwTW33Zipxw/L27jtJJFS/uoN5p2DdHA3M3G0nsuslv5HtLyXAslZXBF
         YXAYkYJ+OdVsCg3Cs+bwX5YoW2csbYBr+38xCAWFrcpCvxMr33VPJrhXTHQcgYCjSgz1
         pXEoQmXGAOMsFQDNtFtHcRBZEmaeM3orpTlPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Icd3S6fysa6PQB1IvdBLYuy5pEg+pRKkO0zAPB11e+s=;
        b=DjyrhD/LlNjEWOJqM6Oaa7Z1A1XBbv+OWKdxhX+xF2R1pgOJAYXX2MGsibuh+BI/2+
         ub5b8cJope69dAY2RSij2+hinXpdgXm1JYJSnrodbxLewEUp3VDcOnGzh88ZF3fPFxOw
         io7WipQ+7bJ8Rc0+XV6Rl7lVjtZ6HD5DV1qZEOpxcntpiB9RB42gJbg2B78Vv4ioMPGf
         8TLZT0Ch++gZuIG+oMBgzuA5TDOaJJihaTyzk8RXl4wzYGts01a3AM4A9jiLBMcxoe4I
         gnQtWkHQDE/KG3bmEo58Zgxz5TS4enrjhJpR+79lCMB0KDAUTRLUyI+Nhanc83iNLcKQ
         Z1Mg==
X-Gm-Message-State: APjAAAVCyARR8aCHjvFSUbcqx+9h9CbXaTJMb+ONQ4pGob/gDcsTHhle
        PCUMXvmKmHuLEghLUC6Hmr0AWHAfx7s=
X-Google-Smtp-Source: APXvYqzMFRTFeoNy9o/ALfb+tIOu1XQVvB3QdVx6XJLWGce6EIswMeNCLptBeAUvFayUpCOuuVslFQ==
X-Received: by 2002:ab0:620e:: with SMTP id m14mr54418035uao.68.1559154654312;
        Wed, 29 May 2019 11:30:54 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id l10sm13350uak.9.2019.05.29.11.30.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 11:30:52 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id q64so2620235vsd.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 11:30:52 -0700 (PDT)
X-Received: by 2002:a67:ebd6:: with SMTP id y22mr63801054vso.87.1559154652088;
 Wed, 29 May 2019 11:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190218063730.26870-1-ms@dev.tdt.de>
In-Reply-To: <20190218063730.26870-1-ms@dev.tdt.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 May 2019 11:30:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Viag00jL-QRLsnyDoXWT5KFyZ3TnMdTPSJ-dbuNNiFVQ@mail.gmail.com>
Message-ID: <CAD=FV=Viag00jL-QRLsnyDoXWT5KFyZ3TnMdTPSJ-dbuNNiFVQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: Fix DMA cache alignment issues
To:     Martin Schiller <ms@dev.tdt.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 17, 2019 at 10:37 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Insert a padding between data and the stored_xfer_buffer pointer to
> ensure they are not on the same cache line.
>
> Otherwise, the stored_xfer_buffer gets corrupted for IN URBs on
> non-cache-coherent systems. (In my case: Lantiq xRX200 MIPS)
>
> Fixes: 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in a more supported way")
> Fixes: 56406e017a88 ("usb: dwc2: Fix DMA alignment to start at allocated boundary")
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  drivers/usb/dwc2/hcd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

This patch has been in the back of my mind for a while bug I never got
around to it.  Today I was debugging memory corruption problems when
using a webcam on dwc2 on rk3288-veyron-jerry.  This patch appears to
solve my problems nicely.  Thanks!

Tested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: <stable@vger.kernel.org>
