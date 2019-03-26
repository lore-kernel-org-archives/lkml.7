Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFD9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E12206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5felNL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfCZTil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:38:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33510 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:38:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id bg8so2101118plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DgUudxueHTm/QW4KmBGdf24XZ1cf36j15ieGoiJGyt0=;
        b=r5felNL0VK5UkhOOqGyDvuBMNRfNffjUCMk5OBPVirXv+TttCFc0Bo3cDgvrjgBZHN
         isIk+L9FXT0ld8vXynrBHKQHCZ3rstzq5g9f64ipj8DZUbO6xL1kClqFlYnDQKkA5rz/
         9PSwnITePwJQWTu6kcBYCLQeA+u9Mu0brrIVDrbfJ3XUrm4HSyR+GLd5GBDiTYqIvDAA
         A7zMSX7ZqUq9eJtrENhNMGSTRxkv8x3sdLp/j3HBWacyf7DSxob322eF3Kssngf5TylD
         q09BlYNWaVsLVaXOBc3LV/IaWcz1gFeQsD5txjPUK6YKHZcY4AabptVaSiB1DX4/0Br/
         GJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DgUudxueHTm/QW4KmBGdf24XZ1cf36j15ieGoiJGyt0=;
        b=LSVj9WlASycjjD4p3eVaPhUxLJPusQC2cXvw66UIChq51+eHOTJ1E3SoJFoOEGgTJw
         G2mwgvAYMSo3Y7RHt5/o/scVTYio36vuIIB3t0H/vX+rPiAHWXPhLnjIf9A4SNBjiGM/
         7f9Wi134mpc/yOUKjLKbmw/pd13kHRiyO6lTVQiY7zCCNTZFctaIqGVbAfJ6TZell+pl
         Gw80LzvMsifrTovxU+ZbhqkWhcJ+r1uzm69rCXoU46mP8tP6w0GLr8dG5WGU+1UcVRrN
         OC7C8JGLDwKw+oEabxSp8s5dt6XyJBRn+ula6nWyh4rfuxpRNVFezfQj2uieaScLXg5c
         NHWg==
X-Gm-Message-State: APjAAAXJw4rxItT0WHxRlmUOf0ZuwJE/ffDDt1VSiQyA5cY8fRoIxU7N
        9Qv04UbWZjD1DtU4wOjZH0c=
X-Google-Smtp-Source: APXvYqzt77PBPPJmWn87EiNsYSMEuuRRlPahYyl0svfPhm+k0SASts5ivFpqOjDiQbo42ipVHDnqMw==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr33218338plq.293.1553629120756;
        Tue, 26 Mar 2019 12:38:40 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id e1sm25088804pfn.73.2019.03.26.12.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:38:39 -0700 (PDT)
Date:   Wed, 27 Mar 2019 01:08:34 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Edward Cree <ecree@solarflare.com>, gbastien@versatic.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: trace : fix  error directive in argument list
Message-ID: <20190326193834.GA13540@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below spare errors.

Sparse error:
make C=2 CF=-D__CHECK_ENDIAN__ M=net/core

./include/trace/events/net.h:171:1: error: directive in argument list
./include/trace/events/net.h:173:1: error: directive in argument list
./include/trace/events/net.h:175:1: error: directive in argument list
./include/trace/events/net.h:171:1: error: directive in argument list
./include/trace/events/net.h:173:1: error: directive in argument list
./include/trace/events/net.h:175:1: error: directive in argument list

To avoid sparse error changed
to
if (IS_ENABLED(CONFIG_NET_RX_BUSY_POLL))

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 include/trace/events/net.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index 1efd7d9..49e6003 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -168,11 +168,12 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,

	TP_fast_assign(
		__assign_str(name, skb->dev->name);
-#ifdef CONFIG_NET_RX_BUSY_POLL
-		__entry->napi_id = skb->napi_id;
-#else
-		__entry->napi_id = 0;
-#endif
+
+		if (IS_ENABLED(CONFIG_NET_RX_BUSY_POLL))
+			__entry->napi_id = skb->napi_id;
+		else
+			__entry->napi_id = 0;
+
 		__entry->queue_mapping = skb->queue_mapping;
 		__entry->skbaddr = skb;
 		__entry->vlan_tagged = skb_vlan_tag_present(skb);
-- 
2.7.4

