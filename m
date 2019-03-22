Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A24C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBDE21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253925;
	bh=dXSPNAw77WfAI319AqADIh4yUh+iD1Dj9jp9CJOd2bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8SpL0giwDpdc8Oo0Da1vDZBSR3ce0tG7Fm1HvyrLjT6AVQCjeIMAn+CdVSNIfqDK
	 56bnHw8HoYS8XCKA5j3fddn1d1KGi2j9d5JCy/4V3XP3GkDIoRXoYhIrJYBph0+KCr
	 Nx72HR8Rs894JZpyW4TIeGzA59onHJIplj6//KGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfCVLZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbfCVLZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:25:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A6F20657;
        Fri, 22 Mar 2019 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253921;
        bh=dXSPNAw77WfAI319AqADIh4yUh+iD1Dj9jp9CJOd2bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lci8Lr7lHPm8kk5b8K2C8KorJIvp+3IvSyTUJI0WY1p9LKsSb7KFbKtO0DPQ+twCs
         swoDEf9NTqbYkBlqAZLGzbcDUs+8H3KB3XuF7uZJLGNn0cPFx7olx82UyV42v6jC+D
         AutjhwE4NOrbHGgdyd6O1eQUvSR2h0m7Pndp0pgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 3.18 095/134] 9p/net: fix memory leak in p9_client_create
Date:   Fri, 22 Mar 2019 12:15:08 +0100
Message-Id: <20190322111217.032973286@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhengbin <zhengbin13@huawei.com>

commit bb06c388fa20ae24cfe80c52488de718a7e3a53f upstream.

If msize is less than 4096, we should close and put trans, destroy
tagpool, not just free client. This patch fixes that.

Link: http://lkml.kernel.org/m/1552464097-142659-1-git-send-email-zhengbin13@huawei.com
Cc: stable@vger.kernel.org
Fixes: 574d356b7a02 ("9p/net: put a lower bound on msize")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1065,7 +1065,7 @@ struct p9_client *p9_client_create(const
 		p9_debug(P9_DEBUG_ERROR,
 			 "Please specify a msize of at least 4k\n");
 		err = -EINVAL;
-		goto free_client;
+		goto close_trans;
 	}
 
 	err = p9_client_version(clnt);


