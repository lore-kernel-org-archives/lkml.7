Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6420C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6C9206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sP5RmOvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfDYOBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:01:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HLbIk0s5M1du/mMNoAlatmEicBx7uPR77M+SYxINoG8=; b=sP5RmOvOcvvGGRHwWpF2YIktL
        C/EjF6AMsJnW5ybyAIwEi6e5hHRlRMNQ3lRplb9qGJJFyvkvnrpB37IXNGKOFn+wy7gkVnH+t59s0
        zGSKR+tUyS3OgSENYuAVXEVlkbWhZkWzjtNA+9+qZau47KxaQhn2KBZcW3fNow1kiDBDPxZY6M2qU
        pf69qRoX/qpjFsl0rqP+wPAqi44slpLsV/1S35rGNPR5QLvWs0bOp5aLKZcFV3jZ9ffrPIuC7ANYy
        2jpctX2v5OD/JJiKf0BvCroFiOXnckGewaWxRsHa24CIVGlzWXSU5cDijR85kMBf82YkjSsSnoX/G
        73VhYBMCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJew4-0003A0-Io; Thu, 25 Apr 2019 14:01:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE91E29C42EE0; Thu, 25 Apr 2019 16:01:10 +0200 (CEST)
Date:   Thu, 25 Apr 2019 16:01:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/28] locking/lockdep: Add description and explanation
 in lockdep design doc
Message-ID: <20190425140110.GS12232@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-3-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424101934.51535-3-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:19:08PM +0800, Yuyang Du wrote:
> +Unlike a lock instance, a lock-class itself never goes away: when a
> +lock-class's instance is used for the first time after bootup the class gets
> +registered, and all (subsequent) instances of that lock-class will be mapped
> +to the lock-class.

That's not entirely accurate anymore. Bart van Assche recently added
lockdep_{,un}register_key().
