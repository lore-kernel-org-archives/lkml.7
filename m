Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DDDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288962054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126958;
	bh=rFU2YsDTCR+g4ae+SbfDAKzw8zKAomNbMWmv4WKsv5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yfxxaRjRDzSGnP1OUFpen8hCj4DNVrCSuB2Vg1ft9swtap6LoFVq/ypNIRv3huj+l
	 gTUSQwheRNJdfErKcmZVTWmNiIdE46rVk1lVaCLRISDSeq3cxDVKD6ajlQzdqalb8O
	 OJPARO5jtXN1YiWWUtH4ZGG9Pvl9MlLFer17e9Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390788AbfDXR3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390267AbfDXR3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:15 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B642054F;
        Wed, 24 Apr 2019 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126954;
        bh=rFU2YsDTCR+g4ae+SbfDAKzw8zKAomNbMWmv4WKsv5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNRGIL5meVvQ6/HwQ4qwybmXFlokJtwOoCIhmgvB8wpG3XSAqh3VNlu/KIs/0J573
         Ko7YuIUwu4JGQLyT7RYWn/fV4urNi/DCrhx0R2flsBwi+lCdu6gtysIdMZa93ow9ut
         QBhUKYN5gOyU9ANnXxvsITNMav2GWMDK4UDORQxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Sax <jsbc@gmx.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Ambro=C5=BE=20Bizjak?= <abizjak.pro@gmail.com>
Subject: [PATCH 4.14 70/70] i2c-hid: properly terminate i2c_hid_dmi_desc_override_table[] array
Date:   Wed, 24 Apr 2019 19:10:30 +0200
Message-Id: <20190424170919.238907592@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit b59dfdaef173677b0b7e10f375226c0a1114fd20 upstream.

Commit 9ee3e06610fd ("HID: i2c-hid: override HID descriptors for certain
devices") added a new dmi_system_id quirk table to override certain HID
report descriptors for some systems that lack them.

But the table wasn't properly terminated, causing the dmi matching to
walk off into la-la-land, and starting to treat random data as dmi
descriptor pointers, causing boot-time oopses if you were at all
unlucky.

Terminate the array.

We really should have some way to just statically check that arrays that
should be terminated by an empty entry actually are so.  But the HID
people really should have caught this themselves, rather than have me
deal with an oops during the merge window.  Tssk, tssk.

Cc: Julian Sax <jsbc@gmx.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ambrož Bizjak <abizjak.pro@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -337,7 +337,8 @@ static const struct dmi_system_id i2c_hi
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
 		},
 		.driver_data = (void *)&sipodev_desc
-	}
+	},
+	{ }	/* Terminate list */
 };
 
 


