Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3DFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E916221882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573183329;
	bh=TtcIWVFvH8sO1mq2610KXVS5GHlyLmK8WHMed4U9AGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dZEd1BZ65c7BEqXVfLtC9WuUitVqbcm9QMbbYYz/ejgjmDCvQKY3DcYRKAF6CFc+I
	 U4JZa8P3u6b0OwgYu/WScWKwYICJ0yKEzWYQE9KXykijiu7HSvsMdRqThHQCmlBz4m
	 21EH6AeTVhma+fcBdhvCIKOKOEGq3safxezz8L7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfKHDWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:22:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfKHDWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:22:07 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5786D2084D;
        Fri,  8 Nov 2019 03:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573183325;
        bh=TtcIWVFvH8sO1mq2610KXVS5GHlyLmK8WHMed4U9AGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=goM3px9yVWQf4lLKGGqGOlhfcK257j/88y22lMvV/faxJTGgCRbxIR8rGfQ5CGTIi
         TIA7RiicdBJaz8LkMEIljlJGPwo9VhlEl2Wt45XF5wMI7vFupjlApXz/vFhXW1ujnA
         7tioyhL0YMkILin71mygpOcnIGD90V0T2nbXh7zs=
Date:   Thu, 7 Nov 2019 19:22:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
Message-Id: <20191107192202.8869589f225132480d77a33b@linux-foundation.org>
In-Reply-To: <20191108020456.sulyjskhq3s5zcaa@linux-p48b>
References: <20191107190628.22667-1-longman@redhat.com>
        <20191107195441.GF11823@bombadil.infradead.org>
        <ed46ef09-7766-eb80-a4ad-4c72d8dba188@oracle.com>
        <20191108020456.sulyjskhq3s5zcaa@linux-p48b>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 18:04:56 -0800 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Thu, 07 Nov 2019, Mike Kravetz wrote:
> 
> >Note that huge_pmd_share now increments the page count with the semaphore
> >held just in read mode.  It is OK to do increments in parallel without
> >synchronization.  However, we don't want anyone else changing the count
> >while that check in huge_pmd_unshare is happening.  Hence, the need for
> >taking the semaphore in write mode.
> 
> This would be a nice addition to the changelog methinks.

Done.
