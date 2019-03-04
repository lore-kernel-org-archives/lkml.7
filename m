Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B74C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1002720863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCDHYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:24:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:54407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDHYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:24:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 23:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="scan'208";a="119387287"
Received: from hu.sh.intel.com ([10.239.158.51])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2019 23:23:58 -0800
From:   "Chen, Hu" <hu1.chen@intel.com>
Cc:     hu1.chen@intel.com, bo.he@intel.com, he@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] io: accel: kxcjk1013: restore the range after resume.
Date:   Mon,  4 Mar 2019 15:05:55 +0800
Message-Id: <20190304070556.24681-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303161728.3571869e@archlinux>
References: <20190303161728.3571869e@archlinux>
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
Changes in v2:
- Handle return value independently in resume callback.

 drivers/iio/accel/kxcjk-1013.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7096e577b23f..17837e26bcf2 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1437,6 +1437,11 @@ static int kxcjk1013_resume(struct device *dev)
 
 	mutex_lock(&data->mutex);
 	ret = kxcjk1013_set_mode(data, OPERATION);
+	if (ret < 0) {
+		mutex_unlock(&data->mutex);
+		return ret;
+	}
+	ret = kxcjk1013_set_range(data, data->range);
 	mutex_unlock(&data->mutex);
 
 	return ret;
-- 
2.20.1

