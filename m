Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B60C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD4620675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575484085;
	bh=JjkMZRxTwNONSFOYQHMxJzRrh51/ljojQTltNjp4x1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o0BV+QcHtAPjgZJHBtQSp09evX22nDUW29huC1bbTB8AbDqKHypw2hb60pBBbepky
	 dl7hsHY23wPdMVdVEQZRVKcpp5WWUflMyZCCu25Pzp52+mBoH75F0gUlBYN5JS2iAZ
	 EQU0bjuv2EWIIZ/g2Us+01hubt2v9v+RZr085csw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfLDS2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfLDR6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:58:03 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7555E2084F;
        Wed,  4 Dec 2019 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482282;
        bh=JjkMZRxTwNONSFOYQHMxJzRrh51/ljojQTltNjp4x1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPXrEkVcrl0+Dlo/NxE2GA0o+tWXaaaFbnuVAsABRRbn+Y0hA489Q2Gy5MVuTJjXN
         /fopYcwsrlEdS+31cpGhQs0M3tktTkYvr62arx29OEOUsD13u7/HOW7+McmOTch6qX
         qcYpbykPDoCvXuNkfMzpAe7/iYPa7KBvFEHPEM9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 24/92] ubi: Do not drop UBI device reference before using
Date:   Wed,  4 Dec 2019 18:49:24 +0100
Message-Id: <20191204174331.646682407@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit e542087701f09418702673631a908429feb3eae0 ]

The UBI device reference is dropped but then the device is used as a
parameter of ubi_err. The bug is introduced in changing ubi_err's
behavior. The old ubi_err does not require a UBI device as its first
parameter, but the new one does.

Fixes: 32608703310 ("UBI: Extend UBI layer debug/messaging capabilities")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/kapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index e844887732fbd..1db375caef71b 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -227,9 +227,9 @@ out_unlock:
 out_free:
 	kfree(desc);
 out_put_ubi:
-	ubi_put_device(ubi);
 	ubi_err(ubi, "cannot open device %d, volume %d, error %d",
 		ubi_num, vol_id, err);
+	ubi_put_device(ubi);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(ubi_open_volume);
-- 
2.20.1



