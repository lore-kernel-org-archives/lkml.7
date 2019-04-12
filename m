Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E203C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1B721721
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HhBICwZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDLB1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:27:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33114 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDLB1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:27:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so7327473ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxsZY8t9t7AiL+EGMTasnx3Y7YxDru18auEy0U1+F5c=;
        b=HhBICwZ+eoz+o+6Sh8a1nYIV3c3SAnEstczc5w60ZpboF5syTMKuUcKYuw/pGvcv/b
         P5u1MK3grRhX9aMp9UDRQShlhLNnG/5tgU76x3tqqH+pmxQIHloPZXYtij22zsJU5PEM
         v9eU92UPmFuIwtYGTo611lIUZ4dAKqXG4XjLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxsZY8t9t7AiL+EGMTasnx3Y7YxDru18auEy0U1+F5c=;
        b=m9sSSt79E4CH4c77bK5r07bGZC5si88vHJju8dAMY8my6f5ohsWosAg3vHlbixhEzg
         0TeegjgO5Q99S8JmEjlvrJ4iXtr6yMmR9W08osByD65qYs69gF69J7FN6spEnLA0T/N5
         YZi273uSQhuRUz5Yku27w7NiAKBj63ImqQwv5XRoUQZ9etv8KJcgxxum6xCG3rZ7EO1C
         gda9dS4EPmNPPT8UXYxivOhW5DGI5x9YYwHzoArH1SkjOIx71sGLSLm5SVs1ECr2P8R0
         Z3LKWwplJT+BS1qJw9hscIdeIHINrBFXvzt/N7mPYlJStMeSMl6oKUIqQLNwXnX0LzQY
         RD5A==
X-Gm-Message-State: APjAAAWiMWsC32MDvlmbISMoKW6uW2zvQw1hgi+2G3fwTDLUqBvpJx3U
        mi79wjDYGRO583jmkKEop4KsUW8xo3o=
X-Google-Smtp-Source: APXvYqyJvaIRYe5vaUGak6zXDO7a0/OPCGfbVALJ/S/GzbDlt/AsH4GkzaO1fjayiuhgzEy2EBo2FA==
X-Received: by 2002:a2e:9915:: with SMTP id v21mr21890257lji.154.1555032450361;
        Thu, 11 Apr 2019 18:27:30 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j27sm7814268lfk.97.2019.04.11.18.27.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 18:27:29 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id g7so6155521lfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:27:29 -0700 (PDT)
X-Received: by 2002:a19:c018:: with SMTP id q24mr28997770lff.38.1555032448510;
 Thu, 11 Apr 2019 18:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190403203137.203582-1-dianders@chromium.org>
In-Reply-To: <20190403203137.203582-1-dianders@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 11 Apr 2019 18:27:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNmxspD_3p-BftgySn5mPSYvSTeEXkzNS9B+ReZho-Uyw@mail.gmail.com>
Message-ID: <CA+ASDXNmxspD_3p-BftgySn5mPSYvSTeEXkzNS9B+ReZho-Uyw@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 1:32 PM Douglas Anderson <dianders@chromium.org> wrote:
> +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
> +                                struct cros_ec_command *ec_msg,
> +                                cros_ec_xfer_fn_t fn)
> +{
> +       struct cros_ec_xfer_work_params params;
> +
> +       INIT_WORK(&params.work, cros_ec_xfer_high_pri_work);

Sorry for the late review, but this should have been
INIT_WORK_ONSTACK(). Should it be a new patch, or is this in a
non-rebasing tree yet?

Otherwise, looks fine to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
