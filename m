Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10648C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E3521929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256695;
	bh=fZt6u4MprsXwIiQhhloL1FTJWJC+64ebKaRFWLUutWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CKYch7Wf8v66TUU+F9libOi8/QGzlFDbHMF3XZpKxHpDlnTxmjemSV7jQeSVRfiEr
	 bSb9fbs+zGxzyaO+XxWwr1miz6CDKl8L2QyGj1scUn4o2eYRTfGnryVlsJYvGkOQmE
	 LTA4cDz6rNIcR1ltMy+wQ3N+1d9KPCOYrBCGn6qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfCVMLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389170AbfCVML0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:11:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D932082C;
        Fri, 22 Mar 2019 12:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256686;
        bh=fZt6u4MprsXwIiQhhloL1FTJWJC+64ebKaRFWLUutWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2/oLh5egiZjQ5WM7qfKjpEh7I0+rDVfuf/Cu4YhgdLIxoTevYm0efO07tgADAh6y
         AnbHucvHqjGMFcAdUxfHwDg1qxuoi3Lx0QaF+2s0QlUDOaMYfsmFSKSUatlilVb2lx
         iVdsCO/0OfowsGrW82CDGu7vZtUOYEB8WxEYlO5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 270/280] drm/radeon/evergreen_cs: fix missing break in switch statement
Date:   Fri, 22 Mar 2019 12:17:03 +0100
Message-Id: <20190322111345.929829902@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit cc5034a5d293dd620484d1d836aa16c6764a1c8c upstream.

Add missing break statement in order to prevent the code from falling
through to case CB_TARGET_MASK.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/evergreen_cs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struc
 			return -EINVAL;
 		}
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
+		break;
 	case CB_TARGET_MASK:
 		track->cb_target_mask = radeon_get_ib_value(p, idx);
 		track->cb_dirty = true;


