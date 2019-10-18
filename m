Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11AECA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92287205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437438;
	bh=+DOoDVc0VcnWbD40iSGHebhxChdm5C5qW61ySyP17ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x8ihcFdhwWHPS4qC6oZ4a/BBapR7rSrZgF0Z2WS6EojrEdwFKqq2fZiwqlTquvsmd
	 jdaiVGiwEG33oytoJuNVa64AJi7Rh2S5LwlTu7pwHbjchA67dh1rfUM868tPtBVPBS
	 cOEuGyCA5nfi1THe6eFnDAJ50G+b/rINmpPMuMSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405479AbfJRWX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729237AbfJRWFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:05:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9252245B;
        Fri, 18 Oct 2019 22:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436309;
        bh=+DOoDVc0VcnWbD40iSGHebhxChdm5C5qW61ySyP17ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErK5GLxMF+lLVZggHVtdVJuIrTMoComiyHd4uwbXPzws0XRIcKp4Jq+oW13ewKw0q
         kpFv7g6Ofu1RFqK8CeV/XrS0xJdNxqMYnjyGNKS2HnjQqzAkhNyIUia9fiEDV6VTQB
         BSu7blfELmsRcgreZpWbVskk89TwiQ4YLK/6WM4o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Frey <dpfrey@gmail.com>,
        Andreas Dannenberg <dannenberg@ti.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 79/89] iio: light: opt3001: fix mutex unlock race
Date:   Fri, 18 Oct 2019 18:03:14 -0400
Message-Id: <20191018220324.8165-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Frey <dpfrey@gmail.com>

[ Upstream commit 82f3015635249a8c8c45bac303fd84905066f04f ]

When an end-of-conversion interrupt is received after performing a
single-shot reading of the light sensor, the driver was waking up the
result ready queue before checking opt->ok_to_ignore_lock to determine
if it should unlock the mutex. The problem occurred in the case where
the other thread woke up and changed the value of opt->ok_to_ignore_lock
to false prior to the interrupt thread performing its read of the
variable. In this case, the mutex would be unlocked twice.

Signed-off-by: David Frey <dpfrey@gmail.com>
Reviewed-by: Andreas Dannenberg <dannenberg@ti.com>
Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/opt3001.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index e666879007d2c..92004a2563ea8 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -686,6 +686,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct iio_dev *iio = _iio;
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
+	bool wake_result_ready_queue = false;
 
 	if (!opt->ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
@@ -720,13 +721,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 		}
 		opt->result = ret;
 		opt->result_ready = true;
-		wake_up(&opt->result_ready_queue);
+		wake_result_ready_queue = true;
 	}
 
 out:
 	if (!opt->ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
+	if (wake_result_ready_queue)
+		wake_up(&opt->result_ready_queue);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.20.1

