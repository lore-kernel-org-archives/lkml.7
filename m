Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3CECA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C3F21929
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905360;
	bh=asVhnAg/bI2hyt9+LNgS+5jw0LDtcyGczWuKJbydNgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4nsNGLDRHqdSh9dAL6OqZfXUpHbmE9Oqj3mWbdlPH7Fiufjz+mH8T3mh4VixT6lF
	 5vNqjKMosppuBJoNZ75yXN6JnWeLEQ+6PY0tZSjb9twOS64xoYgLswJoMftHRl93pe
	 utCnsiY/gEHOF4p00+18igWhqvdvtFgdn5V7UOYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390377AbfKDWJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390363AbfKDWJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:09:16 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55202084D;
        Mon,  4 Nov 2019 22:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905355;
        bh=asVhnAg/bI2hyt9+LNgS+5jw0LDtcyGczWuKJbydNgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyAlpEjWHGb10N/OueKcATWscXx+PdjmEdUMwYtgCqdAnOLUyJZ5Ff6LUcDH++J4D
         ukwqf1GWRIaja67zY4g7464Kn+p0lcv63RPbuWO8bon04jHq6imRbaU3zG/vlXLO7y
         M8iZGzlW9tlK7JrA1cCDRcYPXGYHXmELjQTKQSwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.3 117/163] HID: fix error message in hid_open_report()
Date:   Mon,  4 Nov 2019 22:45:07 +0100
Message-Id: <20191104212148.699755550@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
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
@@ -1139,6 +1139,7 @@ int hid_open_report(struct hid_device *d
 	__u8 *start;
 	__u8 *buf;
 	__u8 *end;
+	__u8 *next;
 	int ret;
 	static int (*dispatch_type[])(struct hid_parser *parser,
 				      struct hid_item *item) = {
@@ -1192,7 +1193,8 @@ int hid_open_report(struct hid_device *d
 	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
 
 	ret = -EINVAL;
-	while ((start = fetch_item(start, end, &item)) != NULL) {
+	while ((next = fetch_item(start, end, &item)) != NULL) {
+		start = next;
 
 		if (item.format != HID_ITEM_FORMAT_SHORT) {
 			hid_err(device, "unexpected long global item\n");
@@ -1230,7 +1232,8 @@ int hid_open_report(struct hid_device *d
 		}
 	}
 
-	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
+	hid_err(device, "item fetching failed at offset %u/%u\n",
+		size - (unsigned int)(end - start), size);
 err:
 	kfree(parser->collection_stack);
 alloc_err:


