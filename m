Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1911BC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A6E21835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005622;
	bh=m8NzCf4h3abOp3hDf9o8iWYgiZUZgDJEXB9aJ8CE73k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u8ULxkEAvgSZrHjMbKl7oSVmliJiQGXQ+teis8X1GXtIryBrEszCK9bgPiJ0tX63a
	 6zbJBchQMEoSTfr05Y3czp6FBaRj9oWx9eBjIcb9v5NUykGUTOwcYUbXonmd/20QE5
	 dnQAHfXdPHdO/aiTjbmaBjO7ruVmhsT0tzH+zXLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgABWVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:21:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbgABWVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:21:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3676124125;
        Thu,  2 Jan 2020 22:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003689;
        bh=m8NzCf4h3abOp3hDf9o8iWYgiZUZgDJEXB9aJ8CE73k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXDCeyyfP4sunWqxOVSo8UVt1u7vJRmb2vWHwqpyT5Av4KBH2zdfRsoZkzot1Zn3w
         M/XEfyR1PX7p3FOPOPqOjRtNpk3TSVityU1MEFaQ1dwmwv0nzaE9sFuesioP6pA3ZR
         gwZGbMpDJbzhJzZpz9d/8F6wl+D6q7SHinAmo4cU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>,
        Federico Cerutti <federico@ceres-c.it>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/114] HID: rmi: Check that the RMI_STARTED bit is set before unregistering the RMI transport device
Date:   Thu,  2 Jan 2020 23:07:02 +0100
Message-Id: <20200102220034.117368636@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Duggan <aduggan@synaptics.com>

[ Upstream commit 8725aa4fa7ded30211ebd28bb1c9bae806eb3841 ]

In the event that the RMI device is unreachable, the calls to rmi_set_mode() or
rmi_set_page() will fail before registering the RMI transport device. When the
device is removed, rmi_remove() will call rmi_unregister_transport_device()
which will attempt to access the rmi_dev pointer which was not set.
This patch adds a check of the RMI_STARTED bit before calling
rmi_unregister_transport_device().  The RMI_STARTED bit is only set
after rmi_register_transport_device() completes successfully.

The kernel oops was reported in this message:
https://www.spinics.net/lists/linux-input/msg58433.html

[jkosina@suse.cz: reworded changelog as agreed with Andrew]
Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Reported-by: Federico Cerutti <federico@ceres-c.it>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-rmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 9e33165250a3..a5b6b2be9cda 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -737,7 +737,8 @@ static void rmi_remove(struct hid_device *hdev)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
 
-	if (hdata->device_flags & RMI_DEVICE) {
+	if ((hdata->device_flags & RMI_DEVICE)
+	    && test_bit(RMI_STARTED, &hdata->flags)) {
 		clear_bit(RMI_STARTED, &hdata->flags);
 		cancel_work_sync(&hdata->reset_work);
 		rmi_unregister_transport_device(&hdata->xport);
-- 
2.20.1



