Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D83C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AB521841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz+FQpOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDJWYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:24:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44507 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJWYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:24:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id d11so3408883edp.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y7nE7ZG7nELr6t53V66jtZhQYEzl5on9riW0DsXxtsU=;
        b=Vz+FQpOzm6oQvCsP+brtuHCQSOX5/IFmz44R5D6t8JjmNBhQLvZMg12d3Mf6jRuj2d
         XROl8WlRjkeOMYXrAvOEVCutH9U5gq6PmaEMgw9CVvrnBormAApbvWFf9PbXBdZD2Bgk
         gRwozLmSR9dFbDKzk4tLfRA6nXzZ1RPIdFwZKrLyl077JXOWvmbE02yK4z3GiSUDkjNh
         FtSJAfcl/a+EYUu/nwKCLcM7j5QfUkMSaUNeXx3FD22PDYBWTpwG2FVJzfzo0rZy7mMU
         5yfYFUy2QM6S30nBSZNlvW0ukXcXDc8ulnVSsxeCsX7UoKrbjFXO/TznvRZVaaSGwRSp
         +CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y7nE7ZG7nELr6t53V66jtZhQYEzl5on9riW0DsXxtsU=;
        b=cAeEQu8Swa/qndk0po6phqsQWkfIQ+DZLCH16BNGDpepMkSUUsAl02+lLWxsEByWk4
         itRu0+v/S/GAzYbqasdzmIEpMFvD4aHXNIFFpUmXPrSEA3kAVVN6D1ZDHNhzeHGdseAO
         7uPvH0hygYu1MzNY+ySuwOBb3QMOaEdRpHL9kmFHsPoCEXQe6xESgQvl2VPqdOIHY3Yf
         EuD3yiFDH7Rr7tARODvSy4zHk/vOHwlLGMuyO/BHoqU8AIijv/wAa7oIoA5oJQbvG6MK
         pgmNXgTOOi3Rpn8/NmRHmz/dmTCG09l/kDC8qzwxFS07OQ7SRScyEu9QmeQ76JOVY1DA
         3qjw==
X-Gm-Message-State: APjAAAUIR1/FfNJCR+++ex99MUlW3wbjpCLFc0cqYI3c5qFwEo0bsx7y
        QZsfHqak4rAdVRD4cCHoza4=
X-Google-Smtp-Source: APXvYqzSW8A0de7PCwOZbttM9WY5RHdOdZwEuTqH8Wg6cvRd7VloMyIIu7l89/NfwCmJQirAMYsnpw==
X-Received: by 2002:a17:906:7496:: with SMTP id e22mr25675653ejl.45.1554935055071;
        Wed, 10 Apr 2019 15:24:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h11sm4540083eds.44.2019.04.10.15.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 15:24:14 -0700 (PDT)
Date:   Wed, 10 Apr 2019 22:24:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] mm/memory_hotplug: Drop memory device reference after
 find_memory_block()
Message-ID: <20190410222413.4ljc2tchgkbl4lbo@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190410101455.17338-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410101455.17338-1-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:14:55PM +0200, David Hildenbrand wrote:
>While current node handling is probably terribly broken for memory block
>devices that span several nodes (only possible when added during boot,
>and something like that should be blocked completely), properly put the
>device reference we obtained via find_memory_block() to get the nid.
>
>Fixes: d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Cc: Qian Cai <cai@lca.pw>
>Cc: Arun KS <arunks@codeaurora.org>
>Cc: Mathieu Malaterre <malat@debian.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>

You are right.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/memory_hotplug.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 5eb4a4c7c21b..328878b6799d 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -854,6 +854,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
> 	 */
> 	mem = find_memory_block(__pfn_to_section(pfn));
> 	nid = mem->nid;
>+	put_device(&mem->dev);
> 
> 	/* associate pfn range with the zone */
> 	zone = move_pfn_range(online_type, nid, pfn, nr_pages);
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me
