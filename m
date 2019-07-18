Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1478BC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFFA21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419246;
	bh=ej18VNWinyrKMWEU+mxAT/c7G+nIfeAfdwON843YUsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jLpxtMb18Y939Bs1iieNtqPpQ0pFVFT9kTRGz8RfG3daepxaHcuHgDWDuk/6GBmdL
	 neKhATqVUVJJJtUjUSn4rPYANRD1Y2uAqKOflw2GRrwETLANcYimuijHb5iKKyHSuI
	 9gqQrplouQqPvdYMhhcbFkzi1QPGOhip2U7tb6EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390432AbfGRDHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390400AbfGRDHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:07:19 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5856121849;
        Thu, 18 Jul 2019 03:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419238;
        bh=ej18VNWinyrKMWEU+mxAT/c7G+nIfeAfdwON843YUsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2X+wDv9dG9o/fgndBvQBJGm9ELRKxH6CcTPEoy1IMU+nWPbLdHS4RN69Rp71AmuYx
         Rt+1qNpCHMrC7lJRjlHaY3iTyH5jGmf96rsZV81x2iaGFF7irpBxHFYrsufmZfctpr
         ht/TjxUkxQJ7nlrlCQP38E/LN2alkILmV8tsgkuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/47] efi/bgrt: Drop BGRT status field reserved bits check
Date:   Thu, 18 Jul 2019 12:01:23 +0900
Message-Id: <20190718030049.364224408@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a483fcab38b43fb34a7f12ab1daadd3907f150e2 ]

Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
reserved. These bits are now used to indicate if the image needs to be
rotated before being displayed.

The first device using these bits has now shown up (the GPD MicroPC) and
the reserved bits check causes us to reject the valid BGRT table on this
device.

Rather then changing the reserved bits check, allowing only the 2 new bits,
instead just completely remove it so that we do not end up with a similar
problem when more bits are added in the future.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/efi-bgrt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index b22ccfb0c991..2bf4d31f4967 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -50,11 +50,6 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 		       bgrt->version);
 		goto out;
 	}
-	if (bgrt->status & 0xfe) {
-		pr_notice("Ignoring BGRT: reserved status bits are non-zero %u\n",
-		       bgrt->status);
-		goto out;
-	}
 	if (bgrt->image_type != 0) {
 		pr_notice("Ignoring BGRT: invalid image type %u (expected 0)\n",
 		       bgrt->image_type);
-- 
2.20.1



