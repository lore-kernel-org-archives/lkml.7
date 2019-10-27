Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2830BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A85222C1
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211617;
	bh=xKVZE5JhxPls7RCkz1IZ18bRsS/CieIGVS88fy3Y+K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SxfYi6Txoy1mqmT+qIm69ekTgfw8uHF08VpjVwf4RdsKkqR6qzrGIj87pC+GDjfjl
	 9yIFudjrIH3xjayIVNImJQMklOgbhlKd4wGrv3k0sfr5qwORGm7kPl78EOnB5Ez6nP
	 m2bAcTMCT/RXokq5Y2jsnRLYFiuRwtq6gEBrIDU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbfJ0VZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732799AbfJ0VZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:25:48 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A418B21850;
        Sun, 27 Oct 2019 21:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211548;
        bh=xKVZE5JhxPls7RCkz1IZ18bRsS/CieIGVS88fy3Y+K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nh72g7yjcpEViTLX+HpKRSucFb5Cc88W4rU4tUbh8CIMHDkmrEnH6fx4tR4bIBor9
         +mLRPozdVSqHy9/6GcGG7UwZadH6hzeCj2xioXSR3rHkh1V7k1oLCBP4ctMmuWgHbu
         jgfVSzfwnsGSIQ6t/f81LGp6HknbYp3uu6y8CmNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.3 191/197] ceph: just skip unrecognized info in ceph_reply_info_extra
Date:   Sun, 27 Oct 2019 22:01:49 +0100
Message-Id: <20191027203406.798811216@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 1d3f87233e26362fc3d4e59f0f31a71b570f90b9 upstream.

In the future, we're going to want to extend the ceph_reply_info_extra
for create replies. Currently though, the kernel code doesn't accept an
extra blob that is larger than the expected data.

Change the code to skip over any unrecognized fields at the end of the
extra blob, rather than returning -EIO.

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/mds_client.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -384,8 +384,8 @@ static int parse_reply_info_readdir(void
 	}
 
 done:
-	if (*p != end)
-		goto bad;
+	/* Skip over any unrecognized fields */
+	*p = end;
 	return 0;
 
 bad:
@@ -406,12 +406,10 @@ static int parse_reply_info_filelock(voi
 		goto bad;
 
 	info->filelock_reply = *p;
-	*p += sizeof(*info->filelock_reply);
 
-	if (unlikely(*p != end))
-		goto bad;
+	/* Skip over any unrecognized fields */
+	*p = end;
 	return 0;
-
 bad:
 	return -EIO;
 }
@@ -425,18 +423,21 @@ static int parse_reply_info_create(void
 {
 	if (features == (u64)-1 ||
 	    (features & CEPH_FEATURE_REPLY_CREATE_INODE)) {
+		/* Malformed reply? */
 		if (*p == end) {
 			info->has_create_ino = false;
 		} else {
 			info->has_create_ino = true;
-			info->ino = ceph_decode_64(p);
+			ceph_decode_64_safe(p, end, info->ino, bad);
 		}
+	} else {
+		if (*p != end)
+			goto bad;
 	}
 
-	if (unlikely(*p != end))
-		goto bad;
+	/* Skip over any unrecognized fields */
+	*p = end;
 	return 0;
-
 bad:
 	return -EIO;
 }


