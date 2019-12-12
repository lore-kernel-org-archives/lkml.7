Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C433C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485BA2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfLLTnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:43:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:58520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730284AbfLLTm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:42:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB117AE37;
        Thu, 12 Dec 2019 19:42:57 +0000 (UTC)
Date:   Thu, 12 Dec 2019 11:36:30 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
Message-ID: <20191212193630.su6wvt54cut6addo@linux-p48b>
Mail-Followup-To: Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        aneesh.kumar@linux.ibm.com
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019, Mike Kravetz wrote:

>The patch does seem fairly simple and straight forward.  I need to brush up
>on my workqueue knowledge to provide a full review.

The flush_work() call is actually bogus as we obviously cannot block in
softirq...
