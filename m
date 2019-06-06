Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E96C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9A92083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LUIT7ffv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfFFP5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:57:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38925 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfFFP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:57:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so3242683qta.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BclZtUvUWc52VCIk0ekElvDVjs6/3uKQ5inY0X8kkuI=;
        b=LUIT7ffv00SVUohWewknTief0H6RArfZ7fTV9DnvQHDw05QmEs31LxA7dm842AJx2R
         DOosa/xn9kqrepdggtOE/obTNjYEatLl5Lu5GDR9mapllBqtwUBDk0AfQBTvangt6Fwt
         jpN32yUGSZWUXzBDbmIG2HvyQOTHkMZ3YUlxARVqw2GoiwxJsew0qEhZqA54IhN24XWM
         7rptQCdUKPBNRmsKHqYrm4Bt4VincY9ztD0EtoAlFrwOyN78/ZayVZgZnJlGQMv3Iu/c
         InVQJilQARTgohC3huuqiOCaKFCIs0Qg05uMeFu+lDeqP8RC0cVu5roUWXb+HkI8CYiv
         w+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BclZtUvUWc52VCIk0ekElvDVjs6/3uKQ5inY0X8kkuI=;
        b=ZrxPPaUGj7QF1lZk13NnTpJ4dpqUj/joLf6rK16rNx7vDHsGMWNVvfrpvsGMbqKSrS
         8YU9EM/fw/ZcvwoNGfqPPjrLDTyAMG7Utyt9s8X7qAe/9XuPD9IUxeCUejRPaiQcps4w
         hM2L+vpiCiH1AHLGkd6dRhERXLInEhpYhPzJCrWup8IyKMSoeJX1HWoRuhFvbZk0aq0S
         u3BOHMhVd61+mEpIhF5aySVUbZw48XkqqMbReySgvDDf9+giXMQ2AVK0qkqdq9NfFLKt
         x0o3E3pXQ1Hly60lUYfFCZ0ksupiczVJwQZN9lIoN/7dLEx/ZXi98xNywGv4wXfctGkP
         Op/Q==
X-Gm-Message-State: APjAAAXrxo+Y54U2DitSthIqZ0baLqPRT9oAgM80puaBFA4I9e5qWk0x
        bTzecAhSOeZ52kFF9WiUJ9s8uQ==
X-Google-Smtp-Source: APXvYqxJwPKcKYHeIEBqgKbv9g2tly5rhw5pFPANBuNbuQFP+rCjnmF5gwMOQCRJtt8Y8fn+GE8eZA==
X-Received: by 2002:a0c:b159:: with SMTP id r25mr13707464qvc.219.1559836640407;
        Thu, 06 Jun 2019 08:57:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v184sm1061841qkd.85.2019.06.06.08.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 08:57:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYulT-0005QQ-Ix; Thu, 06 Jun 2019 12:57:19 -0300
Date:   Thu, 6 Jun 2019 12:57:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rcampbell@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] mm/hmm: Clean up some coding style and comments
Message-ID: <20190606155719.GA8896@ziepe.ca>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506232942.12623-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:29:39PM -0700, rcampbell@nvidia.com wrote:
> @@ -924,6 +922,7 @@ int hmm_range_register(struct hmm_range *range,
>  		       unsigned page_shift)
>  {
>  	unsigned long mask = ((1UL << page_shift) - 1UL);
> +	struct hmm *hmm;
>  
>  	range->valid = false;
>  	range->hmm = NULL;

I was finishing these patches off and noticed that 'hmm' above is
never initialized.

I added the below to this patch:

diff --git a/mm/hmm.c b/mm/hmm.c
index 678873eb21930a..8e7403f081f44a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -932,19 +932,20 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	range->hmm = hmm_get_or_create(mm);
-	if (!range->hmm)
+	hmm = hmm_get_or_create(mm);
+	if (!hmm)
 		return -EFAULT;
 
 	/* Check if hmm_mm_destroy() was call. */
-	if (range->hmm->mm == NULL || range->hmm->dead) {
-		hmm_put(range->hmm);
+	if (hmm->mm == NULL || hmm->dead) {
+		hmm_put(hmm);
 		return -EFAULT;
 	}
 
 	/* Initialize range to track CPU page table updates. */
-	mutex_lock(&range->hmm->lock);
+	mutex_lock(&hmm->lock);
 
+	range->hmm = hmm;
 	list_add_rcu(&range->list, &hmm->ranges);
 
 	/*

Which I think was the intent of adding the 'struct hmm *'. I prefer
this arrangement as it does not set an leave an invalid hmm pointer in
the range if there is a failure..

Most probably the later patches fixed this up?

Please confirm, thanks

Regards,
Jason
