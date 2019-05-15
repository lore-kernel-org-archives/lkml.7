Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90682C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6117A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920012;
	bh=LIppDl/pSIIJoQDgpQp6hdCA/saq1X5ZeQ0WFcvqWKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ScZIiSad1q46kNUG8yAyzmJ/AyHyNQIBJwzU9/HCAol/JYpxAnTGe67uCAGyiMZsb
	 A3kmF1MeIf0dE8elR5UDIJgGj1gxXd8lVKchmkHl9pCb7hGS63eeMNg13LKQdAkrg/
	 KOOlnwmwOhDDNUE2YuvzYFzPasBZGeH/KHR9foGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbfEOLdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbfEOLd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:33:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4782084F;
        Wed, 15 May 2019 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557920007;
        bh=LIppDl/pSIIJoQDgpQp6hdCA/saq1X5ZeQ0WFcvqWKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NiAEH9dEgRwnm6F09E8KCKO9Cw+Ypj1YzhrIxrNhuIuqf2lwK0/qJBRal97JVUrkC
         hN7fEaXQFvEVaUjffHt6IX9EBkVYi0lONQZrGKgM4SC0bw47V1avkTgynJ/xv3RG5C
         Jtfq6TE2MettkhX5ZC569I0Rgw8q0yzdnIygxdts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.1 07/46] i2c: core: ratelimit transfer when suspended errors
Date:   Wed, 15 May 2019 12:56:31 +0200
Message-Id: <20190515090620.361985798@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 4db61c2a16fce2ef85d82751de4ba43a39347cfb upstream.

There are two problems with WARN_ON() here. One: It is not ratelimited.
Two: We don't see which adapter was used when trying to transfer
something when already suspended. Implement a custom ratelimit once per
adapter and use dev_WARN there. This fixes both issues. Drawback is that
we don't see if multiple drivers are trying to transfer with the same
adapter while suspended. They need to be discovered one after the other
now. This is better than a high CPU load because a really broken driver
might try to resend endlessly.

Fixes: 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for i2c adapters")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@vger.kernel.org # v5.1+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core-base.c |    5 ++++-
 include/linux/i2c.h         |    3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1871,8 +1871,11 @@ int __i2c_transfer(struct i2c_adapter *a
 
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
-	if (WARN_ON(test_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags)))
+	if (test_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags)) {
+		if (!test_and_set_bit(I2C_ALF_SUSPEND_REPORTED, &adap->locked_flags))
+			dev_WARN(&adap->dev, "Transfer while suspended\n");
 		return -ESHUTDOWN;
+	}
 
 	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
 		return -EOPNOTSUPP;
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -682,7 +682,8 @@ struct i2c_adapter {
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
-#define I2C_ALF_IS_SUSPENDED	0
+#define I2C_ALF_IS_SUSPENDED		0
+#define I2C_ALF_SUSPEND_REPORTED	1
 
 	int nr;
 	char name[48];


