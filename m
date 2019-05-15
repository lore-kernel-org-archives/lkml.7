Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3457A2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922691;
	bh=0TjL81IqbnAkiwaGUHAMMPYNKAiIgC8Ggtg0x3pthj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PBcE4AumEnPJe2U1VmQpvGoribmOONk0XzyhU79kCZrFrLitg2OwvXGuyDf3zlBF7
	 ir8MdUP+dg56xaayNf+SnNhQsiNSkhou0q5vAlfF4K09gYdcH9w4J2SnVJTvWZQzZf
	 UfMgkuW102Hr0rRnDgUhGrmlOZT1tCEVBJeoZl5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfEOMSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfEOLBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:01:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFEE620881;
        Wed, 15 May 2019 11:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918092;
        bh=0TjL81IqbnAkiwaGUHAMMPYNKAiIgC8Ggtg0x3pthj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0HRCxhtow9y3mttV/hbZW2TGDpn1C64Cz/vlF8gaFLKC/DBcUHl3cwlT9TeimDLsF
         chS7ufSBm4tQJ8y0N9y7euNR0DhCf2o5ClwxQkNqGjFY/QUxbtfOgMlWSSOOPUwbZp
         r5/JHefHIELzZhe2kkRDhj2KlmGarihLmtUlOnDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.18 62/86] timer/debug: Change /proc/timer_stats from 0644 to 0600
Date:   Wed, 15 May 2019 12:55:39 +0200
Message-Id: <20190515090654.500455106@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

The timer_stats facility should filter and translate PIDs if opened
from a non-initial PID namespace, to avoid leaking information about
the wider system.  It should also not show kernel virtual addresses.
Unfortunately it has now been removed upstream (as redundant)
instead of being fixed.

For stable, fix the leak by restricting access to root only.  A
similar change was already made for the /proc/timer_list file.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/timer_stats.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timer_stats.c
+++ b/kernel/time/timer_stats.c
@@ -417,7 +417,7 @@ static int __init init_tstats_procfs(voi
 {
 	struct proc_dir_entry *pe;
 
-	pe = proc_create("timer_stats", 0644, NULL, &tstats_fops);
+	pe = proc_create("timer_stats", 0600, NULL, &tstats_fops);
 	if (!pe)
 		return -ENOMEM;
 	return 0;


