Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DEFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F7220679
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIKBJKnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKUMIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:08:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46566 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:08:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so678315wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJqYvhXBJDffzJ0SjrFtTMgdKaiuOXK87Udh2aE1kIk=;
        b=EIKBJKnJiIYImuHuGrq//OUcOmc2QWisi6PUQPO/OyaDLGtuuQM11gsFNR4tIaWIzQ
         vkr0GFkp5oGVj32D4+DhnCOMVlIGOz+JFtvyLi/a79ZMb/e75QDLrBu+4GraHqwted9I
         tt7BIJ7Sjj0Dv6fDTh5UWk4dlmm272JnXAXtZiGMs+uJygjivWYd3JcSYLNX802ocVA+
         LbLASb3ZkekGzZfVY/toSTaYngajR6MVAPwGQJiuBypVc31mniCL8daeFXpz32nqmMbi
         oKFYnqKtQU16WLzVCWiwiX/HuCYgGVQ/q31l8g+psrT5/oJfpnHY7XwKx1o4CsoTwSr/
         PRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJqYvhXBJDffzJ0SjrFtTMgdKaiuOXK87Udh2aE1kIk=;
        b=KsorRGfJjREsFvN6nEm5FkSpm0yPTfnLmVoHZ22BzF86Bk8yBjJq0G6fUHCEUBF/oU
         PefeBfeiEMHUW5Szk/9dCrodFl2+/EpQvzzB7RTjI5txhG6sx02/5xEfbm2o4v3o31nF
         u7eLkuhZwIaOy/CyhQc1ZKBukHw8Cwhn2YivSntczDuobriV1hlsQ8glkTa9KQYOPTIg
         WnTDHAy3WfTRFxAm+O+USji2RVAoY1wFNrrDgYFulvKiw7gTstqFYTJ0F9JXr3E7VY7e
         6srriR9WqxpyE4nMXRzwtFmKGBC4//nIcd/e1JSrsiioQieqUchL+VTzJo+oR8KDZlp+
         iKMw==
X-Gm-Message-State: APjAAAW8kMbR0IkSr9yxhhji4KCZ3w+Nkc1FFW7zu6LbJjA6OtYump/Z
        bxh2kmmJJaLYHGfuSjs0w50GEDj3
X-Google-Smtp-Source: APXvYqxt7UYus/QYBp7KgEb4MEKvp80qZOawsyaiNOw6CLOIZfZXznUS+4AiMe1KGWmh6JstEnKHaw==
X-Received: by 2002:a5d:6192:: with SMTP id j18mr10526390wru.239.1574338124290;
        Thu, 21 Nov 2019 04:08:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40e1:9900:8828:fc8c:bd94:ae7f])
        by smtp.gmail.com with ESMTPSA id g8sm2738874wmk.23.2019.11.21.04.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 04:08:43 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Subject: [PATCH] misc: xilinx_sdfec: add missing __user annotation
Date:   Thu, 21 Nov 2019 13:08:27 +0100
Message-Id: <20191121120827.4079-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second arg of xsdfec_set_order() is a 'void __user *'
and this pointer is then used in get_user() which expect
a __user pointer.

But get_user() can't be used with a void pointer, it a
pointer to the effective type. This is done here by casting
the argument to a pointer to the effective type but the
__user is missing in the cast.

Fix this by adding the missing __user in the cast.

CC: Derek Kiernan <derek.kiernan@xilinx.com>
CC: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/misc/xilinx_sdfec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 11835969e982..f05e1b4c2826 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -733,7 +733,7 @@ static int xsdfec_set_order(struct xsdfec_dev *xsdfec, void __user *arg)
 	enum xsdfec_order order;
 	int err;
 
-	err = get_user(order, (enum xsdfec_order *)arg);
+	err = get_user(order, (enum xsdfec_order __user *)arg);
 	if (err)
 		return -EFAULT;
 
-- 
2.24.0

