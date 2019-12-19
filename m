Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27DFC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8072E24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780846;
	bh=chLQgsXuHkoQm2h4ueJb1deFdiqcUC5TRor73eu385Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IlsG/VBFmOr4rQpTbGx7g9bnKGeKC+0h2J31d0awfcqxVHxqtcIpjq4WH5HYrsyXq
	 nDzrxFa3OxzMdt7GTfmafB1aO948GbHxrWTh7cnDTUgpKYNUlCCslvMp/g6EM9lSo2
	 QUvUxl1jmpDQ66y9t7cSRmiEpfoPFsoH/PCsyhro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfLSSkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbfLSSkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:40:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900E724679;
        Thu, 19 Dec 2019 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780841;
        bh=chLQgsXuHkoQm2h4ueJb1deFdiqcUC5TRor73eu385Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qb0FUGYpyBu7cuee/009EDQt69lk55KQoFWKopImXYXTQAj0vSkfl+LqzPwXWKrHU
         uwmDKo0+myDv8n6nY8q/azs7SUo4aqhIKAkjnc2ZAxX8JJNcrAQFciLi5HR6erna+5
         jos7HciPKj81I8ww7CjvmjCsuDv7dEb+ePZP0qJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.4 139/162] blk-mq: make sure that line break can be printed
Date:   Thu, 19 Dec 2019 19:34:07 +0100
Message-Id: <20191219183216.228258091@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit d2c9be89f8ebe7ebcc97676ac40f8dec1cf9b43a upstream.

8962842ca5ab ("blk-mq: avoid sysfs buffer overflow with too many CPU cores")
avoids sysfs buffer overflow, and reserves one character for line break.
However, the last snprintf() doesn't get correct 'size' parameter passed
in, so fixed it.

Fixes: 8962842ca5ab ("blk-mq: avoid sysfs buffer overflow with too many CPU cores")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq-sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -248,7 +248,7 @@ static ssize_t blk_mq_hw_sysfs_cpus_show
 		pos += ret;
 	}
 
-	ret = snprintf(pos + page, size - pos, "\n");
+	ret = snprintf(pos + page, size + 1 - pos, "\n");
 	return pos + ret;
 }
 


