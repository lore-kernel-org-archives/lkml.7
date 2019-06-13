Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B20620665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560444934;
	bh=/ewpSppRNwtuoWk8VaEgHJcsNWYUbbPbRZ+qnk2kyu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yvkJjWF7KuYseeGPy3yO+dUmk55NmXSz+y/tw+JW2OMNQ+O4Tps47HbYLUl/kXv8J
	 N2nNVy+uxgl/QuO7n7sukNnLqkCPcJHn6GbXCr5i9t/sxD1Ksy2zHzHrGVfF7JU5cS
	 O+SN06QpLBxE7/JCHnXxhD7u72+scpnshWyEt07w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbfFMQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbfFMCEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:04:25 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5FB208CA;
        Thu, 13 Jun 2019 02:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560391464;
        bh=/ewpSppRNwtuoWk8VaEgHJcsNWYUbbPbRZ+qnk2kyu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I7s+6BUD/VLMgDlpOTxcYbOO91mloye5QM2giwHGWpnPF9a5mIbZSRItaZFiRkGBu
         pfL4yI8SigMJtXXa10yUVoenVbtJnNJtg49iHz/keiHPB9lbGzwHqEeyS8RvWrgt8o
         1eQFFvGW7JDBZfcJ8qYMrZf0jWxzMVgTD7/EihwU=
Date:   Wed, 12 Jun 2019 19:04:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 01/10] mm: postpone kmem_cache memcg pointer
 initialization to memcg_link_cache()
Message-Id: <20190612190423.9971299bba0559e117faae92@linux-foundation.org>
In-Reply-To: <20190611231813.3148843-2-guro@fb.com>
References: <20190611231813.3148843-1-guro@fb.com>
        <20190611231813.3148843-2-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 16:18:04 -0700 Roman Gushchin <guro@fb.com> wrote:

> Subject: [PATCH v7 01/10] mm: postpone kmem_cache memcg pointer initialization to memcg_link_cache()]

I think mm is too large a place for patches to be described as
affecting simply "mm".  So I'll irritatingly rewrite all these titles to
"mm: memcg/slab:".
