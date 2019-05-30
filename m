Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B34FC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FF625919
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191138;
	bh=GwjazmCCMDLs4UDj2hm2Q+Zgfm4SPh7LP4nDmQvjz5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GXjO6gME+YDzhSWgNahwkkGw5ph6VaAL4eAYD/auDjNIEO9Q/82F6OYeb0I+agiLv
	 Ykwu2afgISqLrm9+q8VQzubNWEn9miZH2JH5r7ajVDLT6rGxrdvAzaUbqliSIRNltc
	 JLlPfYHlFKQnzPT+91PELgpQ1ijfnpQzjVlIs86s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbfE3Ei5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbfE3DMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:41 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCB323F4C;
        Thu, 30 May 2019 03:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185961;
        bh=GwjazmCCMDLs4UDj2hm2Q+Zgfm4SPh7LP4nDmQvjz5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqlFhrNMi5TYTJWhShZ18XB35tqbrIt/RH6e5j5nr6Nii2ziPS+iYSu1hQQmWXY2r
         I61ZfFVeD+zBvsc7j5S3ik3o1ioWEcmD+EYeTwMt+3Vgxm6zsRjuyDYZWVAUzw7Qal
         1T1S2mN5nHX6dD+9EjSGM0Sh4u4WXHyZYYNaQcO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 337/405] media: staging/intel-ipu3: mark PM function as __maybe_unused
Date:   Wed, 29 May 2019 20:05:35 -0700
Message-Id: <20190530030557.752739722@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 948dff7cfa1d7653e7828e7b905863bd24ca5c02 ]

The imgu_rpm_dummy_cb() looks like an API misuse that is explained
in the comment above it. Aside from that, it also causes a warning
when power management support is disabled:

drivers/staging/media/ipu3/ipu3.c:794:12: error: 'imgu_rpm_dummy_cb' defined but not used [-Werror=unused-function]

The warning is at least easy to fix by marking the function as
__maybe_unused.

Fixes: 7fc7af649ca7 ("media: staging/intel-ipu3: Add imgu top level pci device driver")

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/ipu3/ipu3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
index d575ac78c8f0b..d00d26264c37d 100644
--- a/drivers/staging/media/ipu3/ipu3.c
+++ b/drivers/staging/media/ipu3/ipu3.c
@@ -791,7 +791,7 @@ static int __maybe_unused imgu_resume(struct device *dev)
  * PCI rpm framework checks the existence of driver rpm callbacks.
  * Place a dummy callback here to avoid rpm going into error state.
  */
-static int imgu_rpm_dummy_cb(struct device *dev)
+static __maybe_unused int imgu_rpm_dummy_cb(struct device *dev)
 {
 	return 0;
 }
-- 
2.20.1



