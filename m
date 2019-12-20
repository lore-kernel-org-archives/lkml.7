Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C0BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E33C206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U9/APrhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfLTVIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:08:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35567 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfLTVIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:08:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so9718931edv.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2lQDYFiSU61IegoZn+J4VONbd8f0VMeRcMDJoBkFbk=;
        b=U9/APrhhsF3x2MS6R3KK3ABwN6yY0iFPxC5xw31FcR60dCln0zk9mIa5gU5JcBYoI6
         t2LTv9/2fajE3eKiszLAErOyWNZ/OvpqFRgugfVCYbHSQSbeD2xnM2o1C3kKsCkyg7NK
         YMQHkFsnbAsnUtANnjodcIFR/FZUiMtZ7CysoEn2/exNHRjW1X0xVzT7dBI/C+trE30J
         C3PXJYefx7NEfMXyEwH+jbCdKAykiN16LqaIuUvBZ2qVFAkN7rcmsS5i1AAoEByFG1Jn
         82EucOLh8/1J+YeyNiXXY7jqER0ZrNtGbMRnZ3Eh+xtpzWO3RBbBub3Ctn8+uYb3KYkJ
         yHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2lQDYFiSU61IegoZn+J4VONbd8f0VMeRcMDJoBkFbk=;
        b=ChOKBGfIQl71TS1hr+AyA+56ctha+UFyvBoOgyHM92tQNYeLaNqaNtB/dVYNSksc6o
         QPwMzt+OMt5ZUydP02xDb0yzdni+ckWpQmWcri8OTg5fr9XbwgVK4nDZNPZ2semGoa6T
         NEKv1WRoxmUFfLZuO4tiQwmRr8dtdz36KxJfUPKqb2VGEtkDUFvFjNHro7gT9Vm5z5AM
         Zm7jX3FAlwnv7/0twPWYuIMGjKtkd37/ERXKBA7q7/N+1VW8j6JObhbcsuMI82oluXrt
         qmz7cx9aWe+YwYDQZgv9HMVBjHC73pxO+BWfEjcjdKNw0xgu0Qhlc9nlqDFUv2NCayEX
         WRXQ==
X-Gm-Message-State: APjAAAUDPYOb2mOivQNQlYzp3G3f0CSahY0g7F8vjbMyyG4KOs0sJQfg
        zQdPdpwOOrgGhSWeoT+HzrVRCkoR07PBuocCtNBo0kLy
X-Google-Smtp-Source: APXvYqySGg6l6ORFyyhC0kSFdcf1phcgOYpzIjO03xOtIiofSZ8Z6UuRq260Bvp3a2c6NoH1c6R8u6BrcrQvWtFORNA=
X-Received: by 2002:a05:6402:c08:: with SMTP id co8mr18125655edb.197.1576876095176;
 Fri, 20 Dec 2019 13:08:15 -0800 (PST)
MIME-Version: 1.0
References: <1576725878-112367-1-git-send-email-mafeng.ma@huawei.com>
In-Reply-To: <1576725878-112367-1-git-send-email-mafeng.ma@huawei.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 20 Dec 2019 22:08:04 +0100
Message-ID: <CAFBinCA27-f0M+XPLkFBbrHzq8HareiuqH2nnC1=Q63uEFswDg@mail.gmail.com>
Subject: Re: [PATCH] phy: lantiq: vrx200-pcie: Remove unneeded semicolon
To:     Ma Feng <mafeng.ma@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 4:24 AM Ma Feng <mafeng.ma@huawei.com> wrote:
>
> Fixes coccicheck warning:
>
> drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c:389:2-3: Unneeded semicolon
>
> Fixes: e52a632195bf ("phy: lantiq: vrx200-pcie: add a driver for the Lantiq VRX200 PCIe PHY")
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for taking care of this


Martin
