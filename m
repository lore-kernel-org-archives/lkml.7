Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8042C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72938206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576503436;
	bh=1StiMPO8LpGHEHAabH7gzxcFrrIg+SMyk8LcOwKzZG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jRLkTayUWrKXXZsqzA6zrzYvztFKeqvpfxbXCOpvHw4v0+jIcUbENadKIqlySWhUh
	 CT8gT3gluTvBdz/yzylinr/focwDH+nLynEUrbXlDzjpPVpykLyxZmcRvr8vjQsjQW
	 ZvC+3W93awmfvNw8O4iZxddRSHjE+/I+uGytUEQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfLPNhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:37:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39933 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfLPNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:37:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so7277149wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqmzVJtM8/ik+wTdyhfYBEe+JzF5iuu01jawnGqmvm4=;
        b=tQYGGoiqAh8eGGmNFqnf1iM6QshP2ZeIsS++hg+YfTC3XN9pUVvhiGp8o7OitRXKNh
         CHAiNfq11s3qHi8kG3J7H/stTLuv6bTa9ojTV3KoDZ7mslUBCUwrAyV77A3fXqFEvhoU
         VjAzE28oqilPOOkeiJpRmorP0AwTPuWkMgb7at7Rb7NAmnEFkmYglHLYVMbYet5Ac8O9
         trAmkiOkMassKcnG/xIFuC8K3NM4SGIKOgONO36Uiwo62u5OAQT/7GMUyahBruVC5bTn
         mCJSZ3r9jCHb4BUvGFCMbLsZ1s3Zn47h1GinzrY8gexPrSrQa7YiKcXIDwpdssRQ2QeK
         XcfQ==
X-Gm-Message-State: APjAAAVjxRgWBAVWIrd1dVPV53ma3UcchgVYacviMrIhFnwAQ+8YL3fs
        /VSxJqktysuP9EJukr+Jnwg=
X-Google-Smtp-Source: APXvYqw8DoZT1xy+8BNikDeso3QARwg/9LWZQz63EgJwiBZs7Ir88Njc3Qb9TIWGZJOeNYbjbrzLyA==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr31839416wro.249.1576503433158;
        Mon, 16 Dec 2019 05:37:13 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x132sm22762701wmg.0.2019.12.16.05.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 05:37:12 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:37:11 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
Message-ID: <20191216133711.GH30281@dhcp22.suse.cz>
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212190427.ouyohviijf5inhur@linux-p48b>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-12-19 11:04:27, Davidlohr Bueso wrote:
> There have been deadlock reports[1, 2] where put_page is called
> from softirq context and this causes trouble with the hugetlb_lock,
> as well as potentially the subpool lock.
> 
> For such an unlikely scenario, lets not add irq dancing overhead
> to the lock+unlock operations, which could incur in expensive
> instruction dependencies, particularly when considering hard-irq
> safety. For example PUSHF+POPF on x86.
> 
> Instead, just use a workqueue and do the free_huge_page() in regular
> task context.

I am afraid that work_struct is too large to be stuffed into the struct
page array (because of the lockdep part).

I think that it would be just safer to make hugetlb_lock irq safe. Are
there any other locks that would require the same?
-- 
Michal Hocko
SUSE Labs
