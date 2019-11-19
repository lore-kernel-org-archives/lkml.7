Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A6BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C0D2231E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574140902;
	bh=/RL5+Jx60ZVLTmjkwS/KLZJ0viMUy5T3HsSrVHwRTwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UcHHGZ8E9r2ebANb8EK1AIxBAju4n1pAnawyx2QCtBjTKLzCs0zAaCTgoB22/OSY7
	 3hjJ7UxlV/6pi98L4qqAa/lQ3PhTYm051fa3czkgsruf+boW8UaWytcv25+Z1LWGVZ
	 jHRDNAon087xRMJbkAza5hmoZ/Qn/IttZERLsnCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfKSFVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfKSFVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:21:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62BA22318;
        Tue, 19 Nov 2019 05:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140896;
        bh=/RL5+Jx60ZVLTmjkwS/KLZJ0viMUy5T3HsSrVHwRTwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zZsz8NlFWpe1LoA0T2eHep+bOJUp6k/AwgL7Pj1sNtZ6Vtzf+HED0uGvYVmGI6r5x
         Vp9To2hncnBzSiWftC69GYHEA7JXlJHHwyips/rGz/+k2eAi0xCp6ap4Mpzi50S+ZH
         9zmpNZQHFbmNoQ1h5MEzUse0G68/9XYFz7Xsu6NQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.3 23/48] Input: synaptics-rmi4 - do not consume more data than we have (F11, F12)
Date:   Tue, 19 Nov 2019 06:19:43 +0100
Message-Id: <20191119051006.344947808@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Duggan <aduggan@synaptics.com>

commit 5d40d95e7e64756cc30606c2ba169271704d47cb upstream.

Currently, rmi_f11_attention() and rmi_f12_attention() functions update
the attn_data data pointer and size based on the size of the expected
size of the attention data. However, if the actual valid data in the
attn buffer is less then the expected value then the updated data
pointer will point to memory beyond the end of the attn buffer. Using
the calculated valid_bytes instead will prevent this from happening.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191025002527.3189-3-aduggan@synaptics.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/rmi4/rmi_f11.c |    4 ++--
 drivers/input/rmi4/rmi_f12.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1284,8 +1284,8 @@ static irqreturn_t rmi_f11_attention(int
 			valid_bytes = f11->sensor.attn_size;
 		memcpy(f11->sensor.data_pkt, drvdata->attn_data.data,
 			valid_bytes);
-		drvdata->attn_data.data += f11->sensor.attn_size;
-		drvdata->attn_data.size -= f11->sensor.attn_size;
+		drvdata->attn_data.data += valid_bytes;
+		drvdata->attn_data.size -= valid_bytes;
 	} else {
 		error = rmi_read_block(rmi_dev,
 				data_base_addr, f11->sensor.data_pkt,
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -212,8 +212,8 @@ static irqreturn_t rmi_f12_attention(int
 			valid_bytes = sensor->attn_size;
 		memcpy(sensor->data_pkt, drvdata->attn_data.data,
 			valid_bytes);
-		drvdata->attn_data.data += sensor->attn_size;
-		drvdata->attn_data.size -= sensor->attn_size;
+		drvdata->attn_data.data += valid_bytes;
+		drvdata->attn_data.size -= valid_bytes;
 	} else {
 		retval = rmi_read_block(rmi_dev, f12->data_addr,
 					sensor->data_pkt, sensor->pkt_size);


