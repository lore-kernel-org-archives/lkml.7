Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036FCC072A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 21:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C459F20882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 21:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRi08ubs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfERVBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 17:01:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42943 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfERVBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 17:01:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id 188so9134147ljf.9;
        Sat, 18 May 2019 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjVQ36VwzFJ7223GVX+W1QUwbbB9XFPvg3hASkJmDUE=;
        b=kRi08ubsnM+ykN86OGVCMysxcVyFgiHLV0b9Fr5ew9x6FdqJsy8RjcIcHaTPXgYKmm
         d9J29YZ8wKZ/wqisIZCggD2OTJlDFI4EqxAo5uyb91meiXhXpkATPV+mqDRW3cmyPHkX
         3XbgcF7MFCIgtbuwm+ReN7wbA62uj7EOJoMwVYslAIsKcLC7kxKGjMpkrLm8pFn0WumH
         oUnqD/c5nHDKWSPTpB74hAfowS5FbTi6RLxKw1bqw7mIUlNbTJJQQf/H3gdEnOrDa1uE
         qZc0C0sQ7lBMw6/Ew01qw9Jk2fXF8lBI1M64m//I24dV9uzG2Ydm6ayj7oXjhOe62ZLV
         9NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjVQ36VwzFJ7223GVX+W1QUwbbB9XFPvg3hASkJmDUE=;
        b=DP0bXifh4c7m/hS+0eXu6r80hH0iq1iNfl/uA2kYpLSghynVC5tHuRr+kB4LYd4P21
         np8rM54eSD/ic0wU26P4VyL+nhDJ0kSyMHoh7fW01UP1cevmnh2uiv0i+fcH+A1yIkKc
         GD/E19vjMfwbuYOiM7UlOuE0/V6bXcCN9Bo/q3kRw3pCHAYdZuKh4F8J9KdaIu85NWNv
         oKYVxc7minzIIKNUzu89ZqVWq9DmKsGIb7UTgCZ8XVXp2kqYUqBwu33D+bb0S8MGwTnI
         5GKTIJyXHVGn3LvIH2u2+4XwHko2RvUAhboUJECD80RoWfiG03/7lfoOv8cQwVhSGP9G
         6z+A==
X-Gm-Message-State: APjAAAUN4P/ejIRFv7GfYpbYqc9uaF2NVV2/tYcNSUoUgyiOaatGJ22J
        hxMw7HoDJO+1ESl4ABetAUWkgGvvO6u7Q0zAMdE=
X-Google-Smtp-Source: APXvYqz5V1Li5FC7AKD0AQty1G5o21b08C9dVNe188+/PFCqLvAreMM45t6P1vCeSAEyPNJZMmZrxAYvskKc+t8Jt58=
X-Received: by 2002:a2e:1f02:: with SMTP id f2mr31672771ljf.86.1558213266061;
 Sat, 18 May 2019 14:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190518173852.GA1191@hari-Inspiron-1545>
In-Reply-To: <20190518173852.GA1191@hari-Inspiron-1545>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 18 May 2019 18:00:56 -0300
Message-ID: <CAOMZO5AjtnPhPsQqTqb+FgyEU7kVp+i+6M1AOmwm9XwzTE9rPg@mail.gmail.com>
Subject: Re: [PATCH] staging: media: imx: fix Unneeded variable: "ret". Return "0"
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 2:38 PM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> fix below warning reported by  coccichec
>
> drivers/staging/media/imx/imx-media-capture.c:617:5-8: Unneeded
> variable: "ret". Return "0" on line 630
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
