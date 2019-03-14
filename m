Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380DEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F14C2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MCAfOpI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCNNMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:12:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59858 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfCNNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9f/pgQGctrdMBPyGDyZtlVIJ3A2Peo64BoIKAMPc8Mc=; b=MCAfOpI4cWl9iA7x4b2wLzBaj
        9T/D2zpRgCjRRIMxUKdMW+uV6tOwfEvJJADi4pcGKq4lovTFfRQOc9IkmRYMoN9zBFYE69Me0KV3P
        TzvFjcceztqyDz6mnAB9v/oxjIJqdOjLjHTdw9CX6TMlx+fzOaGbuSQQWc2hFxkB+BmAQD00wWqUT
        x7WYIhdFkZSeLLGJbLt4L2pEcNzwMP8y5u23HnWGvwonG3J81nxKsDmpXaT9pNixYxuI6NGZlHTzj
        Es9uaGV2cVo5j4CoYPNaNPbo9qNthbWVJd4JuWDmdFDdyjS3CjXSWDTHVbyxtpZ+E+uKu21smAnt5
        4qDhfxSrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8u-0005RI-KX; Thu, 14 Mar 2019 13:11:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 401F62028B0E1; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130113.919278615@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [RFC][PATCH 0/8] perf/x86: event scheduling cleanups
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These here patches are the result of chasing a bug in the TSX Force Abort
patches.

The first patch is simple and fixes the issue and should be marked /urgent and
backported.

The rest is the result of having a hard look at how all that event scheduling
stuff worked while trying to figure out wth was going wrong.

Stephane, since you were involved with writing much of that code, can you
please have a good look? I _think_ I got it, but... :-)

