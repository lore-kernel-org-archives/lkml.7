Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB9BC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22CA206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eqkcSKVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfIKPPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:15:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIKPPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9Ts7UUugH0BhHT6ILLki/cYvYfh0gbGfHUwu1u4OVw8=; b=eqkcSKVD5dOJFE9++guNrEOku
        ugiFibAd7qPBNs79ndiqk4OEMfpM6jqG9pkL4/PgcpCNl1VtuKFn9391adW0g8KjDRn/2DrF+1J6U
        Gr9Qok/kye4rT8b59JEpXjUD5TFaVMr1dMKnWFC1eFVqzm5ygXtuFoyp951ixiriwwS5gwhbBLUJi
        U94832VbTPNeOBMMpu72U5QpaeSWUmS1XVcFXhor3uG9GgdzzMslZ209al1WCJl3Y5KcH8iybTCOv
        TzToz2C27tIJC0cWry7yAwavYapdb8V1G9AK2EhVnWeXkTXCF7FjLQo30x4oe8pVDHIWBOhdbjt8s
        XWUFtI3tQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i84KZ-0008Ht-S4; Wed, 11 Sep 2019 15:14:51 +0000
Date:   Wed, 11 Sep 2019 08:14:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
Message-ID: <20190911151451.GH29434@bombadil.infradead.org>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911150537.19527-6-longman@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 04:05:37PM +0100, Waiman Long wrote:
> When allocating a large amount of static hugepages (~500-1500GB) on a
> system with large number of CPUs (4, 8 or even 16 sockets), performance
> degradation (random multi-second delays) was observed when thousands
> of processes are trying to fault in the data into the huge pages. The
> likelihood of the delay increases with the number of sockets and hence
> the CPUs a system has.  This only happens in the initial setup phase
> and will be gone after all the necessary data are faulted in.

Can;t the application just specify MAP_POPULATE?
