Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA44C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58530224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mx51vNNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfLEIo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:44:28 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:44546 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfLEIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:44:27 -0500
Received: by mail-io1-f46.google.com with SMTP id z23so2700140iog.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 00:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wt9G2vozOpMT2hGMgKE0ip5uoYB13lnK1YvlPurVBq4=;
        b=mx51vNNmXng2Ai4iTAblfI1F6ComWE5BNDOYZ4xrxfULaKGleW01zww0J9E6sEvEGm
         lfLcgIvUw/0nKHL3PF9n6k428lWT/lZXzBTmVRVLyRjWQMqUnL/4r42HLnAkItilGkYS
         rEOKRmjE51Iy/fCKvADi2jVYm4ok8Pi5z2RxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wt9G2vozOpMT2hGMgKE0ip5uoYB13lnK1YvlPurVBq4=;
        b=PyedXjLEf1vR18QiTPhp5H1mDa5F6H56mcDTjWJNHV033oOrXyZ9dW7RFGnQzts5DX
         k2BtNHs6EQSWZKy+uyT7E6FlBeBIRkUoEwZps/j5gNFdM1LNzDcg6plHglNUf6U0zXqq
         0l+QRS7VbX3LwMjBMSiLl4pRbxrzH3VpMm/6v04Gh0QKx9gi2BXCggk+8ts3nWEnEgSx
         LrjtoxnehXZI81V6D49CemtB3GsXH/Pir4AtiXLeioAU0mIHdJhlLdl028wa0dTKVnwA
         ImAbSswTbt2tAwNQgZT7niCmLSQ+BlFXM+evNiPX70dosLFS7Wl649WDFeqYGOnkKk32
         65FQ==
X-Gm-Message-State: APjAAAUcFlRtKFfae5bM1lizuT/IH5pMLLpydI8cNCs/g5/SsdSRWfsQ
        Yulld5FzdNmqS7LCDn2D8TXuf0/M2A8QveYngQ7C/w==
X-Google-Smtp-Source: APXvYqzsTUeVlvYNSc46o8MgjJIitMPOpzSQhh53SIxsiMDq5akjwRzVyhJ8uX4NGcPMJOsXZfEjVH38FLKYx8LYJGo=
X-Received: by 2002:a5d:8cd6:: with SMTP id k22mr5264840iot.283.1575535467112;
 Thu, 05 Dec 2019 00:44:27 -0800 (PST)
MIME-Version: 1.0
References: <1574817475-22378-2-git-send-email-yongqiang.niu@mediatek.com>
 <CAJMQK-iDnOWCYmxcREGschD=sDfU6yKpUu+koP3YDeO3MPCdhQ@mail.gmail.com> <1575529976.9400.4.camel@mhfsdcap03>
In-Reply-To: <1575529976.9400.4.camel@mhfsdcap03>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 5 Dec 2019 16:44:01 +0800
Message-ID: <CAJMQK-jGTAm7YS3ov3ok0SkrH7dWEL4umC21O6RSchrfDs5omw@mail.gmail.com>
Subject: Re: [v1,1/2] drm/mediatek: Fixup external display black screen issue
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 3:13 PM Yongqiang Niu <yongqiang.niu@mediatek.com> wrote:
>
> please double confirm is this dump stack log is ruining on MT8173 real
> IC or not.
> if yes, that may caused ovl hang when disable layer not in blanking,
> then cause vblank time out.
> i will disable overlay with cmdq in next version.
>
It is running on MT8173 acer chromebook. Error only happens when
turning off display.
>
