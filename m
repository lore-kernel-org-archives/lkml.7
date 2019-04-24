Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDFFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2DF218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhAZ7r8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfDXIet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:34:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44267 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfDXIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:34:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so3490396ljg.11;
        Wed, 24 Apr 2019 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G0WmltTj/+joqyqfbRku5uL9E9QNxLminkJqp2CcUSE=;
        b=ZhAZ7r8+CrVd4bzDRKTyW9f8eONSIFJD5swkp0EP5bovli40UAfw5s8PjDwQqb/U82
         ynVZRt8caxTyIvzUije4Eyw6SiRw/Nedb3m2kFpy4/5LuNBEtu87bAUMOO3HJeO+Z3sy
         IJI7M1/pUtjlccbJ557k2FsqtLP4ntZjN+m7pwPboPF7M7D6jnv1JkccYSwn78spHN5z
         2/gO6spT7PyRB1weipNTKhQYiKko1BX7e7kXRNU5t7sHnGH2JG84YmlKhkfH+oi7E5iS
         0d/q7YmIi2d8mbcpY6eP3URuAt2IJICVbHiJt93yf0EaUVqFPTmlrrLupfNZkKO2DqO8
         o5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G0WmltTj/+joqyqfbRku5uL9E9QNxLminkJqp2CcUSE=;
        b=KeHeyhkkjlmKneZ+zK5vZplGH0BlspbYJuRjdK8nNuy10uj6lcK+VOsct0pVOZ1YRg
         LrfRx4ZVRNNwz2AUq+Frm+q6PeE+Z2TnX6l55O/NybnLStFpAbhXaLN2VRMG/jDfMFDF
         WwFTCLBC410wKLfPQTtwfQkj5hPnDmrKl7kIK5FFYI/4Nx8zmEYA/xoqXvYIgSff+vKy
         fK0bW8B+mUAPyl7EecfsAZojVgSJf4C1hTw1G1DCLbPEvLEdn/nmIpcCe4XmGvSmF0YP
         5O3w2wXcCxXNBvIhShXl9Az6cmjLm0yDbZzI+vK7wGbqUO/xshLV8gbDsYFZ6l7ilq9B
         nGeQ==
X-Gm-Message-State: APjAAAXLPOF2g2hLmdZuF3tKU13yBOzdrdphAbBvijjHpNNGvjkK3QmG
        pJVe20gXMtpi7rOzkrwH+1Y=
X-Google-Smtp-Source: APXvYqw4gE/3QVSgVcF9sFRJkaTH9o9pDpxx58f7NNzKpu6CQ7jckQIqYGvLRYYAzuoHejYT9a0uYw==
X-Received: by 2002:a2e:7007:: with SMTP id l7mr16387341ljc.101.1556094886084;
        Wed, 24 Apr 2019 01:34:46 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id a17sm4225433lfg.88.2019.04.24.01.34.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 01:34:45 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:34:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mips: Enable OF_RESERVED_MEM config
Message-ID: <20190424083441.ceo5qovy5amnocp6@mobilestation>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
 <20190423224748.3765-13-fancer.lancer@gmail.com>
 <20190424061750.GA30717@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424061750.GA30717@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:17:50PM -0700, Christoph Hellwig wrote:

Hello Christoph

> On Wed, Apr 24, 2019 at 01:47:48AM +0300, Serge Semin wrote:
> > Since memblock-patchset was introduced the reserved-memory nodes are
> > supported being declared in dt-files. So these nodes are actually parsed
> > during the arch setup procedure when the early_init_fdt_scan_reserved_mem()
> > method is called. But some of the features like private reserved memory
> > pools aren't available at the moment, since OF_RESERVED_MEM isn't enabled
> > for the MIPS platform. Lets fix it by enabling the config.
> > 
> > But due to the arch-specific boot mem_map container utilization we need
> > to manually call the fdt_init_reserved_mem() method after all the available
> > and reserved memory has been moved to memblock. The function call performed
> > before bootmem_init() fails due to the lack of any memblock memory regions
> > to allocate from at that stage.
> 
> Architectures should not select this symbol directly, it will be
> automatically enabled if either DMA_DECLARE_COHERENT or DMA_CMA
> are enabled, which are required for the actual underlying memory
> allocators.

Thanks for the comment. I should have checked this before porting the patch from
kernel 4.9. This symbol has been selected there by the platforms. I'll remove the
forcible selection of the config in the next patchset revision.

-Sergey

