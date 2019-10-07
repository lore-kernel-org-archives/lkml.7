Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA4AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DF420684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4ugxChb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfJGR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:59:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40611 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:59:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so13461346qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KFgo0wRkFEy6VhLxhfmWq5wGyMcJAzeHEJSjpxS5JhQ=;
        b=r4ugxChb5Z8WaG92upUlgKtopDOd0jvBxfboaSQMlL5n8aYxvo3EndkzcWFdNdu5HK
         p8zBEs2dkUz+YTcydHpvpj9kYiT/RzgcYASZYocUIed2h7iMmo/rlMt1Ms+q3WxSm+Xj
         Th/g2QOxV9UpjnkP2VsMCK1tw1ZaI8srhwCs5ElLA2XmR1jy4Qj9kJMwfCZ9a/JgYrOd
         6Yq+1P36LUeD3VePs+vnJqrfqXoDNmV5ezOXb2n+tGgppGT/xIlrQ8NHHLfummEfWFzj
         MRv3uaWRAHbaf/ykvDlFTkJWaLVLrwIiVKlkYm1aoGe0BMcz7kkUKQ/Ov9zTVfbYM7rM
         pOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KFgo0wRkFEy6VhLxhfmWq5wGyMcJAzeHEJSjpxS5JhQ=;
        b=A9Y2kb+AMGqMcVWWhxq35FUYwc/zNtJVQsa9aB5+ZppA7vWI5yPrewP6GuMrB4ONJE
         ykF/MonuZZ8Em5qqTJf80FVk6KFrfShACtkfGHSYqZZsX7SfHFFLDthAOakySvC0xhyv
         vCO0tf/DILY+tM7+xRbiaLIg967kLTl0LsGLk8wUz6QT1MFztpcPVqEd19HrH6b2OYF7
         niJlEIli+kBcx+YNBcW70X3qV9PgdViKmUYrGYaqAdyImR4H4EpfTNvku8gQ6i2ZeZZn
         5n3Dhu+Gy/vyyUktwZOCx4k6ROtmwlaV6RVYwE8v3pZZGNzmh+VyZe936AZD1nXHGe7V
         HqQA==
X-Gm-Message-State: APjAAAWaeKco70EmYnRMsI/TtCKQ6CFSwtr98iKA2Svls+Pp3UiZdygx
        1URIgY3+lKqDIQELDFiY3d1CjQaR+pTEEg==
X-Google-Smtp-Source: APXvYqxiPNuXSPerijni5MUYE58863lxwEhaLkgXUhUry09vaEDR8Lg2wXQU//wlHlGgPOLVE841/g==
X-Received: by 2002:a37:7282:: with SMTP id n124mr24917289qkc.259.1570471139072;
        Mon, 07 Oct 2019 10:58:59 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x15sm6187114qkh.44.2019.10.07.10.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:58:58 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Oct 2019 13:58:57 -0400
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007175856.GA42018@rani.riverdale.lan>
References: <20191007022454.GA5270@rani.riverdale.lan>
 <20191007073448.GA882@lst.de>
 <20191007175430.GA32537@rani.riverdale.lan>
 <20191007175528.GA21857@lst.de>
 <20191007175630.GA28861@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007175630.GA28861@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 10:56:30AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 07, 2019 at 07:55:28PM +0200, Christoph Hellwig wrote:
> > On Mon, Oct 07, 2019 at 01:54:32PM -0400, Arvind Sankar wrote:
> > > It doesn't boot with the patch. Won't it go
> > > 	dma_get_required_mask
> > > 	-> intel_get_required_mask
> > > 	-> iommu_need_mapping
> > > 	-> dma_get_required_mask
> > > ?
> > > 
> > > Should the call to dma_get_required_mask in iommu_need_mapping be
> > > replaced with dma_direct_get_required_mask on top of your patch?
> > 
> > Yes, sorry.
> 
> Actually my patch already calls dma_direct_get_required_mask.
> How did you get the loop?

The function iommu_need_mapping (not changed by your patch) calls
dma_get_required_mask internally, to check whether the device's dma_mask
is big enough or not. That's the call I was asking whether it needs to
be changed.
