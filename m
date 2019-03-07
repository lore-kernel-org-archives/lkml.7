Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBCC20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lbZLnWKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCGGJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:09:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGGJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EMfgQcm4c116FArKBhqY3syPSMSxIVCJr5YlP6qf2DQ=; b=lbZLnWKOli0dIk7Lzo6o4gUlw
        mqCyi1vKXqKum/683Y7gfJzMVFpB0MzA10dI44vzL0TG31wlhLtKaQZ+uBOE3GHrz7Ge1Va36Q2rZ
        lCaQcv2ubs9bUvZ5y4JBQCXl4nN67WYxLPa9OctsHD7jQRl6eEoWkZSCXqzcoGi5Jo2tAq4/Mtyrv
        Jwyy7020T95STD+fmssE4EjrGcPUaDSNMw3+uEknDAJZyA5Skg/uGAQH3+vfm6E6XECARQAYDV7Ie
        8/vRcxAIsdeSKLkDyLjEL0xsOM12OGTa1ffmU03AWWdAYhqDInTlilnAvAqW2RrLZDg4nGsbidRtI
        PNvW1Bn9A==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1mDg-0003ag-Gu; Thu, 07 Mar 2019 06:09:28 +0000
Date:   Wed, 6 Mar 2019 22:09:26 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modpost: file2alias: define size of alias
Message-ID: <20190307060926.GE44339@wrath>
References: <20190207123022.7961-1-2pi@mok.nu>
 <CAK7LNAQZ7PDZ4+uZu-FT4V8yw9oUGz6e++9xSshWJvALj3gN0Q@mail.gmail.com>
 <20190219200837.d34cxg2d7gqxlvhs@mok.nu>
 <CAK7LNASU=Jf7aYnnn_7DWgxLz4sf4=x1HZaoGQW2rSXVbFO9Bg@mail.gmail.com>
 <20190223195749.7yswuedfv4qbiyik@mok.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223195749.7yswuedfv4qbiyik@mok.nu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 08:57:50PM +0100, Mattias Jacobsson wrote:
> On 2019-02-20, Masahiro Yamada wrote:

> > > > If you want all the patches to go through x86 platform-driver tree,
> > > > I am fine with that too.
> > >
> > > I don't mind either way, however I've asked the x86 platform-driver
> > > maintainers if they have a preference in this matter. You should have
> > > received that mail otherwise see [1].
> > >
> > > [1]: https://lkml.kernel.org/r/082d3d38b7dde6050b6b3e518ada439eade65b2c.1550603967.git.2pi@mok.nu
> > 
> > 
> > I saw it.  The 2/8 uses ALIAS_SIZE.
> > 
> > So, I think it will be better to include this one in your series.
> > If necessary, please feel free to add
> > 
> > Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > 
> 
> Okey, will do. Thanks!


Agree, I'll pull it in.


-- 
Darren Hart
VMware Open Source Technology Center
