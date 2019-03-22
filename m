Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C436C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DA12183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfCVPrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:47:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfCVPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:47:31 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MvJwN-1gpguc31aT-00rIeJ; Fri, 22 Mar 2019 16:47:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 13/25] extcon: usb-gpio: Don't miss event during suspend/resume
Date:   Fri, 22 Mar 2019 16:44:04 +0100
Message-Id: <20190322154425.3852517-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DTY19u7ixviVkwcIrPn8cBZZRnu8fU/loRhzQrdCkzn+qRXeCdU
 GmNu3KUD74TsqT53s5yUyjULtO8m0P9eqUICwpICc4tTzMIBU/SaRAYF41fYozL5wVHIRpm
 xKjot+/B9QoZCtaaGrxZMCjUBH186LDVwdPg5CSuL9DFhX8X2SPSvko5uAx5gV0P9YIrNl6
 xF3e4BhB7jBXoaUh6B/jA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MYBvXZ7PdYM=:NffINcQs07xaEGqDq5dHHD
 1rR676+OBVxd3M43p4jdluDJ1eNb2C6ORVxrK3BHuAkusTGK1uzjZjyoD2v/OLWAtTaFWT0y+
 /sfbTuOLpe8aXuQI6cqZ0wWmdqzMFxu+yTsqgXdYpYlwLq6sFHkIhuGp/7wJe9ZiOk3LiXQSP
 rsul4fah9j/EaxbGRzNItcfu2I8RwmGsTTKeKCgo6dOJ/U4W+oLjeoAyGeUA/0kiTRS7iXS06
 4lutrXHknx57+b7+KtxmF2C3GBQP0RO89klRSAdapLK9ZzpjcSBBzkiITJSTVzhRI2v12g+FX
 prfGUWAVzxlvHqRv27Y5mLWdRwVCbevU3EcH4speV5sEZ04RUzy66AE0zhxKx4TPZmetx4m6D
 CBnhkq2Qh08FMBrAGs0LylfDHC3U/x0qGydKTc2mcIquFQFZm9y1e5Kj+RGKW6lUyjURL/TKE
 mg2wMJhZBtCQzHNjydT5onG6OFM2KCdSc+zMIA0d81/aFapZHpX5tMdX+/VXJJhtGLrcfHwom
 TNR2XB2SAR64CZ6WIUt29O/+X0lhiKJp2m1XHVv0h47FyaKJD/1rybLK2LHoLnf+q32aVwnvg
 FAcaQ6MGX5XriN43//M/WaMcuFaEi3QkEyQtIZcjyklU7NmTi2EoCVKn1f/v1Y1rvRC3Lq00R
 oUSeoUl4yuMLKiQ+caynE4v6ym4JVseFIhEf1Rc8FHwOB+DszBLGlHUrmbIt8oYYxKw19NDaa
 dW/H/sE77Fq5Vb3ZVvN3SgDxTffTf+KMqWoNMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

Pin state might have changed during suspend/resume while
our interrupts were disabled and if device doesn't support wakeup.

Scan for change during resume for such case.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
(cherry picked from commit 04c080080855ce84dcd490a2e04805608a21085d)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/extcon/extcon-usb-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index 2b2fecffb1ad..c6a7c9ddf0ac 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -192,6 +192,9 @@ static int usb_extcon_resume(struct device *dev)
 	}
 
 	enable_irq(info->id_irq);
+	if (!device_may_wakeup(dev))
+		queue_delayed_work(system_power_efficient_wq,
+				   &info->wq_detcable, 0);
 
 	return ret;
 }
-- 
2.20.0

