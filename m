Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F588C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EA4216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946646;
	bh=WUYooGrCEDe8VW9BAEf19OtWWMbZj/Ab7oU1AJQaYIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MIu0d3LHJmYvOE/ZOmJKKMQ7mazGHpxlCSu6Y4esPhgPtsKtHFvZ0LkQzzm/h14vh
	 9xZaGMN+rBgxlLUsUkZX64PmShh7RR90ww7SHtwlnrN5BowApd+uKJuH+rjG1QPrUb
	 9MzqL1on8jwyllRAkvkvMNLChOk2Md06o0NdEOwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfIHMoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbfIHMoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:44:02 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F9D218AE;
        Sun,  8 Sep 2019 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946641;
        bh=WUYooGrCEDe8VW9BAEf19OtWWMbZj/Ab7oU1AJQaYIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZH8lsSN7RV2T5wt7Jc9ko2fjOoldq7er2rlif9tkO+pSrfCzF95BUJ7uirZegvqRM
         p3m4CZUYyks/e16uIZP58Wsv5Y85lEpsrV2DPobk2LpNPQOnMBcx3MOxdXL0mW064z
         NapVhZAPuyCufIH5PLJaJyIEDW2ExAn5QGl20Qy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 12/26] Tools: hv: kvp: eliminate may be used uninitialized warning
Date:   Sun,  8 Sep 2019 13:41:51 +0100
Message-Id: <20190908121103.079450650@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 89eb4d8d25722a0a0194cf7fa47ba602e32a6da7 ]

When building hv_kvp_daemon GCC-8.3 complains:

hv_kvp_daemon.c: In function ‘kvp_get_ip_info.constprop’:
hv_kvp_daemon.c:812:30: warning: ‘ip_buffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct hv_kvp_ipaddr_value *ip_buffer;

this seems to be a false positive: we only use ip_buffer when
op == KVP_OP_GET_IP_INFO and it is only unset when op == KVP_OP_ENUMERATE.

Silence the warning by initializing ip_buffer to NULL.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index fffc7c4184599..834008639c4bb 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -878,7 +878,7 @@ kvp_get_ip_info(int family, char *if_name, int op,
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



