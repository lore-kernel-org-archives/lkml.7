Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA77C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C497520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689190;
	bh=vNUo9BmXpYpmpBRNoxUpfj2YZpSjWlIfSuqWPuyDbH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h3jUavyBryZhQc21NLwwaVA2FSWr+VN+9WOwHJDSQfj7gAIvHvEcd/BfZzROIc8aj
	 lu/fMCwF/byns2xep6i2FYXozo1vnVNrnEUadpJ98LhtPwe9UgxFdXYbyP9qHNZfSc
	 /gI+NQv72kh/yvS0MrkpMfW1wpG84xWDkc/CIMwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCDIq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCDI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:26:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FF5E2146E;
        Mon,  4 Mar 2019 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688000;
        bh=vNUo9BmXpYpmpBRNoxUpfj2YZpSjWlIfSuqWPuyDbH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uh0DN6rpYSP8x5e0LV1LaXMYMrmqJLD0E/KOgkbo327wA9Qs4MsOet8bwsqMGMATP
         wJTUtf3YCmkAproiluEElz9OxaYqKZrH0eYuF0aJ/gRsT9UibwoV0l7ARIDY2BDLqz
         QsKjVNco7pcgCVKukZbeDc95+fo6QQdImTbe1XEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 37/52] net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP
Date:   Mon,  4 Mar 2019 09:22:35 +0100
Message-Id: <20190304081619.258652793@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3b707c3008cad04604c1f50e39f456621821c414 ]

__bpf_redirect() and act_mirred checks this boolean
to determine whether to prefix an ethernet header.

Signed-off-by: Maciej Żenczykowski <maze@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/if_arp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index 3355efc897816..4125f60ee53b0 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -54,6 +54,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_IPGRE:
 	case ARPHRD_VOID:
 	case ARPHRD_NONE:
+	case ARPHRD_RAWIP:
 		return false;
 	default:
 		return true;
-- 
2.19.1



