Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1315AECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D0A218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263516;
	bh=C30LIA4zxBrlR+4FaEQFknN7Iq8Y10iVG/GYZVZn4zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yqZO2MLm3rnM2wNLATgHIy+C9R/lhw9ySUz5nIk4J5B8ee3oBS2XPv+v/Rn8qKIaX
	 Zy+QhWrcmfTfqtdRq9FoLDrKzpi3dPHBkZ1I++S+y4erPSM0wGVJYXQrE61vZdwWD1
	 ZjA4JlzOZgruCtmx8pYTnAd/3rkZF3BctUwkBW3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406907AbfJPWFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438312AbfJPV6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:54 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A1C21925;
        Wed, 16 Oct 2019 21:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263133;
        bh=C30LIA4zxBrlR+4FaEQFknN7Iq8Y10iVG/GYZVZn4zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgndQ1df8RGzCKYtA7MWvxVSk8zLeMKje6XbUzMjfYz1X2hANXM7Gwy7u6xCKCCNM
         QK/dISwHZS00+RlNazDJoNBEyZY/gZbayMPQ91hCyGHnExIQZY7zBXa8JHoXvSdoW2
         5OBdJClKUt8+W3aJWf7WO8z7wCWT6/iJ1JUPkXiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Frey <dpfrey@gmail.com>,
        Andreas Dannenberg <dannenberg@ti.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.3 057/112] iio: light: opt3001: fix mutex unlock race
Date:   Wed, 16 Oct 2019 14:50:49 -0700
Message-Id: <20191016214859.675094894@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Frey <dpfrey@gmail.com>

commit 82f3015635249a8c8c45bac303fd84905066f04f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/light/opt3001.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -686,6 +686,7 @@ static irqreturn_t opt3001_irq(int irq,
 	struct iio_dev *iio = _iio;
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
+	bool wake_result_ready_queue = false;
 
 	if (!opt->ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
@@ -720,13 +721,16 @@ static irqreturn_t opt3001_irq(int irq,
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
 


