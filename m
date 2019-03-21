Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785EC21971
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCUWAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:00:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:15205 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfCUWAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="153968190"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 87C9330214C; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, helen.koike@collabora.com,
        snitzer@redhat.com, wad@chromium.org, keescook@chromium.org,
        enric.balletbo@collabora.com
Subject: [PATCH 17/17] dm: Fix const confusion in dm
Date:   Thu, 21 Mar 2019 15:00:09 -0700
Message-Id: <20190321220009.29334-18-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

A non const pointer to const cannot be marked initconst.
Mark the array actually const.

Cc: helen.koike@collabora.com
Cc: snitzer@redhat.com
Cc: wad@chromium.org
Cc: keescook@chromium.org
Cc: enric.balletbo@collabora.com
Fixes: 6bbc923dfcf5 dm: add support to directly boot to a mapped device
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/md/dm-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index b53f30f16b4d..4b76f84424c3 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -36,7 +36,7 @@ struct dm_device {
 	struct list_head list;
 };
 
-const char *dm_allowed_targets[] __initconst = {
+const char * const dm_allowed_targets[] __initconst = {
 	"crypt",
 	"delay",
 	"linear",
-- 
2.20.1

