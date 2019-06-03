Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CACC28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AA027B0E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6EmQsSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFCDXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 23:23:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42249 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFCDXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 23:23:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id g24so15145475eds.9;
        Sun, 02 Jun 2019 20:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pSfpsds9EQbM9WscG0cMmvHxHZNBbzbAhxUSUQzMxEw=;
        b=p6EmQsSt3vDqhOEAwdmtI53kfWo8NyOM/SYeUgm4HfVyXUGbblyzBEvJnA5bHfpVPG
         xCFLdPnD1URb6fyiDAuy641+yfjX2pTPOqINI1Dkw1w4MRtvrUi9PJVzd1YW+ybRtJrs
         cmbdXsMHjSI2Q439j1d2MingD2Mi6Acj+RLRpUWwWtNpOQAtNnAmPyk0uvbecGTv3Ezo
         mJM+RwmKVo0EuneEkAfSZU0AxwmE3ndyzF48eI+0G9be6V1wrOTHhoG6Y8kuIGO6gR4D
         p8AkgiTx7mTFmxTMG0l1mTJD2k46Cxs8BeBLR9E+q43EhepsyS872Lui4rFkACUg7P4I
         DgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pSfpsds9EQbM9WscG0cMmvHxHZNBbzbAhxUSUQzMxEw=;
        b=OVoZ7D7URsGO+Nt8a7l7cp//SsNi8uKLBqfKqEYLLg05RjgDSFIf0p3SiLCw2FOlUF
         q8KEyBdt/My6/r9q8FM5I93AFV56PmfZ43fhYIcthFgqSSz5iS/yhsKGGB37KynszlB4
         TeKPsPP7NbcVbs5+tuzxeXDvMLg4yLsIGPyCLQ73FsgLYnySkAPXJCNgAoI/p4GRUoid
         cmLvgY1YLFKG+2U2mqlB88hAS9D9uWTl5hG5xhl6M7j6s6XTg9R3DMrlqHP4q3UrIw35
         TVMeb+DJQSHSVyFHmrOXdCnf+Q90+cZaG0KhKHgPEoeYih+Hm4uQyqDxhI4B7t9DdDi3
         OpGg==
X-Gm-Message-State: APjAAAUBOheGDipDpITXb8ADYbjg54Mvv1ymkaFjigscy/GblhltQ8ch
        39rJZh+z6vetVP3A9qAX8qU=
X-Google-Smtp-Source: APXvYqy4Hsm/zoTmC0MBbcJlJ9Z2m/nmDD28JaXgZZmuAomhkyMRxC1lnzngw7n2bVbjhVi1S66Pww==
X-Received: by 2002:a50:f286:: with SMTP id f6mr23354274edm.44.1559532227215;
        Sun, 02 Jun 2019 20:23:47 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id a40sm3735370edd.1.2019.06.02.20.23.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 20:23:46 -0700 (PDT)
Date:   Sun, 2 Jun 2019 20:23:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvscsi: Don't use rc uninitialized in
 ibmvscsi_do_work
Message-ID: <20190603032344.GA26021@archlinux-epyc>
References: <20190531185306.41290-1-natechancellor@gmail.com>
 <87blzgnvhx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blzgnvhx.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sun, Jun 02, 2019 at 08:15:38PM +1000, Michael Ellerman wrote:
> Hi Nathan,
> 
> It's always preferable IMHO to keep any initialisation as localised as
> possible, so that the compiler can continue to warn about uninitialised
> usages elsewhere. In this case that would mean doing the rc = 0 in the
> switch, something like:

I am certainly okay with implementing this in a v2. I mulled over which
would be preferred, I suppose I guessed wrong :) Thank you for the
review and input.

> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index 727c31dc11a0..7ee5755cf636 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -2123,9 +2123,6 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
>  
>         spin_lock_irqsave(hostdata->host->host_lock, flags);
>         switch (hostdata->action) {
> -       case IBMVSCSI_HOST_ACTION_NONE:
> -       case IBMVSCSI_HOST_ACTION_UNBLOCK:
> -               break;
>         case IBMVSCSI_HOST_ACTION_RESET:
>                 spin_unlock_irqrestore(hostdata->host->host_lock, flags);
>                 rc = ibmvscsi_reset_crq_queue(&hostdata->queue, hostdata);
> @@ -2142,7 +2139,10 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
>                 if (!rc)
>                         rc = ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0);
>                 break;
> +       case IBMVSCSI_HOST_ACTION_NONE:
> +       case IBMVSCSI_HOST_ACTION_UNBLOCK:
>         default:
> +               rc = 0;
>                 break;
>         }
> 
> 
> But then that makes me wonder if that's actually correct?
> 
> If we get an action that we don't recognise should we just throw it away
> like that? (by doing hostdata->action = IBMVSCSI_HOST_ACTION_NONE). Tyrel?

However, because of this, I will hold off on v2 until Tyrel can give
some feedback.

Thanks,
Nathan
