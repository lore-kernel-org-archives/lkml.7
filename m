Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105CCC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C2924109
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZ+H6638"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfE2Ts7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:48:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfE2Ts6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OLgwDGpkIUZU8BMYV5tPlIqkgGPiffjQ+cEUtOoxAWs=; b=aZ+H6638Jr/eJP0r9vD0KZOpZ
        Q1YIKRNl65MHD/BNONUIH2B8tKseMs0w+wEioKPL0iKwh81FIbuGWIZtRDJ6D9WdJUVI7X9Ht/z++
        0vR/yJRNbp4zW+UDATrpA/AtNqjdTkQWo+qR6sHknI9YyqmF2MyeS84krXwWRxI8h7lS+Ur++4Juu
        eU93kc6SKCDgxQa7TTwyAJahGzjffDvHdSn4/jYBH/GlXXh6lBa1bcTl7cY+t9cI4FB/xzrlD/Su3
        GGXvQyfSr+0xvyFE11rK50ZOUejNc3WniZr2FLkzFQ2QGlOhNia2FlRjwoOH++DuqySvTe35ynqvg
        5RhkqLWeg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW4ZA-0008Gb-LH; Wed, 29 May 2019 19:48:52 +0000
Date:   Wed, 29 May 2019 12:48:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in
 kmalloc_slab()
Message-ID: <20190529194852.GA23461@bombadil.infradead.org>
References: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:37:28PM +0800, Dianzhang Chen wrote:
> The `size` in kmalloc_slab() is indirectly controlled by userspace via syscall: poll(defined in fs/select.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
> The `size` can be controlled from: poll -> do_sys_poll -> kmalloc -> __kmalloc -> kmalloc_slab.
> 
> Fix this by sanitizing `size` before using it to index size_index.

I think it makes more sense to sanitize size in size_index_elem(),
don't you?

 static inline unsigned int size_index_elem(unsigned int bytes)
 {
-	return (bytes - 1) / 8;
+	return array_index_nospec((bytes - 1) / 8, ARRAY_SIZE(size_index));
 }

(untested)
