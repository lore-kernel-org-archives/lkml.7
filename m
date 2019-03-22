Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E2921873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260391;
	bh=S60mzx5ykPBtiTDiSq+UQ3Ch4flUqOURXU4XxSSfq7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fltpEDc4t2LixvN95xsLh9mgDwzdrvGIkzeThpIxACdRd2yjwDidrSH/3L4bI5m2h
	 HmdJn29Y1BbqwI7kjkbiqPxrwSRc9a7JIC9fCH3fZt9DJZHzlhVz/rY0bL3xRe6ev1
	 SctbZNwRXGajOh793gNPmP8B1eQhKUVRI29VX620=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfCVNNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbfCVLav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F53F20449;
        Fri, 22 Mar 2019 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254251;
        bh=S60mzx5ykPBtiTDiSq+UQ3Ch4flUqOURXU4XxSSfq7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5P7vCwgva1/IqF/YyG17HiaFaGkAHQYgcE4a1G2lSNYw92LnsWVG6lN5nx/QdrX+
         VIPf4iKjOmEfkcOjZbCC7o8c1nZlsu/d+v8svKp3kZJW5WP5lnrMQutiZjHpX+Mw9R
         UiK9EQfUbCxZx2njXt8BpFa3pXrcfVxZnFpGgeD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.4 060/230] ncpfs: fix build warning of strncpy
Date:   Fri, 22 Mar 2019 12:13:18 +0100
Message-Id: <20190322111240.893827598@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Not upstream as ncpfs is long deleted.

Fix up two strncpy build warnings in ncp_get_charsets() by using strscpy
and the max size of the array.

It's not like anyone uses this code anyway, and this gets rid of two
build warnings so that we can see real warnings as they pop up over
time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ncpfs/ioctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ncpfs/ioctl.c
+++ b/fs/ncpfs/ioctl.c
@@ -233,7 +233,7 @@ ncp_get_charsets(struct ncp_server* serv
 		len = strlen(server->nls_vol->charset);
 		if (len > NCP_IOCSNAME_LEN)
 			len = NCP_IOCSNAME_LEN;
-		strncpy(user.codepage, server->nls_vol->charset, len);
+		strscpy(user.codepage, server->nls_vol->charset, NCP_IOCSNAME_LEN);
 		user.codepage[len] = 0;
 	}
 
@@ -243,7 +243,7 @@ ncp_get_charsets(struct ncp_server* serv
 		len = strlen(server->nls_io->charset);
 		if (len > NCP_IOCSNAME_LEN)
 			len = NCP_IOCSNAME_LEN;
-		strncpy(user.iocharset,	server->nls_io->charset, len);
+		strscpy(user.iocharset,	server->nls_io->charset, NCP_IOCSNAME_LEN);
 		user.iocharset[len] = 0;
 	}
 	mutex_unlock(&server->root_setup_lock);


