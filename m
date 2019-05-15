Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E297DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A0420657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922113;
	bh=0TjL81IqbnAkiwaGUHAMMPYNKAiIgC8Ggtg0x3pthj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fvj5EqPy/Usa+dT/kvkyzuqOJ5hkSS3Y1yuEWz1WVyLX9Tek5jlEcucRJwXtH8lzY
	 gJAz/VgQaH06wG+XCWZW5/JVFOhiPA0bF0YpM+ClSG6nkk8OtDYCoy6YTXdwnkpeUu
	 C28f4o84pfJzjZq8fZ0VYfoUX6dRQY65UF6xvJTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfEOMIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbfEOLId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:08:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC3F2084F;
        Wed, 15 May 2019 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918512;
        bh=0TjL81IqbnAkiwaGUHAMMPYNKAiIgC8Ggtg0x3pthj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXmeDODyAQCfr9Kl+RnRJwzizBcKPVarlRH8OHnY1vkUEKzBvXZp228zcpXHKmDdy
         IlqUdk5mO3O7Y6erAkrSAcHUGeEcy6vwEJ+T1zJPP0O5oi0C0h+pvfY3DwJS20vRQp
         6jd3KqSMt1sPo+t45R7f21P+b63AJwvP8ewt9t7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 158/266] timer/debug: Change /proc/timer_stats from 0644 to 0600
Date:   Wed, 15 May 2019 12:54:25 +0200
Message-Id: <20190515090728.259967946@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
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


