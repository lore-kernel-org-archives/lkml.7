Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCBCC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE78221019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iGH3Codc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbfGRNxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:53:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390537AbfGRNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TwfmR5tTn6/LBXbB/rae7IzpBvJIoc1FPGUkeejKVqI=; b=iGH3CodcpGY8HZv0ZhjZVbixb
        9HvqMaKmt18fIpDaFvcgYYBrQ5uoatKGwljH9sB/iBDcmzRk5xOKeItzsU8OnWHf42LhFzQd8T7wM
        t5ZOc8hgEvZeRd80NJtSyX9MdrCrNUfVbaH0venw9mKOk8rpq+pzKmxKhc951VYZtsWTzeJIOdzyY
        g5skGAY5uMWbJtLZBWnficbgpbQwCcc3ruAE05G43KQjPeOQqn8g5/sc64Tgj0F6KnrQSG6YC5jzi
        KbxFxSQREZVDRB4cy69yOSd7Bdc1maWJ59YkxpPYAUzII700wRgOnFq5kyXrkup4wwOO7OQs84ewY
        QI3Deu0dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho6qa-0006Jb-VC; Thu, 18 Jul 2019 13:53:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BE9C820B979A2; Thu, 18 Jul 2019 15:53:22 +0200 (CEST)
Message-Id: <20190718134954.496297975@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 18 Jul 2019 15:49:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, dbueso@suse.de,
        mingo@redhat.com, jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: [PATCH 0/4] Various rwsem ACQUIRE fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the patches I ended up with after we started with Jan's patch (edited).

