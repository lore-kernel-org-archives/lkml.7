Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA42CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714F72087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334355;
	bh=8CHdyxQU/h2P9yRp4JgOkPhqV0VxYvb2U7JZBHbtrjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oYK6VPDRyx4ClpC2QdyiiBOo8MihzQ56Lq5cZwMPVdLu0yHBxCp0WpS5/IDRPHzfH
	 g9ZYTpKD67LvHZluNYjnTQGaIhpeF6ES1OPQ1XJqzPIlC2blqGrBnziDcf7xvo6VWT
	 eWMESbcMyr5NTsRXCaIHDCFPPbENkD+TEnaJwwb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfCKT7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbfCKT7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 413CE2084F;
        Mon, 11 Mar 2019 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334349;
        bh=8CHdyxQU/h2P9yRp4JgOkPhqV0VxYvb2U7JZBHbtrjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejPDV0OaFWZuXFWNVf43FLrmWIVPaSmxkQVOjn98UnfvdxPtZEGPi6EZwUKm0QM/3
         Zq3bPI09KpdeLu5CQyFW/JcOJj4kcDbH5Dmbi0ebgS7u4n3quxUkaugOx5mrHPeo0w
         ru3Shh3DgHv/1bqxlqm0D4nJc3DrnkEvzgBMxHp4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 26/27] auxdisplay: ht16k33: fix potential user-after-free on module unload
Date:   Mon, 11 Mar 2019 15:58:23 -0400
Message-Id: <20190311195824.139043-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195824.139043-1-sashal@kernel.org>
References: <20190311195824.139043-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

[ Upstream commit 69ef9bc54715fb1cb7786ada15774e469e822209 ]

On module unload/remove, we need to ensure that work does not run
after we have freed resources. Concretely, cancel_delayed_work()
may return while the callback function is still running.

From kernel/workqueue.c:

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

