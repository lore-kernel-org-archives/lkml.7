Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C50AC17449
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEE1222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/Ur/iFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKMK3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:29:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfKMK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RyqyoAhYFrTj8+rZhJNjGKFC5lrfWOjpjDnyEauhCYw=; b=I/Ur/iFdUYGNFsS0rr+gF+gNu
        GOEklHUHCwoMZ6axDHJ5oa3WJo1Ldm32mWrVGG3YerY3bmjhbCbeR3AfoYxeW/E9mdJERKCS7DKvQ
        E5FcsH6lwx1fVNj1jrr9lploDJPQye3mazlabCoZbdqgSS5ztaKjdl7ypiG6gyOTFKOcCPXi+ODZy
        eIBeYDiu9QFvFJy3Xztf5SXf19EEr4OMGs6ZVRsuypvLdGh2Kr1hamfdlOpzR+aXKT1jyYZRnEhUa
        dowzsjtMZ1rqkdORTbm1ea2sSJtlu2gCCN/BiqeUl/81TNvi+39nJy3UvpyrhtDtlFzS+2mLxnBxB
        9zTrk+H1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUptg-00073i-Be; Wed, 13 Nov 2019 10:29:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D90330018B;
        Wed, 13 Nov 2019 11:28:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 934522026185B; Wed, 13 Nov 2019 11:29:08 +0100 (CET)
Message-Id: <20191113102115.116470462@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 11:21:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH 0/5] locking: Percpu-rwsem rewrite
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another version of the percpu-rwsem rewrite..

This one (ab)uses the waitqueue in an entirely different and unique way, but no
longer shares it like it did. It retains the use of rcuwait for the
writer-waiting-for-readers-to-complete condition.

This one should be FIFO fair with writer-stealing.

It seems to pass locktorture torture_type=percpu_rwsem_lock. But as always,
this stuff is tricky, please look carefully.

