Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7977CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EB621473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WIoPLVVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfGAQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:06:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41868 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfGAQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:06:46 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so29994437ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=InMcyXa5sXJAd1Yjv5DDfuzVwc5hmtVlJVQ+GIywkco=;
        b=WIoPLVVTn8rSwrT7ABjLNYG0wnLKvjvHo/dgBVVxfPuv4EIDyAoUU4BrI/z8rbNtT0
         1O/xrCDhePoSl25Bh596TdgHrewYOtV0sM+w40g2+/HSGL1jnwyOhHBf53s+EhRXSntm
         zx45xkUd6WYP4VH+pHG9Dir4+Np7m0pZ3zkA7Ijt5/8LT4dQDBCaaU1oiEiE9sY1vJz6
         lyD/aMqrltDZztxu++zv6qBse7xclDClJznxjBs29GzmeDJ5rMwk9u/cFjASR0ERP4j2
         bC3Lo/DSmP2hKf+FFVwYjsGudzNzPlOcdHWOF9C6w6sx+n+S7AFqDv8dveTz78H8MmX1
         7Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=InMcyXa5sXJAd1Yjv5DDfuzVwc5hmtVlJVQ+GIywkco=;
        b=tSNmlixpY7+ULdcT7UOKl9ZVbD3vAcX+ylWM8I40T+S26o5NJSdK0oLGF+ZrOSHVqv
         m9Ib8uk4DoXbL77WHhK0yUaiLsIEKbhZKJTTXg+AAwn05gYQMHNQyEkVdizS/3NR+X4G
         rDzeGi5LPCSU9ugIn9dpbRaIsEoG7oP6ZcfmIUqjz4LaWibdXsdFCUQqpedzPAmRKKsb
         Sxzz3MAJv6QohcuTkFyDLCBO9aBXmC5rdPFDDOibxKTgDCwETsgtQoUyveyyq5cphPIr
         d6Dx+Vi6lL1fRWd/eQx93QsoohfKdcfUnLniNeVdEw7nsptiRy7cnf3/FWtxUnUNW+LE
         OY9Q==
X-Gm-Message-State: APjAAAVoMQvKkXwB9VP8mLkOq30Xu6+9YTlIAeacwxeIlr5XeMnPRnkf
        BmzPNmctnXudgbszf76zhdqYrQ==
X-Google-Smtp-Source: APXvYqxL4h8vZQ2+vG0HtnQ8dyFs6puOwncIF/3RmDP3OfBIMby5YcRiUgft36tp862ZyI0igX9kng==
X-Received: by 2002:a02:a38d:: with SMTP id y13mr13211858jak.68.1561997205559;
        Mon, 01 Jul 2019 09:06:45 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id o7sm10000521ioo.81.2019.07.01.09.06.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 09:06:45 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:06:44 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>, linux-mm@kvack.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v2
In-Reply-To: <20190701065654.GA21117@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1907010904320.3867@viisi.sifive.com>
References: <20190624054311.30256-1-hch@lst.de> <20190701065654.GA21117@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Probably best to feed the mm patches to Andrew.  For the RISC-V patches, 
am running a bit behind this merge window.  Combined with the end of the 
week holidays in the US, I doubt I'll make it to to the nommu series for 
v5.3.


- Paul

On Mon, 1 Jul 2019, Christoph Hellwig wrote:

> Palmer, Paul,
> 
> any comments?  Let me know if you think it is too late for 5.3
> for the full series, then I can at least feed the mm bits to
> Andrew.
> 
> On Mon, Jun 24, 2019 at 07:42:54AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > below is a series to support nommu mode on RISC-V.  For now this series
> > just works under qemu with the qemu-virt platform, but Damien has also
> > been able to get kernel based on this tree with additional driver hacks
> > to work on the Kendryte KD210, but that will take a while to cleanup
> > an upstream.
> > 
> > To be useful this series also require the RISC-V binfmt_flat support,
> > which I've sent out separately.
> > 
> > A branch that includes this series and the binfmt_flat support is
> > available here:
> > 
> >     git://git.infradead.org/users/hch/riscv.git riscv-nommu.2
> > 
> > Gitweb:
> > 
> >     http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu.2
> > 
> > I've also pushed out a builtroot branch that can build a RISC-V nommu
> > root filesystem here:
> > 
> >    git://git.infradead.org/users/hch/buildroot.git riscv-nommu.2
> > 
> > Gitweb:
> > 
> >    http://git.infradead.org/users/hch/buildroot.git/shortlog/refs/heads/riscv-nommu.2
> > 
> > Changes since v1:
> >  - fixes so that a kernel with this series still work on builds with an
> >    IOMMU
> >  - small clint cleanups
> >  - the binfmt_flat base and buildroot now don't put arguments on the stack
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> ---end quoted text---
> 


