Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD61AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5C52073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FFdYYfL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRH7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 02:59:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35344 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfKRH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:59:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so17615659wmo.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 23:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fUs8B/WkyUZAbwtx8qw4pJ19URdEWvobTBtidNjfieI=;
        b=FFdYYfL/iV4E09SN3SJxG+L04JMoN0P9xhPsh0UT4Nyczmso3gV/WJJs49LcBPioPo
         p+5md8n9gIzYhUhzYgf8QneYlmECQ1PHJI+owKzcE30N8YnTazyxtQ6r4SE2hx9bhzbM
         ECKsU5dPnaI2HQB2iUDFvCHQr6vTNTwATlSVUAS6M+cypHKmJJ7aGlgKNpqgwxTHnEBI
         dsyVMjnhgCNeugerC98AxfI2oOAe9IlALOsA6OpeALsJtpWq5I2gBRyCdFcXvIxz37fW
         wokLBWXmqZV6OLt5vY4Ad4H6Xf9fD93/1tMusbGOXWVVL820z5Yakrodh59rJjndsI5Q
         lQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fUs8B/WkyUZAbwtx8qw4pJ19URdEWvobTBtidNjfieI=;
        b=YL1VfSRRfgOQm8PlGDRexDnZKMMTQfhGe5goA8xSpBEp0lSw/VvrSROL2eMjdekxZE
         1P9Y2xxlpvwUnwIy/UC+NhU9HhizHwRlba4e1orFH2LnhfGKStX64NTiDSDOhEou6NYT
         SWyVwFsyKZ6kxdGPeIHCz2Esr5oC7etkfiisXCK3i0brlglUDu18jhzjp91MbdZ1UQ6B
         c517YuDAJoSIYYCcf5nN3BD4ci0yHOPqlQdDd2lmyifCUnHDXLZDALHkAKoxl5OLFs1y
         o3XJB+EkNgEzrXJIYz3Lt9CNeAXV8y/dsnY9cv7GOXZnB8B6uvzGiqkkIiU/BlpUOTXR
         ozqg==
X-Gm-Message-State: APjAAAU+9TLAYPAx9jBQlE7jVvAWNfbXIqmFxIn7q/piC8RyEBAz82VR
        8kE7tg44tOY4QGYgxBMBZr0Yjw==
X-Google-Smtp-Source: APXvYqwBtHQUJ22ObkAdul3ssi/S+HiokTzN+Q6rYV/itgcWNhuLU5qzps+leP7X7IdGaHC35mqTKw==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr26411405wma.62.1574063973931;
        Sun, 17 Nov 2019 23:59:33 -0800 (PST)
Received: from rudolphp (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id q15sm22097551wrs.91.2019.11.17.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 23:59:33 -0800 (PST)
Message-ID: <246585089f8b0730bc4e0ddae2e6a877009e1307.camel@9elements.com>
Subject: Re: [PATCH 2/3] firmware: google: Unregister driver_info on failure
 and exit in gsmi
From:   patrick.rudolph@9elements.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arthur Heymans <arthur@aheymans.xyz>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>, furquan@chromium.org
Date:   Mon, 18 Nov 2019 08:59:32 +0100
In-Reply-To: <20191116134001.GE454551@kroah.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
         <20191115134842.17013-3-patrick.rudolph@9elements.com>
         <20191116134001.GE454551@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-11-16 at 14:40 +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 15, 2019 at 02:48:38PM +0100, 
> patrick.rudolph@9elements.com wrote:
> > From: Arthur Heymans <arthur@aheymans.xyz>
> > 
> > Fix a bug where the kernel module couldn't be loaded after
> > unloading,
> > as the platform driver wasn't released on exit.
> > 
> > Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
> > ---
> >  drivers/firmware/google/gsmi.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/firmware/google/gsmi.c
> > b/drivers/firmware/google/gsmi.c
> > index edaa4e5d84ad..974c769b75cf 100644
> > --- a/drivers/firmware/google/gsmi.c
> > +++ b/drivers/firmware/google/gsmi.c
> > @@ -1016,6 +1016,9 @@ static __init int gsmi_init(void)
> >  	dma_pool_destroy(gsmi_dev.dma_pool);
> >  	platform_device_unregister(gsmi_dev.pdev);
> >  	pr_info("gsmi: failed to load: %d\n", ret);
> > +#ifdef CONFIG_PM
> > +	platform_driver_unregister(&gsmi_driver_info);
> > +#endif
> >  	return ret;
> >  }
> >  
> > @@ -1037,6 +1040,9 @@ static void __exit gsmi_exit(void)
> >  	gsmi_buf_free(gsmi_dev.name_buf);
> >  	dma_pool_destroy(gsmi_dev.dma_pool);
> >  	platform_device_unregister(gsmi_dev.pdev);
> > +#ifdef CONFIG_PM
> > +	platform_driver_unregister(&gsmi_driver_info);
> 
> Why the #ifdef here?  Why does PM change things?
> 
The driver is only registered if CONFIG_PM is selected, thus it only
needs to be unregistered if CONFIG_PM is selected.

See 8942b2d5094b0 for reference.

Regards,
Patrick

> #ifdefs in .c code is really frowned on.
> 
> thanks,
> 
> greg k-h

