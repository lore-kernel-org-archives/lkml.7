Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C06DC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBDE223BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lnl1sPne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfGWPlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:41:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42636 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfGWPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:41:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so19330902pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JGDx6QXTVZIP3ROvVhy/zMJsi84wmN5E+eP8G64GvJ8=;
        b=Lnl1sPneGnq+N454dBj1DViI5sW1L6aSNzM2wBoc2AZrVPU3icW4lqo/fuRLh4whEu
         MfF3D6tNLMx4V4Zz2HF4TLvDktr3iFabg6KtNojvwaKqHkTUSAXI4VUxhWoGa1W2UNiD
         SyGF7zAxSXsHzXxb9SNNHMzkxdhyJwxQVQFRaGHLf56G571+pRd4C8z9K25WLGvCf5Gq
         HeuJDc55ivnci2Ogpgj/PGzxiyJ0/ZIJHcWod9G6qnEz9RlpSRkVCpS+fegjZIIxXw/1
         H+lBe/PfzEA7XKuFZnTIqtVmiQu9LHB84V/9CSSsCKYNq0iwQ9y1hVr+pOdhRfGwnzE5
         gpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JGDx6QXTVZIP3ROvVhy/zMJsi84wmN5E+eP8G64GvJ8=;
        b=Fln3uWwlYH/BZcDAxzO6rZlWT4qyCrWZaiFwZ7vR7sh9GCjTe7eWntToVwzinwsMCn
         Q0mOnTnOdFSzg3SV9KNXitO1yGdNDNwYYdv/MFtpJC46hURrYR6KUbpIgUksHsA+/Vbn
         ioRc4RyDkMxCmYoZD98ksm5NpXYE4b1AVXQvCRiozfK04dcRy5KN8CHGWy30dWgNPh8m
         OGDIi8BqSyIKJRA2heLl2AJpyN8kDEJfG7ZVpSQMv94PTflKWs6rhUZD5S+JmEtaKS09
         pBih+QgNoZbJ5tLxKuokELJSpRK2hxR7XaHr5G3R4xDyhTjdAxwRQnv1pOLwgQsE6JvI
         GVjg==
X-Gm-Message-State: APjAAAU4OMS//+vcl2XFUOsmSsWcsoyMzkCq/Vk47ht77jGI/JmraoBd
        7pNgsbN4W/R2lkbLyMN9dnBOnlcp
X-Google-Smtp-Source: APXvYqw9GVywGSdHXCBSPof/oVbL69Leil29uDsPG5b3ubR8pX2GLIM5rdpTew9NlffYOinfxpY98w==
X-Received: by 2002:a17:90a:2641:: with SMTP id l59mr78356148pje.55.1563896462077;
        Tue, 23 Jul 2019 08:41:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9sm53041099pgk.10.2019.07.23.08.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 08:41:00 -0700 (PDT)
Date:   Tue, 23 Jul 2019 08:40:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Linux 5.3-rc1
Message-ID: <20190723154059.GB6198@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net>
 <20190723054841.GA17148@lst.de>
 <20190723145805.GA5809@roeck-us.net>
 <20190723153421.GA720@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723153421.GA720@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 05:34:21PM +0200, Christoph Hellwig wrote:
> Does this fix the problem for you?
> 
I'll try. Give me a couple of hours. 

Guenter

> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 9381171c2fc0..4715671a1537 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1793,7 +1793,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>  	dma_set_seg_boundary(dev, shost->dma_boundary);
>  
>  	blk_queue_max_segment_size(q, shost->max_segment_size);
> -	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
> +	if (shost->virt_boundary_mask)
> +		blk_queue_virt_boundary(q, shost->virt_boundary_mask);
>  	dma_set_max_seg_size(dev, queue_max_segment_size(q));
>  
>  	/*
