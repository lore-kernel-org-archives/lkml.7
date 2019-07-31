Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A108BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7702620659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n3A6uLsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfGaV7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:59:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33798 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfGaV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:59:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so32614971pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=IlRwSSoXPkPO8ZlfGQyrA2PVh0oI2jbeG8M+xqYWNuc=;
        b=n3A6uLscWmFreF939tyOlPubPIYDf44Y3GSbMd5VGwmGbOLz9PMLsYyy6hnO/F5hv7
         HRy2Eq8dQckDsTk18S0fC9yE3YBQk2EeHDpNnOb5HFGvC/FFwabnJ4NyZjZOxhGFbpDJ
         KsRbZRE0bAvaZy7+ZMWdBaHcQQyv7phuAIuXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=IlRwSSoXPkPO8ZlfGQyrA2PVh0oI2jbeG8M+xqYWNuc=;
        b=MqVZmCoTgEkOS24ymSAHjbVy2qastS011OG5/gbyu3vXBtbHG4PwLYEYlbtsqpPnA4
         f+kkmbCXE1tfaBjwJz7lx9HVYVNF9yf39Cxg2/bp1NEnAi9nAX9ufirRmGutnN4bYyUO
         7H2UC7sfwnA/vuFhmV+d6wVlECiO2qUN4Z66uI9SLDcYEKuD/g7AI/rjgUCR1+nfk7kz
         1h5LzfOjc/cKolQ2cpa17D6gz5Hff6AgbyVCE96BaxEyfJSE5J74e2bBl1heyd7mBKs7
         Bjn5i77CmuvCF+CG64jHpRJC4AFm04xxfByveQFthOiPSLuli36fDhDb7VS0S5asKCTZ
         yy/A==
X-Gm-Message-State: APjAAAV1wwBOiSaodE/gi4qR93gXThfJNi1BjP2DNYNYnhyOjyn+Bd4Y
        pC7HFsa1Zwa1OKF8CDYETf3oJA==
X-Google-Smtp-Source: APXvYqxRyvbUZhJsewElOw/jGc81nEj+n2gFMTff3FnLVzjQbJ+uJcjTMouUatne6W5Kncq5F9kkXQ==
X-Received: by 2002:a63:184b:: with SMTP id 11mr55358650pgy.112.1564610374310;
        Wed, 31 Jul 2019 14:59:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i14sm108093300pfk.0.2019.07.31.14.59.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 14:59:33 -0700 (PDT)
Message-ID: <5d420f45.1c69fb81.35877.3d86@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731215514.212215-1-trong@android.com>
References: <20190731215514.212215-1-trong@android.com>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 14:59:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tri Vo (2019-07-31 14:55:14)
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
> +       int id;
> +
> +       id =3D ida_alloc(&wakeup_ida, GFP_KERNEL);
> +       if (id < 0)
> +               return id;
> +       ws->id =3D id;
> +
> +       dev =3D device_create_with_groups(wakeup_class, parent, MKDEV(0, =
0), ws,
> +                                       wakeup_source_groups, "ws%d",

I thought the name was going to still be 'wakeupN'?

> +                                       ws->id);
> +       if (IS_ERR(dev)) {
> +               ida_free(&wakeup_ida, ws->id);
> +               return PTR_ERR(dev);
> +       }
> +
> +       ws->dev =3D dev;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> +
> +/**
> + * wakeup_source_sysfs_remove - Remove wakeup_source attributes from sys=
fs.
> + * @ws: Wakeup source to be removed from sysfs.
> + */
> +void wakeup_source_sysfs_remove(struct wakeup_source *ws)
> +{
> +       device_unregister(ws->dev);
> +       ida_simple_remove(&wakeup_ida, ws->id);

Should be ida_free()?

> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
> +
> +static int __init wakeup_sources_sysfs_init(void)
> +{
> +       wakeup_class =3D class_create(THIS_MODULE, "wakeup");
> +
> +       return PTR_ERR_OR_ZERO(wakeup_class);
> +}
> +
> +postcore_initcall(wakeup_sources_sysfs_init);

Style nitpick: Stick the initcall to the function it calls by dropping
the extra newline between them.

