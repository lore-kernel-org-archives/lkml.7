Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071CDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5817206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121034;
	bh=hjmpnAIp7H1b+RS9Gb7JtQbLwf8dNp2GOvMS39yQNrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bu322rUDqBqeaIAEpoTtpBuLUvEyS5BEzF/QYEDXcyr4N1eaWyF22IE7/03LVNTOW
	 kTtjUI2n6kfPnW/CLM01A0jWtdK1ryem7LEahy/VyYtHrnCXl6b7qROQmm/jTkFvMv
	 RJpdFKdOSnd99CLf8vvCxP35j7aeen8GsfomHfOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404678AbfJCQnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404047AbfJCQnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:43:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EEE32070B;
        Thu,  3 Oct 2019 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121030;
        bh=hjmpnAIp7H1b+RS9Gb7JtQbLwf8dNp2GOvMS39yQNrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSy5DLspyDm/CZxga2fmnnlkxbE5L5Yx3RGZfYY/W8s8QyqJpi6EIlHuzbTnchvli
         vLuKgShG4w08/H/raQ3KxZJnKVK7ugYab+F80Wdh/LaMZd8E/OREmdT6AwvS6deCUj
         6/kYItniw66b+VRkN5SdFIdX8QAFi69SN97teWlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+79d18aac4bf1770dd050@syzkaller.appspotmail.com
Subject: [PATCH 5.3 128/344] media: hdpvr: add terminating 0 at end of string
Date:   Thu,  3 Oct 2019 17:51:33 +0200
Message-Id: <20191003154552.844002633@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 8b8900b729e4f31f12ac1127bde137c775c327e6 ]

dev->usbc_buf was passed as argument for %s, but it was not safeguarded
by a terminating 0.

This caused this syzbot issue:

https://syzkaller.appspot.com/bug?extid=79d18aac4bf1770dd050

Reported-and-tested-by: syzbot+79d18aac4bf1770dd050@syzkaller.appspotmail.com

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/hdpvr/hdpvr-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
index a0905c81d2cb2..b75c18a012a73 100644
--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -137,6 +137,7 @@ static int device_authorization(struct hdpvr_device *dev)
 
 	dev->fw_ver = dev->usbc_buf[1];
 
+	dev->usbc_buf[46] = '\0';
 	v4l2_info(&dev->v4l2_dev, "firmware version 0x%x dated %s\n",
 			  dev->fw_ver, &dev->usbc_buf[2]);
 
-- 
2.20.1



