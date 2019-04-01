Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6963A2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHGM3kNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDAKwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:52:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41630 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfDAKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:52:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so4567369pgs.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LU92lbynmcHVOGum9qmV/Sx9jbs7sSGYzdSK54vBy4I=;
        b=eHGM3kNW+jq4bIW5FqmSBJgg4u4gLgh5k/5zHlIs/K2b/vO7o2/bv/6xyLQq125wHI
         RvQG/tDpTj7klqF7bjfygBgidZQhU996/saBDN6n2S9dcD7kucsKhGui4W1/+N7bLgwn
         KrI/Pc2G5egPQjSqZ5IRGXcEtC/G8fkYFdV4ujpKZC68fRSIMVwEefa2JEskc0gijJ/T
         Gywwkh3eLcLXJ0QZWEeC6sdz+ffHWgANzy0zcVS7+gIZZ+N3otaNsQG43n1IXvancaE0
         rRODYTitV+/M6W6Xbx75MENQe15q41omW631pOQ+JRMcN4nLg1CHzLwyfleY1jOb0VDS
         pWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LU92lbynmcHVOGum9qmV/Sx9jbs7sSGYzdSK54vBy4I=;
        b=JP9PjFMhBAGI/Jm5kmbHsGrTDTyVn54m7d4swWth0NCnphIV06qCsBrU6UEoSfQpQX
         hVr2zLG8wM4bmiQeMtrvf8fIU4xlj+3yBCju453r8YagUehm2jTCB6R/JNCcbH1rltwf
         uJFHnhqzN0wLKyqOb+JCNtHn+0xd82OIrOtfD5HVk1Qg/sAFTdvrLmKQ5HchyAqlftf3
         CKRI8np4Ici0+gYk6ZtxTibxJOUPgkfB3fa8IIHAU6BkjCTcjU5hGNP/h0qk7oScVJBp
         /ed9rlrCszlILBvGcf+YpVNP+0YT6z+UwqmgdjxOJ/d62H+u6KFLBGCE9q8lwafYPuJN
         WFZw==
X-Gm-Message-State: APjAAAXoWt4MwdzdicwDgWDwIOK8Dsakul5HmAQBA0upy4IrlR1qWVB8
        WptNWD7X/s8nLnFi4womtuxtDg==
X-Google-Smtp-Source: APXvYqw0qyzsIgOnK5ZRLqXUt3OZ3rofK1Ww0Wpehk7yuiTVTZxZ2Jcgep97VE7XpL6lxKWwK3CgGw==
X-Received: by 2002:a62:e412:: with SMTP id r18mr10262951pfh.207.1554115920197;
        Mon, 01 Apr 2019 03:52:00 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id j22sm13023639pfn.129.2019.04.01.03.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:51:58 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:51:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Add Lenovo Miix 630
Message-ID: <20190401105153.GE4187@dell>
References: <20190326185525.20781-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326185525.20781-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019, Jeffrey Hugo wrote:

> This adds the initial DT for the Lenovo Miix 630 laptop.  Supported
> functionality includes USB (host), microSD-card, keyboard, and trackpad.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/msm8998-cls.dtsi     | 278 ++++++++++++++++++

What is cls?

How much of this will be reusable with the other laptops?

>  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts |  33 +++
>  3 files changed, 312 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-cls.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
