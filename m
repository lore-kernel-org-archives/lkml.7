Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8704C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70512070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="LlsVT94n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfCZQAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:00:52 -0400
Received: from a9-34.smtp-out.amazonses.com ([54.240.9.34]:40334 "EHLO
        a9-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbfCZQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553616050;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=s/y64a9Nl0E1aNUlGJcS6EovFAznUXKfgfzvkfl1KBk=;
        b=LlsVT94ndQ0NoNjRQgTIrVbjQxe8YzPsYuPiQpjKIJZtSBFGGpwhN3YnGRKaH4L1
        pvVtFPrksLbz5+CNWyzLImAaHw9X8AF1fkzV9rY3g01W9wiQM0Yqol3Ecy7XczT/96x
        BijQyM6zrcywzsOmTcDE2iCoQwNvJsZlJVDeJH+Y=
Date:   Tue, 26 Mar 2019 16:00:50 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        mhocko@kernel.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kmemleaak: survive in a low-memory situation
In-Reply-To: <20190326154338.20594-1-cai@lca.pw>
Message-ID: <01000169babb99b8-b583bf57-5104-45b7-a4d6-e7677c64ece2-000000@email.amazonses.com>
References: <20190326154338.20594-1-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.26-54.240.9.34
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019, Qian Cai wrote:

> +	if (!object) {
> +		/*
> +		 * The tracked memory was allocated successful, if the kmemleak
> +		 * object failed to allocate for some reasons, it ends up with
> +		 * the whole kmemleak disabled, so let it success at all cost.

"let it succeed at all costs"

> +		 */
> +		gfp = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC :
> +		       gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
> +		object = kmem_cache_alloc(object_cache, gfp);
> +	}
> +
>  	if (!object) {

If the alloc must succeed then this check is no longer necessary.
