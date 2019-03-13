Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DE22054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="XdmkV+NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCMRtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:49:08 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49374 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:49:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 7DD1D83C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 17:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id diXvZTzDLZeD for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 12:49:06 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 5358D2B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:49:06 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id i1so2187157ioq.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2DDCFVqlljGEl7G4XbEtgb6b9B5s0YB5Zgn4m4jIfeE=;
        b=XdmkV+NFWSylZFw6fy2miqHbIMgS6xgztZDMWj0MKgjFzrMqlsdW9aha9ntAHtfJ7Q
         5+JZvXWgZrM0pj1/Dowl9evqEPQdc06fet6x1+zZ6cmkoCN6PaPg/0tp+klaO05OmeYP
         QZE9czA5rKG8G7CxBWFFfNEXMFoK0xI8dwLOTsJKJPjL4L8McfC5b4ZQXrbLAlm2pDXN
         EOOITYTVrHsmo7HjJ1LmGKKNFsCCQ1S5CgOFwYOFfhnFvK8ZMhbt7nCsT9yF6EltY1VQ
         Vok/s94OB+LQ3ja1bgodNK01OyDDPyBVG/6B77og9AYCMtrew9r7GjPTmd4C3MO/Zh8H
         LrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2DDCFVqlljGEl7G4XbEtgb6b9B5s0YB5Zgn4m4jIfeE=;
        b=AoZQa44kloVvyuV7Go2b7LkBarpRk7pWoIIbcPymlBxGOWV1BsOt/baoAu2vxHFFXp
         H0qWExwT4h4iRAeKFIgI7//pDo0kOy9LSuXZh/CO+UM9tXroHmr3lqhV3eShnD2DBdJM
         3Rr6tvv7PzlkBTVPM50/r7PFZ6HadCNZWsFfeUAI4ul9Gor4f9lRefh6iA9TW3a53t0P
         7rwxN6PFfM7YqIx063IKMwToOrKgphA0JbhiQ+mhQ+6y5gSCF3G340jLJSa7+wZVjpSQ
         jtTcLXwtYuQxaci7H+XBS+hCfS0TxDoMapm14luHD2pQkG4yrhvGQSf6nYvG+DLnvE7z
         CyWQ==
X-Gm-Message-State: APjAAAXhHil081f9uNFUl50TRHSRmXkXGw6i7pL6Idl2OMT4O983L1v9
        IPFAO5DXXLdxf5oVL1NevHOSrOoHqGuakER4PlNQaZDxT/YUhw29UMuCMs8KUGtWnYY04c4oRSA
        +JtYT9V0QXb4BIVcA1dk0o4aNpm2U
X-Received: by 2002:a05:660c:985:: with SMTP id z5mr2375489itj.39.1552499345947;
        Wed, 13 Mar 2019 10:49:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz9J1kQUXcq9843GT3PeqU/hdATqWTQhuYjjL2kUGGKRtB3Ueiy0KvEi13eRkS8hXA2vyHd4w==
X-Received: by 2002:a05:660c:985:: with SMTP id z5mr2375470itj.39.1552499345737;
        Wed, 13 Mar 2019 10:49:05 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id q17sm5623690ior.71.2019.03.13.10.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 10:49:05 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: storage: Fix potential NULL pointer derefernce
Date:   Wed, 13 Mar 2019 12:48:58 -0500
Message-Id: <20190313174858.23859-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating memory via kcalloc for pba_to_lba and lba_to_pba can
fail. The fix avoids a potential NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/usb/storage/alauda.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 6b8edf6178df..41d979e70784 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -438,6 +438,11 @@ static int alauda_init_media(struct us_data *us)
 	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
 	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
 
+	if (!MEDIA_INFO(us).pba_to_lba || !MEDIA_INFO(us).lba_to_pba) {
+		pr_warn("%s: Failed to allocate memory\n", __func__);
+		return USB_STOR_TRANSPORT_ERROR;
+	}
+
 	if (alauda_reset_media(us) != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
 
-- 
2.17.1

