Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5020FCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9E7222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6talJ7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390943AbfJRFZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:25:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55467 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfJRFZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:25:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so4710344wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XOUV6t3jirkU/o3kiBNxKrxEZIvkxKelj6Wk/Jg5/do=;
        b=f6talJ7wJw+pt76jatTkr/oYKwAQ7eEX4HAfDZHccy18vOTgBzEwtGY8dnwapGpOvq
         y32QjtHB74l6mxLMTT7eXl2GGEDoff2+wtZhwTkMV3brmWzlVz94d+hhbuCRgAk8y2FG
         ajkPfCdat/V8Fszly9vI4DZTJdFbomBSbLgzY+uHazLhtzSaikyL5Ve8cdfTb9+Okn9s
         2fbh9tr8Td31W4cnRRdychRqIpMNSrCPKdR7D7LzmHVYiGNrrCzEAMgQ1FpvOJUyEPFY
         xF3rlEwAuU63TXSAfYlntLaJJbpoPX+2/oHAgCcdaX3g8LO3A5+fdXcF0cogMjFktj7N
         twlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XOUV6t3jirkU/o3kiBNxKrxEZIvkxKelj6Wk/Jg5/do=;
        b=qOgKsmKd4Xax6WAjfObUoXQZrumsumpRlXOOEaPZj+Cq7cHenv4etqtfHO8QUd5SD+
         WCpdBgADo0zSiBqZPdkZRJqLhO4DCsoOYK2xqkF7QAbzmiQYHL7vPSyDt1oI7uiKPV6y
         2rJUr5uDdR58DRQSGUaJcno3YYInRYeYFgqXwhGgzrhDmVJZ/xGX7yxsK1ZXkYFjTLdS
         F2i1Y+6/qmLUDzqGHra/NC6H5kiqUCBP13xQE26vinA7PC9ep9q+Eoix9GWsj8FULghK
         tsB4EKLfwD+TfZL2nXPgGIMjj46bdcV/lXFB7l5KB0pporkV3Dz5HdiuASiY0Brm57rZ
         mDoA==
X-Gm-Message-State: APjAAAWmMZNKUYuAlXF3vwdAJpPL828wjHZOiM+x0NjFtn0/isWlcLKh
        xxGkVk5cNUd8H8wXRLhQpVGEMh+A
X-Google-Smtp-Source: APXvYqzsnrypTKGpbfgyJExRA8OA9ctZIryYpbseZrOOFSfOMgsfAEEWxdO7cDIErvmf948c93UzaA==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr5447793wmj.110.1571376311579;
        Thu, 17 Oct 2019 22:25:11 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:f882:d2a3:f943:89a4])
        by smtp.gmail.com with ESMTPSA id s9sm4988206wme.36.2019.10.17.22.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:25:10 -0700 (PDT)
Date:   Fri, 18 Oct 2019 07:25:08 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] riscv: ensure RISC-V C model definitions are passed
 to static analyzers
Message-ID: <20191018052507.l2dkdam2lam6ul2j@ltop.local>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
 <20191018004929.3445-5-paul.walmsley@sifive.com>
 <20191018040619.o3qb5fyj4qdevwoe@ltop.local>
 <alpine.DEB.2.21.9999.1910172138320.3026@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910172138320.3026@viisi.sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 09:39:29PM -0700, Paul Walmsley wrote:
> On Fri, 18 Oct 2019, Luc Van Oostenryck wrote:
> > On Thu, Oct 17, 2019 at 05:49:25PM -0700, Paul Walmsley wrote:
....
> > >  ifeq ($(CONFIG_CMODEL_MEDANY),y)
> > >  	KBUILD_CFLAGS += -mcmodel=medany
> > > +	CHECKFLAGS += -D__riscv_cmodel_medany
> > 
> > I can teach sparse about this in the following days.
> 
> That would be great.  Would you be willing to follow up with me via E-mail 
> or mailing list post when it's fixed?  If so, then in the meantime, I'll 
> just drop this patch.

For sure.
-- Luc
