Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BBFC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C013620717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 17:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MgUN1SvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfINR2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 13:28:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38575 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfINR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 13:28:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id 7so5206580oip.5;
        Sat, 14 Sep 2019 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mA5mzxsxWnYShGZnGYHnIbq5CGiyFdSMEe2+j4i+v6M=;
        b=MgUN1SvM7yJm/8hPixwOVkO4Z5JXQs1ePB8BdjNQ9TnYTyLE7jeREeQ2oxDSoLE/Sj
         YtsTrQ59ePZpJyj/tDDvYwqDNgVLVPwpojBYibvc3+6YpzYvwo0OuMd6CGCc/0raWziV
         ICiYwQMfHk+9W+a6B5nvz3fwsHFpfpkjHAyxXGlqcfM5vfifm+0p5D01zHucaR12Akcr
         CDi3/DjNX3u3wekkM0L7ZtNzKRdjj0vphCE2RHFDyvSdbrZHKAuvVE5fAcZY4spJ3jYO
         0hybFDEoenEbsm1/On+Kq2bAOwBY41fXRCBRUuI0on4CA3x1UurrDfCXRz7dPUKJpmxy
         Ixmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA5mzxsxWnYShGZnGYHnIbq5CGiyFdSMEe2+j4i+v6M=;
        b=PSvPZFMe2cNkisKXUyl6clH1coVnJke/XnlqRS6x4zYTF/Whf0KjXdu/g3cFg9FUKs
         U5B1wg5aSkIL+/2tnlBglFcbvjPq3BgPOSKOvi+lJWY3iaY8ULUDNvrjLiLGckM8o1T2
         8ybBA4VGL4Ed4a5y5FslatygAUS15CkocxSOcRquI+DXUqJlywBqwENqB1ZgYpbBsTXI
         V1z0BXTvP0P2yZq+XOhNoEm/OPxwTI3lGc6KUZrSpOvn8lh1FiOBnsO4UvVovvRB/hf6
         clRZl7mkbpsBdIcNnA//Bv9y7QN1gcfnedZrd0QyNh4NCp6Aep5x4/fJoaMe5AooPT0u
         CbXQ==
X-Gm-Message-State: APjAAAV6SdFZ+wVr9or7gPmNrfO4TJEVvUaKP1esnc6BbbuTGOVbkg9E
        MagWBS6wJvli7FXEgCRYXR9sizGJ4Gzj6xBj8Qg=
X-Google-Smtp-Source: APXvYqyVRQJX+2iGdouQY/84grVpTaJtdKUwyl2adY9/dPWR24A4Xhdw1if4wm/5/CFwY5bCokeMy6dwm9vC0eBwrkw=
X-Received: by 2002:aca:84e:: with SMTP id 75mr8360168oii.140.1568482129617;
 Sat, 14 Sep 2019 10:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <1568276370-54181-1-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1568276370-54181-1-git-send-email-jianxin.pan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Sep 2019 19:28:38 +0200
Message-ID: <CAFBinCAcZLLtG2pYQ76wE5BjeA1fnARzb0o7aWFBNpQabLBjDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: Add basic support for Amlogic A1 SoC Family
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

On Thu, Sep 12, 2019 at 10:20 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>
> A1 is an application processor designed for smart audio and IoT applications,
> with Dual core ARM Cortex-A35 CPU. Unlike the previous GXL and G12 series,
> there is no Cortex-M3 AO CPU in it.
it will be interesting to see which devices will use this SoC

[...]
> Jianxin Pan (4):
>   soc: amlogic: meson-gx-socinfo: Add A1 and A113L IDs
>   dt-bindings: arm: amlogic: add A1 bindings
>   dt-bindings: arm: amlogic: add Amlogic AD401 bindings
>   arm64: dts: add support for A1 based Amlogic AD401
for the whole series:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
