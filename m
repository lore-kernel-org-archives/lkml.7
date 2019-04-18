Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A19DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D832083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IuxWKeZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbfDRPmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:42:50 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36440 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:42:50 -0400
Received: by mail-ot1-f51.google.com with SMTP id o74so2089073ota.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGBp8E9sWY2g1vA1BwsDvb6YIZTbEwMwQ8ExTOjqap0=;
        b=IuxWKeZdDeALJ3RVuyXqq949K7Ut5Fu1+cOgStxBLkbDhOqShMQtIq1aLshqdXfsdi
         1KGf9yk8FmDxjNqaHOnYo2wWFMgzKYbFLSwoq4m4ZcMc1Z4SLACqK4n+AaqT3MWN+NnH
         4XiOU749N1w3V3kqvVNLTJvKAwVSk5Gk6c7UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGBp8E9sWY2g1vA1BwsDvb6YIZTbEwMwQ8ExTOjqap0=;
        b=arRsHEtkCKSACVwTmbTTTja08sk6UcFlvo/wNGzEzPUELoVfYDJVi1eld2rOZhdZXH
         sNKtySDFovDHmBrlzysVCKw2Llu+HUtsAuEITPCh68vlm4q9A+VQQ79tNnX/DJBj1YEL
         p3/6qV7Ejsuujlg0toUKyQLGlXSQlKJQBXA3wnOXKmflTQPb1jQztefu9/AaBJcK7jiC
         9/UTBUVIbueNzQZ+C3xF0ke+5kCxJL3RulKy1MClrZUL6tEDqs+1aJhfklPIS2j8wyy7
         F8xHfZHFUPsggln5ytZwH8Y1Iw97pJqn0XImfofmFxka4jv0wVVse0F6dGn7iEoAeAoN
         E/3g==
X-Gm-Message-State: APjAAAXEEMhwie+it3ITl40/RYx6W2NV9/THDl2d8Yf8UwWxPmYiVgG5
        GuhTnONPgnUeFFXaWchKQJBAcp55SZ0=
X-Google-Smtp-Source: APXvYqwycmOR6gwjx7XxMplfhV+TFmzem0ccqFcQ6zRzjOGGCP9FSxzBz2CspC9rfWHR4cZ8oFbxvw==
X-Received: by 2002:a9d:61d6:: with SMTP id h22mr56301306otk.251.1555602169435;
        Thu, 18 Apr 2019 08:42:49 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id z2sm1139096ota.56.2019.04.18.08.42.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 08:42:48 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id s24so2048284otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:42:48 -0700 (PDT)
X-Received: by 2002:a05:6830:1497:: with SMTP id s23mr56835378otq.236.1555602167808;
 Thu, 18 Apr 2019 08:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190417012048.87977-1-ncrews@chromium.org>
In-Reply-To: <20190417012048.87977-1-ncrews@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 18 Apr 2019 09:42:36 -0600
X-Gmail-Original-Message-ID: <CAHX4x8483=65JVKRoZn9RadmoCp0VObLCH6BZO6dFT28B_r0ew@mail.gmail.com>
Message-ID: <CAHX4x8483=65JVKRoZn9RadmoCp0VObLCH6BZO6dFT28B_r0ew@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/chrome: wilco_ec: Add Boot on AC support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, bartfab@chromium.org,
        Oleh Lamzin <lamzin@google.com>,
        Jason Wong <jchwong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's one error that Guenter just found...

> +
> +int wilco_ec_add_sysfs(struct wilco_ec_device *ec)
> +{
> +       return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
> +}
> +
> +void wilco_ec_remove_sysfs(struct wilco_ec_device *ec)
> +{
> +       sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);

Should be sysfs_remove_group()
