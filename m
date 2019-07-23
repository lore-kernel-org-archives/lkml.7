Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A75C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575BB20823
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy4P4RYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbfGWQSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:18:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35190 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGWQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:18:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so20807365plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SbioZYsqXTI1b1a0jzbxqVl3pYOBasDSMS5fRiQSkc0=;
        b=Sy4P4RYjtAGYig3McVhvQgjSkVJsl5VfMkOeDHnDGRy0UXcNxsAMbHhDSgmQc2AuvU
         Rwd1exGmFBBn9sgcWHa2iyUsV2nyIjBq9SPamzqI0yXo2ycQLI3QJPeG4bv8JT6gmkBk
         2WjzT7JkRfnU51mUduThGjz4U+xtSKVTUDNWmrKuOfKQaXYwQ/ol9Rs4NGpd9QLRws1L
         XydZMOSczRv3FthK9dX7qAoWOs2Y9SWM1m1eUpAQpu/O8yM0HBFTvj2A+GBUrJ5YCk1p
         IkmAh3OVM8d+5I+z0j56a56JAHtyW23gkHBl1vQbR8iZRwgEB5Cg4cdiRWsFVLERhcM9
         8C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbioZYsqXTI1b1a0jzbxqVl3pYOBasDSMS5fRiQSkc0=;
        b=NJ8RZejNe/MwF1IJ2ypji1ZD+yVK77oJq1bccE6kMelB//uo93NZ8mytq2HPUK77zb
         FVq8yUiwCIVhn0vqbcVsCzpMkWXiHJWYBSPCGkxNoGpIUfFafMvX0R6xlj1oRg3ejvMm
         cIRYZEh99Zm1ebB6InDciDsc+dBX5us5LSvsmApTQ6T+gCg0AaE410nnAhRBpN1pTwSE
         ePCHn5La8lSV3GThdEW3szUfW6j9JGGN4VzWZ0U+W+4fN3vtEWfWflc8lGF5m5CXKnJ7
         uNOiCc1MbCprlNN3IgR82qGWSMOozhX51zVbOwz72VYvq2MiQK2iOspfvUqXlK3TtUyj
         tI8w==
X-Gm-Message-State: APjAAAUiHHjQjQD33v8urxXGQ2p4lbfZVnVFTEIsouL3Lb0p17iwyK93
        VYN5JpgUOJnLZ8yfnfYYDts=
X-Google-Smtp-Source: APXvYqwnSWgCdax5ypwc5jfHzHjSUNJ8t7VshuLos9iQqiSQWW15WxRl9t3NhDEv9mI7R3+KnozLTw==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr76202371plb.299.1563898720354;
        Tue, 23 Jul 2019 09:18:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k6sm52727889pfi.12.2019.07.23.09.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 09:18:39 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:18:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Linux 5.3-rc1
Message-ID: <20190723161837.GA9140@roeck-us.net>
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

This fixes the problem for me.

Guenter
