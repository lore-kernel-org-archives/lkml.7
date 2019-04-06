Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BA2C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396702171F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGHXt7EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDFW4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 18:56:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44305 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDFWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 18:55:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id i21so7671853oib.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBhIrrVgBhL3JASzmlLBNug0qu1+MyiouPUsQrHTrOA=;
        b=BGHXt7EWdYykFnKylooH/+vybWZ2QXQ/V4eJo5L7kA1dwEaIXpI5vg/BShDM6iS1ym
         5EFC+d8W4ygO0ANuw0Qzw55E8QdvQwtXs+UqBg5skFCi7O8y2O+e0ljABNDGsw8nHdoJ
         dVwijj1sFUsoiOzJnaNc3jsqTqfPNhOuIvr1VLfTEqu18z7bbjEq+xdyvd/s3FxNLWTU
         IlTRya/7K6T7Gs7CVqCbzZLTr9y0kaOGlAZkBzVHqpJAbT25AssdQft2ZbNlTnaHky2s
         hZ5JUfJfWcVMUtOyC00vlUyMJjqj11qjRxKXL81yQIn09rFeX5UJOiJw4ajXZqCIt02C
         U9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBhIrrVgBhL3JASzmlLBNug0qu1+MyiouPUsQrHTrOA=;
        b=AAWnWv+XX2SSnej1rzOcPGG6SgOaxgEwnlnYvdysOslLtmhSw9ATdZzMK74JzQSk9X
         ZUb5IrTT6CmMwc5VLHxYrC/HqE7PHHzcPjdMmpaHOWWu0jydMDv3HmzT4PzlFbVZVKRN
         ytbdGybUymINRsufNnDOF1y5lthurOUkrnK1J8N5sosMbo0M/nIc10pl8G3jFzYGp+e7
         er4CsPSeThck2/5pvrJuEqJlAfILpdYEc9qZXOrw2p9ULAFEVlzD515ZlvT9OOuplho3
         6ccJenzZ2M4AsgiTvWdR9w0KrEv+TULsftFT8taJtP9RCE9Yk1ZZg6bHnfS7ExQKRsU/
         aF1Q==
X-Gm-Message-State: APjAAAUpPuWGxzw8qBFH5l9cuGZfIaoxXHJHv0Yd+xQe12NzoWbPKtFN
        MVdOrRhOxL1WBDRjIns1Qxk3PGSbyBF3QA==
X-Google-Smtp-Source: APXvYqyhcekf7SIaYbv3qneuPVcmiEn5uEE2SbT8d4gkWmr5zJrti6yAXvcu1x99VmR9Sb/jx8RbQA==
X-Received: by 2002:aca:62c4:: with SMTP id w187mr5354880oib.45.1554591358907;
        Sat, 06 Apr 2019 15:55:58 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:f0cf:ad07:6e62:18ae])
        by smtp.gmail.com with ESMTPSA id z12sm10138270otp.2.2019.04.06.15.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 15:55:58 -0700 (PDT)
Date:   Sat, 6 Apr 2019 17:55:55 -0500
From:   Madhumthia Prabakaran <madhumithabiw@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: Fix spinlock_t definition without
 comment
Message-ID: <20190406225554.GA9140@madhuleo>
References: <20190405200046.20600-1-madhumithabiw@gmail.com>
 <20190405205304.GS32590@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405205304.GS32590@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 11:53:04PM +0300, Dan Carpenter wrote:
> On Fri, Apr 05, 2019 at 03:00:46PM -0500, Madhumitha Prabakaran wrote:
> > Fix spinlock_t definition without comment.
> > 
> > Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> > ---
> >  drivers/staging/greybus/connection.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/connection.h b/drivers/staging/greybus/connection.h
> > index 5ca3befc0636..0aedd246e94a 100644
> > --- a/drivers/staging/greybus/connection.h
> > +++ b/drivers/staging/greybus/connection.h
> > @@ -47,7 +47,7 @@ struct gb_connection {
> >  	unsigned long			flags;
> >  
> >  	struct mutex			mutex;
> > -	spinlock_t			lock;
> > +	spinlock_t			lock; /* Protect structure fields */
> >  	enum gb_connection_state	state;
> 
> What does the mutex do then?  Why can't we just use the spinlock for
> everything?

Here, mutexes protect spinlock_t for gb_connection_state fields and
gb_connection_state fields itself in struct gb_connection.

However, I wasn't sure then and now exactly, how to find out which resources in the
structure, the spinlock or mutex is performing kernel synchronization.

> 
> I did glance at the code and it wasn't immediately obvious to me.

Thanks for reviewing it.

> 
> regards,
> dan carpenter
> 
