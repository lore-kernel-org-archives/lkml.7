Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9FC2190B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139725;
	bh=7hsL9hZpwvOswIB0Ku9z8+/irDIZJ8hlInCvinZezi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gxcasyCSgkF4naEwzdf/0M898a7X7hlvpid13yeU6m7gN2r+ypoKxawNk0KrhxXdm
	 DeoQKpweTrfa00x/VeSCjULQPG+VrLvKG+om7rTHdHmBSpGwXDJIxNgok5BSD6DQrE
	 j+s+WLw5PRbtLSXrc2r418gw2sIEBCFF3/Wnl9ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbfDAR2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732825AbfDAR2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5081A20880;
        Mon,  1 Apr 2019 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139720;
        bh=7hsL9hZpwvOswIB0Ku9z8+/irDIZJ8hlInCvinZezi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wd5RXoJwA+BwnoL5q/+/CR7LeNfhW0spX2qn+/rvDBArsjBoXirBxZxgzWz0D2tV1
         2ewQAVMq6SPLTMUPJyn4D1mHrnyeQ729NOTr7mGe3x6uTSXfs02MXXGRJnKOo4FPCn
         EwaEzg2qt/F1nzPR8SYw/LagmKzh886zp1cds6x4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.9 34/56] staging: vt6655: Remove vif check from vnt_interrupt
Date:   Mon,  1 Apr 2019 19:02:50 +0200
Message-Id: <20190401170105.804913774@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Priestley <tvboxspy@gmail.com>

commit cc26358f89c3e493b54766b1ca56cfc6b14db78a upstream.

A check for vif is made in vnt_interrupt_work.

There is a small chance of leaving interrupt disabled while vif
is NULL and the work hasn't been scheduled.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
CC: stable@vger.kernel.org # v4.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6655/device_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1084,8 +1084,7 @@ static irqreturn_t vnt_interrupt(int irq
 {
 	struct vnt_private *priv = arg;
 
-	if (priv->vif)
-		schedule_work(&priv->interrupt_work);
+	schedule_work(&priv->interrupt_work);
 
 	return IRQ_HANDLED;
 }


