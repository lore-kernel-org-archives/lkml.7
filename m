Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D82F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VomSogBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfHSL2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:28:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37391 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfHSL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:28:41 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so3426647iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUgp/lYE2mh6lZVjp7CtML4dZtKS5hCiUObTY5MOrek=;
        b=VomSogBR+Rjw/zSHOgYzWP0EPLOWDtlkOX71pe6ugmjomlrnQcTpcjmO8sKNJJVF88
         eBBJwuHQMPRsPnPRI1d3VWz79WvjiSugyn9jqibRlINZRgvgDoPjI2EtLD1fnsLV99c2
         ShCoueTKwSrH6XIpq3jwrrr8LQOc+bXuyUl/de11l4GYIgokqYrOeou3Ki93L+WqlQJx
         GBubyAUF11lufOEIB4UNoLNvXP6xnBfxBWyQ5xpZJrGplgu4FdH8bkcGeEjP/ZaKEtLl
         6ea5JCPDW1r6tJ7EqnwrgEoniW2UAOXZ55UlUK2Muaf/SGJ0KQMtvI49SO35Tby1zv3b
         l6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUgp/lYE2mh6lZVjp7CtML4dZtKS5hCiUObTY5MOrek=;
        b=ZGrGW2DrouAPmbAWuRwdoyCig6a4ac9Dqu7Q1XbWzwhLeofep8MoJqiCsULYMw4+cY
         CY7b0pn83t2AWs3GjUURwl2LCQ0yZI4xjmGgFDkh8vKxlt5noHcIH9QRYA3KfTRNnPBn
         EHY48x7qrnFeI1LekMmseKjh9wzf9VK2BaoaCJQ64RjZkLjLdgyhwB3uaA7ppUp5i2ty
         RRqdytu+Xa1VeHst2mRnUqfBVfPlBC1XQ4wqEt7ZPj/bxu+YqSarZLSM5j4KgKEJYOUD
         ATkzHx71+Z/+CHeDMrnUE/GNHFFKaNcVmtaYhEWDHkxXmEAOv9CgCrTKqz38nsKVKHi5
         dvkw==
X-Gm-Message-State: APjAAAWg6w79tWcZxa4KknjZdZRjuMK5Xxf3LtKYS1enJqLnbu3CUaHu
        A7l9SeWbkQ7SiTIgAG5+x0iQHWfS+nFTuwhpyEP8EA==
X-Google-Smtp-Source: APXvYqws9l57+4N1t5CybQVbaJVVd9Nfbb44LfgnzTxj+oSX0EqosHdKwwu2xUgfJeO4/2mhYPOE0MJ85EFvW0XmVeo=
X-Received: by 2002:a02:ca0c:: with SMTP id i12mr25223915jak.82.1566214120815;
 Mon, 19 Aug 2019 04:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190814104520.6001-1-darekm@google.com> <42c7ef3c-b7e5-8c63-c7c2-bfc6c56100c6@xs4all.nl>
In-Reply-To: <42c7ef3c-b7e5-8c63-c7c2-bfc6c56100c6@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Mon, 19 Aug 2019 13:28:29 +0200
Message-ID: <CALFZZQHu1C_8idxkwjBdxpW=y9gKmDnLOeTHZ9iAkNo7YubZHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] drm: cec: convert DRM drivers to the new notifier API
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-samsung-soc@vger.kernel.org,
        David Francis <David.Francis@amd.com>,
        amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        nouveau@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sean Paul <seanpaul@chromium.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Lim <Thomas.Lim@amd.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Enrico Weigelt <info@metux.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:38 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Hi all,
>
Hi Hans.
> The patches in this series can be applied independently from each other.
>
> If you maintain one of these drivers and you want to merge it for v5.4
> yourself, then please do so and let me know. If you prefer I commit it
> to drm-misc, then please review and (hopefully) Ack the patch.
>
> I would really like to get this in for v5.4 so I can get the userspace
> bits in for v5.4 as well through the media subsystem.
>
> Dariusz, can you post a v7.1 for patch 5/9 fixing the typo?
>
Done.

I think it would be good to test v7 changes to dw-hdmi and tda998x on
a real hardware. Hans, do you think you would be able to test those?

Thank you.
