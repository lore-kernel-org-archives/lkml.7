Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748DDC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ADD2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258396;
	bh=un6pJKybvXWIYWWwHWXHtp+/+ASv2S42exiCBAtA538=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0wQeGmwQRbJeqtVFSv/0wA5lBmn1d3TWBoZ82nuEjCU/ZZNdJDI0Ux8F1guPMqToQ
	 qzC2MgWe+TS5R0LNHbo6odGc5xQQCjNmF78zjAjjSJ1UrLS1yCDo3gZWSFszmLfs0Q
	 jNnF1PiExK8zPlJYdDqHUm+sOEHvpFKbrjB4sAEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbfCVMHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388087AbfCVMHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE0121929;
        Fri, 22 Mar 2019 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256431;
        bh=un6pJKybvXWIYWWwHWXHtp+/+ASv2S42exiCBAtA538=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIU5fbBdy7DqBE/xSFFj+wvHJ8jYDPOcVB950e4DhgOYU0Q+gwn9Kk8fxmcd3CMNh
         qDERE7yM4zY5DQGEzKRf7RycDxC5KFSISPL/HMu1jPo4L84M6Swq4MA4kwemJnyX3p
         pI1Dt+VIDV+0r7qEmon/gi5XZoEcQ6rKbB71ZmRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 4.19 208/280] media: i2c: ov5640: Fix post-reset delay
Date:   Fri, 22 Mar 2019 12:16:01 +0100
Message-Id: <20190322111332.206053257@linuxfoundation.org>
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

From: Loic Poulain <loic.poulain@linaro.org>

commit 1d4c41f3d887bcd66e82cb2fda124533dad8808a upstream.

According to the ov5640 specification (2.7 power up sequence), host can
access the sensor's registers 20ms after reset. Trying to access them
before leads to undefined behavior and result in sporadic initialization
errors.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Adam Ford <aford173@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/ov5640.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1759,7 +1759,7 @@ static void ov5640_reset(struct ov5640_d
 	usleep_range(1000, 2000);
 
 	gpiod_set_value_cansleep(sensor->reset_gpio, 0);
-	usleep_range(5000, 10000);
+	usleep_range(20000, 25000);
 }
 
 static int ov5640_set_power_on(struct ov5640_dev *sensor)


