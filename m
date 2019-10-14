Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2893C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCD72089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mIza66vK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfJNMhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:37:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56580 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfJNMhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yYAldVN1JRszGUxBq9RZEjwXEyMvOHbWiO36ki8rfvE=; b=mIza66vKvzZBQf7NH/6oCRM8R
        1bHTY3YpWccy8oU6bSFQmji9JLg/BG+qFWRJAcZdr8WG9C+8IvvypPzr+r/0tlNo3xPjVXvVlRJrA
        FXaNmhpDkho8mLdgdHer2ZIMKYLDXfYnwGVc3XBNgeLOZn4d+xpc755YahnbuZSt/BuRkEjpfe7Yr
        EMECvRbqRZ5AdnyiGpAFExoSdUAfhF28Q+6Nfp3JuaAXXMpmfXCk+PVNKkyHGsmFZd1b1SRBc0YaY
        PwVDZXdzfWpF+yYiX1+LCGbqZYBaqGjViul3tkaS4o9OQGGH+f9MCiY9Inha/tHR9OnktDz0lPAmh
        UeaSG/i2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJzbO-00007u-S9; Mon, 14 Oct 2019 12:37:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E152C300F3F;
        Mon, 14 Oct 2019 14:36:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6E1E2829A4D1; Mon, 14 Oct 2019 14:37:28 +0200 (CEST)
Date:   Mon, 14 Oct 2019 14:37:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/6] ipc/mqueue.c: Remove duplicated code
Message-ID: <20191014123728.GE2328@hirez.programming.kicks-ass.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-3-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012054958.3624-3-manfred@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 07:49:54AM +0200, Manfred Spraul wrote:
> +static inline void __pipelined_op(struct wake_q_head *wake_q,
>  				  struct mqueue_inode_info *info,
> +				  struct ext_wait_queue *this)
>  {
> +	list_del(&this->list);
> +	wake_q_add(wake_q, this->task);
>  	/*
>  	 * Rely on the implicit cmpxchg barrier from wake_q_add such
>  	 * that we can ensure that updating receiver->state is the last
> @@ -937,7 +932,19 @@ static inline void pipelined_send(struct wake_q_head *wake_q,
>  	 * yet, at that point we can later have a use-after-free
>  	 * condition and bogus wakeup.
>  	 */
> +        this->state = STATE_READY;

  ^^^^^^^^^^ whitespace damage

> +}
