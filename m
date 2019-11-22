Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DDEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284952070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421167;
	bh=S3t5Cafj8u2c9Tf3AxCsWdFvcbncy3FrspDvoheR4uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K6BagVVxL+gXXSoraDNwVaFg6cyazG9Br1p6LXk2SiIk1qfYowTaicuCFbbX0WZ/x
	 jJbOSfJXww8QrkLT7nKseYpRGThO4C+3Xaxty9PzcgW59E0Mrll2hqr3lEVJ/lwIIS
	 mwTRkzqS1a9H6pIOnxlvAXVynIfak/9WshvvPKtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfKVLMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:12:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfKVK52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:57:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80C062071C;
        Fri, 22 Nov 2019 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420248;
        bh=S3t5Cafj8u2c9Tf3AxCsWdFvcbncy3FrspDvoheR4uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIk0FCeNCQCQzxL1CXNmcDFIzs6N7sfmh4soThdpyBURNoNfUlwldxM8AIbWjEuq7
         FoCYKy86ZQOeTZud8qkoh1lcPjNZtz1N3EbhrUgeQ8u4QTqW1zqLdmui4maKO5b6zk
         6CTwLrJBKRHwTLqJvdDamxA9+Uka40uRLw/ug2FE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        John Einar Reitan <john.reitan@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/220] PM / devfreq: stopping the governor before device_unregister()
Date:   Fri, 22 Nov 2019 11:26:48 +0100
Message-Id: <20191122100915.371382417@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

[ Upstream commit 2f061fd0c2d852e32e03a903fccd810663c5c31e ]

device_release() is freeing the resources before calling the device
specific release callback which is, in the case of devfreq, stopping
the governor.

It is a problem as some governors are using the device resources. e.g.
simpleondemand which is using the devfreq deferrable monitoring work. If it
is not stopped before the resources are freed, it might lead to a use after
free.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: John Einar Reitan <john.reitan@arm.com>
[cw00.choi: Fix merge conflict]
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/devfreq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8e21bedc74c38..bcd2279106760 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -578,10 +578,6 @@ static void devfreq_dev_release(struct device *dev)
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
-	if (devfreq->governor)
-		devfreq->governor->event_handler(devfreq,
-						 DEVFREQ_GOV_STOP, NULL);
-
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
@@ -717,7 +713,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 err_init:
 	mutex_unlock(&devfreq_list_lock);
 
-	device_unregister(&devfreq->dev);
+	devfreq_remove_device(devfreq);
 	devfreq = NULL;
 err_dev:
 	if (devfreq)
@@ -738,6 +734,9 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
+	if (devfreq->governor)
+		devfreq->governor->event_handler(devfreq,
+						 DEVFREQ_GOV_STOP, NULL);
 	device_unregister(&devfreq->dev);
 
 	return 0;
-- 
2.20.1



