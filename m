Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FD7C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6959A2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNfDt3Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405215AbfFKKI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:08:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42449 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405185AbfFKKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:08:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so4887735plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZlyaOqGyFC7c17YkXUN6lg7zWIfEjQ81AkuyNrOkHoI=;
        b=iNfDt3Mub6qkW0z3LbJ8k3XhEhgrwj408NhTtyiJ6DQRpxzE5YyIhWdIoQ4KTgZ5a8
         xANiP/c57r4XCNlvB6waiOOr+CJG8PWR4fTrTnx9YvERYNHNNAF9I2xZfzV3B/45Qu+0
         sC8YMWLSu5O3wXnHjU2Hr3/oB79N4W5VWRk5ROSTSQvQq6COdk95b/6LCU2SexSHy8xW
         l74aELF8On/prZrnquyTQh4WvCa2LH4S9SkNqOoYWSL4aoJX6mn2p0iuS1RQOkVW/oca
         Zqc7fnHeAY1QmuCJOFAFPMdIacZLI6P31LD+4Er9fjpYT9miw5ZFHG1J9jvW5Zef3FOu
         RESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZlyaOqGyFC7c17YkXUN6lg7zWIfEjQ81AkuyNrOkHoI=;
        b=GVe1E0Hk402P9XfsW68AFR8Rjo7YJ7uEjpC0ggSv8bW2h8RTyj4YXwx9SicvPACAZa
         yRJNqNAdkVwbaSm3c86xZgMRmPYNfELUhxrJUAYuB/Zfeu37SA03Yu+VAm3GTxOcaF5P
         5lN/pcDjogdUJvX0pw0oZnZ62h3xan+vcgVHDia+sb0VyeFeiA3KbzSEhEjasD1WZG0a
         5PIoJC2Td4sGX2fjO+mKXUG/vJ4MLAXaGIT3koaHESE4+XgpDI9p0E6lrULkB2X+DfnM
         9P6bbYUy5/4sGvSD2oquAFQIz3zk80zfGKVBwuq1RxV2srVmi6imtamWCInBIfSbBsM0
         vINA==
X-Gm-Message-State: APjAAAVk0DZvkkaLhOI1bN92glAyp8SqKtG6EmlX+XwwZrSs3kvdxmOT
        Q3TC4sCCHguZunXIgNAkeNY=
X-Google-Smtp-Source: APXvYqxwnC907CaLK2IU7NoNst6512I1yB+gfZW2TtIB/QhDmvCege3bObpdwaixhApkF6l6btT53A==
X-Received: by 2002:a17:902:a411:: with SMTP id p17mr15886850plq.104.1560247705500;
        Tue, 11 Jun 2019 03:08:25 -0700 (PDT)
Received: from ubuntu ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id o126sm13908712pfb.134.2019.06.11.03.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 03:08:24 -0700 (PDT)
Date:   Tue, 11 Jun 2019 03:08:19 -0700
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     ssantosh@kernel.org, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] knav_qmss_queue: fix a missing-check bug in
 knav_pool_create()
Message-ID: <20190611100819.GA10185@ubuntu>
References: <20190530033949.GA8895@zhanggen-UX430UQ>
 <20190611093744.GA9783@ubuntu>
 <56a08bd2-6b94-457f-99f7-91ef3fca8804@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a08bd2-6b94-457f-99f7-91ef3fca8804@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:54:15AM +0100, Marc Zyngier wrote:
> Hi Gen,
> 
> No idea why I'm being cc'd on this but hey... ;-)
I copied email address ftom thid commit:-)
https://github.com/torvalds/linux/commit/832ad0e3da4510fd17f98804abe512ea9a747035#diff-f2a24befc247191f4b81af93e9336785
> 
> On 11/06/2019 10:37, Gen Zhang wrote:
> > On Thu, May 30, 2019 at 11:39:49AM +0800, Gen Zhang wrote:
> >> In knav_pool_create(), 'pool->name' is allocated by kstrndup(). It
> >> returns NULL when fails. So 'pool->name' should be checked. And free
> >> 'pool' when error.
> >>
> >> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> >> ---
> >> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> >> index 8b41837..0f8cb28 100644
> >> --- a/drivers/soc/ti/knav_qmss_queue.c
> >> +++ b/drivers/soc/ti/knav_qmss_queue.c
> >> @@ -814,6 +814,12 @@ void *knav_pool_create(const char *name,
> >>  	}
> >>  
> >>  	pool->name = kstrndup(name, KNAV_NAME_SIZE - 1, GFP_KERNEL);
> >> +	if (!pool->name) {
> >> +		dev_err(kdev->dev, "failed to duplicate for pool(%s)\n",
> >> +			name);
> 
> There is no need to output anything, the kernel will be loud enough if
> you run out of memory.
Thanks for your comments.
> 
> >> +		ret = -ENOMEM;
> >> +		goto err_name;
> >> +	}
> >>  	pool->kdev = kdev;
> >>  	pool->dev = kdev->dev;
> >>  
> >> @@ -864,6 +870,7 @@ void *knav_pool_create(const char *name,
> >>  	mutex_unlock(&knav_dev_lock);
> >>  err:
> >>  	kfree(pool->name);
> >> +err_name:
> 
> kfree(NULL) is perfectly valid, there is no need to create a second
> label. Just branch to the existing error label.
Sure, better not to add redundant codes.
> 
> >>  	devm_kfree(kdev->dev, pool);
> >>  	return ERR_PTR(ret);
> >>  }
> > Can anyone look into this patch?
> > 
> > Thanks
> > Gen
> > 
> 
> The real question is whether this is actually an error at all.
> pool->name doesn't seem to be used for anything but debug information,
> and the printing code can perfectly accommodate a NULL pointer.
That sounds reasonable. This patch just fixes a *theoretical* bug.

Thanks
Gen
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
