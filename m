Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF9C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86165223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Awwfyfh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390900AbfGWQwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:52:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40028 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfGWQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:52:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so20789533pla.7;
        Tue, 23 Jul 2019 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Qj5IIwqgNLGa4ZWyo6tUF4BC8UycTqmBaNZSmrXNZk=;
        b=Awwfyfh60aonP3N7bKnwltr2gXTT5/zdbyZWzrWakq/yDwEdPjPO60XRc0+lUIgng8
         kAwjo3Ot/bfunUovy8IqYTaOstnCCP+hu1sW/orQydMOyA6G+0mNEYwLni3TPFbjDIr/
         ZoJN8pv3OJuu9EiD9DRd32Qqvx3jDcQOoHDgTcZQ2wP7CBLfZkZi5Q+8nWjhp/W9akH6
         61UMyFrgSaTU39Mud2TjL3LtiOKzreKuiPwc9yKegLiEOfex6W7GQ+/FQRpJBOiTzF4B
         19hQrS93pEWzdlyhd6uP9VdkYnQguexyquNpmcJAcAOtfqupn0+z5M9X2On1LweJt3Zt
         QqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Qj5IIwqgNLGa4ZWyo6tUF4BC8UycTqmBaNZSmrXNZk=;
        b=pgFRJWZ1DZ6kd+vCxUELm/jNW2k8fAoRu8ReUpBj3k5MLqQDYqVV8YElf4/jJAOENX
         Tl9yVSux8jpyjOEwXpOJjUXg73cpCv7F6qGiahO202xZeZ0uuZ4ZimNY4wroP7O85Exz
         v2Mr2+gjB9i67RnV4PDl40QQRhg658pCB5Eu1N/5v2qm1jxfEok+LSmrjrTWtj5hAv7j
         f8/6Yy2lfASlEmNEjP6vXnsPyacF+9+OiT0AcxWXgpsF9JoIrW+2DVKvoyMnSG1urfUd
         WZtEJ+4oshk8HlZbMIYocDfLXlPkymTU6Es6GEaFbHZh8kgDo3PEU4DnfE8KMv/Op1tH
         JI7g==
X-Gm-Message-State: APjAAAVo7rYIrK9vmVBM8Al0gEtGQrJ+VLMi71vuUIBJ+V2uFN6sHQg5
        pvxR+4A0jz/DmJn+bhDsypuyARLA
X-Google-Smtp-Source: APXvYqweNH6jJ1TzfFfD8qzOD4kaJ5w9jn/POrjk2ZwtyWxqLieOXDssHNdNfpoakojURgVSAY33og==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr79980802plf.246.1563900730978;
        Tue, 23 Jul 2019 09:52:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15sm51228528pfg.102.2019.07.23.09.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 09:52:09 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:52:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: Linux 5.3-rc1
Message-ID: <20190723165208.GA26316@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net>
 <1563839144.2504.5.camel@HansenPartnership.com>
 <4dc6ef77-afce-1c6d-add3-8df76332e672@roeck-us.net>
 <1563859682.2504.17.camel@HansenPartnership.com>
 <1e05670d-9e28-1b1d-249d-743c736e6d63@linux.ibm.com>
 <1563895995.3609.10.camel@HansenPartnership.com>
 <20190723161918.GB9140@roeck-us.net>
 <1563899014.3609.26.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563899014.3609.26.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:23:34AM -0700, James Bottomley wrote:
> On Tue, 2019-07-23 at 09:19 -0700, Guenter Roeck wrote:
> > On Tue, Jul 23, 2019 at 08:33:15AM -0700, James Bottomley wrote:
> > [ ... ]
> > > 
> > > Yes, I think so.  Can someone try this, or something like it.
> > > 
> > > Thanks,
> > > 
> > > James
> > > 
> > > ---
> > > 
> > > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > > index 9381171c2fc0..4715671a1537 100644
> > > --- a/drivers/scsi/scsi_lib.c
> > > +++ b/drivers/scsi/scsi_lib.c
> > > @@ -1793,7 +1793,8 @@ void __scsi_init_queue(struct Scsi_Host
> > > *shost, struct request_queue *q)
> > >  	dma_set_seg_boundary(dev, shost->dma_boundary);
> > >  
> > >  	blk_queue_max_segment_size(q, shost->max_segment_size);
> > > -	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
> > > +	if (shost->virt_boundary_mask)
> > > +		blk_queue_virt_boundary(q, shost-
> > > >virt_boundary_mask);
> > >  	dma_set_max_seg_size(dev, queue_max_segment_size(q));
> > >  
> > >  	/*
> > 
> > This fixes the problem for me.
> 
> Great, thanks!
> 
> I'm thinking this is the more correct fix:
> 
> https://lore.kernel.org/linux-block/1563896932.3609.15.camel@HansenPartnership.com/
> 
> But we'll see what Jens says.

Yes, that patch also fixes the problem with sata-sii3112.

Guenter

> 
> James
> 
