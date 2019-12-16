Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1362082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521538;
	bh=L/nnExgTN5kvZ37fES9X+zpcR8LXTKi/LCfLOz8SJg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8xszonYXDtCc4b+q77i+31Ou400fLPGkPKNUIhxs5yWw5Im/MZKh8hG9q7T66fxH
	 28NYlbw7ZzdEbms2Hhl22FLeoEatHZB/6ZNFay5udpsGFjRTa5uqNKVI8tC8xUFUuF
	 2YkkKPuKk1OKv6thZBuCbVl02kjZUg9l6BCjQfWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfLPSEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:04:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbfLPSEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:04:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C7120700;
        Mon, 16 Dec 2019 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519443;
        bh=L/nnExgTN5kvZ37fES9X+zpcR8LXTKi/LCfLOz8SJg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlx0PCB9BbsIo86yviCRjQt3L08daidtKSavM35Kl9Vx4nJrFS5SmteF3pXutUZEG
         jq7XzSxlam/tiXgNhO+6dF0SPN/BzifK2tCDG0avsuSHIQg3hywqJqcQkXXDlliy7i
         Wkp4nXyxl/8IiC4MBbHXaF+bEKwJDY/0EBRSwwHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 068/140] intel_th: Fix a double put_device() in error path
Date:   Mon, 16 Dec 2019 18:48:56 +0100
Message-Id: <20191216174806.256392602@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 512592779a337feb5905d8fcf9498dbf33672d4a upstream.

Commit a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
factored out intel_th_subdevice_alloc() from intel_th_populate(), but got
the error path wrong, resulting in two instances of a double put_device()
on a freshly initialized, but not 'added' device.

Fix this by only doing one put_device() in the error path.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
Reported-by: Wen Yang <wenyang@linux.alibaba.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org # v4.14+
Link: https://lore.kernel.org/r/20191120130806.44028-2-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/core.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -629,10 +629,8 @@ intel_th_subdevice_alloc(struct intel_th
 	}
 
 	err = intel_th_device_add_resources(thdev, res, subdev->nres);
-	if (err) {
-		put_device(&thdev->dev);
+	if (err)
 		goto fail_put_device;
-	}
 
 	if (subdev->type == INTEL_TH_OUTPUT) {
 		thdev->dev.devt = MKDEV(th->major, th->num_thdevs);
@@ -646,10 +644,8 @@ intel_th_subdevice_alloc(struct intel_th
 	}
 
 	err = device_add(&thdev->dev);
-	if (err) {
-		put_device(&thdev->dev);
+	if (err)
 		goto fail_free_res;
-	}
 
 	/* need switch driver to be loaded to enumerate the rest */
 	if (subdev->type == INTEL_TH_SWITCH && !req) {


