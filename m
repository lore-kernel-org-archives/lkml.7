Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DDFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A36205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQQ59/0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392053AbfC0Sov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:44:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40663 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391783AbfC0Sos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:44:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so10123144pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzctWG2X4xielHQdWFhB2zioySjlIs2B78a6UgrxqY4=;
        b=tQQ59/0DDMemTDjjVLEU4x3KF7BwCR9j5d57Fr3CkZ7bAB9ICIe2Ed3RIOo6EuwoNW
         I+7U6ur9vwcEvxSkUDb6lNy0OEeovlqAAgFj4754MFMnGzT7w4eyEm1w5cl3YDk3bron
         4/Ns3zxCGkrT0JhtZf0sRdKCfGNMnhxapa8RWhT1mdaNQY5NeTYwrFYAB+sN5ckFTokU
         g6vgWGMGV52vQkELESRCtu98gQN7m0la7HQ1vefLOgCcNPVnD38kmzUFEvlR2MllH5a5
         FnCEiKUa4vkruoAV/CwjSW63euhEYsQ9Lhz5mxWsEraQvjxOUdGF/E5uofzcJkPEalMy
         +Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzctWG2X4xielHQdWFhB2zioySjlIs2B78a6UgrxqY4=;
        b=dDbZME322Q4c7s8f9We3ryh5E0FZiCmdtnoeWDeZD8Z/h7oshWLnG1zWgxd2WL1eNf
         8EnS8mnFlVq1YYDGmkcduz/HXLzeVkSj86SwevvV5VU3Auk1weR/NGUIyfyYSCmCx9DY
         8zUrnsqBKztyQMaLNdR+2zzI3N3c4v6vrStjwOlWnLJszsvgo/FQBjaYt+LUL9BSg70s
         ic3tPrMG5TfiWWE1WSXwPncbBBVi6PlUTa2wHqoQ9/A7jB/MTzErBhtZbW6bmX9qArYT
         RxlgwCySSmruO1Fj2Nf2jAkJqBBNc3n267Ibc/GRmKV+nOCaZz3EK5RstbZLmBaO66ks
         if0Q==
X-Gm-Message-State: APjAAAUu1mG2gzQJwamNmE+MYz7p2aOXsp55g4QZC/FK8zRokXM8hjPt
        sRl1ca396do65cuM9ivVCELS3u4H2p3SgqMA7KA/DRX61KhLrA==
X-Google-Smtp-Source: APXvYqxfSqCpg/pye9gyS+SdDCwGBl/Rk5xUfsOv5wGfcKChNkfyKrOqqreVSnAEtokS2AIh/nfGh2xwCP2NIsiiSkE=
X-Received: by 2002:a62:4746:: with SMTP id u67mr36682932pfa.243.1553712287620;
 Wed, 27 Mar 2019 11:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190312163101.155910-1-venture@google.com> <20190327164542.GC11712@kroah.com>
In-Reply-To: <20190327164542.GC11712@kroah.com>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 27 Mar 2019 11:44:36 -0700
Message-ID: <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drivers/misc: Add Aspeed P2A control driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> > +     phys_addr_t mem_base;
>
> Is this really a 32bit value?

It's going to be a 32-bit value if this is in the dts for one of the
correspondingly supported aspeed models.

>
> Your ioctl thinks it is:
>
> > +struct aspeed_p2a_ctrl_mapping {
> > +     __u32 addr;
>
> Does this driver not work on a 64bit kernel?

This driver is aimed at only 32-bit hardware (ast2400/2500).  I
modeled the approach after the aspeed-lpc-ctrl driver as it's
providing similar functionality.

>
> > +     __u32 length;
> > +     __u32 flags;
> > +};
>
> addr really should be __u32 here so you don't have to mess with 32/64
> bit user/kernel issues, right?

Add is __u32 there.  Are you suggesting it shouldn't be?
>
> thanks,
>
> greg k-h
