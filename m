Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A8C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC54E21019
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551894329;
	bh=fnaFw823APjxHulQ4+6wwEYV5Cn6l0+jzGalebq3cFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vnFEwmIZkc8PZmbNPFo03jigvdbTPAyt/H4mpjs+vR8jIcyaUFt7PZhXmI3B5+FpZ
	 QNb5nJbcnPLC5e5rNHzvHch/pf8wbt2rrvBtnl7E7vYg6CHt75jDrtbxLyysgLTIJ4
	 2ktCUnBrflD5USGFfXsB5n3b+8nNwACJ09MXw6SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfCFRp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfCFRp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:45:27 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEED9213A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551894327;
        bh=fnaFw823APjxHulQ4+6wwEYV5Cn6l0+jzGalebq3cFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tt75t3PXaPmNbY3DTWJzmy9Rs6w36M0YZa4XASyddvIfHPuG/skHNIJyFTshoObxL
         n+7RBdXOaTlfo6hGqNZNmLr34oNIzSwInYVKcVpT/bfMo/NQu7Asb3uACAN2hkGENY
         nTGGdRqHek6KNUqfqEOS7l6vARJwOZZfxTM2Kas8=
Received: by mail-wr1-f44.google.com with SMTP id o17so14413141wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:45:26 -0800 (PST)
X-Gm-Message-State: APjAAAXZnHpd20tOYtw0qkTIGxFEH0JolNOdVnQBBFmSg3rvpm2y3n6H
        3SnscpUY9gs4YwwQ+mILKbJ58mwIYlUYhf6UfJC+PQ==
X-Google-Smtp-Source: APXvYqycCiWUyBWek2cV3rb2VRLlGPzW1OwTHX7jDqXVifhITwkrmYdgvwZ+wVv87HdZxGS8lIKrxdQZqeba+LPZxCw=
X-Received: by 2002:adf:e747:: with SMTP id c7mr3724886wrn.176.1551894325330;
 Wed, 06 Mar 2019 09:45:25 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <alpine.DEB.2.21.1903061323030.1646@nanos.tec.linutronix.de>
 <20190306141144.GD7930@mit.edu> <20190306165230.75b7d110@alans-desktop>
In-Reply-To: <20190306165230.75b7d110@alans-desktop>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 6 Mar 2019 09:45:13 -0800
X-Gmail-Original-Message-ID: <CALCETrW=ht70o8xt4+KyudScr4-h+mxZ_PnYHn46gpAzfskE4Q@mail.gmail.com>
Message-ID: <CALCETrW=ht70o8xt4+KyudScr4-h+mxZ_PnYHn46gpAzfskE4Q@mail.gmail.com>
Subject: Re: a.out coredumping: fix or delete?
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 8:53 AM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> On Wed, 6 Mar 2019 09:11:44 -0500
> "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
>
> > On Wed, Mar 06, 2019 at 01:25:17PM +0100, Thomas Gleixner wrote:
> > > > It's been 25 years since Linux added support for ELF.  Can we just
> > > > delete the a.out support entirely now?  According to the Linux-ELF HOWTO,
> > > > support was added in 1.1.52 (August 1994).  It's pretty much necromancy
> > > > at this point.
> > >
> > > The Kernel-Necrophilia cult members might disagree. :)
> > >
> > > But yes, good riddance.
> >
> > Doesn't Minix 1.0 use a.out?  It *is* cool to be able to binaries from
> > run dead operating systems.  :-)
>
> Minixemu compiled fine ELF last time I checked 8). It does need  a 32bit
> system as it still uses virtual 86 model.
>

While I consider vm86() to be a giant turd, I also consider it to be
supported and even wrote it a somewhat decent test suite :)
