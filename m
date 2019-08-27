Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3916C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C222077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9PXFeoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfH0MrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:47:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39988 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0MrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:47:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so18651535wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Mmg/CV+E5swW47zCZMM5HqjObfVMKUEI8HgI/3Z7N+4=;
        b=K9PXFeoSBoBTxt6NHl3NO4cpuMBw3NU60uP+qc6KQrFurTIArQWAtXjGCMqaU8CaPK
         DIWQHkEA6186IYCLyLHxmWHZ5yISMm1o6UXYycpm8YX6zXDwSqamZJt0tp7LBymbf3sa
         6GtKHDjZPOY0M7cT9nAdc0VasoCFsXaTA7HYG5P8REKzF3MHEPrJLPU46HdIDYECPe+u
         fskJcPeoswnH7iu8ftuti7EOvwXZhYS3dmlxGT4K+/Qp4WiVnJfhUpuYOAVsYbXfvBHQ
         nLvQg8rfZ6kgN2hA4usMLZkoYCS2jtBk4w8LKLnQ5UK5zI2XajeEF/K20Iy23BT8frt5
         SlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mmg/CV+E5swW47zCZMM5HqjObfVMKUEI8HgI/3Z7N+4=;
        b=I9wff9bQkQGtxOS/53EZDxpcNaXftWBDhX40R8bP4gVGx6raKN14QbFM1DhJC0i896
         PgN66s0OPpdNSsDQTuU8BE/ATxGdvPF/8FvrIPhUzSuwIEMW6QmKBR+TFEGkiSFlJIGg
         OJREzlnw155r3rf8+9FiPuaNg5nZ6eAW6nSjZs/P2Jd9/dm2xLWhxNr72SCBkTlWtL4O
         YcXumDOySF2Ctwwmm6hKBOtZJmfxGzpw0p1ZePaqP5TfFsliIMpiwNM+i7VDHOmkb4Gb
         HJszFAX2FK6tR7M/E3/VrN93wzdtzCY2mLPr8+ckESSxWA213RUY9jKweMM+H9H3TxpY
         H60A==
X-Gm-Message-State: APjAAAVIBpvMPqsRuWetBD2x0k2v2mDxLYkZpOV9dnghnsbDG6kL0nj7
        dKR9PB3M9ql7aF+9mQpBkGCq1g==
X-Google-Smtp-Source: APXvYqwZAhl6YpJjYYXAyMGUX0CA/mWYCtjEntHJvIF66p59cmxfH9vJiZT/n6KJBXVT+mrkxWF4gw==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr871859wrs.117.1566910029426;
        Tue, 27 Aug 2019 05:47:09 -0700 (PDT)
Received: from dell ([2.27.35.174])
        by smtp.gmail.com with ESMTPSA id f17sm3715068wmj.27.2019.08.27.05.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:47:08 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:47:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v6 10/11] mfd: cros_ec: Use mfd_add_hotplug_devices()
 helper
Message-ID: <20190827124707.GD4804@dell>
References: <20190823125331.5070-1-enric.balletbo@collabora.com>
 <20190823125331.5070-11-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823125331.5070-11-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019, Enric Balletbo i Serra wrote:

> Use mfd_add_hotplug_devices() helper to register the subdevices. The
> helper allows us to reduce the boiler plate and also registers the
> subdevices in the same way as used in other functions used in this
> files.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v6:
> - Improve patch description stating the reason of the change (Lee Jones)
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Add a new patch to use mfd_add_hoplug_devices to register subdevices
> 
> Changes in v2: None
> 
>  drivers/mfd/cros_ec_dev.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
