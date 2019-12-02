Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91FEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1F3206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndPuXay1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLBXNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:13:19 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38039 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBXNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:13:19 -0500
Received: by mail-io1-f67.google.com with SMTP id u24so1439664iob.5;
        Mon, 02 Dec 2019 15:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIcqe1Il5Hobhfl1geECnsXqeChcULUG/wl9IaIholI=;
        b=ndPuXay1ZWAYPo+jnQA12bJWngbmReq4b/Dl2/d4VLN6nzWY6O6mThZMcZ7SaxsoHZ
         +SxoQjcYSwS5ReeJiab2PtlEmuQ3y2LqbtbHlsdJTmO3iAJaR4fnovWHlxAjFSUxjjVx
         iukdMTnn17xniykgIW3jbyT5Y2Jlk6o2JFCYsZdAUl4712NtC5rGP7qnNpxL5udluU9b
         0cNjKdY+KpO0B57EvTN3WM8BfFRNJ/U042jODqpEn6bXQx33gUAnK9b2WmO1+5QN85u/
         zdDmXG/1PaRYwbRIk34iR4jlK988DvGIzPJzVHXkDuaa8wU0WZ3KrRvPTXYRUH3Pojem
         m4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIcqe1Il5Hobhfl1geECnsXqeChcULUG/wl9IaIholI=;
        b=IPMCkJJZRRGFTnNgrAzDRsLsDA/A2BHuwugShG57T7VjqHCllb9NcMVJt2+vfI0AmK
         GhEVxKwZpqdEHrwpw5RfKr0Pr7npugsbcuqRREKkPMQtNTP2QWPtrjfeOr7kTgs55Trm
         MHlPM9jeo+/r5UBLAHggFECReth36hDBszuTvlu/ptxQYog/PI1tJY0y3Za0zy9VWRG8
         TZvy3dPpnD+On/iXmxFvhAdGMj/cgiC3S2ESaB8UKeO9jeEy7hVEewmXpgu0hlWS1B6E
         8avjbAKZAw/46HBXx++XdpE2LhWIdFxLzAgDm/LYQVmWcpt0BKcfPCTCNnjcnV63T+yh
         DjMg==
X-Gm-Message-State: APjAAAULlMgALQqX7xKu9PEVPEqDKAvIiCmDhPEMxZMEQ7GWDz8RHPcF
        w6Ou8pGqxW0Znh/C2O0+Z3D45MHb9rACguwT0vXT+w==
X-Google-Smtp-Source: APXvYqzqGaQ3howApB7nLMK/LN2JIwU2vd8BDBc2s8juIuL0Dw92McbBUWgGBDXY2saegJ2LiOHZWf5mVV0AhOBH27M=
X-Received: by 2002:a5e:8516:: with SMTP id i22mr1416397ioj.130.1575328398056;
 Mon, 02 Dec 2019 15:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20191130053030.7868-1-deepa.kernel@gmail.com> <20191130053030.7868-8-deepa.kernel@gmail.com>
 <20191202174811.GA31468@infradead.org>
In-Reply-To: <20191202174811.GA31468@infradead.org>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 2 Dec 2019 15:13:06 -0800
Message-ID: <CABeXuvq1+t++mCT0xwcMMkwSWh7VxPTGP7zzFCiMC=vyz5bK-Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] fs: Do not overload update_time
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 9:48 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Nov 29, 2019 at 09:30:30PM -0800, Deepa Dinamani wrote:
> > -     int (*update_time)(struct inode *, struct timespec64 *, int);
> > +     int (*cb)(struct inode *, struct timespec64 *, int);
> >
> > -     update_time = inode->i_op->update_time ? inode->i_op->update_time :
> > +     cb = inode->i_op->update_time ? inode->i_op->update_time :
> >               generic_update_time;
> >
> > -     return update_time(inode, time, flags);
> > +     return cb(inode, time, flags);
>
> Just killing the pointless local variable cleans the function op, and
> also avoids the expensive indirect call for the common case:

Will update this in v2. Thanks.

-Deepa
