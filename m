Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB30C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E02C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="OnFv8cOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCMTFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:05:03 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:46200 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbfCMTFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1552503902;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=CDYmVMH7PAkHSQKUXC14Z3jOmSyhKpP/gELxNikp4NE=;
        b=OnFv8cOOAKVXVVH0bLgfTrhVe2UIZcprhHhFW2YY1sdh3KtqeMBoeQtcQ89QgZXi
        wuDP2mJSlDWEfGjhQnYOcArIhieEXw+1ymWBxk48McCj0ICnAfak74SADK3a1Jwgj9L
        lV6PQhPtLJxksHhczsozt4o3qKAqBsidqv3byjBA=
Date:   Wed, 13 Mar 2019 19:05:02 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     "Tobin C. Harding" <tobin@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] slob: Use slab_list instead of lru
In-Reply-To: <20190313052030.13392-5-tobin@kernel.org>
Message-ID: <0100016978719138-5260db28-77f5-4abb-8110-2732aa709c5e-000000@email.amazonses.com>
References: <20190313052030.13392-1-tobin@kernel.org> <20190313052030.13392-5-tobin@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.13-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019, Tobin C. Harding wrote:

> @@ -297,7 +297,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
>  			continue;
>
>  		/* Attempt to alloc */
> -		prev = sp->lru.prev;
> +		prev = sp->slab_list.prev;
>  		b = slob_page_alloc(sp, size, align);
>  		if (!b)
>  			continue;

Hmmm... Is there a way to use a macro or so to avoid referencing the field
within the slab_list?
