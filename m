Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA4BC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 22:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EED20880
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 22:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569708259;
	bh=+LR3RvDm+2ZImZYU0glSfuRvJ341Rv5LciFQr6Cy6wA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qcqhpW3Q6VTLLaczDm8UH0tQd4YUwyArrOCQ2wpTitf00hC54+jQY5yh7zSb+iJ6y
	 DuQcPp+eTlF8ypThk5HY2Z+/uY5CvQ24BCgpTjvtfKdonI5QaLOBGJm/5NBz8ejAHh
	 R7+rZp4oNWaDzzc0k9mytFKWVlFdrBCfaDQUYekM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfI1WEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 18:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbfI1WEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 18:04:12 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC92F20866;
        Sat, 28 Sep 2019 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569708251;
        bh=+LR3RvDm+2ZImZYU0glSfuRvJ341Rv5LciFQr6Cy6wA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Scf4bwAi5HaX4X8cVyqnzFCGblAgIqSzzPiGp8HzS33jbEOYbplOkEUjSBucQxE0m
         e2AiKx++r8+hyzaKXCbkw8k0wMyrCtVs4R+ZPbWEKmA7tJF+d4hty+Hy7Bl5PM47RA
         WIfNUHmdF3xcenKQzW66jKe2p5qc+yrXyECXfxbk=
Date:   Sat, 28 Sep 2019 15:04:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tglx@linutronix.de, Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm, vmpressure: Fix a signedness bug in
 vmpressure_register_event()
Message-Id: <20190928150410.5964a7935ca1b3cb47a2ae76@linux-foundation.org>
In-Reply-To: <20190928214702.GA30382@bombadil.infradead.org>
References: <20190925110449.GO3264@mwanda>
        <20190928142356.932cff0ad6c17f4a18edc80f@linux-foundation.org>
        <20190928214702.GA30382@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2019 14:47:02 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Sep 28, 2019 at 02:23:56PM -0700, Andrew Morton wrote:
> > How about doing it this way?  Only copy the int to the enum once we
> > know it's within range?
> 
> This will return a positive integer on success instead of 0.  We need:
> 
>  	mutex_unlock(&vmpr->events_lock);
> +	ret = 0;
>  out:
> 
> with that,
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> How about further adding ...
> 
> + * Return: 0 on success, -ENOMEM on memory failure or -EINVAL if @args could
> + * not be parsed.

Cool.

--- a/mm/vmpressure.c~mm-vmpressure-fix-a-signedness-bug-in-vmpressure_register_event-fix-fix
+++ a/mm/vmpressure.c
@@ -355,6 +355,9 @@ void vmpressure_prio(gfp_t gfp, struct m
  * "hierarchy" or "local").
  *
  * To be used as memcg event method.
+ *
+ * Return: 0 on success, -ENOMEM on memory failure or -EINVAL if @args could
+ * not be parsed.
  */
 int vmpressure_register_event(struct mem_cgroup *memcg,
 			      struct eventfd_ctx *eventfd, const char *args)
@@ -402,6 +405,7 @@ int vmpressure_register_event(struct mem
 	mutex_lock(&vmpr->events_lock);
 	list_add(&ev->node, &vmpr->events);
 	mutex_unlock(&vmpr->events_lock);
+	ret = 0;
 out:
 	kfree(spec_orig);
 	return ret;
_

