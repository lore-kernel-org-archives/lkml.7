Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF3C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAF022525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004354;
	bh=lpVUCKrMKkCEh6k0qqlmPg17HY6gk5Rz8TVwfI1sY7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hcp4jJYrwEz5+M5sjljTZnA7uhGxS4+GsZk4dwEVBxbJ7Nkep/GdCTSO127DlKVLY
	 zC/t+W5se2KCuOfniGPE8Ak7YrL+QsSwpuwIILcw6ClyizYhEEHk4IxJB4jWul1h7a
	 1YmSAc/Qy2ycQb3DK8+2Hkoe2J4YNdjCLNWvIRnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgABWcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730423AbgABWca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:32:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C347222C3;
        Thu,  2 Jan 2020 22:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004349;
        bh=lpVUCKrMKkCEh6k0qqlmPg17HY6gk5Rz8TVwfI1sY7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMpJEj88Nk15/P3NTCo7sFtookKrbUUfk/wTt92TZQ1OxB5p1uy3QdKvysvRujhrR
         5XiUrtWO0drtn3uB9NjOs4CVB5OATE4XuoF1BbTd6XhQMD7OaXe6caDEXl6hAvv6kQ
         oU5ddZZgH+qxkOp4Es5YLNzLi4AT1nmJfkWYQOLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maurizio Lombardi <mlombard@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 142/171] scsi: scsi_debug: num_tgts must be >= 0
Date:   Thu,  2 Jan 2020 23:07:53 +0100
Message-Id: <20200102220606.879645270@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit aa5334c4f3014940f11bf876e919c956abef4089 ]

Passing the parameter "num_tgts=-1" will start an infinite loop that
exhausts the system memory

Link: https://lore.kernel.org/r/20191115163727.24626-1-mlombard@redhat.com
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 2b0e61557317..d7118d3767c3 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4953,6 +4953,11 @@ static int __init scsi_debug_init(void)
 		return -EINVAL;
 	}
 
+	if (sdebug_num_tgts < 0) {
+		pr_err("num_tgts must be >= 0\n");
+		return -EINVAL;
+	}
+
 	if (sdebug_guard > 1) {
 		pr_err("guard must be 0 or 1\n");
 		return -EINVAL;
-- 
2.20.1



