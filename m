Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB3BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD7E22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfHUPu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:50:29 -0400
Received: from ox4u.de ([212.118.221.216]:35641 "EHLO s1.ox4u.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfHUPu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:50:29 -0400
Received: by s1.ox4u.de (Postfix, from userid 65534)
        id A8754260130; Wed, 21 Aug 2019 17:50:27 +0200 (CEST)
Received: from ws-140106.systec.local (unknown [212.185.67.146])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by s1.ox4u.de (Postfix) with ESMTPSA id 12026260114;
        Wed, 21 Aug 2019 17:50:27 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iio: core: Fix fractional format generation
Date:   Wed, 21 Aug 2019 17:50:23 +0200
Message-Id: <20190821155023.6333-1-alexander.stein@systec-electronic.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the result is -0.3252 tmp0 is 0 after the div_s64_rem, so tmp0 is
non-negative which results in an output of 0.3252.
Fix this by explicitly handling the negative sign ourselves.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/iio/industrialio-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 245b5844028d..18350c1959ae 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -568,6 +568,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 {
 	unsigned long long tmp;
 	int tmp0, tmp1;
+	const char *sign = vals[0] < 0 ? "-" : "";
 	bool scale_db = false;
 
 	switch (type) {
@@ -593,11 +594,11 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp1 = vals[1];
 		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
-		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
-		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
-- 
2.23.0

