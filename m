Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC8AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537652072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431932;
	bh=0qfrtZ5NmyJsBBCly+ROPI0/m910v0h1Lcw9xY4CtBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q0aXqdQjK16SQ74sxPPB+/Ni++ENpaDqyOzj1OkFu6kx37WFS4Bt5RsF0qCOL2WOY
	 X1Pm54wBcK90cyyfirDJF8wnayA1UdhnyIx1pE7KMaNRpLC4w7453MH7PG1K8OfIgV
	 Hz2obzkaRW2pAOiKkZvfD0tdmJxlWWXxpQ7g2fIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgAGVSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgAGVFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:05:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2F920880;
        Tue,  7 Jan 2020 21:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431099;
        bh=0qfrtZ5NmyJsBBCly+ROPI0/m910v0h1Lcw9xY4CtBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpk5pChCM+3YAYS3NdzWr1hZ7nt0EGNeplw46PYxBkFeDvm8+/wnrO67P7G/6X9kN
         s3C6u1KaesFrSHa5RqexEA2UMD+qT2rovD654uZylNoSShtgsDgaWBY6FfapBjb6SC
         vkNoc9irgq5yLY6HOC25X1/xjN2X4XGtjuL3Gi7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Tsirakis <niko.tsirakis@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/115] xen/balloon: fix ballooned page accounting without hotplug enabled
Date:   Tue,  7 Jan 2020 21:54:03 +0100
Message-Id: <20200107205301.310423800@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit c673ec61ade89bf2f417960f986bc25671762efb ]

When CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not defined
reserve_additional_memory() will set balloon_stats.target_pages to a
wrong value in case there are still some ballooned pages allocated via
alloc_xenballooned_pages().

This will result in balloon_process() no longer be triggered when
ballooned pages are freed in batches.

Reported-by: Nicholas Tsirakis <niko.tsirakis@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 747a15acbce3..6fa7209f24f4 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -395,7 +395,8 @@ static struct notifier_block xen_memory_nb = {
 #else
 static enum bp_state reserve_additional_memory(void)
 {
-	balloon_stats.target_pages = balloon_stats.current_pages;
+	balloon_stats.target_pages = balloon_stats.current_pages +
+				     balloon_stats.target_unpopulated;
 	return BP_ECANCELED;
 }
 #endif /* CONFIG_XEN_BALLOON_MEMORY_HOTPLUG */
-- 
2.20.1



