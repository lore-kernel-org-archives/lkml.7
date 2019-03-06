Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E45C10F09
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669CA20842
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfCFCub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:50:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:47833 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfCFCub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:50:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 18:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,446,1544515200"; 
   d="scan'208";a="149634712"
Received: from hu.sh.intel.com ([10.239.158.51])
  by fmsmga004.fm.intel.com with ESMTP; 05 Mar 2019 18:50:27 -0800
From:   "Chen, Hu" <hu1.chen@intel.com>
Cc:     hu1.chen@intel.com, bo.he@intel.com, he@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] io: accel: kxcjk1013: restore the range after resume.
Date:   Wed,  6 Mar 2019 10:32:20 +0800
Message-Id: <20190306023224.23695-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <23ced5ac-b0a0-7d87-76d7-bdec0c3e0e15@redhat.com>
References: <23ced5ac-b0a0-7d87-76d7-bdec0c3e0e15@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "he, bo" <bo.he@intel.com>

On some laptops, kxcjk1013 is powered off when system enters S3. We need
restore the range regiter during resume. Otherwise, the sensor doesn't
work properly after S3.

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: Chen, Hu <hu1.chen@intel.com>
---
 v3: Avoid unnecessary mutex_unlock (Hans).
 v2: Handle return value independently (Jonathan).

 drivers/iio/accel/kxcjk-1013.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7096e577b23f..50f3ff386bea 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1437,6 +1437,8 @@ static int kxcjk1013_resume(struct device *dev)
 
 	mutex_lock(&data->mutex);
 	ret = kxcjk1013_set_mode(data, OPERATION);
+	if (ret == 0)
+		ret = kxcjk1013_set_range(data, data->range);
 	mutex_unlock(&data->mutex);
 
 	return ret;
-- 
2.20.1

