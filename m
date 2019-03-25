Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECAAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE0720651
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cNY39yx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfCYUuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:50:37 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50832 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfCYUug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:50:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 563B2E20
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 20:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6D4pr5_j_8IQ for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 15:50:35 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 8ED5BE3A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:48:45 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id a184so566792itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6rKOlRcVDNylxTYpEQra270TlKJZLrSc2YTveB5az8=;
        b=cNY39yx9PEMb7BsYwZ1VmB6DX1ZImAHBUF/asvcQ01dX+EMU9+YvM3tBJxKJQCgq0l
         pD8SDSyG12V5it3TDi/gIB8RZgfcoQMoA4aa/CWmP7511reDxj5+eijk80BB7jKZYU8/
         vPmJWlO1xwxKHlZsf4tPOEbeyaq5cG+nXVvsrwqTdUXIXLI9yVIjglfVVrT2L/uECbfR
         vwlgjCMtuyu1IhtKsAyAXByoloftG7vEPvzeNOkER/xgy8WfD0ELoCfCUCwCN3BaJs4V
         kaprwUlvMvDQAp6J4txL+fxyBp2aglL1JRoWS8f2C6xRwpmEukNsyafdN139jxSXhHqc
         L5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G6rKOlRcVDNylxTYpEQra270TlKJZLrSc2YTveB5az8=;
        b=aXFdf4OZMPlJ0ipVBUE0r+E8ZTh03btPYSWY8D8v9dsWuIPio6slHQWRSCfThjAmEo
         HsAJ9t15U+4WWweMsk2El9Ji113C1OD/kLDDzoKy6pDVgo7d+uG+bbBwSu3Z5jDNUEKN
         y08SONyZy9BTDCGOUfu5NTKtQkd0fLpd+zrWl/Os5fFCpq9ssI3U4X+k0MncA83gtHhj
         6MQXfsJjTh80o9NsfcBgSIjjUAqAyVHl4R9ToH8AJQoBhm6ww8G41YGEgwLMXiYplzAY
         pt4KW2aLHcqD5VghudQMUFVRW0xyfL+PgTCrn2PAIPwp1UKKIBMLzeXlRVIXXafPEvQh
         G02g==
X-Gm-Message-State: APjAAAWKLNl0o6leZ/CjcsSe4JlHOsaRZCajEMfN/BGop4izqwh/+OLS
        mZnjNZX93ljMnm1eypRsrYfs3MHqTigDu3KYIg6cDwIzvzaTH0NifWGqNV5kOU4Z9dchR28LuKI
        XLmpFPxgLYlH+0kRlfWMnEmWfR2uq
X-Received: by 2002:a24:4355:: with SMTP id s82mr11906130itb.176.1553546925233;
        Mon, 25 Mar 2019 13:48:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJqlWPVdE/cR7aPNSeOFveRbU7/FH+xX1PlHFaZhoJZlTNemg+w8JKQ5z63Y45Vg+CeXpIBg==
X-Received: by 2002:a24:4355:: with SMTP id s82mr11906114itb.176.1553546925031;
        Mon, 25 Mar 2019 13:48:45 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id k22sm4056921iog.10.2019.03.25.13.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 13:48:44 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: check return value of idr_find
Date:   Mon, 25 Mar 2019 15:48:22 -0500
Message-Id: <20190325204823.5428-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <225abd6e-4551-213d-367b-93d938789188@arm.com>
References: <225abd6e-4551-213d-367b-93d938789188@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for Steven Price's review of this patch. In the current code,
idr_find won't return NULL because the SCMI_PROTOCOL_BASE id must 
exist. However, it might return NULL in the future code if the check
is on another node while processing the children in subsequent calls 
to scmi_mbox_chan_setup().
Therefore, the patch conservatively checks the return value and 
returns -EINVAL when it indeed failed.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8f952f2f1a29..35faa203d549 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -709,6 +709,8 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 
 	if (scmi_mailbox_check(np)) {
 		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
+		if (!cinfo)
+			return -EINVAL;
 		goto idr_alloc;
 	}
 
-- 
2.17.1

