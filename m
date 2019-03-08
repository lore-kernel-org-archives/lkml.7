Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273252085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049608;
	bh=GOH9b9g1R2C4C2dBAk133LLX/s+AL+6iHid9FNsrllM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+KhtRavEsEijyUivridxV9julv/RrDKfBCCyRQ3BjWCPIA3gXgnsP5Swt6eEFH5W
	 CJtipBIxLWOh+C5GyYUdwIAawsZHlh+mscysQMK5jYINP/6583+7VE1hg1JeyDgx1F
	 SB0aaGaYRRbtU8hcoU7mkiZv7RyFXDZCok7iKrfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCHMx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfCHMxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9808E20684;
        Fri,  8 Mar 2019 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049600;
        bh=GOH9b9g1R2C4C2dBAk133LLX/s+AL+6iHid9FNsrllM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHXo48HJCrSGILZjYlR+YlPj2es71dI3jrA2pl5iNXPndBPKIAm/1Zvr/kFt6K5ta
         b1CblouW8P5ubdZWOs53JXAdK6pWKh8cNUvE7U8AophP6kqnj8/8BVJ5ZtYJV5DL9o
         3TRZwMJPBr/UBsJoV94Ws1U+CFz4b/daERDlphPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5.0 42/46] Revert "selftests: firmware: remove use of non-standard diff -Z option"
Date:   Fri,  8 Mar 2019 13:50:15 +0100
Message-Id: <20190308124904.952691881@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luis Chamberlain <mcgrof@kernel.org>

commit 13ac7db09c914e4991a08b7ad578267d5cdd9856 upstream.

This reverts commit f70b472e937bb659a7b7a14e64f07308e230888c.

This breaks testing on Debian, and this patch was NACKed anyway.
The proper way to address this is a quirk for busybox as that is
where the issue is present.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Fixes: f70b472e937b ("selftests: firmware: remove use of non-standard diff -Z option")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/firmware/fw_filesystem.sh |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -155,8 +155,11 @@ read_firmwares()
 {
 	for i in $(seq 0 3); do
 		config_set_read_fw_idx $i
-		# Verify the contents match
-		if ! diff -q "$FW" $DIR/read_firmware 2>/dev/null ; then
+		# Verify the contents are what we expect.
+		# -Z required for now -- check for yourself, md5sum
+		# on $FW and DIR/read_firmware will yield the same. Even
+		# cmp agrees, so something is off.
+		if ! diff -q -Z "$FW" $DIR/read_firmware 2>/dev/null ; then
 			echo "request #$i: firmware was not loaded" >&2
 			exit 1
 		fi
@@ -168,7 +171,7 @@ read_firmwares_expect_nofile()
 	for i in $(seq 0 3); do
 		config_set_read_fw_idx $i
 		# Ensures contents differ
-		if diff -q "$FW" $DIR/read_firmware 2>/dev/null ; then
+		if diff -q -Z "$FW" $DIR/read_firmware 2>/dev/null ; then
 			echo "request $i: file was not expected to match" >&2
 			exit 1
 		fi


