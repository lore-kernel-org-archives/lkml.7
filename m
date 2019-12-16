Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96788C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9E20700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519424;
	bh=Ed1Hq/HQhuS0e/QvE5n80m20YwTftllcPIv26wDuKiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0r2IOwhmcXDs+2adcbJVFj9xGgNIGRS30nw4taIwu3pItFbO2/axUuQY/AmpXrzW
	 lHiR0mYriBUAnF6ZvgbEjQw4BodLmlpp2evljuVS6KiW06bQHA0B0IlCu1/TG1IX80
	 7Ygiyq0iSDJtXFCTHQOV3RhfntkWQOWnfw3oE+7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfLPSDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbfLPSDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:03:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99AF421835;
        Mon, 16 Dec 2019 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519419;
        bh=Ed1Hq/HQhuS0e/QvE5n80m20YwTftllcPIv26wDuKiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUhGpeIw3nisJU1SotmZk9odFNu5eLSM8deehAVdXavVm2Ca9YAtwd0D1LFQ8NmIt
         66EWMSyCucW1Rm3l2wmp3y7IjHf5KgYPhcnrip1a5IXZiw9ioGaiFJ/z5ddkhCvnFn
         2G27OFpSRC+mvDV7EZ1B3N08O0leu6iPI7gQ9+v0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 059/140] blk-mq: avoid sysfs buffer overflow with too many CPU cores
Date:   Mon, 16 Dec 2019 18:48:47 +0100
Message-Id: <20191216174804.176499341@linuxfoundation.org>
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

From: Ming Lei <ming.lei@redhat.com>

commit 8962842ca5abdcf98e22ab3b2b45a103f0408b95 upstream.

It is reported that sysfs buffer overflow can be triggered if the system
has too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of
hctx via /sys/block/$DEV/mq/$N/cpu_list.

Use snprintf to avoid the potential buffer overflow.

This version doesn't change the attribute format, and simply stops
showing CPU numbers if the buffer is going to overflow.

Cc: stable@vger.kernel.org
Fixes: 676141e48af7("blk-mq: don't dump CPU -> hw queue map on driver load")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq-sysfs.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -151,20 +151,25 @@ static ssize_t blk_mq_hw_sysfs_nr_reserv
 
 static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 {
+	const size_t size = PAGE_SIZE - 1;
 	unsigned int i, first = 1;
-	ssize_t ret = 0;
+	int ret = 0, pos = 0;
 
 	for_each_cpu(i, hctx->cpumask) {
 		if (first)
-			ret += sprintf(ret + page, "%u", i);
+			ret = snprintf(pos + page, size - pos, "%u", i);
 		else
-			ret += sprintf(ret + page, ", %u", i);
+			ret = snprintf(pos + page, size - pos, ", %u", i);
+
+		if (ret >= size - pos)
+			break;
 
 		first = 0;
+		pos += ret;
 	}
 
-	ret += sprintf(ret + page, "\n");
-	return ret;
+	ret = snprintf(pos + page, size - pos, "\n");
+	return pos + ret;
 }
 
 static struct attribute *default_ctx_attrs[] = {


