Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C2DC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8715C213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vy80CdrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfFYOwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:52:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfFYOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tbvYi4DRDcYImKB7lxdCEs1VYn+lamcV2Qw7WnQ+Aqk=; b=Vy80CdrD3uYvq0TU6ajF+Epkk
        fO1g86TTddMUVUoN7XPeh2/8gn1IfNmXe2Yya4rpMOUFPUUTWM7XfKUmhhMKFmjNQLDFJh1HqLHpD
        GjnD3w/SdLckXsfCqgvTuboivttqvWIRXVWc7uIFQWQKnp9tuODdPxaTTvnHZiA+wfSgdMWFUb3UQ
        /+ypijw4Msm+3Dci6biMM2Yn7pYPwYQ4jCGXbteMcEquO22UDvnfeYHI7d5yWzIuD2fMrJFHbsyFd
        Oemno7glKRGVUXoXWE8qpE18Vf4dJ8wTZVAgIp/KnsJp/xkRMBin4D4zYIT2DMpJth0jp4ZRC3aFY
        CF/vszhUA==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfmoL-0006gd-K5; Tue, 25 Jun 2019 14:52:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: remove unused powernv code v3
Date:   Tue, 25 Jun 2019 16:52:35 +0200
Message-Id: <20190625145239.2759-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the powerpc powernv port has a fairly large chunk of code that never
had any upstream user.  We generally strive to not keep dead code
around, and this was affirmed at least years Maintainer summit.

Changes since v2:
 - fix incorrect opal stub removals that crept in in a rebase

Changes since v1:
 - reword some commit message
