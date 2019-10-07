Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F9ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E44921655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AC15jO7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfJGLZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJGLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:Subject:Cc:To:From:Date:
        Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LddlgqOr3dajtcKVvBd1CcysEhG8VsH4/cZRTEpbFas=; b=AC15jO7x1pCQ
        m0SrZfKXUYUYHnSpt+pEOvci/SwMdPe1PYyEiKG7IHIX0bRQPrM4VCXQW50mnUIDHLfy4nAZ6t1Cv
        WYErmNAAuSFhPOIo2oHKGoFdxBJS/vXe13B+ZbSuh8f+ZmAauh6M3zNEJ2+XDH/Ht2uMy+7WrB253
        s+uB7O/WaA0S8WWiyhps795jGHKZjmyQsNcTi7mOo0qa1Otfky6rYthnC06EpKG/1E22eCjPkBhEQ
        JGKPv7752ujMQuu/tyVflJftfx5gqAgkRg73YJfUBN+JEoOsNpw+9lZNAkEtbvpckt5Y5w3Bccgeu
        g/nKYooKP7SfnTQR0lGjXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6w-0003GO-EU; Mon, 07 Oct 2019 11:23:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15EF530705A;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9ABF320244E28; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007082708.01393931.1@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 00/13] Add static_call()
References: <20191007090225.44108711.6@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series, which depends on the previous two, introduces static_call().

static_call(), is the idea of static_branch() applied to indirect function
calls. Remove a data load (indirection) by modifying the text.

These patches are still based on the work Josh did earlier, but incorporated
feedback from the last posting and have a lot of extra patches which resulted
from me trying to actually use static_call().

This still relies on objtool to generate the .static_call_sites section, mostly
because this is a natural place for x86_64 and works for both GCC and LLVM.
Other architectures can pick other means if/when they implement the inline
patching. The out-of-line (aka. trampoline) variant doesn't require this.



