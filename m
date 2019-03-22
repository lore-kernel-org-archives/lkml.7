Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A61AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1889A21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255324;
	bh=pEzhlSD0hK3tHdBwNLzvGMvq5r35kcrtrJ7rmG4NA5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CIb41OarbJVixMkuXhDCZ34npOHHqQmqlGJF+FQd+reG2YKljGWhIAiBRcib2n00O
	 VLEEt5GPL6cVF7OmkaockdmJQfR4BKOj0uaJC5D3levs6C0gc69PBYEBH1uGFnZB2f
	 Yzjv5oy+zkLwSls+/uO1EudhIOovsIZKxXdmt4hM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfCVLsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbfCVLsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:48:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C67A21916;
        Fri, 22 Mar 2019 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255318;
        bh=pEzhlSD0hK3tHdBwNLzvGMvq5r35kcrtrJ7rmG4NA5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6quZIl9tsM+zDcQzwwitO4nMoektY4XK4s5XeclNuKYQGv6qyPRTbZh30sOMNAxR
         cjyFiC8qDKsdUIN1asVVdldRgmM6ioDK8CwwODCA6ZHpNb0MXH1UNfowm6QcA+sqAd
         QAVRwoRac2DOiZRKnN5dtkZYOLPvWNzA4BBmqA/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <thesven73@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 035/183] auxdisplay: ht16k33: fix potential user-after-free on module unload
Date:   Fri, 22 Mar 2019 12:14:23 +0100
Message-Id: <20190322111244.271735719@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 69ef9bc54715fb1cb7786ada15774e469e822209 ]

On module unload/remove, we need to ensure that work does not run
after we have freed resources. Concretely, cancel_delayed_work()
may return while the callback function is still running.

>From kernel/workqueue.c:

    The work callback function may still be running on return,
    unless it returns true and the work doesn't re-arm itself.
    Explicitly flush or use cancel_delayed_work_sync() to wait on it.

Link: https://lore.kernel.org/lkml/20190204220952.30761-1-TheSven73@googlemail.com/
Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
Acked-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/auxdisplay/ht16k33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index fbfa5b4cc567..a93ded300740 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -517,7 +517,7 @@ static int ht16k33_remove(struct i2c_client *client)
 	struct ht16k33_priv *priv = i2c_get_clientdata(client);
 	struct ht16k33_fbdev *fbdev = &priv->fbdev;
 
-	cancel_delayed_work(&fbdev->work);
+	cancel_delayed_work_sync(&fbdev->work);
 	unregister_framebuffer(fbdev->info);
 	framebuffer_release(fbdev->info);
 	free_page((unsigned long) fbdev->buffer);
-- 
2.19.1



