Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A79A218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzSN2L7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfDXIt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:49:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43781 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfDXIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:49:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id j20so15150832edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1J1H0a1t2NqJ0JROo5ZCzMM72Kt8L7jVFDW7jeEjn9I=;
        b=rzSN2L7f68Y+uKaP44rReGESu8s5T/Lf6qhriJFjqdJYvmMRxBX4hg2+nlZNfgOxJN
         nfQr87lPW2PkrYwtMnmP1A/7Nsld2X/08IxkkWG5ZyY5K3IjqupIMHaEUBNbfNx6Ecgb
         BFDFXrKWsjAK/gzorsh60wI6d0Wa15CkxqvLy5FfIX3kooYbkzahqpx2Hpx5ksCLMS+p
         z5gBGriUa9/q66Mokg+H4alEbt/uDg6po7c9BOZDd/L14BdSoU3Osd8TcRdWz+ZetqX9
         325+S5j+IzYjqYHQ3yr8wUJYd1+de36PAmbm9TT2YaHF/DFuiI3X2frxM+2P293bRDjv
         EdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1J1H0a1t2NqJ0JROo5ZCzMM72Kt8L7jVFDW7jeEjn9I=;
        b=G7FkxndPP0skhmoRQev7U/JnVWsJgJtG8SNXTyS09k244u6eBjey0hQKdEMq/Cq/OP
         DUOJYRk+JWu1Xd3SGoWfNIRoKgO15ZSunmynFi+oANcGvRTYn4T6BrOIIgPa5v4r7cEj
         tuTk2dyF89P5BlFXUYeNTkbIdyrgJEhRENFEvPOtDh9xRnfWYBn1ImvZT1lm1OqLUVIz
         cf5n6d/IGj+Cl4KYU7JIHIJGYfceOtoI9nlnZZo3i6Pbqqv7lyw63hexNQHiEqphf0Hi
         h/QbYluIhhJou/7w9TYRlg+GE081hJpgHWzSI3dgB5WRIKd1kM8n9j1ROOG/oVUYZpr2
         xFvw==
X-Gm-Message-State: APjAAAUXI9TpaZsme1jTFlmrP0zj1H6jxuietpa5Hn5bakkUieKoocL1
        2SZ2bMpiZZ5D7Z0FhhXnBiNYQQeYUIz/7x0q7dY=
X-Google-Smtp-Source: APXvYqzLXNxulKc9gC8D67axpgAvmxhUd9yH6BY5GFzPagrEa1l838lDBH1RE/Mm6Tjdel7w1ULRSguxAGJsDyYiTJ8=
X-Received: by 2002:a17:906:641:: with SMTP id t1mr15180995ejb.158.1556095795031;
 Wed, 24 Apr 2019 01:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190409102654.25845-1-hch@lst.de> <20190424061423.GA12864@lst.de>
 <CAEbi=3cpQWymVB0fErJ5-cULm59dmG5QZ+MNH0PB7oOGOpe8hA@mail.gmail.com> <20190424083628.GA15056@lst.de>
In-Reply-To: <20190424083628.GA15056@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Apr 2019 16:49:18 +0800
Message-ID: <CAEbi=3c7OsNU9uge4Bfk9vRJHjgcDNyPBAU1GXdmXTnEwC_k0Q@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove __virt_to_bus and __bus_to_virt
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E6=96=BC 2019=E5=B9=B44=E6=9C=8824=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Apr 24, 2019 at 02:55:25PM +0800, Greentime Hu wrote:
> > Hi Christoph,
> >
> > Thank you.
> > Acked-by: Greentime Hu <greentime@andestech.com>
>
> Can you queue it up in the nds32 tree?

Yes, I will put it in nds32-next branch. :)
