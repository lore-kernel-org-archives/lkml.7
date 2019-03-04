Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A492146E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688304;
	bh=ZII+5kFh7/oSg3GFZ7RIFcM7Kd+LOYU8JhNAXrT+nVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iP0wIapXL43XjG9WHZPdhjlmngxbU7SpJ49nBiexNNsHcOR5XpDsO+gl1lPNZOz2t
	 Ibvp8h8VZCQP/9Z3Ug8gkGL1E+gHNKUV74asfpBRZYw1fWDghWkW0hLq7csd33+2C1
	 jlSaYL4GQQ9JeUOny3xi+O+r6l8R3y6SJN5ziZRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfCDIbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfCDIbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:31:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E9221019;
        Mon,  4 Mar 2019 08:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688298;
        bh=ZII+5kFh7/oSg3GFZ7RIFcM7Kd+LOYU8JhNAXrT+nVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUjbXIQelcE8trTTJombi0vcNlTrOoB3R+SPq+GySMLv/i9y0RAi0A/4e+FYWSEj1
         kyS8OhuBGTyYGqY4bmlsI5MO7/NhHMDAAHeKmPd2GDCuXD66wbQaJ5WEcijFF+EiMN
         Jg6KglQnZkG2E2/uhwBGA3V1MAeNeyk8+TQGYpSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 57/78] net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP
Date:   Mon,  4 Mar 2019 09:22:40 +0100
Message-Id: <20190304081628.092526651@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 6756fea18b69f..e44746de95cdf 100644
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



