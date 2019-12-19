Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08F2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B5C227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782065;
	bh=gx1f6UecOc57In9eyhc/iqzYZc5hHEWeXlAOfJltopU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sZB5GfOkrFX1DuNshDwBY1gmnlJm6/oTYlVuaeeCZfeAVnylhe9hhg9CntaH5W/KA
	 Y0dCHpKF9FSJXpO7ZWa3tFS+5nN9AAskHnASeNmRydma0a5h7m5QKpWZXZwwXXrSCV
	 B7KJP8WkUxkHNA+4Xehp95YOrtrATqEnMwvr+UDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfLSTBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:01:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbfLSSva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:51:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703832064B;
        Thu, 19 Dec 2019 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781488;
        bh=gx1f6UecOc57In9eyhc/iqzYZc5hHEWeXlAOfJltopU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+h1kYsy5P/fwKd2rNpy3pX+D4tHGL0GGTYLdblp98LowXjFwx9uanM/DePCrC8Xu
         hRJjR1aYKIEUP6kixrCjZRvJCdVo2DNGSYrom/c4qcCnm0O7z7bqhWzu6/3MgEs+pk
         0tdC0LaWCqAR3LbJNfnbwp2rG9FEgFS/FW0UQoGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.14 21/36] rpmsg: glink: Fix use after free in open_ack TIMEOUT case
Date:   Thu, 19 Dec 2019 19:34:38 +0100
Message-Id: <20191219182911.992885069@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182848.708141124@linuxfoundation.org>
References: <20191219182848.708141124@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

commit ac74ea01860170699fb3b6ea80c0476774c8e94f upstream.

Extra channel reference put when remote sending OPEN_ACK after timeout
causes use-after-free while handling next remote CLOSE command.

Remove extra reference put in timeout case to avoid use-after-free.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Cc: stable@vger.kernel.org
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rpmsg/qcom_glink_native.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1104,13 +1104,12 @@ static int qcom_glink_create_remote(stru
 close_link:
 	/*
 	 * Send a close request to "undo" our open-ack. The close-ack will
-	 * release the last reference.
+	 * release qcom_glink_send_open_req() reference and the last reference
+	 * will be relesed after receiving remote_close or transport unregister
+	 * by calling qcom_glink_native_remove().
 	 */
 	qcom_glink_send_close_req(glink, channel);
 
-	/* Release qcom_glink_send_open_req() reference */
-	kref_put(&channel->refcount, qcom_glink_channel_release);
-
 	return ret;
 }
 


