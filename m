Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96613C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 21:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6826320863
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 21:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JI+T+tHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfI1VrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 17:47:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfI1VrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 17:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mS/WPmBvHmCvj9LjwYuwySkMwkJdIDR8uWJJT1v85Tw=; b=JI+T+tHy6rTt1mdzgwGOmKKEs
        PymbdU108IKyAkfNxlhutuKqr8cbiDtDtxbJw1VjmNJOTx9ok9ee2CCpnBkgrn57q2yhbAfYOMm/0
        5WL1oo4a1Hn2JbklNoa6V4Y5UyBAtwS26p1vOhP+6IGden8CVhlu0IHAc9A/6woZl707YpUV0LHUz
        sjAVlUQcCsq3T/A+OlQ4fhW9oeYa7xF6jyEZyFchcj4Yqy6y6c5yqfP0lutD/w+1Uglz+0SOEj9rh
        +bZ8eqyFQkKPCGe7x67dRzgZpaApitQ9ci0Orv/g++BY6JytSd1BqEh1pVBrfWqltpiCDkBWLPEKE
        S0XRUDKtw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEKYQ-0001pU-Bp; Sat, 28 Sep 2019 21:47:02 +0000
Date:   Sat, 28 Sep 2019 14:47:02 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tglx@linutronix.de, Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm, vmpressure: Fix a signedness bug in
 vmpressure_register_event()
Message-ID: <20190928214702.GA30382@bombadil.infradead.org>
References: <20190925110449.GO3264@mwanda>
 <20190928142356.932cff0ad6c17f4a18edc80f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928142356.932cff0ad6c17f4a18edc80f@linux-foundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 02:23:56PM -0700, Andrew Morton wrote:
> How about doing it this way?  Only copy the int to the enum once we
> know it's within range?

This will return a positive integer on success instead of 0.  We need:

 	mutex_unlock(&vmpr->events_lock);
+	ret = 0;
 out:

with that,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

How about further adding ...

+ * Return: 0 on success, -ENOMEM on memory failure or -EINVAL if @args could
+ * not be parsed.
