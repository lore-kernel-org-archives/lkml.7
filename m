Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C635AC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952F72168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C91q5g6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbfIDSkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:40:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfIDSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yERScqNIF39dI0X95RDXlycUNcqsABfDkiiYU0N0y6w=; b=C91q5g6wf8Un02twMhuc1wem4
        lh8cE7eHxYptydS+Kuq23QypIA6dXMbY1OEEpkBg8JXSWwuvbFQajQodSHGbTIBA2O+eLFX0ui/rn
        rgWcKNIcmfFIdqoXFWRoLkVHFiVC10rUfMqDGISiy3nEpDiLUnp5QBVWCUivvZyU9odUyNeSykLMG
        tCpJydUovjDXSf0QeWfCfIinn0YqJ36HnF5x2Ldp/jYB5HPz7RSPZXHGU/ZSJv8TkcDAADsuO0H5I
        xTfAOtk8GUoNzV231PSwWa3BMNqfu77YUCYp9058XMvELRsY/oIBjsmJQqBSDt1GBzWK38c/FKKW8
        qKMuhhwpQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5aCE-0000h3-PQ; Wed, 04 Sep 2019 18:39:58 +0000
Date:   Wed, 4 Sep 2019 11:39:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        zhong jiang <zhongjiang@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Unsigned 'nr_pages' always larger than zero
Message-ID: <20190904183958.GM29434@bombadil.infradead.org>
References: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com>
 <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
 <2807E5FD2F6FDA4886F6618EAC48510E898E9559@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E898E9559@CRSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 06:25:19PM +0000, Weiny, Ira wrote:
> > On 9/4/19 12:26 PM, zhong jiang wrote:
> > > With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages"'
> > > compare with zero. And __get_user_pages_locked will return an long
> > value.
> > > Hence, Convert the long to compare with zero is feasible.
> > 
> > It would be nicer if the parameter nr_pages was long again instead of
> > unsigned long (note there are two variants of the function, so both should be
> > changed).
> 
> Why?  What does it mean for nr_pages to be negative?  The check below seems valid.  Unsigned can be 0 so the check can fail.  IOW Checking unsigned > 0 seems ok.
> 
> What am I missing?

__get_user_pages can return a negative errno.
