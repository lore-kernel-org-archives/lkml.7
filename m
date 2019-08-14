Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF21FC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C922067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fCArUvFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfHNB4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:56:01 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37695 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfHNB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:56:01 -0400
Received: by mail-ot1-f44.google.com with SMTP id f17so43402290otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLHNhXfk5bsRqPD+tbhogFAW5bK2pPgzyn15UpRBUkA=;
        b=fCArUvFeqf++8XO7TL2SswY5UdvHzBj1/FROxkxlZ4gjI9j6i60nmJUSfvkTbAa505
         v72La5COWkibK06TGDURqOdAvnmHX9p8WxlIHqxbc7DM6q0gQunp5dlPdc1Hddbei5zJ
         gPHFjXH9zsm2F374EDm4cKIdApk3dVMntGiEKEbIS2gi2g02RRxMZsx+W6ca2yTsCXsq
         2ZoE/Kjmhfr10bheznVwOH+bUxu87VPW7S0D05udOIWuKSJ6oZ45o7yYV6vGViEtX2xe
         uu6mweL8dnKbvMNbRwobZykgf9495HD5OI0GwH4f74B3oFBQpWHpJcFs6S1o30PAbvxQ
         +inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLHNhXfk5bsRqPD+tbhogFAW5bK2pPgzyn15UpRBUkA=;
        b=Ywfk0GfhyLPEPanLB5lEs/kQByxcbsIJPd42fmr/QY/mEXe+zEBaUVIF5jyZEtxtQ8
         GWuRkf+tGX9F1oZzokOGLqnRbQOxRtZLIRm/ibgIG41COCSnQE6zVjUlqAcYnq0iICI7
         IAVCRIEjmNB/8Qw5WDmf9sBpa/bh9CLzXVrEmQf09yeCxMiv6w22Mblr603eLBfSBFrz
         zre45j/g844yf2ph3Yy0sfljiSGRaryV0vVrMF6C4hPnQI5GA2qVs3WpPxEbz3N7nmHy
         fuUfmkDu6VTH6MbLL0ZHL9UuFiILPJPU7LnZ90oC26NtTZhC42Z9VYok/IhxyszepbVZ
         0+dQ==
X-Gm-Message-State: APjAAAXBodkgT5vFYB7xfGWsSlOcfoB/c7YMdR9b/524LmyxvRRQ7aqf
        Ho5BEzvmDy52MLx/lqUdFpzemUCMOE5ULDfu1UCd1g==
X-Google-Smtp-Source: APXvYqyexNUdayXG5IEwU/3HPkWVsx7m78gh6YUok7JltEj/ZhFTHF7Z1gqMJZTFLZPg+Esh9tAgAEE9qGueqYuuTnE=
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr32438898ior.163.1565747760317;
 Tue, 13 Aug 2019 18:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
 <1565251121-28490-3-git-send-email-vincent.chen@sifive.com> <20190812145928.GE26897@infradead.org>
In-Reply-To: <20190812145928.GE26897@infradead.org>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Wed, 14 Aug 2019 09:55:49 +0800
Message-ID: <CABvJ_xiwDrOE1yCsBWe6qF=WU1pgi=kE8+GHfar-q+Tov0vYpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Make __fstate_clean() can work correctly.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:59 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Maybe s/can //g in the subject?
>
> > +     regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
>
> No need for the inner braces here either.
OK, I will remove them.

>
> Otherwise:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for your comments

Regards,
Vincent Chen
