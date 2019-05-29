Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31031C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF2523C80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="YLj+z14b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfE2PyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:54:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34701 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2PyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:54:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id j24so3021901ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HZPIDMHhUw7CgfVQ/9XO5eI1+3TKH0K2oXJxQv63Hxo=;
        b=YLj+z14bB4aNZfVxxhFnzHr+IJ0pqDENed4opWRwB3klsdl+zcbbOsZ5Cz+kb8fF3n
         PYPoAbsciMmnBeh1o3ZEOzy622o6+WWvo1l6+xcYhEBGC1KG2jA+iDGAtAe504we8fuw
         NI4d8Ws93egDU5nhkdLg5rTL97Ryu8Ksl/k3zgW9NN6D3YHQJNY55kto8DGg1v5rTMPs
         KW+fDxM3R82Tcht78VcJ51Qfd3xt3w0ZzCmdzrym5zRrab0CHd81011koMd1G6XWAfkg
         bgzrtoGgdM0nT7faKI/0o9NmgTL1+KPxcF+4fi8bvJBLZfBnNCjJM5Dm96IbByxYodVl
         TLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HZPIDMHhUw7CgfVQ/9XO5eI1+3TKH0K2oXJxQv63Hxo=;
        b=U5s5NpWslOe7nOXhwz0Oegkset1an58GYJKaI1xQTKoKQhUKosvyI+4xSP4RaUdmQc
         Ik7epAVSw8CBe3cKfqJBYOmUNA/1dJVUYY4u30eTiqix9w3fctBZ6mo606MWKtevL1jv
         pxddV/sI9IgaZHtSjy95M1ZVKZcOZJIlg/IABv94THxcXO5iE0UDje0J2HXVQrYsdLI0
         XYZh0EBUR2eloPl44oMGiokc9UJBeSM9zVcGPGgNLckRbOszjk9WmRBzmBJFmKc8W11C
         JBQrwKr/09jZ12PtfYRalGRMU+HOcfw7CIZ0foH0DHzw2sL75qyQ0ecwKKRub5yx3yJu
         GMpw==
X-Gm-Message-State: APjAAAXakoSbzYvkJhyeJe6X0yBu4yAoOSCFtscu/8FWKYNmec2LgmvZ
        8YT6Y1SQaVMcMmiz5VvmM4OB3g==
X-Google-Smtp-Source: APXvYqxnp6Ve/wM1vnGRQlgI3iNH7KRfR+IK9dcQlN8Qua6EBlBLsRfVNuraPd66a2x2nieNPzMGWQ==
X-Received: by 2002:a2e:7001:: with SMTP id l1mr42358017ljc.11.1559145262588;
        Wed, 29 May 2019 08:54:22 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id y127sm9462lff.34.2019.05.29.08.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 08:54:21 -0700 (PDT)
Date:   Wed, 29 May 2019 17:54:19 +0200
From:   Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: kpc2000: add missing spaces in core.c
Message-ID: <20190529155419.ego3sfedew65ini5@dev.nikanor.nu>
References: <20190524110802.2953-1-simon@nikanor.nu>
 <20190524110802.2953-4-simon@nikanor.nu>
 <20190527073159.GX31203@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527073159.GX31203@kadam>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:31:59AM +0300, Dan Carpenter wrote:
> On Fri, May 24, 2019 at 01:08:01PM +0200, Simon Sandström wrote:
> > [..]
> > -		ret = copy_to_user((void*)ioctl_param, (void*)&temp, sizeof(temp));
> > +		ret = copy_to_user((void *)ioctl_param, (void *)&temp, sizeof(temp));
> >  		if (ret)
> >  			return -EFAULT;
> 
> This should really be written like so:
> 
> 		if (copy_to_user((void __user *)ioctl_param, &temp,
> 				 sizeof(temp)))
> 			return -EFAULT;
> 
> temp is really the wrong name.  "temp" is for temperatures.  "tmp" means
> temporary.  But also "tmp" is wrong here because it's not a temporary
> variable.  It's better to call it "regs" here.
> 
> regards,
> dan carpenter
> 

I agree, but I don't think it fits within this patch. I can send a
separate patch with this change.

Thanks

- Simon
