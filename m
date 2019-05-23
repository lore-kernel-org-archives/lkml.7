Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15E22184B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0KPNMSd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfEWRnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:43:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35551 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfEWRnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:43:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so1438016pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GPbTqA3sKULGXvYjOTM7gfPZ7s4y9WwkUm1EREZ84Ec=;
        b=0KPNMSd1e/ZShlAg1C25np34O9KMTbLFWMGEN4hhgcEhVyzmdg5tjbCMiFs1aybHC6
         Qpem7qqPH7wZ4Y1fpd/on//UTqYR/TJz2wC3p8mAuf4EPSJ+zqxXdvq+cUPYsMcx/dRk
         EJrnBOUKqsEexPUnDc9t4pjTsVMOc/DoL+jt8v9Wyf/nNMNpk+KmMOurhckcCiuYo8aP
         tWxIVyTzlRevLlnAIJgCTLQ7i0JTkhGkeIzFcoQPfXmExNfoNOaGDETbyV6xKsyeqkXF
         EHjzKM3rmL85wy3SZurcNLO0/Vg8m4xth9v1V0hD2M/S/tFuQf+P5py04XOUCNByiOKB
         7fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GPbTqA3sKULGXvYjOTM7gfPZ7s4y9WwkUm1EREZ84Ec=;
        b=Q2fQIt2SPu3S41Ca9ccqemoJY1dZ21H6sGZ868atdhpLU7lWMeaDvweLTqKUVRzZ+V
         C7ztyp7FpjzGX+xytA+Oteroywr60Q3tpHZdZK/mUC+v/Q0B87BwQ0uIg6dNNtXbTsiR
         8UFvd0nBIBrWoR0yTGDvbKSenBOTpxq/aXVpoAtb7p4NNoMOo0BBuXCS14DvZ20VxnSZ
         8t2DDTekuFiPp8Ed7h0ZjCe4iDtRL1AI6w8yX/8gCagJvg1rUB4StCiDBDqYjKetJQ/P
         5CLZXZoBq6uWX4OLEtQQDfEIqaQdt1kMgRAbfqBQipaLaWks6WJjooA09V7XsGP6aUis
         FSPg==
X-Gm-Message-State: APjAAAV6MIIqMH//gKEV1OWzpbOH62t/Yh7iJjHLnUWfOtqsy4P8/UGJ
        aUqcSdKL1z25VBNQm4XX28jFDw==
X-Google-Smtp-Source: APXvYqxxNUBl2ALbzC/oRGpRc2/4PfBhkyFvL2USl2iASHWmjwWhqOT4E5ch4yBkBNmaWJBlon5wXQ==
X-Received: by 2002:a62:4118:: with SMTP id o24mr74875817pfa.17.1558633431910;
        Thu, 23 May 2019 10:43:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:a988])
        by smtp.gmail.com with ESMTPSA id h18sm13255pgv.38.2019.05.23.10.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 10:43:50 -0700 (PDT)
Date:   Thu, 23 May 2019 13:43:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190523174349.GA10939@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed that recent upstream kernels don't account the xarray nodes
of the page cache to the allocating cgroup, like we used to do for the
radix tree nodes.

This results in broken isolation for cgrouped apps, allowing them to
escape their containment and harm other cgroups and the system with an
excessive build-up of nonresident information.

It also breaks thrashing/refault detection because the page cache
lives in a different domain than the xarray nodes, and so the shadow
shrinker can reclaim nonresident information way too early when there
isn't much cache in the root cgroup.

This appears to be the culprit:

commit a28334862993b5c6a8766f6963ee69048403817c
Author: Matthew Wilcox <willy@infradead.org>
Date:   Tue Dec 5 19:04:20 2017 -0500

    page cache: Finish XArray conversion
    
    With no more radix tree API users left, we can drop the GFP flags
    and use xa_init() instead of INIT_RADIX_TREE().
    
    Signed-off-by: Matthew Wilcox <willy@infradead.org>

diff --git a/fs/inode.c b/fs/inode.c
index 42f6d25f32a5..9b808986d440 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -349,7 +349,7 @@ EXPORT_SYMBOL(inc_nlink);
 
 static void __address_space_init_once(struct address_space *mapping)
 {
-       INIT_RADIX_TREE(&mapping->i_pages, GFP_ATOMIC | __GFP_ACCOUNT);
+       xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ);
        init_rwsem(&mapping->i_mmap_rwsem);
        INIT_LIST_HEAD(&mapping->private_list);
        spin_lock_init(&mapping->private_lock);

It fairly blatantly drops __GFP_ACCOUNT.

I'm not quite sure how to fix this, since the xarray code doesn't seem
to have per-tree gfp flags anymore like the radix tree did. We cannot
add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
xarray api doesn't seem to really support gfp flags, either (xas_nomem
does, but the optimistic internal allocations have fixed gfp flags).
