Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B52EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DD221E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MpR6TPeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbfHGPlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:41:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41469 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfHGPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:41:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so106065975ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HAXloeaOD6Dgz0TeHmNMEkOukZ7q9iclSHb8TPMnnoM=;
        b=MpR6TPeY9ksExXbV1M0WZ4jh4/JwJ9vWGRF9Q289lrNZt6ApwrI38CI+eNBR2DkMNa
         Z7kScwuTmiRNYxUCmrhHLisuDE7Jq6jOB6Uy5ZU+gWd24CE2XuQKs/7HOsVWT5q4QYua
         0uVXOCj7D12af1thKryyrhhJNQYJeGuHuo6mHxA3Em5MvzfobH7So0FWtWQRRIAv9cpK
         SKGbb+p6Gx21xSqHvNDTgXbWQ6wLvI8lAggwhl53uqM/EKM/49TBSh42hrAepJq0swFZ
         IrsJjSxAGrDjL7077HKRQ9LC6pgVFEbioMkeUxrVjzA6YqVgZD5u3o5nUM0Nz6aGTkLd
         KPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HAXloeaOD6Dgz0TeHmNMEkOukZ7q9iclSHb8TPMnnoM=;
        b=qzV/H6MDvTH77nzMU91ZRPiGeeHhnwrN7A/Mon9egmeS1qp3FrzUrCTCnb7dmHA9ZH
         dpqPB3DTEqPuRJ2vxPNdtZMvDoJI3e8gwt2A1z3W1jyGdm6nWIeVXSv+bmjlPBSxQWkM
         7MdRmlSHHAue3KJ5DEkAtKV/zq7sP/S/lvbj0MwZWseKtUx6SKbdfSPwsNW/sylBc8Ye
         fnhFKfiLLvCRsu89v+lMrkn1M3wl3BpHp7gFaQP1zD+GoeoH5DudphSOo9NnMPgb/HvB
         nBb97RiADltNsi3JhMDcDUD1ZHI06nNSWpIhDyKj9Uj8K9cEG7P2x2YU6vYPqHQrj5yp
         OYsg==
X-Gm-Message-State: APjAAAXJUX76lSMPqGVK5U5HOZjWBgzrs1VTKzA2hGnqPpNKNKSaTZlD
        vm4/XzhJEefN0//W7STC4HbsQQ==
X-Google-Smtp-Source: APXvYqwyIB1L+QiELH/YNHUY/Gf3N1VW1Uv2dDPLw4xrbndDgaWQH9vQgWS83jDCgfoU7TiFL406Bw==
X-Received: by 2002:a5e:8e0d:: with SMTP id a13mr3602621ion.28.1565192459955;
        Wed, 07 Aug 2019 08:40:59 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id a1sm68914330ioo.5.2019.08.07.08.40.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 08:40:59 -0700 (PDT)
Date:   Wed, 7 Aug 2019 08:40:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        palmer@sifive.com, linux-kernel@vger.kernel.org,
        james.morse@arm.com, linux-riscv@lists.infradead.org,
        mchehab@kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/misc
In-Reply-To: <20190807152438.GA16495@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1908070832500.13971@viisi.sifive.com>
References: <20190807151009.31971-1-hch@lst.de> <20190807152215.GA26690@kroah.com> <20190807152438.GA16495@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Christoph Hellwig wrote:

> On Wed, Aug 07, 2019 at 05:22:15PM +0200, Greg KH wrote:
> > > Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/riscv/mm/Makefile                            | 1 -
> > >  drivers/misc/Makefile                             | 1 +
> > >  {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c | 0
> > >  3 files changed, 1 insertion(+), 1 deletion(-)
> > >  rename {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c (100%)
> > 
> > Why isn't this in drivers/edac/ ?
> > why is this a misc driver?  Seems like it should sit next to the edac
> > stuff.
> 
> No idea.  EDAC maintainers, would you object to taking what is 
> currently in arch/riscv/mm//sifive_l2_cache.c to drivers/edac/ ?

If this driver is moved out of arch/riscv/mm, it should ideally go into 
some sort of common L2 cache controller driver directory, along 
with other L2 cache controller drivers like arch/arm/mm/*l2c*. 

Like many L2 cache controllers, this controller also supports cache 
flushing operations and SoC-specific way operations.  We just don't use 
those on RISC-V - yet.


- Paul
