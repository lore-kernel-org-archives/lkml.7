Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF90C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629B52176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FofQNljN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLRAwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:52:37 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35366 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfLRAwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:52:37 -0500
Received: by mail-io1-f67.google.com with SMTP id v18so170132iol.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AYVMcfsYQ7/My9/CMSR2wcI0dgtFvQ4q3wHm6ZJbP7A=;
        b=FofQNljNG3XnDs6PJ7xFcBeDlHTzYOtvZ01PQExhZPG6io6qRbCyfSDgrfJus9w+RY
         EUKujDmdEuxs/2PL/yBZHnD0GDVJoKMAHnu8p4swz9hLkIom6X/4WAiA38KgIBg9eSPm
         LuXAOqwZ0wpbfJx4OFtWnU3nUhr2MWfrpndIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AYVMcfsYQ7/My9/CMSR2wcI0dgtFvQ4q3wHm6ZJbP7A=;
        b=MFDeJi8yUOQyOuz2p4srIKpyyekND2enf3UJWbQpl5RDZEKxYosr2iZhBJfc0q0Oq8
         pM0IT6yu37ziVNiEBg43QYXpUkuAtRStlrxh1NOx6ThnzP+aakC7B3KO8nvvDOJ3de/4
         EMgz6y91RBbE9H0dYi9tfsQSCRnMWzfW7d9PYdslSg/NhQejlApNwilOSLm5L/s5XuhJ
         ZeEMgPoixffkNxEAMo5vxpibR/cz45evDKqptsl2ghL5MxKiyzqfskhK6jOearmSxYmS
         JDPsPqHOwhK5LrT7kDoVULEVWLgxH4ksNtXA6OOY5to+S3vmJyj9al5VdALjHnq12KOu
         jYBQ==
X-Gm-Message-State: APjAAAWfcUlc9Sr7FW9pQXdgcewmQjCI0Q9CJNdSbSXlgt5NtayvVXHg
        E24OB2oE2jaZLZolTacHa22KfEtmp9w=
X-Google-Smtp-Source: APXvYqx/uazvrCP2TxAZOxsp82aJmXmxaXovvmGJOBegwGuMXzGyaoD/Dox/mazWI4I7ORa85gwUjA==
X-Received: by 2002:a6b:c9c6:: with SMTP id z189mr527724iof.285.1576630356084;
        Tue, 17 Dec 2019 16:52:36 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id l4sm102638ioa.9.2019.12.17.16.52.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 16:52:34 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id r13so166420ioa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:52:33 -0800 (PST)
X-Received: by 2002:a6b:be84:: with SMTP id o126mr546930iof.269.1576630353286;
 Tue, 17 Dec 2019 16:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20191213154448.8.I251add713bc5c97225200894ab110ea9183434fd@changeid>
 <20191215200459.1018893-1-robdclark@gmail.com>
In-Reply-To: <20191215200459.1018893-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Dec 2019 16:52:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U_trS6U4wTRMnW0_7xCjxqdTkTV5vmhyMC=vGbNAhQdw@mail.gmail.com>
Message-ID: <CAD=FV=U_trS6U4wTRMnW0_7xCjxqdTkTV5vmhyMC=vGbNAhQdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fixup! drm/bridge: ti-sn65dsi86: Train at faster
 rates if slower ones fail
To:     Rob Clark <robdclark@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 15, 2019 at 12:05 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Fixes:
>
> In file included from ../drivers/gpu/drm/bridge/ti-sn65dsi86.c:25:
> ../drivers/gpu/drm/bridge/ti-sn65dsi86.c: In function =E2=80=98ti_sn_brid=
ge_enable=E2=80=99:
> ../include/drm/drm_print.h:339:2: warning: =E2=80=98last_err_str=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]
>   339 |  drm_dev_printk(dev, KERN_ERR, "*ERROR* " fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~
> ../drivers/gpu/drm/bridge/ti-sn65dsi86.c:650:14: note: =E2=80=98last_err_=
str=E2=80=99 was declared here
>   650 |  const char *last_err_str;
>       |              ^~~~~~~~~~~~
> In file included from ../drivers/gpu/drm/bridge/ti-sn65dsi86.c:25:
> ../include/drm/drm_print.h:339:2: warning: =E2=80=98ret=E2=80=99 may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
>   339 |  drm_dev_printk(dev, KERN_ERR, "*ERROR* " fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~
> ../drivers/gpu/drm/bridge/ti-sn65dsi86.c:654:6: note: =E2=80=98ret=E2=80=
=99 was declared here
>   654 |  int ret;
>       |      ^~~
>   Building modules, stage 2.
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks!  I have rolled this into my v2.

-Doug
