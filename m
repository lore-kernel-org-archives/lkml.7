Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF18C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E048F24680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012128;
	bh=V1NUZndACQbO4v7EBwinVF/JrUe//xaw0pdq45yfOd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kUkY6TqAHfPzcy7cIOcWb/L0z5OPXf0IZDFCnlmyqGNmBIRZda3gPucB3dPT75Bea
	 iEudKAnIbTF/6lABq2UYcaI5CucOoi6Txu2bZbAh1uWIfV7ms0fImnVBA1tHGSP/Jd
	 n/EviBpFEf6r6ZQbhPJU3luMTiKDN0guY+x84q9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfLJVIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfLJVIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:08:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B117524696;
        Tue, 10 Dec 2019 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012115;
        bh=V1NUZndACQbO4v7EBwinVF/JrUe//xaw0pdq45yfOd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiaUQHazJqhTCYKMQmz9rY7YMdIoFPECW+KZMHeUQ/pZ/NnlGoBssDpE5pxY+ilTD
         UC7HwDMZ1GR0nuvdMBnwvEV+5LoZDUxOp8qCk7xeCe6/MpbO0AyKyUNn3kjmtuQMdy
         Q8c3gIeXgy2vPJ38bx2d/qWAhqtnCHgN8cdXz+cI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 087/350] misc: fastrpc: fix memory leak from miscdev->name
Date:   Tue, 10 Dec 2019 16:03:12 -0500
Message-Id: <20191210210735.9077-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 2d10d2d170723e9278282458a6704552dcb77eac ]

Fix a memory leak in miscdev->name by using devm_variant

Orignally reported by kmemleak:
    [<ffffff80088b74d8>] kmemleak_alloc+0x50/0x84
    [<ffffff80081e015c>] __kmalloc_track_caller+0xe8/0x168
    [<ffffff8008371ab0>] kvasprintf+0x78/0x100
    [<ffffff8008371c6c>] kasprintf+0x50/0x74
    [<ffffff8008507f2c>] fastrpc_rpmsg_probe+0xd8/0x20c
    [<ffffff80086b63b4>] rpmsg_dev_probe+0xa8/0x148
    [<ffffff80084de50c>] really_probe+0x208/0x248
    [<ffffff80084de2dc>] driver_probe_device+0x98/0xc0
    [<ffffff80084dec6c>] __device_attach_driver+0x9c/0xac
    [<ffffff80084dca8c>] bus_for_each_drv+0x60/0x8c
    [<ffffff80084de64c>] __device_attach+0x8c/0x100
    [<ffffff80084de6e0>] device_initial_probe+0x20/0x28
    [<ffffff80084dcbd0>] bus_probe_device+0x34/0x7c
    [<ffffff80084da32c>] device_add+0x420/0x498
    [<ffffff80084da680>] device_register+0x24/0x2c

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20191009144123.24583-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1b1a794d639d0..842f2210dc7e2 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1430,8 +1430,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return -ENOMEM;
 
 	data->miscdev.minor = MISC_DYNAMIC_MINOR;
-	data->miscdev.name = kasprintf(GFP_KERNEL, "fastrpc-%s",
-				domains[domain_id]);
+	data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s",
+					    domains[domain_id]);
 	data->miscdev.fops = &fastrpc_fops;
 	err = misc_register(&data->miscdev);
 	if (err)
-- 
2.20.1

