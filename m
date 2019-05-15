Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201FBC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8A920862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LeCQCmQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEOA3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:29:55 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:38594 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfEOA3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:29:55 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F1AE8C125A;
        Wed, 15 May 2019 00:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557880200; bh=ttubcOyDHXHRg/8lR8MMWbv3JXxGF5+A18qKO7mrXcU=;
        h=From:To:CC:Subject:Date:From;
        b=LeCQCmQOrVbiDkKATUytS/bNqgblVr+C8prM38lmtf3oDKZQWqYv2zFOiSzX1gLJ+
         wrses5UYFDSyTMnewoDTq8j79xAgl7CDOs86ZVkQZXT7Q7Sl/r2x9qTFb6UYViM+LT
         /+rZAkM7V57JJrgFNDbhQYqE/NBP1JgRD5AiSI4xCKIPcAB1AEQ6XxG25bo6q/YfqF
         4ej9nWFl9nIipAsiY9w3S+d9CjVsgDHqBXkdDC/06O8D5U2PYwHMrAL5y9CrZDmQcc
         PJXoH3mwatA1n12KxDtx/azkIAMCG3u91pvdujPIaA7wWAKTzjorGQKYMXmFftbK3i
         GBmSJJ5FvBOMA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 35C1FA005A;
        Wed, 15 May 2019 00:29:52 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 May 2019 17:29:52 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 05:59:49 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:00 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <paltsev@snyopsys.com>, <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/9] ARC do_page_fault rework
Date:   Tue, 14 May 2019 17:29:27 -0700
Message-ID: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.182.230]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was on my todo list and Eugeniy's patch in this area pestered me to
finish it finally.

The ideas it to cleanup/tidyup ancient do_page_fault() code and make
it more readable and hopefully better generated code. There are only
a few/subtle functional changes
 - Eugeniy's fix to prevent user space looping
 - reduction in mmap_sem hold times

Also this could have been 1 single patch but this is tricky part of mm
handling so better done as bite sized pieces to track down any regressions

Eugeniy Paltsev (1):
  ARC: mm: SIGSEGV userspace trying to access kernel virtual memory

Vineet Gupta (8):
  ARC: mm: do_page_fault refactor #1: remove label @good_area
  ARC: mm: do_page_fault refactor #2: remove short lived variable
  ARC: mm: do_page_fault refactor #3: tidyup vma access permission code
  ARC: mm: do_page_fault refactor #4: consolidate retry related logic
  ARC: mm: do_page_fault refactor #5: scoot no_context to end
  ARC: mm: do_page_fault refactor #6: error handlers to use same pattern
  ARC: mm: do_page_fault refactor #7: fold the various error handling
  ARC: mm: do_page_fault refactor #8: release mmap_sem sooner

 arch/arc/mm/fault.c | 192 +++++++++++++++++++++-------------------------------
 1 file changed, 79 insertions(+), 113 deletions(-)

-- 
2.7.4

