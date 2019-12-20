Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22BAC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD772072B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Dg9+0JwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLTXAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:00:44 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33562 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTXAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:00:44 -0500
Received: by mail-il1-f194.google.com with SMTP id v15so9334567iln.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kYpUFg+g66OYb+0+NDvmD3uzMBedPiin3i8BKFrTBZw=;
        b=Dg9+0JwC0nl7+te1/6kqnsS0yw2ym/KBliialLPLp3KLENQXrsQ4hs3MFdyjzlKqld
         vpzcmhBHAeVo3JiNOTOyT/5OIaLPkflMLAg4itd7iEy48e5e8vjRSNXw2KmuWLpDVen5
         u8m+o6D6Ce1KBC1GYrdSC66voxU6MWkOuVGk3PbdmodUuWlMmW70Htw1XT4hiqGRAf8b
         46RX3autdlYKZy4ZamcrjI7G2dJDRScbr1MSx5z5aPoC6bVuo9qd4iyRCZ2dZBOzr+yc
         9LAp5wSkwuGE01uyjAyCBKszam+XUgI6Y0SZMSFT0rVe0zYxU1Y7vvTDPbhdDcA/cTxQ
         KV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kYpUFg+g66OYb+0+NDvmD3uzMBedPiin3i8BKFrTBZw=;
        b=eFjqQXPHlQg9FFZpMp6RPb99MaB73VZky+IqaiiaxFXY4URA8VVZ/dhkCRciSIBVvL
         bJCYXsB9L9dwoCsbqCIQ3NskgsNsKCa//RIoDxh/HxjJpJJpy1L8579HeQE4NCeJGr/c
         Wc94cmWMQZWPouE0ar9R0P15fLvLcCKhqVJQrjDTDCs+XYb3k3lfKC8S8xhO8qXHpANi
         W+dNTRZW8w0aU0R7hZ77z/HQ+YDTEcnDaLNAgrB8NnhKe02ogV9XAGEBbCcwc6cvWJvW
         Ngg82Xj+dRZcFPHfmNjgOOKzSdQFNkfRwJGpu6Gqh/wZDWFHUogOi+Es/sBPRxKhrSE6
         c2eg==
X-Gm-Message-State: APjAAAWYFjbOPH96pDODSMx3VOL41TZkxDig/bUuWCBjRuo8NNCOF3IX
        3yu8I4S0xSczp2lrRsPiKcclWA==
X-Google-Smtp-Source: APXvYqwHDVsOJy6xq6j6CKHzVDaMD3x7chhr2BoQe/hKpFFOE+Zlw2OuSvViO0uW1zFxhD1O/Go46w==
X-Received: by 2002:a92:d708:: with SMTP id m8mr14116422iln.244.1576882843543;
        Fri, 20 Dec 2019 15:00:43 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id h23sm5524854ilf.57.2019.12.20.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 15:00:43 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:00:41 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Olof Johansson <olof@lixom.net>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] riscv: export flush_icache_all to modules
In-Reply-To: <CAOesGMg_VySkckuTfeMWkfcQ6fUBokAQbCGXP9emz9WvtX4fKQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1912201500230.57866@viisi.sifive.com>
References: <20191217040704.91995-1-olof@lixom.net> <alpine.DEB.2.21.9999.1912200302290.3767@viisi.sifive.com> <CAOesGMg_VySkckuTfeMWkfcQ6fUBokAQbCGXP9emz9WvtX4fKQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019, Olof Johansson wrote:

> On Fri, Dec 20, 2019 at 3:05 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > On Mon, 16 Dec 2019, Olof Johansson wrote:
> >
> > > This is needed by LKDTM (crash dump test module), it calls
> > > flush_icache_range(), which on RISC-V turns into flush_icache_all(). On
> > > other architectures, the actual implementation is exported, so follow
> > > that precedence and export it here too.
> > >
> > > Fixes build of CONFIG_LKDTM that fails with:
> > > ERROR: "flush_icache_all" [drivers/misc/lkdtm/lkdtm.ko] undefined!
> >
> > In the past we've resisted doing this; see
> >
> > https://lore.kernel.org/linux-riscv/20190611134945.GA28532@lst.de/
> >
> > under the principle that we don't want modules to be able to flush the I$
> > directly via this interface.  But maybe, like moving the L2 related code
> > out of arch/riscv, we should just do it.
> 
> So you are aware that all other architectures that don't have coherent
> icache already exports this, right?
> 
> Being more puritan on RISC-V buys nothing w.r.t. keeping modules from
> doing anything, you'll just end up having to mark a bunch of them
> broken on your architecture. :(

Yep, we'll pick it up.


- Paul
