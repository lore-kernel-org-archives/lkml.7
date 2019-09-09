Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AF4C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEA521920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x5hZJxs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfIILhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:37:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37449 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfIILhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:37:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id r195so14272224wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:references:user-agent:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=kZoKalqZhhWKQ6GSRTA3V3x0JaPlgytes3e0+INLRaE=;
        b=x5hZJxs3ph0hf3O+XGKV6xBLU0N2rUiRCdn8ru54+LH6HncjkMPO21ZUiZRvZ+1i5x
         iQqmdXYCwvp9mRdj0ZOHvDON2id86CARAXZuw5S6B5MT9/aWelV6Zf3G+q/peM+AnZb2
         tFP5jlieJSsMcjfRlr0PgevczJM83dePs6LXk89UuQNeXsawQIHoIH5jbIG852/LSAZi
         /2Q+djzKrVvz0yyQ/eFy4UqHPjiITn6kuXKfheMpMTu0jw8GUAy1AIynlCstKd2fcN4h
         txz1c2apTYXSVxwLa3dS2xhLaI31jOElfOl0+oG+kphjJsHBcgmcHOs49nMo9nOUTxaX
         1asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:user-agent:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=kZoKalqZhhWKQ6GSRTA3V3x0JaPlgytes3e0+INLRaE=;
        b=ILHnnRYMbKts9cBOqt7/BoAGPRCWMb2Lm/9yiC4NDK2OCgXuzDAeeS92s+P/ErI83w
         GaWq5yN+P0GVY8heifcpRjkMfpgimrhFd5c4/i0pzZuzy8d/ANjCjHTjmlZLzjRw2BpH
         qH7PsWQWeR5x5fLsU4i6WkWNZs4PwSd7FoHU15D7oR/jiBoQy3y90SkI3J5KTqjZAQYL
         xcABnXiEI/Pc1BvbBx/76qoLsF2RVQdrQ2frEpNMNcmRXJZNKn9LkrM1sLvz4303kc7r
         Hx+xqKrpO33AX9F7Wp33WPqjMRwZtaL0dfph/iufqjrjRs/zRKV03/ZTYtJJ3UacutWt
         0EGQ==
X-Gm-Message-State: APjAAAVg/bLPe9J+PLDunjEYB5vixKR2QjXJMJ/eFE8UOzYa8vxFWGQ7
        PiECUnSIFFf46echFTKwxvmB2A==
X-Google-Smtp-Source: APXvYqxtjd0hUrVCW+o450nTVfK83QWVgMXod2fEY5tWx4EKzD3PxuBAlvts9NPWeGtD+mt4Pidq+w==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr17945437wmu.67.1568029021609;
        Mon, 09 Sep 2019 04:37:01 -0700 (PDT)
Received: from localhost ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id g185sm27003700wme.10.2019.09.09.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 04:37:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
X-Google-Original-From: Jerome Brunet <jbrunet@starbuckisacylon.baylibre.com>
References: <1567667251-33466-1-git-send-email-jianxin.pan@amlogic.com> <1567667251-33466-5-git-send-email-jianxin.pan@amlogic.com> <CAFBinCBSmW4y-Dz7EkJMV8HOU4k6Z0G-K6T77XnVrHyubaSsdg@mail.gmail.com> <be032a85-b60d-f7f0-8404-b27784d809df@amlogic.com> <CAFBinCD7gFzOsmZCB8T1KJKVsgL7WMhoEkj3dRzyqwAnjC0CNA@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: add support for A1 based Amlogic AD401
In-reply-to: <CAFBinCD7gFzOsmZCB8T1KJKVsgL7WMhoEkj3dRzyqwAnjC0CNA@mail.gmail.com>
Date:   Mon, 09 Sep 2019 13:36:59 +0200
Message-ID: <1jv9u1ya3o.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 07 Sep 2019 at 17:02, Martin Blumenstingl wrote:

> Hi Jianxin,
>
> On Fri, Sep 6, 2019 at 7:58 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> [...]
>> > also I'm a bit surprised to see no busses (like aobus, cbus, periphs, ...) here
>> > aren't there any busses defined in the A1 SoC implementation or are
>> > were you planning to add them later?
>> Unlike previous series,there is no Cortex-M3 AO CPU in A1, and there is no AO/EE power domain.
>> Most of the registers are on the apb_32b bus.  aobus, cbus and periphs are not used in A1.
> OK, thank you for the explanation
> since you're going to re-send the patch anyways: can you please
> include the apb_32b bus?

unless there is an 64 bits apb bus as well, I suppose 'apb' would be enough ?

> all other upstream Amlogic .dts are using the bus definitions, so that
> will make A1 consistent with the other SoCs
>
>
> Martin

