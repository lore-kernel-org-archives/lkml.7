Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2259FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBD2217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQAnIj3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCTAtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:49:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47030 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfCTAtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:49:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so342320pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=woHC6P4IWHeqMPl0bBWCL/dn49O6TQqdOp+Q3BiQuPY=;
        b=uQAnIj3za4wrrwn7MJzIR0I98MQQmbfVD3GTktU1sIuzy5cmsKWcdvzDQC4X6+rvH8
         w6u3rtLEP3oq281/rdAsfnHNFTiEDCD5Sq/aJeDMIBS8t3a6+grQhuDmmBMk4JHa3+/k
         vq109n8sn+nAr2NyC3hsMZ+mU8VNNF7BEmW4jvJ89MlAHHM46CkcB5DqEGtK12AxOjVO
         4K0U+0pKhoX0dyV4I9HW97CCS2DdyN6mtY+USRwB529UqmXR3VHrgbratA6CuBBPSImx
         GSfAWkTfQlWwzTArpKAOkbTyMSllPqqThJxy7nPNbDUOsu4BQtT9rDdopXMu1e/mjCSK
         mYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=woHC6P4IWHeqMPl0bBWCL/dn49O6TQqdOp+Q3BiQuPY=;
        b=HzPeuiV91HHsfsQYatCykfYB5n8YLq3N4fH7vzOQCLl2BaPridwpDzouYwIlVy6NjH
         ic9fEzotV7ix1dmHBVwzP+dstY6ayM+WH22tHDI72UmZ10mjZaezvcU3+moDFBzC4afk
         0c2qRxvyy48MLHxqbV+6D8ot+YHRSG4ZYh67INd5oSH8Vx4m+EDuZb9qcG4cJZQmKu5x
         G5xJotBBJotlEWNXLGjZtAU+uQL0tJHGwDvdrfpyLjFiy+J/feeaI7Z25HdOrAjSRUhi
         BrXQ9WUvjQpvR1Dx9nfxiewHCW1Cfawyh4+WlfXNYhn+zgTG5V2+XzKd5h2xFRg86A6y
         w/iA==
X-Gm-Message-State: APjAAAVZ7Mrgj1tP6zBdTSYWLR2i0gCRBKz55ievWJaPTRD3vV8HsyUI
        jNtxDDYkWWoALwmaJmS+EYIwBg==
X-Google-Smtp-Source: APXvYqzU9Et7B/EaHRkr6v8Rip9mhd6P1ZraR9Jxn1pAooOpa+WFbT96w8mMoXRsA/HzvaCyFOLoog==
X-Received: by 2002:a17:902:ea8c:: with SMTP id cv12mr5255204plb.123.1553042956167;
        Tue, 19 Mar 2019 17:49:16 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e1sm297905pfn.73.2019.03.19.17.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 17:49:15 -0700 (PDT)
Date:   Tue, 19 Mar 2019 17:49:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     chrubis@suse.cz, vbabka@suse.cz, kirill@shutemov.name,
        osalvador@suse.de, akpm@linux-foundation.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT
 is specified
In-Reply-To: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1903191748090.18028@chino.kir.corp.google.com>
References: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Yang Shi wrote:

> When MPOL_MF_STRICT was specified and an existing page was already
> on a node that does not follow the policy, mbind() should return -EIO.
> But commit 6f4576e3687b ("mempolicy: apply page table walker on
> queue_pages_range()") broke the rule.
> 
> And, commit c8633798497c ("mm: mempolicy: mbind and migrate_pages
> support thp migration") didn't return the correct value for THP mbind()
> too.
> 
> If MPOL_MF_STRICT is set, ignore vma_migratable() to make sure it reaches
> queue_pages_to_pte_range() or queue_pages_pmd() to check if an existing
> page was already on a node that does not follow the policy.  And,
> non-migratable vma may be used, return -EIO too if MPOL_MF_MOVE or
> MPOL_MF_MOVE_ALL was specified.
> 
> Tested with https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c
> 
> Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: stable@vger.kernel.org
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: David Rientjes <rientjes@google.com>

Thanks.  I think this needs stable for 4.0+, can you confirm?
