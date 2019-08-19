Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC91C22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gHxmZzIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfHSSV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:21:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35896 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfHSSV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:21:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so1640322pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=jP/JQPgiqAwhWQodLXFsl9IKaLN+6gUU9OI6gGA5uas=;
        b=gHxmZzIyVuqmW6gvuv7zh2ZbslqcwvNtBNwHBaPPklw5C56nMIakO/vuigwOKP0dO+
         NhxDDASRUqAvrKZ52GXCqj8461rIFSCG69+jwIuvyUvfcKjWTA75lB91pT/T0owzTIo2
         bH2F6CztvO609JlSizcGnC3fhjF14lWJCQg8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=jP/JQPgiqAwhWQodLXFsl9IKaLN+6gUU9OI6gGA5uas=;
        b=VJNX8yTpN91Ec0j3LEQOZCKdu+m2LInubautWGDb7ETF9GJwTbI3wMm7fLCegrZcrQ
         TK3cQXT1NtjwreHcDvA7C7ybBY/YWwDMlDx9Xlj4JU1msyq+cywr+YjJ0GKBV8BUBvcu
         sMbcpdy3e1s5WWdkQQJ6+oL48MLRPzp4umaw6kt26Uy5HiDe+iy08AfcQIlzFI/NMVVU
         UFvZgftxezgXYHxEVFsPHrfTgDVCkGz5fA5abhpQKhbowOl8cS5gG2EInNb3hj6n2KVs
         RsLkq9iw7B/Mg5cS27fNJMsELm0kQt2xD/MWXdboLnIEq+/dcnaDkx7OcdNT+UXRTEm/
         d9Lw==
X-Gm-Message-State: APjAAAV7JVlvDFf/j5oiEIQ0kmfmSaQutXDkA2g7o7rXsnJIrebw1JwS
        qBaVF5b/LYw5Iq/SBuRghBkLSMbRAn/Ing==
X-Google-Smtp-Source: APXvYqzgrtmFVvmKO/7WWQrhphfl8a0I8GR0ubDqk15rivjyHR6au16Dm+7k27bol5FZ98yJG+GIqg==
X-Received: by 2002:a63:2157:: with SMTP id s23mr21793454pgm.167.1566238915467;
        Mon, 19 Aug 2019 11:21:55 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b14sm17035231pfo.15.2019.08.19.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 11:21:54 -0700 (PDT)
Message-ID: <5d5ae8c2.1c69fb81.25dd0.ca75@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819175457.231058-3-swboyd@chromium.org>
References: <20190819175457.231058-1-swboyd@chromium.org> <20190819175457.231058-3-swboyd@chromium.org>
Subject: Re: [PATCH v3 2/2] PM / wakeup: Unexport pm_wakeup_sysfs_{add,remove}()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Tri Vo <trong@android.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 11:21:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, subject should be

PM / wakeup: Unexport wakeup_source_sysfs_{add,remove}()

Quoting Stephen Boyd (2019-08-19 10:54:57)
> These functions are just used by the PM core, and that isn't modular so
> these functions don't need to be exported. Drop the exports.
>=20
> Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> Cc: Tri Vo <trong@android.com

Messed up the address here too. Should be

Cc: Tri Vo <trong@android.com>

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/power/wakeup_stats.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeu=
p_stats.c
> index bc5e3945f7a8..c7734914d914 100644
> --- a/drivers/base/power/wakeup_stats.c
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -182,7 +182,6 @@ int wakeup_source_sysfs_add(struct device *parent, st=
ruct wakeup_source *ws)
> =20
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> =20
>  /**
>   * pm_wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs
> @@ -205,7 +204,6 @@ void wakeup_source_sysfs_remove(struct wakeup_source =
*ws)
>  {
>         device_unregister(ws->dev);
>  }
> -EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
> =20
>  static int __init wakeup_sources_sysfs_init(void)
>  {
