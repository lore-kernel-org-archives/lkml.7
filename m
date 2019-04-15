Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A49C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6D720651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356120;
	bh=ztni7lGS0IkxkmeDSu3uLSYLBFrCKNNIGd+xVUIG+Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQ2go8Ksy08b7eNulZBZHRW09cthwIC2M/oXETSCvhZjLduPesHCLKydj3UWbXR9S
	 ol61Mk1W6gCIttMro2jYHHcaFTsZw32m6yyWesz5Jm+gp1x4WWt1zck8DIJPZbMV3C
	 DKWvHXlM4q5j7SC2bAEXTq1+UiKvjoEy974mSsJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfDOTIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730512AbfDOTIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46BE1218A1;
        Mon, 15 Apr 2019 19:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355317;
        bh=ztni7lGS0IkxkmeDSu3uLSYLBFrCKNNIGd+xVUIG+Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwoOOhNWkBQKKTZWItLLsGneEtpMy6uC1j/LM+eIVmK96aomE9MWLcX292lmxYScK
         IJ3Oa2YI9S5h3cZtT0nFNwkLk79OObIMOo+33uz+nNyxcc8x5gzlSHGMJfHvF4JU/G
         cRM3vMjOymiHXXeJrViPNFJSyfyXakiY1eqc3ubY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 093/101] dm integrity: change memcmp to strncmp in dm_integrity_ctr
Date:   Mon, 15 Apr 2019 20:59:31 +0200
Message-Id: <20190415183745.293517351@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 0d74e6a3b6421d98eeafbed26f29156d469bc0b5 upstream.

If the string opt_string is small, the function memcmp can access bytes
that are beyond the terminating nul character. In theory, it could cause
segfault, if opt_string were located just below some unmapped memory.

Change from memcmp to strncmp so that we don't read bytes beyond the end
of the string.

Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-integrity.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3174,7 +3174,7 @@ static int dm_integrity_ctr(struct dm_ta
 			journal_watermark = val;
 		else if (sscanf(opt_string, "commit_time:%u%c", &val, &dummy) == 1)
 			sync_msec = val;
-		else if (!memcmp(opt_string, "meta_device:", strlen("meta_device:"))) {
+		else if (!strncmp(opt_string, "meta_device:", strlen("meta_device:"))) {
 			if (ic->meta_dev) {
 				dm_put_device(ti, ic->meta_dev);
 				ic->meta_dev = NULL;
@@ -3193,17 +3193,17 @@ static int dm_integrity_ctr(struct dm_ta
 				goto bad;
 			}
 			ic->sectors_per_block = val >> SECTOR_SHIFT;
-		} else if (!memcmp(opt_string, "internal_hash:", strlen("internal_hash:"))) {
+		} else if (!strncmp(opt_string, "internal_hash:", strlen("internal_hash:"))) {
 			r = get_alg_and_key(opt_string, &ic->internal_hash_alg, &ti->error,
 					    "Invalid internal_hash argument");
 			if (r)
 				goto bad;
-		} else if (!memcmp(opt_string, "journal_crypt:", strlen("journal_crypt:"))) {
+		} else if (!strncmp(opt_string, "journal_crypt:", strlen("journal_crypt:"))) {
 			r = get_alg_and_key(opt_string, &ic->journal_crypt_alg, &ti->error,
 					    "Invalid journal_crypt argument");
 			if (r)
 				goto bad;
-		} else if (!memcmp(opt_string, "journal_mac:", strlen("journal_mac:"))) {
+		} else if (!strncmp(opt_string, "journal_mac:", strlen("journal_mac:"))) {
 			r = get_alg_and_key(opt_string, &ic->journal_mac_alg,  &ti->error,
 					    "Invalid journal_mac argument");
 			if (r)


