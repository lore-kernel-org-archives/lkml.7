Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC57C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD858208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688486;
	bh=q+5mM6lhPL3sL+/JQJJD87KlaX6zZsdeni98qxUgqjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IfwqhsFLFSdeBt8ZR7cEg7Q9jCOBfCPgPkwJy3/lTkYd28ziWvAARMxYX63pb0ie2
	 Bh4Y0hMygxShCTx4/gYfsIw61f9+fUM5EnIb1CfERx44DhkvO1Y0ERcjL0hh1HVbVi
	 O+XhwXxoj42gqxlt30951lxm7CfD6I8lDhvzaXN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfCDIeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfCDIel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:34:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF5B20836;
        Mon,  4 Mar 2019 08:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688481;
        bh=q+5mM6lhPL3sL+/JQJJD87KlaX6zZsdeni98qxUgqjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7GgYY9yy+BnL5ryIyBxEIKiopKN9R17fO98EPZJEJPRp71ZzTmfS9nXmkAL52Bj8
         IF2tv2pkKYq4GJYEuHHEdX9Y3cD14pACkh9nVXhKuX+FSzdQ8c4Uc5aDA6kAuiNBU3
         1yxQQ6sAFAW4CRiS8O27e9uu6GQupK5LHbxGCrJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 59/88] net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP
Date:   Mon,  4 Mar 2019 09:22:42 +0100
Message-Id: <20190304081632.875420332@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



