Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070E3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E572070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YygxDZKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfH1Pqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:46:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39300 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfH1Pqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:46:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id y200so53220pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=ZS7Y/y5POlRQUUgjwfRwjQqTrIKK4/cYLXKkRxQMVLA=;
        b=YygxDZKDgpTMBwfaJOXbtDUYsVR/OD0HLLqOuPHJaGowNBJJHlCU6oBH580wryI5wi
         wpg00RYwJjHFGLA3bheil7dv3mvZwsG9H0lOGqgX0NDk0Vr9TD5v5nALa3ttOy3GLk4H
         yrQJPl7V/3e3mFvs0NZjGgkBZ18zf8aSILf/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=ZS7Y/y5POlRQUUgjwfRwjQqTrIKK4/cYLXKkRxQMVLA=;
        b=mopgWWFQLsSqrESE9zqCCeC4aDOrYWpqSVXpCdcFZy67a7Hqe8LPzl4TPTMwUNe20f
         uCuAD3vT81yhq6GBsdT97gCH5aSDebyngcoNpSgXxSAPInbAPNOcuzup4c0APC5rGm/q
         nMDKD2NOSptsW/LuKqFReQsBvldQL9TI4aqrnlrXO7u6QLY5afRPfLV/4DrK7jFiUeR7
         6BvyfqxR0zz14+qO0UsD91zn9aQ2UEtsKzpImtRbKzyCFk1g9UnjZHTWZCKJbdtzhXqU
         +NqjJCGdhgBcoGA1hm/XenvXrt9eZyOjDYNl7xmh741WfWyc9UbENpIZ1BvygqtQNH/v
         4smA==
X-Gm-Message-State: APjAAAUgcrcP1tj+nE8RTcBw2E6QPGHY4mFhxpYT8w0c8xtodRdX7tTM
        i5+DuLqlhj+zOd+fFtf4cjW6cA==
X-Google-Smtp-Source: APXvYqzHau1v45Oh2FPo6aVD3LD+hHdX/kvw0eeGCfDzNUtpYjvq25YTCIBKx/Ar/+gfOBBnh//Xxg==
X-Received: by 2002:a62:f20a:: with SMTP id m10mr5396909pfh.95.1567007210488;
        Wed, 28 Aug 2019 08:46:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r6sm7757096pjb.22.2019.08.28.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 08:46:49 -0700 (PDT)
Message-ID: <5d66a1e9.1c69fb81.45c82.ec94@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190828083411.2496-1-thierry.reding@gmail.com>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: platform: Introduce platform_get_irq_optional()
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Kamil Debski <kamil@wypas.org>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 28 Aug 2019 08:46:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thierry Reding (2019-08-28 01:34:10)
> From: Thierry Reding <treding@nvidia.com>
>=20
> In some cases the interrupt line of a device is optional. Introduce a
> new platform_get_irq_optional() that works much like platform_get_irq()
> but does not output an error on failure to find the interrupt.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Thanks!

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

