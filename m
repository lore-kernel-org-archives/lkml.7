Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B201A2082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfHSOoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:44:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSOoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:44:13 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 242F32A09CC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:44:13 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r9so605832wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TF+A3q0AGPqtPsFHg+fVpmCHghsk6iALe9Z0fNSb534=;
        b=J2L++D4CosR4QU/qkR2uYZacscGSdiIj+STPIM6d9g7dksHKC4RuTq8r0FPuvostFr
         7LtO8BiafJnrys1xjLmeUXJlF9401vBZ365k+mswVmi7Q79BZXHjIexLv5GB7dG5ahMt
         Gex+cH/zcI1ZbPA6LxKqGkT/MPyFHQi/74k0wLFV3/rqfHhk14IB+bJKz9nb5HBNDr9Q
         7CdGvXJocPtrpW/vxdKJYhrb14tLnPXDhn61IkxxOQAzaz06IIR+yKLgFvX5ulju2BrT
         MdCP17qsd6nTi5YPM893TJCFmxg8Vr4rW/74HRCgfI3KwAvNHxpKGJ56q80TJdM8hutj
         GujA==
X-Gm-Message-State: APjAAAU78QLeCu7tzvxyuHjTSMvvyzZPue4lODYmYzJ8cC4/miWmqD9L
        aMYWp/kswWOS+riUkFnezqv6+7m4zJfwCk9oBvZ/1IWEeOz9uEzA9zO2VOrCA62G1RqRuXk8jrv
        /OY1h+psRS9uZJUKwSU0QN9+M
X-Received: by 2002:a5d:5041:: with SMTP id h1mr29807438wrt.30.1566225851860;
        Mon, 19 Aug 2019 07:44:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyA26JO1FFWwEAiE1hEocCfZzTUcXX4NgdVBXA3fvIQBxVanf3Ieaz/oxscAleno0wwfLc2jw==
X-Received: by 2002:a5d:5041:: with SMTP id h1mr29807411wrt.30.1566225851669;
        Mon, 19 Aug 2019 07:44:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i66sm12621685wmg.2.2019.08.19.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:44:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Tools: hv: kvp: eliminate 'may be used uninitialized' warning
Date:   Mon, 19 Aug 2019 16:44:09 +0200
Message-Id: <20190819144409.13349-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building hv_kvp_daemon GCC-8.3 complains:

hv_kvp_daemon.c: In function ‘kvp_get_ip_info.constprop’:
hv_kvp_daemon.c:812:30: warning: ‘ip_buffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct hv_kvp_ipaddr_value *ip_buffer;

this seems to be a false positive: we only use ip_buffer when
op == KVP_OP_GET_IP_INFO and it is only unset when op == KVP_OP_ENUMERATE.

Silence the warning by initializing ip_buffer to NULL.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index d7e06fe0270e..6d809abaf338 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -809,7 +809,7 @@ kvp_get_ip_info(int family, char *if_name, int op,
 	int sn_offset = 0;
 	int error = 0;
 	char *buffer;
-	struct hv_kvp_ipaddr_value *ip_buffer;
+	struct hv_kvp_ipaddr_value *ip_buffer = NULL;
 	char cidr_mask[5]; /* /xyz */
 	int weight;
 	int i;
-- 
2.20.1

