Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3031ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE92173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F+hfDSLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfJGLXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:23:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfJGLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:Subject:Cc:To:From:Date:
        Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=a9Cv1nGAHOO+s2E/xDw1mfOkJtSraarhm/8/mekMRkk=; b=F+hfDSLbLjTQ
        CenBI2h+b39TQtKVzTbrmAX+DRhqRxUJQxrXZNP5eCoKsM1hPT7T12rpijH3go71H+0cjX+u5BC0v
        u4ASUbgPmuD/xk336544te3kUPwqM6UOtiTSlv0w7Pbc7br8wJ+l+xCqNSG3it1B89DhVZFANEl8j
        BaKk+7dVtstONbbTQYCg9DST4PknhvpH6xWlydxr8Q7Vdctx+xT8z4YSraWWcjAY+xOyEpXR9ewXO
        j+6Z6G+cnrSonnM05UZyGyHApjh9zqaYrw6sci2jJzp0X7Rp1I7LorZYDrNFDAkc5WRN88FCaRU77
        KIzy+snRqXD8zh/8vju3Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6u-0003Fz-O7; Mon, 07 Oct 2019 11:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4E3130655C;
        Mon,  7 Oct 2019 13:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8271020244F8E; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007082541.64146933.7@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:25:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 0/4] Propagate module notifier errors
References: <20191007090225.44108711.6@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches came from the desire to propagate MODULE_STATE_COMING errors.
While looking at that I spotted fail with a number of module notifiers
themselves and with the whole notification business.

I will probably add a notifier for MODULE_STATE_UNFORMED, but that is later.

Fixing this error propagation fixes a fairly serious (but really uncommon) bug
when memory allocation fails for jump-labels while loading a module. And since
we're going to be introducing more of that (static_call), fix it now.

