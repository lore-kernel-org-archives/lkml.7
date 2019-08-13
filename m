Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109B1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D376720651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MYr8+wkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfHMJBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:01:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfHMJBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jU0wD6FWfmNldhXoFi7WHQ4/IYKAI+ej/AJ8ebgyYvw=; b=MYr8+wkq3EBRCSOlr62A95iJg
        eQDuhcDoXerjq2jQB8wbwwlt76h7iG7FpizCxySxcwPyNLOWIHp27sy/2vNn5UfSykpOJbJqbCcAc
        TDIYomwYB3HyTZ570Yux04IP/9N+bo0GNZyhrvM+lqhvfLmWBnrkkK/EqppNNZjKFenK8ZUQLukD4
        SmGBnJXJUuJSpX0mfJyLkLRN7kpwQkJTxNh2ZdcSkDKAkpwTZvYE2+wua+8qTQ/l0NqQlLBwbLsYR
        H7iOkP/DQFpkIglkH2D+OZGgRhF2LnKzbbitNHYsiMJmaEibOW/usAPEpcDqBLpUxBpYkVLy1vRmb
        oe6APh/Eg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxSgg-0006Ot-Op; Tue, 13 Aug 2019 09:01:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: remove various unused set_memory_* related functions and exports
Date:   Tue, 13 Aug 2019 11:01:40 +0200
Message-Id: <20190813090146.26377-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

while looking into implementing a DMA memory allocator for PCIe unsnooped
transactions I've started looking at the set_memory_* and related APIs,
and it turns out that many of them are unused.  Fix for that below.
