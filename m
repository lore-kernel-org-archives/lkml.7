Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B12C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8312070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258742;
	bh=sBJrwuKBclQrBq3lXjS0PqgDZrDahtN5SSz1wa6yTas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K2yaJEwsgQdiRMK0ag4sJG03dzvvI9JxIIJaIxy43H6H/40MXHC5lIlD6/OzZTvNo
	 T4nKS8FV9W6DmS8DnrRHbuJDmuk920J+kB7wUUiRpXcmsk+vqd25TcKySV/ZqQmLc4
	 5HwUlYCLRb16b/a/DChhfQCK/i4d3bP3hD4yr9tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbfCVMpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387725AbfCVMAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77DEF21934;
        Fri, 22 Mar 2019 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256016;
        bh=sBJrwuKBclQrBq3lXjS0PqgDZrDahtN5SSz1wa6yTas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSMtL46UPP22rCorN45aFmsCe5ZzaNK2n/Jf5C/IkJ9O4v2gg7tNmFdNeu5H8nuvV
         LvhveuhZXW2Chuqxe1w07IGls4h7qLadQdF0pugEaN6tjRdVwglID8ykGqjKhl/zU3
         a3gkfVzIc/7hcNPKdI5Qagd/RoD+2v6NhoYk5U4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <thesven73@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/280] auxdisplay: ht16k33: fix potential user-after-free on module unload
Date:   Fri, 22 Mar 2019 12:13:38 +0100
Message-Id: <20190322111309.941014563@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index a43276c76fc6..21393ec3b9a4 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -509,7 +509,7 @@ static int ht16k33_remove(struct i2c_client *client)
 	struct ht16k33_priv *priv = i2c_get_clientdata(client);
 	struct ht16k33_fbdev *fbdev = &priv->fbdev;
 
-	cancel_delayed_work(&fbdev->work);
+	cancel_delayed_work_sync(&fbdev->work);
 	unregister_framebuffer(fbdev->info);
 	framebuffer_release(fbdev->info);
 	free_page((unsigned long) fbdev->buffer);
-- 
2.19.1



