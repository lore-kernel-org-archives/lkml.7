Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5FAC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7349215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="frwbTaE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392631AbfFMQjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:39:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfFMHJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MzWuvFZ+lpFRWxyb8Xqi32aPdYJB0lJW3Q3yHOMsMHI=; b=frwbTaE/RTeW2oLPedYgORYSw
        ZeiXllpoUuj9f1okPCW97TOmCGkq42ZsRmf/frpvMTXZJVnUsTuQ3i2CpQAOEzTm3kQr3EhW8jgH4
        UZr6JOD3GpATRzVNfaTY0CbwKibMTIEG1TSesIkEB5ZQ7b6O+Xg18Nq13PEv0cBZeRjJUvq7SObqj
        aZFok3gZFSfCj6QTERa3GZrUb9GA6yRKM6P6yUmHdzu1CWxvr3j1ykjjOlnkVIp191JAt8/u7lnRv
        VTvOi0+kJqunvDJ6HHjN1ITkEOcG6jLU2zBBo6viw96QnY/0RWBRfGn6s7ydui1E8nqhvK3SG4eO9
        V5eBGcAKw==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJr8-000494-05; Thu, 13 Jun 2019 07:09:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: binfmt_flat cleanups and RISC-V support v2
Date:   Thu, 13 Jun 2019 09:08:46 +0200
Message-Id: <20190613070903.17214-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

below is a larger stash of cleanups for the binfmt_misc code,
preparing for the last patch that now trivially adds RISC-V
support, which will be used for the RISC-V nommu series I am
about to post.

Changes since v2:
 - fix the handling of old format flags
 - don't pass arguments on stack for RISC-V
 - small cleanups for flat_v2_reloc_t
