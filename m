Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0415C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6582204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498278;
	bh=AHfXVkVCpGPYGXW9k61ljlmPgoAsVdfzI+bzjky1T/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tot0rPNqjYIh8CEKRgrrMF6O+PCyzmBzLIP4zcZU2x1eakz2QVef4Oq5LyigkRXnR
	 MF2+uoqyqAPk43YiAEC4oemCHiKuLYi5HUJPgapvHRgYrJUyXe4KJZfmw7S22LntMw
	 +rGEnov+Ur37PXK9rT4MfPMjztLneo90220GvG+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfKKSvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730263AbfKKSvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:51:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765E52196E;
        Mon, 11 Nov 2019 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498274;
        bh=AHfXVkVCpGPYGXW9k61ljlmPgoAsVdfzI+bzjky1T/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDn5g6cVL8og+SohxyOzz6q/D2zdmLT7wUa+QQobUAKaGYNHsHynUgBb4Rtiguc7C
         m7SU9PAgMEx7nvQaKoAuIVzKNyiM9C9AGCdTaM432VklFqS+q2EUGZgAMF9+f1K/ja
         J+O8JHZih5hH+ajps66fh+iaDcMgj+iYyNvAx89U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.3 066/193] intel_th: gth: Fix the window switching sequence
Date:   Mon, 11 Nov 2019 19:27:28 +0100
Message-Id: <20191111181505.959486019@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 87c0b9c79ec136ea76a14a88d675a746bc6a87f9 upstream.

Commit 8116db57cf16 ("intel_th: Add switch triggering support") added
a trigger assertion of the CTS, but forgot to de-assert it at the end
of the sequence. This results in window switches randomly not happening.

Fix that by de-asserting the trigger at the end of the window switch
sequence.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: 8116db57cf16 ("intel_th: Add switch triggering support")
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191028070651.9770-2-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/gth.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -626,6 +626,9 @@ static void intel_th_gth_switch(struct i
 	if (!count)
 		dev_dbg(&thdev->dev, "timeout waiting for CTS Trigger\n");
 
+	/* De-assert the trigger */
+	iowrite32(0, gth->base + REG_CTS_CTL);
+
 	intel_th_gth_stop(gth, output, false);
 	intel_th_gth_start(gth, output);
 }


