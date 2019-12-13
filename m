Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258DBC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C0A2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je3d2YUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfLMKVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:21:31 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:41700 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMKVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:21:30 -0500
Received: by mail-pj1-f66.google.com with SMTP id ca19so1006874pjb.8;
        Fri, 13 Dec 2019 02:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrrU8ejlgbPQjfrKRpVho4T9Efm+u5wYss2r64N1VDY=;
        b=Je3d2YUo41n5r0ub0WvZJMfsnD5hRfE9csnHnl9RdWO887RJNZAVRgFZ+Kygl9+F2v
         +Nje0YXAMoAC12KLe9fHVJmHH0RDRrruyYoYdIERHAUsAmy3at952+x2duAtmvD9ZLHU
         /Uaw8dnjVFj9Javhqxj3N2DmKfgpLE49YH+YrutBiqAwRITyq0kPE/ODKjbuRq7z94d/
         it3/E1bgwHkjJAxEwEbSs5tcb0/+2GoeOogcUsbbSgp7WG/xLs6dxGRT4+rEHmBi+mso
         AonTF3R8bCi2nV9UYDH4GkpEB0dFGQOaWYXN5jR2AV5cnLuXfh+AsWpe/srzA/CXYBTT
         fq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrrU8ejlgbPQjfrKRpVho4T9Efm+u5wYss2r64N1VDY=;
        b=Z6ZRjcfAfgBWhfho7RN9CgcXHksnUBffzNotMmsnwoOjc8aMoaT7b3gDjWfocktZnP
         ksMvyrE3W0BRDsdzqRPPuhPjmYQs1SOAI/SirP+68mKhvqYicMq8OJaKEB44hrg04RON
         hs4vYQjRVu5EXRDZDYnAYzmFhJLM1mBCwWdnt42qT3t8NJhTJatInH6d0Yse47dHV4Ux
         gUE9gzDfwceVZ4jnqQZ04ijA1pznObRlBRsmgngYK9QXR/C844Am2jMV/Kc0T6ZXR0CR
         shQ1Avm5UZzf0ref3RXLymRactlf1GugaTNTEwYt9RlYqfP2X7gtqzgeCiltSY1fIxXh
         /u3Q==
X-Gm-Message-State: APjAAAXfLpaYQAhbHB555fIzAedcFLJDV1m9pgSkE72w4nSV84cF39ON
        lEOJAG3gM7GRRGfIBoS3skBXO1dHKu6BflN693Y=
X-Google-Smtp-Source: APXvYqw0EhM9QTiW9VIiW4p7ueTzJr8zMOVW9Y3qcoyyEcfCPsH9YTA+mvtAi9nP/KzhA+QPhM/TYqXsC1TkWGu9O+k=
X-Received: by 2002:a17:902:aa08:: with SMTP id be8mr14812726plb.255.1576232489641;
 Fri, 13 Dec 2019 02:21:29 -0800 (PST)
MIME-Version: 1.0
References: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
In-Reply-To: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Dec 2019 12:21:20 +0200
Message-ID: <CAHp75VcY9syYZoaOLWUHQQ6n5CXwvUnarDJPovLtyLTyZE_ifw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/mellanox: fix the mlx-bootctl sysfs
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 9:24 PM Liming Sun <lsun@mellanox.com> wrote:
>
> This is a follow-up commit for the sysfs attributes to change
> from DRIVER_ATTR to DEVICE_ATTR according to some initial comments.
> In such case, it's better to point the sysfs path to the device
> itself instead of the driver. This commit adds the missing
> sysfs_create_group() so the attributes can be created under the
> device. The ABI document is also updated.
>

Fixes tag, please.

-- 
With Best Regards,
Andy Shevchenko
