Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B98720657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254024;
	bh=XBuECskMGsfO6fRwTV0yotdIcshD/fxmv1C5umaLj7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kyq1k48sHuk8EDcE37kNygf4KATCiljzcOzKH5EImIqXvXcuOO+XUlSX/CwPSILfQ
	 QAkrJ+x3J+TTcwQ0kMzkc+t6SvEBhCOc7D5qIpUA1MlhV43Ec+oC61b05cvzk4ogjy
	 q4D4NIZM8y9jvh4dpkAVg2T5vElEIPyChBbAYvgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfCVL1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbfCVL07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:26:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA06B218A2;
        Fri, 22 Mar 2019 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254019;
        bh=XBuECskMGsfO6fRwTV0yotdIcshD/fxmv1C5umaLj7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZTVI8vfM0xpgXdWtNtCfK+r6Uvpcc02mAtBNEsCYBenj77ddVTsZky9KTpSp0Jge
         igowV7a65QJHK27PzpQbTYPVSAWdIyL07s+Aut6kVXlAGrWfBNck5UvloV09HhLBa1
         JyJ6juejaolgrOX9kWGuZFCr7tjDJDxFWlmChXwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3.18 134/134] drm/radeon/evergreen_cs: fix missing break in switch statement
Date:   Fri, 22 Mar 2019 12:15:47 +0100
Message-Id: <20190322111220.278514792@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1318,6 +1318,7 @@ static int evergreen_cs_check_reg(struct
 			return -EINVAL;
 		}
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
+		break;
 	case CB_TARGET_MASK:
 		track->cb_target_mask = radeon_get_ib_value(p, idx);
 		track->cb_dirty = true;


