Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F23C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD89D20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921305;
	bh=Gi0mXYSUl7AGjIwZHG2n41VtWx97EL72PQKIdzQj5wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zBIopCPxlX83o/6Prcw2pZ5T6UV0N0IUdvuUbLEbUS4W7iHIsubedOA2JT3OwnEzo
	 czOD6gj3I0vRONP+ehqMTQa/0Jjj68NxGUtQKiBW71GWdq7qeYW5pp/lxYf7FkKqvf
	 6LuDwpvyNLm/cCVNCoMKi+s7KiOf20vCqGdIlWsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfEOLy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbfEOLSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:18:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F2820818;
        Wed, 15 May 2019 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919116;
        bh=Gi0mXYSUl7AGjIwZHG2n41VtWx97EL72PQKIdzQj5wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Amg/CLWs00vML6Rt8wHqcU9DMeiE5ul+td380OoIulxdBhJyXh+BlvYHiDrRrkchG
         IdM9e6M4QckhS9oLnkqry9SgDTmjmRBohT0XPCMqMZ4j3HZEipQt8E4naiO/TT++82
         bGOaUaHErd13Ks8vz4jasc8QcahG7obTx4aAx8X0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 073/115] vt: always call notifier with the console lock held
Date:   Wed, 15 May 2019 12:55:53 +0200
Message-Id: <20190515090704.731040228@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7e1d226345f89ad5d0216a9092c81386c89b4983 ]

Every invocation of notify_write() and notify_update() is performed
under the console lock, except for one case. Let's fix that.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 1fb5e7f409c4a..6ff921cf9a9e4 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2435,8 +2435,8 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	}
 	con_flush(vc, draw_from, draw_to, &draw_x);
 	console_conditional_schedule();
-	console_unlock();
 	notify_update(vc);
+	console_unlock();
 	return n;
 }
 
-- 
2.20.1



