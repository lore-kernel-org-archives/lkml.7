Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDBEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB72214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O84mdoRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfKHJbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:31:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfKHJbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mmNnULM/VKjYavmcObobx5Rd93KoR1x/7NkcWKtN1+Q=; b=O84mdoRO2yNi9tsZBrBodcX/E
        5E6ZDTyfmxhjwCMaOtvdi7eVL6nxVo1Vp3n1GDN1wcodPVMDAiGcI3RrRfZZPVALovO7AIeileEyM
        vm4d2KnKmPxLcLntBWldGGcFygj2lSnLIBhCZoz0vd2r7vafR3xcvApdGB+pt9RrYIFE4jSy1be03
        msmvyZo5AoBNNcDNljebfvRPWa/CKJ9nqoJqtZQFMr8S/ePgYqkJAUxRR6ugOQz0dhtaxtnM2G2HA
        eC3I+m5SUMy0YsNdf79D5WITW7wDa6RSuoPRhliCB7A5JpCuzKVcAZFS2uY9AlNSK8fUHHsNloW6A
        sDoPV4Xng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT0cF-00018T-KV; Fri, 08 Nov 2019 09:31:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67F77301A79;
        Fri,  8 Nov 2019 10:30:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 136362022B9E1; Fri,  8 Nov 2019 10:31:36 +0100 (CET)
Date:   Fri, 8 Nov 2019 10:31:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tim <xiejingfeng@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
Message-ID: <20191108093136.GI4114@hirez.programming.kicks-ass.net>
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
> In psi_update_stats, it is possible that period has value like
> 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which

How can this happen? Is that a valid case or should we be avoiding that?

