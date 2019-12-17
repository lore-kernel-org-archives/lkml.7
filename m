Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C9B20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6AP41bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLQK2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:28:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLQK2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bIkxC7xrtkS/3g2FFIznGoGAxv7dO4HwGOAXsrRmmTo=; b=k6AP41bhj3bPX4tRMuhIqzwq6
        p5uvfbl7DNoG/EOh5zVltIB4xLSjUq9E4BNeHIR2S+g4PxcdQsdzBSY7IJE+bhtqNMSoE10xxAYzX
        LBBFdBp6ivkxdNqqPX6GGsCLFbNLJ03ZncJ/1Vy9KhjjI2yeu489/6xtP0YzrNtcptjU7DvybXJvd
        5pCPKG8HGwIQbDENHGy/HYHdTbCVNrvFcymMD81naPiQ4d81Mb2jdOsk2G+1ZmUzJpXuCLaGEzxUK
        0lzTjvlyVxACptYHcBIIHVQ3oKpwKY9gQVUuhwLXwAAGfpVYrYTKjYjwxCiAb31e9Qy27i62HIeR5
        oNdsvG9Ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihA5Z-00012m-Ms; Tue, 17 Dec 2019 10:28:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 901293040CB;
        Tue, 17 Dec 2019 11:27:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AEF929E718D0; Tue, 17 Dec 2019 11:28:24 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:28:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20191217102824.GB2844@hirez.programming.kicks-ass.net>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
 <7b412d15-b796-3b8d-0e98-22362377093f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b412d15-b796-3b8d-0e98-22362377093f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 04:52:23PM -0500, Waiman Long wrote:
> On 11/13/19 5:21 AM, Peter Zijlstra wrote:
> > @@ -130,20 +131,12 @@ static inline void percpu_rwsem_release(
> >  					bool read, unsigned long ip)
> >  {
> >  	lock_release(&sem->dep_map, ip);
> > -#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> > -	if (!read)
> > -		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
> > -#endif
> >  }
> >  
> 
> This is the only place that set RWSEM_OWNER_UNKNOWN. So you may as well
> remove all references to it:

Done, thanks!
