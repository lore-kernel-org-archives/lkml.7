Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C8ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31AD21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263101;
	bh=DunNQsyNa1VNuHxx2OOC8Q0qfEOKg0cfD+bPhM640gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CXsyUNvGlgnOzdRNAF/pJBT+G0zFL+JPvrh1k+jpBDtIK3MCfoNw6k69oep7DaAHI
	 8ZNqenZadDyMZf+AhbHaS7fUYYquEQgYN67YooBA5Vsl5WGdUhJ5NPt80OrQRSS1gr
	 ThsIkM/zMlfZ9iYqcqfEu3f0anZhqrEQQGPtprzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438133AbfJPV6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfJPV5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:24 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BF721928;
        Wed, 16 Oct 2019 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263044;
        bh=DunNQsyNa1VNuHxx2OOC8Q0qfEOKg0cfD+bPhM640gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJe6q+vIebxnHKYjGjQdUaYBcUEa/ZxyG+VewlRbDp35C/Ia5YRaD3PXkSAxzYX82
         Is0uiFXzFNoTFgkQRIOC+Utko6NCKZVZsXd9I3feeRk1HmlMIGWqg/Jqk6nMSpHt8S
         wZgH/kSDI2MSL4tGJ6e8VzoroL6dg0cuFGt8bEKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Frey <dpfrey@gmail.com>,
        Andreas Dannenberg <dannenberg@ti.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 48/81] iio: light: opt3001: fix mutex unlock race
Date:   Wed, 16 Oct 2019 14:50:59 -0700
Message-Id: <20191016214839.933714089@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
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
@@ -694,6 +694,7 @@ static irqreturn_t opt3001_irq(int irq,
 	struct iio_dev *iio = _iio;
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
+	bool wake_result_ready_queue = false;
 
 	if (!opt->ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
@@ -728,13 +729,16 @@ static irqreturn_t opt3001_irq(int irq,
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
 


