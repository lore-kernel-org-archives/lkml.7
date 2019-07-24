Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F53C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1102054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000359;
	bh=pJA0dcm5ZHMDCaDP8sQtXRZlZVJ0fE0QiDNBOeUdFEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F1FShybi3EcgiuWmH/hmmCBPxymTwp97tlGIjxLVo+wp5otrsEtBUFmmsmhdEMePa
	 ifFWvejhaL5pXDJa1X02Hew9q1j94op+Kl+ePIa62ZdX03nCC/jTg56Pome5CIMvob
	 pVvapUSFkHhB5NZzL+7xmpnxvXL6sc4EECCuCn/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfGXUch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfGXT2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:28:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B70229F4;
        Wed, 24 Jul 2019 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996522;
        bh=pJA0dcm5ZHMDCaDP8sQtXRZlZVJ0fE0QiDNBOeUdFEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqs/86D00m79MY/EcIkUn6px0LsuiYP8BxWJ4AI+ztOsnUURbi1FXI+/Ux9R/3dxW
         ipMqr+Kn3mvEbNu9CVPk1NiAzcZuTmZS4PsfZuRgDCgLrxendu7iMrIbptHD8ZCRv2
         9f4/cScb4V5Sr1uGMLKJkdDEoTQIXa8DYoDgG77c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 075/413] RAS/CEC: Fix pfn insertion
Date:   Wed, 24 Jul 2019 21:16:06 +0200
Message-Id: <20190724191740.470997080@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6d8e294bf5f0e85c34e8b14b064e2965f53f38b0 ]

When inserting random PFNs for debugging the CEC through
(debugfs)/ras/cec/pfn, depending on the return value of pfn_set(),
multiple values get inserted per a single write.

That is because simple_attr_write() interprets a retval of 0 as
success and claims the whole input. However, pfn_set() returns the
cec_add_elem() value, which, if > 0 and smaller than the whole input
length, makes glibc continue issuing the write syscall until there's
input left:

  pfn_set
  simple_attr_write
  debugfs_attr_write
  full_proxy_write
  vfs_write
  ksys_write
  do_syscall_64
  entry_SYSCALL_64_after_hwframe

leading to those repeated calls.

Return 0 to fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ras/cec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 673f8a128397..f5795adc5a6e 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -369,7 +369,9 @@ static int pfn_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
 
-	return cec_add_elem(val);
+	cec_add_elem(val);
+
+	return 0;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, u64_get, pfn_set, "0x%llx\n");
-- 
2.20.1



