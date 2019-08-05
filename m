Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25C8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665C42070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdnnKcwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfHEX3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 19:29:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40421 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHEX3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:29:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so36992986pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=wiloosTmjjcp4t7af0k+zFA/+KwYN5hZVuPSy0bPbrI=;
        b=GdnnKcweqVjIAEhLjUJNZNvqAep6YhW4RCIOksr4IDGFPqFlHO2IEreaXiUu3OzvL/
         Ag7GsiKXIZ6ylTXI00xXEtujmVXoaUw1m6Ov7RMSt9CIx0vwd1vIrNfVGGH2rKhbOisy
         KwdKzXb3TioAZW2MZIzoBE0/nHalWXsEJp0D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=wiloosTmjjcp4t7af0k+zFA/+KwYN5hZVuPSy0bPbrI=;
        b=LlviW94yWwty12IhcLYJAb2lS0rV+N3UyQn/k6Jk88MgIxrRhYUaw7a/qljlQ/if3c
         asr+ixHdcqpC3bQW7KZ4HV6avN+kGyZY+WVIm6SU9FEMQv+SvKh+HPjtU5QflXsTOgMi
         rwRSkqc2mSpxbwp56wTQuvWeGD+3bFGWyE7GLJrhdypJ1xAUs49YHrtdA9GTq9zGLLQD
         AqxBEcVu5A/I5xqEz+LLkqzanpnuh5eV30Qv2uKkkREt+0+cnh4P8b66ejFdKJLds/8Z
         QRBmcVDbpTdzSTW+uyZ0MUuD/y3KZQvR8nqurfNAbkZhGMQTPeOPhQhnDImCmV+mVF/d
         tXJA==
X-Gm-Message-State: APjAAAXUKRKT7c4gYTzm0Z7R0RRfCHLBf25P0SO3G/nfF4KUIo8UdG3W
        QycKpEMuK7tfz+N2t8TkAqYlCw==
X-Google-Smtp-Source: APXvYqxdlxKuGLuRWMULvIxTV2Gvzb8gRLweOO0FZS+Ubf3PDNdl9GD7vHZB4gQibtBFBJr3/zSE6Q==
X-Received: by 2002:a17:902:b909:: with SMTP id bf9mr204057plb.309.1565047747318;
        Mon, 05 Aug 2019 16:29:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p65sm84534701pfp.58.2019.08.05.16.29.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 16:29:06 -0700 (PDT)
Message-ID: <5d48bbc2.1c69fb81.62114.5473@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190805175848.163558-4-trong@android.com>
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-4-trong@android.com>
Subject: Re: [PATCH v7 3/3] PM / wakeup: Show wakeup sources stats in sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 16:29:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tri Vo (2019-08-05 10:58:48)
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeu=
p_stats.c
> new file mode 100644
> index 000000000000..3a4f55028e27
> --- /dev/null
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -0,0 +1,161 @@
[...]
> +/**
> + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> + * @parent: Device given wakeup source is associated with (or NULL if vi=
rtual).
> + * @ws: Wakeup source to be added in sysfs.
> + */
> +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source =
*ws)
> +{
> +       struct device *dev;
> +
> +       dev =3D device_create_with_groups(wakeup_class, parent, MKDEV(0, =
0), ws,
> +                                       wakeup_source_groups, "wakeup%d",
> +                                       ws->id);
> +       if (IS_ERR(dev))
> +               return PTR_ERR(dev);
> +       ws->dev =3D dev;
> +       pm_runtime_no_callbacks(ws->dev);

Does this only avoid adding runtime PM attributes?

I thought we would call device_set_pm_not_required() on the device here.
Probably requiring a bit of copy/paste from device_create_with_groups()
so that it can be set before the device is registered. Or another
version of device_create_with_groups() that does everything besides call
device_add().

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> +
