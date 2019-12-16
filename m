Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8188FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EC9206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576502823;
	bh=xsyVClhCFJbUgMovG+1PWHD2YeEFXGY1Kj5tAO44IqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1JBc6pdR9muOjwbTCYn98XIGGWVGcih8Dz6NYYq+OdYT8vlUem2Eu02nAPZp/0mdN
	 ckvc7kCFI+6R0BZI0FnxPMymQd66RvrPVsZ8WDjcBWPPRFUVrP7WF2Kcp888qrDTc2
	 IXFiBdnTxBimANYxazEsMibjOOl9WKMAo7hVG6Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfLPN1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:27:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43854 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLPN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:27:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so7237587wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/uIa6qWlTFo90l2lpEZAt0MQFqChyxhRzpPtTSYXp4U=;
        b=W3NoOA+5xMJLhFL2KS2cNhzimAQ5e4fyjJXvMqz5YUDL2WfnObwemUqHbXs9LABV9k
         UzT8ve4yEpfn1jkpX/PiEXqTdFUfgs/G0adtGo5RMl/uwmMpMtJcvRPq6eRBcTa1Hhq1
         EPiaPx0TkcyT9CPURvafwkDNcI24LiHDI9MVJADx9I8A+yzeczaRBUnvqyXboEPXPBMF
         N5lpv703Z7mJYhlqXwejqmo5wDfynx9yKmRr6Fl5zEzovBJM4zaHnTnRJCcTVa7zu3jz
         nxuUGP4UjrVzgoDdxlHzEuW7nj5lSrnzMsdRX4XIYfKqQgNVQBIXK32NO+DD9dQNuwSn
         z0UA==
X-Gm-Message-State: APjAAAVhOamfiQivLbkIOiDoqYwqXoGOUiG4FJneLvhmfRXtNuF3x9eg
        Z+GvDYQIeOrj9ZMQJfpIjlQ=
X-Google-Smtp-Source: APXvYqwnhYWJEhw+ULTW9reda6U0/VuF01asXaxwkhWlolBkdgoO1MteBuEjrxsO3bJo2EZR/Or9Xw==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr29905382wrn.155.1576502819684;
        Mon, 16 Dec 2019 05:26:59 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f1sm21415912wro.85.2019.12.16.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 05:26:58 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:26:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
Message-ID: <20191216132658.GG30281@dhcp22.suse.cz>
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
 <79d3a7e1-384b-b759-cd84-56253fb9ed40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d3a7e1-384b-b759-cd84-56253fb9ed40@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-12-19 15:52:20, Waiman Long wrote:
> On 12/12/19 2:22 PM, Mike Kravetz wrote:
> > On 12/12/19 11:04 AM, Davidlohr Bueso wrote:
> >> There have been deadlock reports[1, 2] where put_page is called
> >> from softirq context and this causes trouble with the hugetlb_lock,
> >> as well as potentially the subpool lock.
> >>
> >> For such an unlikely scenario, lets not add irq dancing overhead
> >> to the lock+unlock operations, which could incur in expensive
> >> instruction dependencies, particularly when considering hard-irq
> >> safety. For example PUSHF+POPF on x86.
> >>
> >> Instead, just use a workqueue and do the free_huge_page() in regular
> >> task context.
> >>
> >> [1] https://lore.kernel.org/lkml/20191211194615.18502-1-longman@redhat.com/
> >> [2] https://lore.kernel.org/lkml/20180905112341.21355-1-aneesh.kumar@linux.ibm.com/
> >>
> >> Reported-by: Waiman Long <longman@redhat.com>
> >> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> > Thank you Davidlohr.
> >
> > The patch does seem fairly simple and straight forward.  I need to brush up
> > on my workqueue knowledge to provide a full review.
> >
> > Longman,
> > Do you have a test to reproduce the issue?  If so, can you try running with
> > this patch.
> 
> Yes, I do have a test that can reproduce the issue. I will run it with
> the patch and report the status tomorrow.

Can you extract guts of the testcase and integrate them into hugetlb
test suite?
-- 
Michal Hocko
SUSE Labs
