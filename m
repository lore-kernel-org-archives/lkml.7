Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE7ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1040620867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkUljmTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfJGWK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:10:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39076 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:10:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so14289248qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pcIqZVzzISfUOTvLwugKEQa/SxdaQBJkIfYZLHL/HF8=;
        b=hkUljmTtezaGiXDvCEpABges9PQ04lb1jl/pWzD7hrvrGgVrBiswTbVNzqQbt322st
         0dIiB/BCPErsZ5VdjFnFSmYJesABlwbW842qH2uJORqmP2HGdmbICUfZfLRR3ZWhL7pT
         KPAhC9LWoW50vXlbugWAaOvvyjJ7Ps9qXkbyIwQxogVYME7wNTCNlcYUpV4q8PPnqxej
         lyCvt/qfdryfwe6fOFneKWwvl+dNYW639iS6rt069Nf9j0rkPM5ohOaTUGnJuTrMHMRi
         tSxo1DZdd9OvzK5m5IsNtpFujoNR+hwjN4cvRhE3dJRg9uxGX8VJIJro1bBetMiFiHpu
         8cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pcIqZVzzISfUOTvLwugKEQa/SxdaQBJkIfYZLHL/HF8=;
        b=eFs35MTbK+uIXTAmx73xqLbK9c9DJA6YlItXCcdPYALKv2nNz7QRCMPgj4cXTYmr7t
         TUXN3sdcRnn3OCMK0qYgnrkIgVhWTeRLx7IuJ1SE0NjM3nb2/w/BSIsh4jgdoP0weu2s
         D8+adkLwn+AQVn/vmUEmAqy2URVyqsZdgPuLI+hDY8YAxk64klxVk3YSfa56Zzq6fZZM
         B+0rB9Pr5YzhHfXlTrsldyTF3WsINbEzb5HCmOLsVkU+LkZmd/JdCSF2yzp/K129vIoK
         yHppVmPwdrmNDM3doBj1yuPEFAV+43EIW9akLE4oAZf2cBWt4PMAOnU6Y8OdkhINthPj
         kSew==
X-Gm-Message-State: APjAAAVPz1zXe7v/2iNxp5sIOuHEVhNG5MWkXdm8bwJxGBzJV3pLJP/P
        7L2L81qdMfrpPmrkNuP9I8A=
X-Google-Smtp-Source: APXvYqyntoOsd5Gz3HmizY5GlMxzA5EyX9iJZMYy4k1q+XyrqrvB7W8XbfUtdObMnPC30OT8J4IHeg==
X-Received: by 2002:a37:6789:: with SMTP id b131mr7902286qkc.314.1570486257212;
        Mon, 07 Oct 2019 15:10:57 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v7sm7896432qte.29.2019.10.07.15.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 15:10:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Oct 2019 18:10:55 -0400
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007221054.GA409402@rani.riverdale.lan>
References: <20191007022454.GA5270@rani.riverdale.lan>
 <20191007073448.GA882@lst.de>
 <20191007175430.GA32537@rani.riverdale.lan>
 <20191007175528.GA21857@lst.de>
 <20191007175630.GA28861@infradead.org>
 <20191007175856.GA42018@rani.riverdale.lan>
 <20191007183206.GA13589@rani.riverdale.lan>
 <20191007184754.GB31345@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007184754.GB31345@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 08:47:54PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 07, 2019 at 02:32:07PM -0400, Arvind Sankar wrote:
> > On Mon, Oct 07, 2019 at 01:58:57PM -0400, Arvind Sankar wrote:
> > > On Mon, Oct 07, 2019 at 10:56:30AM -0700, Christoph Hellwig wrote:
> > > > On Mon, Oct 07, 2019 at 07:55:28PM +0200, Christoph Hellwig wrote:
> > > > > On Mon, Oct 07, 2019 at 01:54:32PM -0400, Arvind Sankar wrote:
> > > > > > It doesn't boot with the patch. Won't it go
> > > > > > 	dma_get_required_mask
> > > > > > 	-> intel_get_required_mask
> > > > > > 	-> iommu_need_mapping
> > > > > > 	-> dma_get_required_mask
> > > > > > ?
> > > > > > 
> > > > > > Should the call to dma_get_required_mask in iommu_need_mapping be
> > > > > > replaced with dma_direct_get_required_mask on top of your patch?
> > > > > 
> > > > > Yes, sorry.
> > > > 
> > > > Actually my patch already calls dma_direct_get_required_mask.
> > > > How did you get the loop?
> > > 
> > > The function iommu_need_mapping (not changed by your patch) calls
> > > dma_get_required_mask internally, to check whether the device's dma_mask
> > > is big enough or not. That's the call I was asking whether it needs to
> > > be changed.
> > 
> > Yeah the attached patch seems to fix it.
> 
> That looks fine to me:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

Do you want me to resend the patch as its own mail, or do you just take
it with a Tested-by: from me? If the former, I assume you're ok with me
adding your Signed-off-by?

Thanks
