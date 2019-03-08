Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A371C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3DD20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FzS+23+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCHQiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:38:20 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45416 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:38:20 -0500
Received: by mail-io1-f66.google.com with SMTP id x9so17188612iog.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mc3kgEXstVrKxiL/zW8NxOi7MBM4oD4dA0kJPLSJlGs=;
        b=FzS+23+QUfF99b+UFD0HpPuw8R2Tmg4Ae57f07RoO/nFhzHUJMEYISnEGs24m30CyV
         H8fy9aQC2MHFneD2cjd+7F5Gx6jZ0XXkfKgslX0qyncv7PaYIARMyjyPgWsAuVeig0No
         ngJW5D4ysUYEv2eywvrFQSZ20R/uqt1T+E8vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mc3kgEXstVrKxiL/zW8NxOi7MBM4oD4dA0kJPLSJlGs=;
        b=e+k14J1sDXIai6VDp5WHIBHEloIi69VGpCN0iMx4WfPc28YMNJ6y0VJpgyY4dT4U4v
         Ronx+u+OyoQJWK6v6PfNQAphm8YiFsE/Wl5OKb9gJxUvr/Kqwk5P7kGKMuPNrTmG4SIe
         76nUu+vWJdboRX374YOUcFiSbB21WyfMIehTrA4Y6ohnSmlJsLWC4d0l/4qo0voM4jSE
         ijoHvNyXZ6IlfGxSCb7igoiH7sIq2ZxpEt6oaMpadU0Tdeo9UgUdnI/9PtZEyxadJ4ux
         XoiXIF8LmL+HUhUlZUm+00kRcwAgA+aqpkFmTrmQDdzqDt/S1gHomAdBJ8C6XgUy5LfO
         s8/A==
X-Gm-Message-State: APjAAAV2o7H+Xbe5C57u3exZiQE/ItcSv8ntN4IKGuZ23bful8lIRHHs
        BtR4TcjAli8xRh0HujkMBuGHjWPku5/GrN+GMuGAxA==
X-Google-Smtp-Source: APXvYqzppXTY5wEZvSKJKgQMuiVD9MKQoixLf0ztyMPnIlCNgAyIDWQ7oTkTJT9MlQtQtrIWt8fv8qIhHJB//xvc65U=
X-Received: by 2002:a5e:8d13:: with SMTP id m19mr9541141ioj.43.1552063099456;
 Fri, 08 Mar 2019 08:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20190220233658.986-1-eric@anholt.net>
In-Reply-To: <20190220233658.986-1-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Fri, 8 Mar 2019 16:38:08 +0000
Message-ID: <CAApk1dVubN7ME6GNuedGmF4V1qnH_JYnSEvFffAzwsMFaZNmgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/v3d: Add support for V3D v4.2.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, a few things I thought of after sending the Reviewed-by email...

> +       v3d->reset = devm_reset_control_get_exclusive(dev, NULL);
> +       if (IS_ERR(v3d->reset)) {
> +               ret = PTR_ERR(v3d->reset);
> +
> +               if (ret == -EPROBE_DEFER)
> +                       goto dev_free;
Might be preferable to make this explicitly check against the
not-found error code (whatever that is)? As in if (not found)
<fallback to bridge> else <return error code>. Similarly...

> +       if (platform_get_irq(v3d->pdev, 1) < 0) {
This should probably explicitly check for not-found rather than any
error. As-is, we might silently go down the single-interrupt-line path
on a platform with 2 interrupt lines if platform_get_irq(v3d->pdev, 1)
hits some other error.

> +               ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
> +                                      v3d_hub_irq, IRQF_SHARED,
> +                                      "v3d_hub", v3d);
> +               ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 1),
> +                                      v3d_irq, IRQF_SHARED,
> +                                      "v3d_core0", v3d);
Not introduced by this change, but return value from first
devm_request_irq ignored here?
