Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4EFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E70721905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127367;
	bh=LupqdGEKvkxtPWLNBCqP6BnFQsYy1xR0cgrOa7hvzDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ArSGTT6E860Zq1Ldj9IL2cjaN18UyRRYriizwSpM8zik08NzK9PD/zoAN5xXBMDFd
	 rOteVXofdm0iwdHp1Vw8nykYp00V6ESn5y8zk4eAsFomNZuXpP5udwRLet/GZ6AxRt
	 HR2osz/PdXzUJoFmQISq5INCn6+M/OPj18F6S7gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392036AbfDXRgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392023AbfDXRgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:01 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC01218B0;
        Wed, 24 Apr 2019 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127361;
        bh=LupqdGEKvkxtPWLNBCqP6BnFQsYy1xR0cgrOa7hvzDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYmr8syA4uujiAuZ4f8fz1KHmMWT2sqhyb7y747I8bSXCV3fx5UWlOVSdXodydFQw
         qQQwZEAjl1vuyXzx54NLfdpIUPuvgodPojtar9wYiCNcPdweEtzBP9ruU10CRGL+EB
         uzQGD/KBg8gzOTR2DTUdkJT5uaMBie2tWRH+T6QU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.0 061/115] iio: Fix scan mask selection
Date:   Wed, 24 Apr 2019 19:09:57 +0200
Message-Id: <20190424170928.710466361@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

commit 20ea39ef9f2f911bd01c69519e7d69cfec79fde3 upstream.

The trialmask is expected to have all bits set to 0 after allocation.
Currently kmalloc_array() is used which does not zero the memory and so
random bits are set. This results in random channels being enabled when
they shouldn't. Replace kmalloc_array() with kcalloc() which has the same
interface but zeros the memory.

Note the fix is actually required earlier than the below fixes tag, but
will require a manual backport due to move from kmalloc to kmalloc_array.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes commit 057ac1acdfc4 ("iio: Use kmalloc_array() in iio_scan_mask_set()").
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/industrialio-buffer.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -320,9 +320,8 @@ static int iio_scan_mask_set(struct iio_
 	const unsigned long *mask;
 	unsigned long *trialmask;
 
-	trialmask = kmalloc_array(BITS_TO_LONGS(indio_dev->masklength),
-				  sizeof(*trialmask),
-				  GFP_KERNEL);
+	trialmask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
+			    sizeof(*trialmask), GFP_KERNEL);
 	if (trialmask == NULL)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {


