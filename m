Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EC0C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721BF20645
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe9T/z4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfESRv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:51:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35597 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfESRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:51:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so6079732pfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VTpDnGpSlH3sitRA1I0tP2N8TOBZbLCzCKErVuqixPw=;
        b=Xe9T/z4kHbUN5PPMLszy4q/YrdRAwME43PLuBHkM+Hzma52O2VPXyaQME/McxWTsj0
         9ie7U33Py6iF2OV8NvZA/HyHWMJzJILk9HxDchjBQLz84jdolRHHo8wN3dAOf+4SYlZ1
         xUZxObPRj4Y9PGVXXvpdPlC7Hb76rVz1/enOCJXIwg6nAsfMlmjZ0LRLfKXG7OXX8J0o
         yReU8cv2fKINMFk71zwy77aHeGIvmUZlXleKviH26hn8i0zHkK/WXTiUgpEBt/DIPdi2
         7zOrbXcov6cMx8ixJdni1kjKoNxqAU/GaR5yjYUPpVdgZIcNfJeA7KJTYyHigJrS8Tjt
         ELBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VTpDnGpSlH3sitRA1I0tP2N8TOBZbLCzCKErVuqixPw=;
        b=QCt6/Y5qpqfyQgM0DmhzPYcET4zUhGSDZQVm2Vi85UoIdJJoX1lHh4jDPfwsEB1BA2
         zlF4+NvNSSEzwzqaUJjUUWMSvfF+Jhbx80GR6FYoKAMVvZy0KOlZ9LgOTVlzqgU8+Ltq
         YLONiCkR3a4q6Rbq8yD3oZTgismG9RJm116VZAlHZE+VS0Fg+e41kgb5IlotJ6Lj/IA8
         8+BRD1ptnyiq9AQTe3QnMie+TnhezXkGl3J45qlCYF6JhyMCro2uTMbUscL+z+VQhyec
         TTar/NLtfxPMBK2uZhBpc1ElM4Jdx2iS+Ux3r3kKsqMcA1CkELacU20NELS7NAhJGYLN
         8Y3Q==
X-Gm-Message-State: APjAAAXBuasA9BJqBjzN2GEXcyFfE65ZCC+bF7n/JkRBr6MytDDmZQY9
        9W0KzBBTZqn+OiedwdY28rYq+FSV
X-Google-Smtp-Source: APXvYqxn+YXcNTZuduG70hpfaq1BM9K3JvhmJLAfft2z8UBpYUir/hMdb3/9Ug/qeDVHh1+cXhNNpw==
X-Received: by 2002:a63:d354:: with SMTP id u20mr21757566pgi.129.1558278440716;
        Sun, 19 May 2019 08:07:20 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:5085:bb4a:e3a8:fc9d])
        by smtp.gmail.com with ESMTPSA id g17sm2441105pfb.56.2019.05.19.08.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 08:07:20 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v4 2/7] devcoredump: fix typo in comment
Date:   Mon, 20 May 2019 00:06:53 +0900
Message-Id: <1558278418-5702-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
References: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/dev_coredumpmsg/dev_coredumpsg/

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- Add Reviewed-by tag

 drivers/base/devcoredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 3c960a6..e42d0b5 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -314,7 +314,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 EXPORT_SYMBOL_GPL(dev_coredumpm);
 
 /**
- * dev_coredumpmsg - create device coredump that uses scatterlist as data
+ * dev_coredumpsg - create device coredump that uses scatterlist as data
  * parameter
  * @dev: the struct device for the crashed device
  * @table: the dump data
-- 
2.7.4

