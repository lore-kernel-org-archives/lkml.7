Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC5CC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7A224682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781593;
	bh=WQenRLrZDkwW+vI+f6c2c5mZGuhSMwWB2m9IQwuTozk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S8tkAhNmEKTVNvTlU1PQvVaZQ4Q/rhMdcoFfcEa2Nv/s9Ju7lgws0CcoKo5GsMccs
	 CSPZKMA+ZCga3fCV00wEi/n0KHCnXnHYkxD2kDpXGJhKw621v3t1izwxx3JYFH4Gyb
	 GhbzVX3mVtX+14SS1cWrVPSy3p9+j7Yb64EMa0hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfLSSxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730338AbfLSSxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:53:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E9624682;
        Thu, 19 Dec 2019 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781590;
        bh=WQenRLrZDkwW+vI+f6c2c5mZGuhSMwWB2m9IQwuTozk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJl51gfVAv/QOyrjrtJLJOZn6JwvLPd17NxZbbF7Ihr6eaNPXyFHfDO6170yeeufd
         SQaIWXJ1X7luFqYQot4mUkD6qfAZ6ASo6z2owSh9m3xWoeKqVQlFgMgKAKES2Gwqs2
         0qt1mVIttBmyR1vPmbIx6mgrBjHiM/BY9cJ86VPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 33/47] cifs: smbd: Return -EINVAL when the number of iovs exceeds SMBDIRECT_MAX_SGE
Date:   Thu, 19 Dec 2019 19:34:47 +0100
Message-Id: <20191219182935.476928876@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182857.659088743@linuxfoundation.org>
References: <20191219182857.659088743@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

commit 37941ea17d3f8eb2f5ac2f59346fab9e8439271a upstream.

While it's not friendly to fail user processes that issue more iovs
than we support, at least we should return the correct error code so the
user process gets a chance to retry with smaller number of iovs.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smbdirect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1164,7 +1164,7 @@ static int smbd_post_send_data(
 
 	if (n_vec > SMBDIRECT_MAX_SGE) {
 		cifs_dbg(VFS, "Can't fit data to SGL, n_vec=%d\n", n_vec);
-		return -ENOMEM;
+		return -EINVAL;
 	}
 
 	sg_init_table(sgl, n_vec);


