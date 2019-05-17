Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D90C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB19B20881
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y7J2bDfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfEQLzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:55:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfEQLzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KYKom5mc79z8xfv+mauoa7XhRbMyqaJwUcjxTwdXVjQ=; b=y7J2bDfqdWlgSaaWA60/SMzzx
        WxiNDOPygWSLP5zUqnpbiH6R4876sx2GTgDMt/NYhGE5VBk3RJ6Jxe2qnJzIVNUqcSl22ndtt3W2O
        iMG/DtGY+1YG9buSHhtHazhV3YyPA0reyDqucsppUyoUGp0emj2iJWcZnqWbg/PESPN6757cZPdNG
        d0BmGeiDBBee3V7O4BMWisUJXnzgLiUNFKsA0JStma9MQdA+VwuqQqyiuCjUpmRV2ccTzgLyYAbNR
        jaDiSWRgusmIz1LImOYY/b/H3tPBdEKGnxxXKe5M44BlHzaDOJ8VK9k5vZW09B8JM/sR/6+QCpDIh
        Xs/r8tK3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRbRz-00016x-93; Fri, 17 May 2019 11:54:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AE62820281C10; Fri, 17 May 2019 13:54:56 +0200 (CEST)
Message-Id: <20190517115230.437269790@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 17 May 2019 13:52:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     yabinc@google.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] perf ring-buffer fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically a split of Yabin's last patch.

