Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC684C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01BC2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBppyJOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfFEPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:35:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42503 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfFEPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:35:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so1900764wrl.9;
        Wed, 05 Jun 2019 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4qxaThqFMW3T47fPge2zEn/JNJ6QZB5xTLy596ejaYE=;
        b=sBppyJOLLnidkgAo1ilStRVEvw9MCYjjXfDV/juuX7NWYcycYlBujY+Xs1/0kJ6cak
         Z0fxNUk6r4DUIX4LL1Grma5xAEBmtSi+AZfagFu6jAZFcTgsPkHyuKIXvwAFBmDzjkeM
         wX6GMK0e9LmdvdRBbD+7Z9KyHrQDPusXiyy4etXFSIZmeoyU0qoHIi47n3NNfdktlT1R
         bkAqOBGaVbUD0Mnm/mFYqatvuf/LIKpNaU8FQ+h0vX6e75ykJ+TlwWVVI6f8nr5BNTo9
         M88i2oMaEk8pVWhSTlVfZWJYWgkizjCKfXJF7rOMcLeTv7zXB8KU3B63u8wULImyjItH
         dWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4qxaThqFMW3T47fPge2zEn/JNJ6QZB5xTLy596ejaYE=;
        b=nV7wV5ed9rIDgJ95fk4TQxmZRrxDF6UoorAnG5SP6u6OSumTeXkABRYYwKUhVJTQEj
         1brOykayix+1/4KKFO8hzi7uLC1XA9i5yYoax/8AvauNMdlQh7cPsC+I1Ex+nX4sC2yZ
         OC8o+q1XMnwhLFEnpTkeoM0L6Li8rtn4XQMZmVpWsXo0C/JQK+YeuL2j9Jzt/clRtQ9Q
         UQKAJwDPgj4WTBAQrUPrf++7svV6Cc7d7CioXFh+EfupuOV7u++JbfSO+t1ElrBKrbUy
         lHRsEzlsVuNfXt/hSJacTbAvll8lfDBQUc9ucaQAqzpHU5ZGCXTSw7rgOU0sieM7CF7s
         uhiQ==
X-Gm-Message-State: APjAAAVMvN24/Mki6VxzXpx7C9xgf9vgyY9e4XiGjeBCG/uykrfzt0hQ
        QO9at9yFSeGLoucE8cSyIsY=
X-Google-Smtp-Source: APXvYqws+28UOXzH6NniVSdnPkLlgX2SkS0XQ+8Sgui2RNxpaTt4rhI242grVGvwEUNmyr0CvYEjwA==
X-Received: by 2002:adf:e4d2:: with SMTP id v18mr11040759wrm.189.1559748940377;
        Wed, 05 Jun 2019 08:35:40 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id l8sm15977196wrw.56.2019.06.05.08.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:35:39 -0700 (PDT)
Date:   Wed, 5 Jun 2019 23:35:32 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sg: fix a double-fetch bug in sg_write()
Message-ID: <20190605153532.GA4051@zhanggen-UX430UQ>
References: <20190531012704.GA4541@zhanggen-UX430UQ>
 <38bbd54f-d85b-e529-36ad-5c1809bb435f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38bbd54f-d85b-e529-36ad-5c1809bb435f@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 08:41:11AM +0200, Jiri Slaby wrote:
> On 31. 05. 19, 3:27, Gen Zhang wrote:
> > In sg_write(), the opcode of the command is fetched the first time from 
> > the userspace by __get_user(). Then the whole command, the opcode 
> > included, is fetched again from userspace by __copy_from_user(). 
> > However, a malicious user can change the opcode between the two fetches.
> > This can cause inconsistent data and potential errors as cmnd is used in
> > the following codes.
> > 
> > Thus we should check opcode between the two fetches to prevent this.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> > index d3f1531..a2971b8 100644
> > --- a/drivers/scsi/sg.c
> > +++ b/drivers/scsi/sg.c
> > @@ -694,6 +694,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
> >  	hp->flags = input_size;	/* structure abuse ... */
> >  	hp->pack_id = old_hdr.pack_id;
> >  	hp->usr_ptr = NULL;
> > +	if (opcode != cmnd[0])
> > +		return -EINVAL;
> >  	if (__copy_from_user(cmnd, buf, cmd_size))
> >  		return -EFAULT;
> 
> You are sending the same patches like a broken machine. Please STOP this
> and give people some time to actually review your patches! (Don't expect
> replies in days.)
> 
Thanks for your reply. I resubmitted this one after 8-day-no-reply. I 
don't judge whether this is a short time period or not. I politely hope
that you can reply more kindly.

I am just a PhD candidate. All I did is submitting patches, discussing 
with maintainers in accordance with linux community rules for academic papers.

I guess that you might be busy person and hope that submitting patches 
didn't bother you.

Thanks
Gen
> I already commented on this apparently broken one earlier...
> 
> thanks,
> -- 
> js
> suse labs
