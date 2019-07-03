Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F83C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE71B21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XSHjKKmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGCK2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:28:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfGCK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=From:Subject:Cc:To:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dKFe6thn0pBSVjx4RI760bAQ7O+n0nRrBKPxLxFI2mA=; b=XSHjKKmzgPH+0AL1Usw4hiTVz
        2TX3UXrZVbe9XRWfzPFqCmB3UW2blCtotnM41JrQiVnCFJu1gsvj7UMi02MDggJK+7Fu2d23voni2
        Q3giZB10Wo5rrR4pSimG+7E1kM7IvgSTTQrosuvJnzElekQFg87rrHYZ8g5m164NLqf0m4GLbqNQO
        3hnM5k9X3uDD/ZqEWiMITFr5c6xR9a+5xgPN4+OeTyHC2slnqv32V7kveoba4kjvSKrFb63iai5TM
        9asGi/t52k3ZogT9sPQXbnIwIHV4uVy9iShRpZlXCmusq4+ZizBpPFdq5QcJbJeVwLxPocGrOIJcG
        UgRa54ajw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hicV1-0006sL-IK; Wed, 03 Jul 2019 10:28:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BE3432026FC16; Wed,  3 Jul 2019 12:28:25 +0200 (CEST)
Message-Id: <20190703102731.236024951@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:27:31 +0200
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH 0/3] tracing vs CR2
From:   root <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Eiichi-san re-discovered the bug earlier found by He Zhe which we've failed to
fix due to getting distracted by discussing how to untangle entry_64.S.

These 3 patches are basically a completion of the initial approach I suggested
in that earlier thread:

  https://lkml.kernel.org/r/20190320221534.165ab87b@oasis.local.home

Yes, idtentry is a mess, and this doesn't help, but lets fix this now before
someone else trips over it.

This boots on x86_64 and builds on i386 so it must be perfect. No Xen testing
what so ever, because I wouldn't know where to begin.

