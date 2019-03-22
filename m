Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC87C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715BC21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254492;
	bh=yy/SXnu0dI8DdVTk7ylbJJV8NCtt+YVk9LyMmclMPAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xAce7ewUllczqP1+rzd/R8A75VX7O0CajVZntQPqVjpQIul61LnprDAD/94x/8S3k
	 9b6yAnpeerk/3iR+EUUW5TKy/GekzjfyZGRjUrLv1F5DUy6iY+eAqjpvTE+pif8PsJ
	 Ik8Y2inkAOGOxpnxXdxZZAGh/xnHxGsfdHreQ9ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfCVLev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbfCVLes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC212183E;
        Fri, 22 Mar 2019 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254488;
        bh=yy/SXnu0dI8DdVTk7ylbJJV8NCtt+YVk9LyMmclMPAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c66knJ4VlAEIsfQamTAsY9meOAftBj2/v/6rRKyETyARO7hwMC/Hmn5MNv0nLk7tu
         X80FV4X8uugh3hdgdIb9NdgN7DMsIIhjXLipIVA74vvVWzQu3Smhkxbec7E6DuuaIy
         5RhRQF2K5djavgyrm3iUkNYGDYK8W8up//gRJrZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4.4 151/230] 9p/net: fix memory leak in p9_client_create
Date:   Fri, 22 Mar 2019 12:14:49 +0100
Message-Id: <20190322111247.264128871@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1058,7 +1058,7 @@ struct p9_client *p9_client_create(const
 		p9_debug(P9_DEBUG_ERROR,
 			 "Please specify a msize of at least 4k\n");
 		err = -EINVAL;
-		goto free_client;
+		goto close_trans;
 	}
 
 	err = p9_client_version(clnt);


