Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64ECC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E03222CA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="eZ/L2L86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfIZJJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:09:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40756 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfIZJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:09:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id v38so1271483edm.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGYADD5SGijdLvajVeEAR1iT5VRxJ+M854JgFDPO0NA=;
        b=eZ/L2L86xdCcZoJkPzKptumIs+hgt3ENQD+fjXkaMWgPlXmSyJAfAED3tJx9++9c6a
         36knpsijq3JjgWfIU+/VpljMtD65Gr00yJSvPH4wuj7H7qJY4OCG3QR4zkxHEHlWHPgf
         fs66iHlIzcDRVU4aebhtwRdt2OEv9rAR8/VXsl/tpGHjA+c3fZ6CqbkgiWnlyPnOuJ7/
         /vOxU56ilUS77HAb2BopoYGBb+aU1PhnNFMoyIgI6NgdRFdeUA/k+j7b5xqfLOyY/+2o
         Mymf0XMr97Hp7l67bJzi5hVAHjQcdmxR6k7OiZWb0VVLFGYC+ZP/JlUS4I2dGHjfH6Qn
         atfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGYADD5SGijdLvajVeEAR1iT5VRxJ+M854JgFDPO0NA=;
        b=VT2eOOapuSFiP3FXZUvrUJm8ESP4aABOs85uUovTW+Qe/BGJcQbkeQvcj1xrxMjPiv
         tbg0maX7irWaDB0PgKvD+8ua8qDE282ZuuqerstXhDN2VS9NAPbU+jKQTtZfkJRLwPYD
         qoNM5phfxXSULXSunIhfe1rvzAQHpWGB25W5fwJZ/Oy6m2esMt8/nlpdB0BjTC3sA8HJ
         q6AEsFUSesTn9Yca9eQjqg0mTZg6fNgnN1rY8Pd1Dek9ETGOOzfg/TaqrhHj6rdhjd61
         KTvBNbnf0himi2F/gpMfLmTACYHaWrl86xXTBZp6xqgk0oJPRdxt3cTh/i/i7HhhhiNE
         pgVA==
X-Gm-Message-State: APjAAAUZup5CLMCGKyp4O2qM93TZH9olLjBnowZdqhhLkn/d0VyV8lgG
        uvgNcRUJyJUXZaUbs3VC71kCkQ==
X-Google-Smtp-Source: APXvYqw1LWiNc1mxdGLk2fea8Pwu9IrzyiD4JWnlZjGEzkH2VKWYEfpinOeNbFYqrAAN+TNrK2ls3w==
X-Received: by 2002:a50:fa09:: with SMTP id b9mr2360050edq.165.1569488974289;
        Thu, 26 Sep 2019 02:09:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b16sm163968eju.74.2019.09.26.02.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 02:09:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EB10F102322; Thu, 26 Sep 2019 12:09:35 +0300 (+03)
Date:   Thu, 26 Sep 2019 12:09:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/3] mm, page_owner: fix off-by-one error in
 __set_page_owner_handle()
Message-ID: <20190926090935.ofbyb2sjhi33nfp3@box>
References: <20190925143056.25853-1-vbabka@suse.cz>
 <20190925143056.25853-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925143056.25853-2-vbabka@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:30:50PM +0200, Vlastimil Babka wrote:
> As noted by Kirill, commit 7e2f2a0cd17c ("mm, page_owner: record page owner for
> each subpage") has introduced an off-by-one error in __set_page_owner_handle()
> when looking up page_ext for subpages. As a result, the head page page_owner
> info is set twice, while for the last tail page, it's not set at all.
> 
> Fix this and also make the code more efficient by advancing the page_ext
> pointer we already have, instead of calling lookup_page_ext() for each subpage.
> Since the full size of struct page_ext is not known at compile time, we can't
> use a simple page_ext++ statement, so introduce a page_ext_next() inline
> function for that.
> 
> Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
> Fixes: 7e2f2a0cd17c ("mm, page_owner: record page owner for each subpage")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
