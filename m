Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92094C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C6A20659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402177;
	bh=mxhUM6dznwCbEYf2MdC2HmPJxop9xoKCA3IDiJPMupA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R/kuahIeTpA7fKNVVLZ/IEF2XaMfh4i6Yyu10TdambZ3FmS4qIiYiaMiuvkRkXxbV
	 d2fVmqM5El8fjzDA/6DcgwgHPTm9jDchPDo8ALlOjZA7Vwe7EqYvNsLyTP9KGTVMvJ
	 yxRBUQMkFfG0c07eiiH8xjJAdzjEQE/fnMIlwgro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfKVF4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfKVF4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:56:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081032071F;
        Fri, 22 Nov 2019 05:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402169;
        bh=mxhUM6dznwCbEYf2MdC2HmPJxop9xoKCA3IDiJPMupA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXqhXtIirzvgsGJIMpjRIVYs88UKPXKVYAV/EmN44HKQJK7jewAl0x7TYvczXeJhr
         FbU10ivPC2taruhWhT4pOeemtNo/yNEYgH1uiSRoNfbZ2DvVOUgupnXai0jUINhuTV
         1Wowz76+1GTVJ4SAcO/d0NPy7NhA3NWL6N80eXu0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 022/127] ubi: Do not drop UBI device reference before using
Date:   Fri, 22 Nov 2019 00:54:00 -0500
Message-Id: <20191122055544.3299-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index d4b2e87444986..c2cf6bd3c162a 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -227,9 +227,9 @@ struct ubi_volume_desc *ubi_open_volume(int ubi_num, int vol_id, int mode)
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

