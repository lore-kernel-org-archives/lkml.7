Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08533C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42B2205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgGximCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFUVNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 17:13:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41250 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUVNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:13:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so5645466oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 14:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IUC+1FlEWN4tKm0SeOLpdninTmF6qp7MuCWQSXIRz0=;
        b=EgGximCk5VUAACKrAUkWk4HPsHG5TW9Q2kItYQxrZT4piz7tvdkA7ErNRpdUfgYTz/
         rApW/8A0zBwoaPh8gPyBvBXE4p4MQdQY5PVrXdPQpdzqHvi/Nxm65xy4BlmYu7862Ymy
         gdDEkEtwyRZhRDVCPOSOTHUxTXzQ3OZjn21yiAbjiYvXV/a92/NPBxtATIGFDdLzcxP4
         /9bhou2w+OKNEawob6PgVVubUkYgux8mIJOqchPDyvC8vLvZq3wC5ABvjCfkJWlUk/Km
         RsALukt/0D3l7eoRIbGbntdPp2gu4dXbDmkGZAWmnXxH0pBSEMT4iUeZm1lK7zCstle3
         du+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IUC+1FlEWN4tKm0SeOLpdninTmF6qp7MuCWQSXIRz0=;
        b=sJQIb0vTa8j+xsvVJrx/rMvCFKAc81NeeFjprKZQqJmfbUPGTILPDJSYDDrUXnqfdY
         BnzOkuEmaThqlYOfnmrUy2SLDPOE7q5JiulHzc2JCzup8QrfmXld6DG15QVR1J4DkMfO
         BSTCGar3qLbgLKqfVrG8hF7TgRiVCgEp1DTJO76MwLtjstEhwhMDAS6G78SZIf/9AcQ/
         TqIbdW1s7qB1fQQvCLTgDSVlodvAnFjgFsddUPXZe3LkjrjYDHyLEa8jZA3NaUIO95TT
         0m6L38xvumEmgi7I40ZlX1EIVwWxGSLiwAxun/VWxVu40PezwWYBAoRcRCn6SPsM847Q
         711w==
X-Gm-Message-State: APjAAAWG7An/h0vStENqvRcErqxk525BfnnUdb6Bi7k8Ohfnmt6qq5pI
        8XeCDlTmdwND6nvgQ6TdprPHVl5EZqQHHDFPgt2P3w==
X-Google-Smtp-Source: APXvYqyxyydXVSFfPulOIi8kVAD1JoXVYjMnHyrAQUKHmu3An8stQ4fEJaOVPKC1r0dPwGaIb3ZzO/3MuR63dIStNJk=
X-Received: by 2002:aca:edc6:: with SMTP id l189mr3939794oih.86.1561151624435;
 Fri, 21 Jun 2019 14:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190527191552.10413-1-TheSven73@gmail.com> <20190621151500.cv57g3al5sadpcum@shell.armlinux.org.uk>
In-Reply-To: <20190621151500.cv57g3al5sadpcum@shell.armlinux.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 21 Jun 2019 17:13:33 -0400
Message-ID: <CAGngYiU_drPPXAzY3W3duxxTcUXUASeuCu_wj8zmxvrasEDq8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/i2c: tda998x: access chip registers via a regmap
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:15 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Another con is the need to keep the functions that detail the register
> properties up to date, which if they're wrong may result in unexpected
> behaviour.
>
> I subscribe to the "keep it simple" approach, and regmap, although
> useful, seems like a giant sledgehammer for this.
>

Thank you for the review !

I added this back when I was debugging audio artifacts related to this
chip. The regmap's debugfs binding was extremely useful. So I
dressed it up a bit in the hope that it would have some general use.

But if the cons outweigh the pros, then this is as far as this patch
will go...
