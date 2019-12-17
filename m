Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A3DC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CBB2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576573259;
	bh=xAX0PRZHP/FMnReTRbQbZgrSB/CF9jeXgcinFfc+AGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1k5s7OO5w7IfXIYrYjDaEJkBhxRhaQs/k3J5iubCR9t0i2Anhb9fQqVIFKXSUtJ3v
	 lYcd+iMljdbC8e0J5OlKWm0UqgDVmwcXgY/HSdMJseQDoRgS+XABCwZyCDUKdIazUl
	 CODWAb8FLt4a0Ih2Lyc1jEstXSeC9VxHRNK+XfZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfLQJA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:00:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35563 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLQJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:00:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2163534wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 01:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mZx7PX3XtfO3qJUEKG2W3+v5puR8ZcOAgW53SrnG1Rc=;
        b=BZyxkIZHzoTIAZb7PkiiOhGGWtt9Orwc8Jtj2XpELuPFEX5DptGuQ/duSIZ1o1RyA3
         9iexUq/FGwRN82fakhPjdSjoJgzTWOgpsSt4wai03y2Oox7qE29AAJJXNWPqn0vs/CeP
         rO7CD+Ly4lhtwBoGRg0PXRiBsL/Df7Gn7aToLmEohb+1FweqmgipDFh7m0e8i6L+jU+w
         8S8s7fQ7Rn0lU9MeEfmCrD/BNbXVpmxhGA1sTlPhPIjiO7ZjEXd2et8EBCJqSgy3TNqF
         dq5b9mSmhRL4FrhoRIIsu535Ew5N+3esockKGRBzmY64PU5wzcdzQWszYCtGzMuedwkd
         q59w==
X-Gm-Message-State: APjAAAVXx02PamZvYZAGpDmHQ1K7R7qbtQr2bokdM6GHSU/bfeqjokMq
        Nfm1VXXUGWHSaVfT/2PkOs4hN/qo
X-Google-Smtp-Source: APXvYqz1ZPSuW692DjIqgtNqoG0fDxuqI/SuDMEZDBxv1n/Z46mQVepJF+UcqZ/1r3GQHv7ofaTjbQ==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr4044497wml.103.1576573255589;
        Tue, 17 Dec 2019 01:00:55 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id b68sm2311610wme.6.2019.12.17.01.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 01:00:54 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:00:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com, Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
Message-ID: <20191217090054.GA31063@dhcp22.suse.cz>
References: <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
 <79d3a7e1-384b-b759-cd84-56253fb9ed40@redhat.com>
 <20191216132658.GG30281@dhcp22.suse.cz>
 <98ac628d-f8be-270d-80bc-bf2373299caf@redhat.com>
 <21a92649-bb9f-b024-e52b-4ce9355f973b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a92649-bb9f-b024-e52b-4ce9355f973b@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-12-19 13:44:53, Waiman Long wrote:
> On 12/16/19 10:38 AM, Waiman Long wrote:
[...]
> >> Can you extract guts of the testcase and integrate them into hugetlb
> >> test suite?
> 
> BTW, what hugetlb test suite are you talking about?

I was using tests from libhugetlbfs package in the past. There are few
tests in LTP project but the libhugetlbfs coverage used to cover the
largest part of the functionality.

Is there any newer home for the package than [1], Mike? Btw. would it
mak sense to migrate those tests to a more common place, LTP or kernel
selftests?

[1] https://github.com/libhugetlbfs/libhugetlbfs/tree/master/tests
-- 
Michal Hocko
SUSE Labs
