Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA82C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84881205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639230;
	bh=9GmwRl0DwCCUQJu6ri224z0+vAKb2vpX+bVgVpvHWOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J2msFFFidedNZDzjA4/cg8NpFt1IImfi1lOeaonY15VkVGmw0ipuDHdp9IGKQGYoo
	 M0Xxi1Qe3KvC44a7qEUwpOm2GKDhL9XTVmgZYCe9hUk2oM6QoIcAGB992S+sMqYi/G
	 rdhp5egcuGdLTu5y2z2VMHFrX6GkFQZAsi8TioNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbfEWTU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389645AbfEWTU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:20:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD7B21851;
        Thu, 23 May 2019 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639226;
        bh=9GmwRl0DwCCUQJu6ri224z0+vAKb2vpX+bVgVpvHWOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOL9q+MN4UvuBIXiTG0juoDWsG8r59tEMaxZg3MeE/4h/1lyFpqZdLMWiu1bRUTVR
         QGinAJMGzp9OJuXqrQf5nSBmy9GzBPVpb1ilnMsDE2wSKgjpnx5cFr2KqhIPVwXKSQ
         RiV/NoZEFDlyxTeGu0Qam9unpImpxxsx3e9fY5sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.0 026/139] parisc: Allow live-patching of __meminit functions
Date:   Thu, 23 May 2019 21:05:14 +0200
Message-Id: <20190523181724.129167883@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit d19a12906e5e558c0f6b6cfece7b7caf1012ef95 upstream.

When making the text sections writeable with set_kernel_text_rw(1),
include all text sections including those in the __init section.
Otherwise functions marked with __meminit will stay read-only.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org>	# 4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -512,7 +512,7 @@ static void __init map_pages(unsigned lo
 
 void __init set_kernel_text_rw(int enable_read_write)
 {
-	unsigned long start = (unsigned long) _text;
+	unsigned long start = (unsigned long) __init_begin;
 	unsigned long end   = (unsigned long) &data_start;
 
 	map_pages(start, __pa(start), end-start,


