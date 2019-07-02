Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C799C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A372184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054992;
	bh=rOlToZ6vzTH/OlDc5FQCdWtvbsvZqdQvaZ4azGXR+3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oS7AYtNjpdvmdur5Z+WRmzchR5AnaV6r3v0CT9lCshNv4C7qW9HS7b+iSG5LVPBJO
	 1zfL7PFHsCd3cVCEdWhU8Dryr63hmIUKC3jYbKKBxsPSAGS8fJtpCPHy5SJPQWO6a+
	 F2VD3TjTsEHb551dg6ePCutrbRHQMtibjQstzRL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfGBIJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfGBIJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:09:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E81E62184B;
        Tue,  2 Jul 2019 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054988;
        bh=rOlToZ6vzTH/OlDc5FQCdWtvbsvZqdQvaZ4azGXR+3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Knhug6oW0i8VaCxz23XJiHc5YY7qrSgd5xPCw37tirnvwFRcPGTiaXq6qqJm53Ljt
         Ht2fICRkx8HhOBcrqcYZ6r5DsnfDnJ3bVOwO3K3d5USuOUeJtVCa1Zj9lZxIH2/i6R
         I4FDiyFZIJiMDn2pDz5qyDGomzBP8qaMXgmRMxlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, JingYi Hou <houjingyi647@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 30/43] net: remove duplicate fetch in sock_getsockopt
Date:   Tue,  2 Jul 2019 10:02:10 +0200
Message-Id: <20190702080125.429553787@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
References: <20190702080123.904399496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JingYi Hou <houjingyi647@gmail.com>

[ Upstream commit d0bae4a0e3d8c5690a885204d7eb2341a5b4884d ]

In sock_getsockopt(), 'optlen' is fetched the first time from userspace.
'len < 0' is then checked. Then in condition 'SO_MEMINFO', 'optlen' is
fetched the second time from userspace.

If change it between two fetches may cause security problems or unexpected
behaivor, and there is no reason to fetch it a second time.

To fix this, we need to remove the second fetch.

Signed-off-by: JingYi Hou <houjingyi647@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1358,9 +1358,6 @@ int sock_getsockopt(struct socket *sock,
 	{
 		u32 meminfo[SK_MEMINFO_VARS];
 
-		if (get_user(len, optlen))
-			return -EFAULT;
-
 		sk_get_meminfo(sk, meminfo);
 
 		len = min_t(unsigned int, len, sizeof(meminfo));


