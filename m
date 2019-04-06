Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B890DC282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 02:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAE22186A
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 02:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDFC4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 22:56:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbfDFC4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 22:56:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 587439124F4C6F9FB7EB;
        Sat,  6 Apr 2019 10:56:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sat, 6 Apr 2019 10:56:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: comedi: dyna_pci10xx: remove set but not used variables 'chan' and range'
Date:   Sat, 6 Apr 2019 03:07:49 +0000
Message-ID: <20190406030749.56659-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/comedi/drivers/dyna_pci10xx.c: In function 'dyna_pci10xx_insn_write_ao':
drivers/staging/comedi/drivers/dyna_pci10xx.c:109:21: warning:
 variable 'range' set but not used [-Wunused-but-set-variable]
  unsigned int chan, range;

drivers/staging/comedi/drivers/dyna_pci10xx.c:109:15: warning:
 variable 'chan' set but not used [-Wunused-but-set-variable]
  unsigned int chan, range;

They are never used since introduction in commit 16a7373a8e14 ("Staging:
comedi: add dyna_pci10xx driver")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/comedi/drivers/dyna_pci10xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dyna_pci10xx.c b/drivers/staging/comedi/drivers/dyna_pci10xx.c
index 9bdd5bf2eb99..d38bfc6113e8 100644
--- a/drivers/staging/comedi/drivers/dyna_pci10xx.c
+++ b/drivers/staging/comedi/drivers/dyna_pci10xx.c
@@ -106,10 +106,6 @@ static int dyna_pci10xx_insn_write_ao(struct comedi_device *dev,
 {
 	struct dyna_pci10xx_private *devpriv = dev->private;
 	int n;
-	unsigned int chan, range;
-
-	chan = CR_CHAN(insn->chanspec);
-	range = range_codes_pci1050_ai[CR_RANGE((insn->chanspec))];
 
 	mutex_lock(&devpriv->mutex);
 	for (n = 0; n < insn->n; n++) {





