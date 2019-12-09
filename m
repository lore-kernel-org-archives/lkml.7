Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD586C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908EF20663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fluep6Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfLINQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:16:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42830 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLINQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:16:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so16115138wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 05:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6JKjS8ULGOzUFR7zV+Ndftoq/ev83XREiug0BBdNIeE=;
        b=Fluep6Cy08Kzg9mPraMCdGJvXYVj7EnADOl1PYagnYKgrHsKt1Xsp9NRKUB+ooeph/
         vP1+nnfyracffXp6R4IWPuaA7oCZWLkd6UpAvbwPT8oMhZKdDaZDYxR8YyhaW5CtdN0/
         jQMOwkxHx0EfxlhkGxlS4Wm+dDO/tKc/uQdzSCJyN6rnJNfK3QiH4T3LcvbHymztIO/X
         exCokdFITCA6+DJkwR6Z7p+pwf7cFCKcyxsQ3LPAyLO9rtDkjaFip8op45XbbJ62+Bnv
         YtOSlyoy1OXRn487KoaySckqJh++QDJvxdhmXQLOe1XR0g1/u96bV0K5wTZYTF2bPDLS
         2i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6JKjS8ULGOzUFR7zV+Ndftoq/ev83XREiug0BBdNIeE=;
        b=twvbaANwlkMlZgAkfgBOCUVLxrOGnF0eBqcu+Iwnhp9L8UtUJezpSvv2i2/5Uw93J7
         w/ImC/jBwOn7anZHqfW8s/WRZjOibh1exc/DFBt0S5cBbZQVhisfjnTdOxMnhVuuiDtE
         ELzenk7Eq+rmlar0EsPrjWKVlWS0Ug8XG7oUsB7icfMqICTiG0wOq7HYjjNO0mS9nRS+
         AOOKnKdPXFj/3/Ebz6wg5cBogB83smgtVzBk7xsLNKo5p4XUW/JlW8tifbTlN7FsD+uA
         BEwrge+IlD1MrwLXKWfRSzlsV00VsDZDtBKXke1tNtoeYlcr6bP7Y6VN3d78+GcA/1Jz
         LEsQ==
X-Gm-Message-State: APjAAAVCgJwzT5/lmtbHjswL8NaIIblGipiyGhpPOalhjFnsvg7KXgXf
        UZU+Dp3vBH7tPb1qVnkgvPFSHg==
X-Google-Smtp-Source: APXvYqyfJb9ulY7eYGRni5x1EoiZ65N/w4IbXiFtTbTgqXufBVfAXngFIBRVWJ/guKS6mVh9b6EFmQ==
X-Received: by 2002:adf:8041:: with SMTP id 59mr2019145wrk.257.1575897385263;
        Mon, 09 Dec 2019 05:16:25 -0800 (PST)
Received: from dell ([2.27.35.145])
        by smtp.gmail.com with ESMTPSA id d8sm26935218wre.13.2019.12.09.05.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:16:24 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:16:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, broonie@kernel.org, linus.walleij@linaro.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 03/12] mfd: wcd934x: add support to wcd9340/wcd9341
 codec
Message-ID: <20191209131618.GL3468@dell>
References: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
 <20191121170509.10579-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121170509.10579-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Srinivas Kandagatla wrote:

> Qualcomm WCD9340/WCD9341 Codec is a standalone Hi-Fi audio codec IC.
> 
> This codec has integrated SoundWire controller, pin controller and
> interrupt controller.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Change since v3:
>  Fixed lowcase usage of wcd934x as suggested by Lee.
>  Updated few if checks as recommended.
>  add defines for SLIM devic and Instance ID of WCD934x
>  Updated device name and compatible for gpio controller driver.
> 
>  drivers/mfd/Kconfig                   |  12 +
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/wcd934x.c                 | 306 +++++++++++++++
>  include/linux/mfd/wcd934x/registers.h | 531 ++++++++++++++++++++++++++
>  include/linux/mfd/wcd934x/wcd934x.h   |  31 ++
>  5 files changed, 881 insertions(+)
>  create mode 100644 drivers/mfd/wcd934x.c
>  create mode 100644 include/linux/mfd/wcd934x/registers.h
>  create mode 100644 include/linux/mfd/wcd934x/wcd934x.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
