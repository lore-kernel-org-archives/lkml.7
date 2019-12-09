Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F2DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76122068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtHK5BAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfLINRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:17:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34767 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfLINRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:17:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id f4so15426768wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4+QA/tgnnIgBecFWO74sIEulDFPFsySoDm6BKiBPuIs=;
        b=TtHK5BAIe4p2p2E4v3xakR8r03HFNDQD5p0kmKz6BqeglB72D1LS8HQckhtJdHYF6s
         UcCKoi/Z26YLLdKCJZO+HHHQL+HS9tRQPacXFHLuQgBYAD6Ge4fuqL4Xf50Up5kaFVaN
         E80bJ/7qKJ6AT/ZB7OgrGuq10uBIRuE4u76wNjS+Lk13f9ERx82b9DEIdRszzMcWMBf1
         9RxdH5SvcD+8Ckh8gCm1KGVOFlAdQ53hzYeh+wI21DlPY1gKU3CrvPgqWRV/DqnAKBmp
         hS1dODN9nRn5R0AX6pWoVsavUa3k9tmYxyDfUiYCEImgVQi1CgqfeggiiOQiNHZ/L8m/
         /Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4+QA/tgnnIgBecFWO74sIEulDFPFsySoDm6BKiBPuIs=;
        b=R+U0KvNGdIe5sJd/Y1dyHJfVkKDkItu7PI17jhCw1VqA8h23mex5C4PnAQ9p8Z35lw
         yDBX/2OwAbnWOCIp19KTUic4mmnQm7mGLC00c5lqnQfH5YcnBg1P69kHJB+N5BxM+g1W
         FM6o3INjGtUNpFyZoyVqIoVwh7ejx4GBfIlk2o3jIV3HofYOgB7dvdRLreLLVZGLZU4K
         cS6YZK9cAJQnARiDAxys+tg+N6ZEolUaHoD+Jj6iIz+uF8MKxD/0CKk1jDMZilaGIA3O
         E4C0j911YYSS5wMiqoubDpLneV5kYKMzOcWPP6iL0olAP3i6vU+fbNInrIIZqTSkAJKZ
         OqSg==
X-Gm-Message-State: APjAAAWslXuRNvP2MbTGKqYG0JM2i8/QjjxR1KeTvS1mz3pWP938rJX0
        /XK/DqG0CTouP40dMpuX9Oa/jQ==
X-Google-Smtp-Source: APXvYqyRDWEKFoDHnaCmaf2MHVbQ5xRPyxwdKLhtWp6mVWE70kvawyamBbCkIcnqRzgXhvTg64VXvw==
X-Received: by 2002:a1c:49c3:: with SMTP id w186mr25635339wma.53.1575897473285;
        Mon, 09 Dec 2019 05:17:53 -0800 (PST)
Received: from dell ([2.27.35.145])
        by smtp.gmail.com with ESMTPSA id u14sm26646505wrm.51.2019.12.09.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:17:51 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:17:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>,
        Akshu.Agrawal@amd.com, Guenter Roeck <groeck@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 4/4] platform/chrome: i2c: i2c-cros-ec-tunnel: Convert
 i2c tunnel to MFD Cell
Message-ID: <20191209131745.GM3468@dell>
References: <20191121211053.48861-1-rrangel@chromium.org>
 <20191121140830.4.Iddc7dd74f893297cb932e9825d413e7890633b3d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121140830.4.Iddc7dd74f893297cb932e9825d413e7890633b3d@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Raul E Rangel wrote:

> If the i2c-cros-ec-tunnel driver is compiled into the kernel, it is
> possible that i2c-cros-ec-tunnel could be probed before cros_ec_XXX
> has finished initializing and setting the drvdata. This would cause a
> NULL pointer panic.
> 
> Converting this driver over to an MFD solves the problem and aligns with
> where the cros_ec is going.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> You can now see the device node lives under the mfd device.
> 
> $ find /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.auto/ -iname firmware_node -exec ls -l '{}' \;
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.auto/i2c-9/firmware_node -> ../../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00
> /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.auto/i2c-9/i2c-10EC5682:00/firmware_node -> ../../../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00/10EC5682:00
> 
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 36 +++++++++----------------
>  drivers/mfd/cros_ec_dev.c               | 19 +++++++++++++

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
