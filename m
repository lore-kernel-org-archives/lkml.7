Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C457CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F118021744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904170;
	bh=mOzjGy2Q9cTEq/lLvfPWhDSPbJebbl1LtvQpkbyCVFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uldq2GJIWnDxkfa1TpJUvDBkEWUDZ4LMKoGba/bIVi+Fmg3/KKoO3gaInRZcQK+f2
	 ZNKW7krNnzfEJMtySjgkv6A1ja2kA+DSLcFDVq0Fewhor4z5/Y59dqH3pHxti6tC8e
	 5yZwAYui4sZebV5LH67DeeGlNtwiXbzhc6Ea0+pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfKDVt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730365AbfKDVt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:49:26 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79E220B7C;
        Mon,  4 Nov 2019 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904166;
        bh=mOzjGy2Q9cTEq/lLvfPWhDSPbJebbl1LtvQpkbyCVFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7HmCIXd9RcsfrWmLV6mJQhsF+EpkBjKeOnSEGQhZyTbwnPWThsPAGd7kA8Se6h3V
         SspKVqe0VHOlOnilAMF2Fgtc3Rn9etT8jmw8HEfZXZgnQsyDhlefNflrcJkPUA0Iej
         BPPHin2POhigsNEnjNTRWnLvhFhOM++vKAp17cSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.4 35/46] HID: fix error message in hid_open_report()
Date:   Mon,  4 Nov 2019 22:45:06 +0100
Message-Id: <20191104211908.747212493@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit b3a81c777dcb093020680490ab970d85e2f6f04f upstream.

On HID report descriptor parsing error the code displays bogus
pointer instead of error offset (subtracts start=NULL from end).
Make the message more useful by displaying correct error offset
and include total buffer size for reference.

This was carried over from ancient times - "Fixed" commit just
promoted the message from DEBUG to ERROR.

Cc: stable@vger.kernel.org
Fixes: 8c3d52fc393b ("HID: make parser more verbose about parsing errors by default")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -959,6 +959,7 @@ int hid_open_report(struct hid_device *d
 	__u8 *start;
 	__u8 *buf;
 	__u8 *end;
+	__u8 *next;
 	int ret;
 	static int (*dispatch_type[])(struct hid_parser *parser,
 				      struct hid_item *item) = {
@@ -1012,7 +1013,8 @@ int hid_open_report(struct hid_device *d
 	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
 
 	ret = -EINVAL;
-	while ((start = fetch_item(start, end, &item)) != NULL) {
+	while ((next = fetch_item(start, end, &item)) != NULL) {
+		start = next;
 
 		if (item.format != HID_ITEM_FORMAT_SHORT) {
 			hid_err(device, "unexpected long global item\n");
@@ -1041,7 +1043,8 @@ int hid_open_report(struct hid_device *d
 		}
 	}
 
-	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
+	hid_err(device, "item fetching failed at offset %u/%u\n",
+		size - (unsigned int)(end - start), size);
 err:
 	vfree(parser);
 	hid_close_report(device);


