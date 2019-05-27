Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B49FC282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C632075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udCNPVOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfE0DNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 23:13:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34627 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfE0DNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 23:13:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so8728343pfa.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 20:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NCsV2gW6t5UqNhN3D3I7oSjbY9N12iBiE5UdaIK+ekw=;
        b=udCNPVOsqpgvTYuvkglh33m6JGunj9X5HQc3NtWDtttnXH79jCATY2AJaMvg7+QmxD
         bPPq3+aR5Iz2aUdQvCjT7lH/B0eoczJ5jLjiZAFbm8FcDT8alTTuk67DW6s4+lZuy/4+
         Q+iBHczTW2sIX0lYYnAGxf749r5gr81pbv+TPHH4l1As3aE2PMs2yQJ690IR271g1Zte
         AQztp1Tk7FoBVFP8oiyZjLot1+qJ+MH+guyl8tXe9UgZy3QmVhNzaHatfdtpy8VFQQoK
         ezlSfl277NQZ02/DeRavC3I5LNq4ttK0xTto1ygGUg1JPRu6BuDxFLSSGxplcOZXPjnJ
         j2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NCsV2gW6t5UqNhN3D3I7oSjbY9N12iBiE5UdaIK+ekw=;
        b=pXgAKgQu/CG6eUmvjTz92xqHshKLgjwb4peVYjotbuLEcfSp587QIwo1I71NwVITgC
         FIWT04Iqdmmxdd0BxqBT9FDYa9aP3FF5PU6Cdc0Eff6VQd9lfmPLB78+W5npEso8QI3M
         J9RVd37Q5EeYzul4L9kWX/WbZQJxSlwbBwj6eFd5WDxNb3+wgPPjIUOCxUhjxe5FtR8d
         LFa0ZczfJqzOFJ0WU/fex/WVoekshf3lOcVPK/h9niojgSaXHINBPOjTBNKdSn6FD2tu
         /oU9aMIne6qtEBVIq48VGr4B5kHpWoPfpny8m7o3YA8+MYMoVnr6wuzQuJu4v0fF7H/5
         +o0A==
X-Gm-Message-State: APjAAAWTV4m3q5JFJWkAMWRFZhNmN66LAG9mLXvipIa7U4AfwiN1k0TD
        RBNK3ZdyyF1LoNOeeMcsnP0=
X-Google-Smtp-Source: APXvYqxwYZFVlVs73XW/twQdc6Ve/zbUt354slZJ5kqHsRCMBtJ5rQNOLjRS33wXPrrDMLUrrR/iAQ==
X-Received: by 2002:a65:614d:: with SMTP id o13mr37543080pgv.309.1558926783964;
        Sun, 26 May 2019 20:13:03 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id l13sm8495613pjq.20.2019.05.26.20.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 20:13:03 -0700 (PDT)
Date:   Mon, 27 May 2019 11:12:51 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm-region-hash: fix a missing-check bug in __rh_alloc()
Message-ID: <20190527031251.GA18979@zhanggen-UX430UQ>
References: <20190527005034.GA16907@zhanggen-UX430UQ>
 <20190527014913.GA10098@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527014913.GA10098@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 09:49:14PM -0400, Mike Snitzer wrote:
> On Sun, May 26 2019 at  8:50pm -0400,
> Gen Zhang <blackgod016574@gmail.com> wrote:
> 
> > In function __rh_alloc(), the pointer nreg is allocated a memory space
> > via kmalloc(). And it is used in the following codes. However, when 
> > there is a memory allocation error, kmalloc() fails. Thus null pointer
> > dereference may happen. And it will cause the kernel to crash. Therefore,
> > we should check the return value and handle the error.
> > Further, in __rh_find(), we should also check the return value and
> > handle the error.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
> > index 1f76045..2fa1641 100644
> > --- a/drivers/md/dm-region-hash.c
> > +++ b/drivers/md/dm-region-hash.c
> > @@ -290,8 +290,11 @@ static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
> >  	struct dm_region *reg, *nreg;
> >  
> >  	nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
> > -	if (unlikely(!nreg))
> > +	if (unlikely(!nreg)) {
> >  		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
> > +		if (!nreg)
> > +			return NULL;
> > +	}
> >  
> >  	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
> >  		      DM_RH_CLEAN : DM_RH_NOSYNC;
> 
> This patch isn't needed.  __GFP_NOFAIL means the allocation won't fail.
> 
> And there are many other users of __GFP_NOFAIL that don't check for
> failure.  
> 
> Mike
Appreciate your reply, Mike.

Thanks
Gen
