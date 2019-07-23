Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49549C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA6F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu7QRiQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbfGWQTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:19:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44224 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGWQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:19:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so19370723pfe.11;
        Tue, 23 Jul 2019 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=utciOzF0KT/vzhyI5HhnvVFUYaN/yvk0fzwnCeqDMHU=;
        b=pu7QRiQkyygYe3Hd3g9JGjCXsl/l3fvRDcrWf91F2tQlBdnh9Hr5jhkHHMAFuXaqzn
         RdLOTYwBzJZK6szwSKTTz9iO+ePY8y+J15FzoSqmx3bgGJG7Zev2eYXD8KNY7JWJBJNW
         Du9gEFuMoeE6e0KF/St0nRkTBSd3qEacrrYQGUeUeaZzNO5bsloqVmExtpAsFeZXqZwD
         n9alyRGUzKUPBhSQr1/RsEC3ZaM1bNcTiQTkXVaXCeQbZhBZofroU2fxydsjyZFVBzQX
         PesV4lu/tru8rLgiCXA5vwo/kTPMtFB4214C7z+enDSsaXlTdm4Dj7pMx0DtLoEZZj9k
         7ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=utciOzF0KT/vzhyI5HhnvVFUYaN/yvk0fzwnCeqDMHU=;
        b=Ryq1844iB9EbZFzc9SHPIzNx/0d+azVw3DIEWp5ctyDco/6OCXTCEL79K3WSZNHXrG
         yKO6P51RuTDQ9iXXb+blWaSwLOM9Gob2yhDsx8vUlr5+TuyvWyvrZvRhGxy03hOkpVti
         iOvxGF5TwGZK/l2N5BTwIXLupDvThHwQRrQer5RC0D+RcWrOLU1nAi7eyM7V6pB6Ke6H
         wQe4XSHEGOKgBuF2dxzwdG/J4OLwoWD30DuOBCMQC6t7KfeHvr7Wk1ycmNO24/UJHuMP
         dNZ4mq4chbKixkSrL65wKtzHyMoLcn5fBisAztdyd62VK/X5pSPgQ3Z6jQgoHoZ+olE7
         BpUQ==
X-Gm-Message-State: APjAAAXysuDKqdTXO0csTBd0bOUbnCmLMmGAZtRN9Qz/CJsJaoSrGQ0c
        bcYMi6NLu6PCdte1H6X4RsPT5RO7
X-Google-Smtp-Source: APXvYqz461jCg84f3q8N4Y2fKQcIQbFIv/9hUWPgyG7IaTSpCabyw4mx15RPQH9nHBCk9k0//Y2b6g==
X-Received: by 2002:a62:107:: with SMTP id 7mr6664662pfb.4.1563898760177;
        Tue, 23 Jul 2019 09:19:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d129sm48889826pfc.168.2019.07.23.09.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 09:19:19 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:19:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: Linux 5.3-rc1
Message-ID: <20190723161918.GB9140@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net>
 <1563839144.2504.5.camel@HansenPartnership.com>
 <4dc6ef77-afce-1c6d-add3-8df76332e672@roeck-us.net>
 <1563859682.2504.17.camel@HansenPartnership.com>
 <1e05670d-9e28-1b1d-249d-743c736e6d63@linux.ibm.com>
 <1563895995.3609.10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563895995.3609.10.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:33:15AM -0700, James Bottomley wrote:
[ ... ]
> 
> Yes, I think so.  Can someone try this, or something like it.
> 
> Thanks,
> 
> James
> 
> ---
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
