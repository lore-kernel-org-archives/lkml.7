Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3F2206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411794;
	bh=iqZ9kfmD4a3nQPkkXW2HeSkEZb0fLWKVoSwyY0pxtDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTcILX+YqOzs9pBnDnbsiiHYU0VHpnkAUdAMg+PlJwcam8s4xGkFX653jeNYWKMiE
	 CzyeOhHCLV6aQ/AGC6T8kbhMNprpSuEOdvq/rcpVUr/06rHE1kMAGijDik5ne0/3q6
	 iYZlMzmp10X6MWiRRWAwHw3kf3KSWJQi+wRlwrKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfCLR3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbfCLRRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:22 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF6521741;
        Tue, 12 Mar 2019 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411041;
        bh=iqZ9kfmD4a3nQPkkXW2HeSkEZb0fLWKVoSwyY0pxtDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7U7ATc5Qnb5b1gcjOUCz252SOn6tacDj8x1PVy3ZZ97j3+kjiDqS6sSFzEBDz4eX
         WgXEmFVY4KNtYkBoUeiQQztXWtMqXA5WjnGaUbf5L6nuDdLAqoKRDFhJH8txg2c7QU
         eZ/3dL/OWUADuFzOIKpjElM68WCPE0nsfRFceYLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.9 05/96] ncpfs: fix build warning of strncpy
Date:   Tue, 12 Mar 2019 10:09:23 -0700
Message-Id: <20190312171034.966419467@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Not upstream as ncpfs is long deleted.

Fix up two strncpy build warnings in ncp_get_charsets() by using strscpy
and the max size of the array.

It's not like anyone uses this code anyway, and this gets rid of two
build warnings so that we can see real warnings as they pop up over
time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/fs/ncpfs/ioctl.c b/fs/ncpfs/ioctl.c
index 0a3f9b594602..37779ed3f790 100644
--- a/fs/ncpfs/ioctl.c
+++ b/fs/ncpfs/ioctl.c
@@ -233,7 +233,7 @@ ncp_get_charsets(struct ncp_server* server, struct ncp_nls_ioctl __user *arg)
 		len = strlen(server->nls_vol->charset);
 		if (len > NCP_IOCSNAME_LEN)
 			len = NCP_IOCSNAME_LEN;
-		strncpy(user.codepage, server->nls_vol->charset, len);
+		strscpy(user.codepage, server->nls_vol->charset, NCP_IOCSNAME_LEN);
 		user.codepage[len] = 0;
 	}
 
@@ -243,7 +243,7 @@ ncp_get_charsets(struct ncp_server* server, struct ncp_nls_ioctl __user *arg)
 		len = strlen(server->nls_io->charset);
 		if (len > NCP_IOCSNAME_LEN)
 			len = NCP_IOCSNAME_LEN;
-		strncpy(user.iocharset,	server->nls_io->charset, len);
+		strscpy(user.iocharset,	server->nls_io->charset, NCP_IOCSNAME_LEN);
 		user.iocharset[len] = 0;
 	}
 	mutex_unlock(&server->root_setup_lock);


