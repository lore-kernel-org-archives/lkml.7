Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AA0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BFE21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253914;
	bh=jF1VomsOOJ5r90xfa1HfFFyyMujpQdBt0zSvSMWWtk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PPDPC6RiDTGNaBPrV6mxvOLMedYZTFFQqg8KmD3TycWh37SVF/4GFVekrLNOP6AB5
	 bw/+lt0Y0e+8h7SHYiKbL5zSXYIlM/ze4Pe0WvE5AvR7p93c3dwe8SKAZid5niWoWa
	 bYodfAjJM/Yh8FXgZzUppOM1DvOCkCfWX1pbxeGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfCVLZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbfCVLZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:25:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E7D218A2;
        Fri, 22 Mar 2019 11:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253910;
        bh=jF1VomsOOJ5r90xfa1HfFFyyMujpQdBt0zSvSMWWtk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVEQM09cLI8dlLlvV+QDl1aKNHwg9q4E22lks3cShAu7pW18nNGcJEULx1vZfzfLf
         C9fQBRRC4noKO7eoYF3+wFDfMjBI4zkTadk5nbqYQPEJCX51qeUTfZjdDDCd0D30M0
         R6YEQo2+QW8Ab8agkr31/w+4JMbON+xVfPz4rtbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 3.18 109/134] CIFS: Fix read after write for files with read caching
Date:   Fri, 22 Mar 2019 12:15:22 +0100
Message-Id: <20190322111218.211259548@linuxfoundation.org>
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

From: Pavel Shilovsky <piastryyy@gmail.com>

commit 6dfbd84684700cb58b34e8602c01c12f3d2595c8 upstream.

When we have a READ lease for a file and have just issued a write
operation to the server we need to purge the cache and set oplock/lease
level to NONE to avoid reading stale data. Currently we do that
only if a write operation succedeed thus not covering cases when
a request was sent to the server but a negative error code was
returned later for some other reasons (e.g. -EIOCBQUEUED or -EINTR).
Fix this by turning off caching regardless of the error code being
returned.

The patches fixes generic tests 075 and 112 from the xfs-tests.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2772,14 +2772,16 @@ cifs_strict_writev(struct kiocb *iocb, s
 	 * these pages but not on the region from pos to ppos+len-1.
 	 */
 	written = cifs_user_writev(iocb, from);
-	if (written > 0 && CIFS_CACHE_READ(cinode)) {
+	if (CIFS_CACHE_READ(cinode)) {
 		/*
-		 * Windows 7 server can delay breaking level2 oplock if a write
-		 * request comes - break it on the client to prevent reading
-		 * an old data.
+		 * We have read level caching and we have just sent a write
+		 * request to the server thus making data in the cache stale.
+		 * Zap the cache and set oplock/lease level to NONE to avoid
+		 * reading stale data from the cache. All subsequent read
+		 * operations will read new data from the server.
 		 */
 		cifs_zap_mapping(inode);
-		cifs_dbg(FYI, "Set no oplock for inode=%p after a write operation\n",
+		cifs_dbg(FYI, "Set Oplock/Lease to NONE for inode=%p after write\n",
 			 inode);
 		cinode->oplock = 0;
 	}


