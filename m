Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D687321734
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334306;
	bh=+u1e3/PVkxtbkOTEztkjRaMj7bgwpvCzON0ol0D8zI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPfBMVvuM9htKlpDc/+45iZH6kUKBvVBBJ1cyDEfiZNA823Cfo3ZqZTJbmkT4E2WG
	 bR3Iu987oTWeP7/6AI0sGJjzR3sNiY1ypG9cAWGukEO3CZUjoSHFbz8L0x8GRkd9yR
	 NEX2P0/uBbVW2DRIQLx7RXYXX+VTSrTHa+1p28A8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfCKT6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfCKT6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0692214AE;
        Mon, 11 Mar 2019 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334301;
        bh=+u1e3/PVkxtbkOTEztkjRaMj7bgwpvCzON0ol0D8zI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0fNbGszTs2DgsJcvGIb235+1/63lm7xz31+iGTDtowfqYPnLzkyzQFZstw7BZwjt
         Z2k7WDKPmpObo03onPV/T/4QJgEKwzzBbwpsKM5KKFiwaVJaAVSCJ5nD3tXFJVK1YW
         yKa6dyXECVt6kuFtlRzp1D+iFrmxVJ+UBesfu0rA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 43/44] auxdisplay: ht16k33: fix potential user-after-free on module unload
Date:   Mon, 11 Mar 2019 15:56:59 -0400
Message-Id: <20190311195700.138462-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
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

