Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FBEC31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BF7208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfFQM7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:59:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQM7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:59:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7aqD-1hi5Tv2z0v-007yoG; Mon, 17 Jun 2019 14:59:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: platform: add OF/APCI dependency
Date:   Mon, 17 Jun 2019 14:58:53 +0200
Message-Id: <20190617125908.1674177-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r/0hHafrBCppjYQNVu+1mD3eJ6YmngQjlW/+xUHtbAPKwuxS3Qx
 nZBCpWPQCl4eOcffBSVdqrI12pu0iPjKkoHlB6z8bV2mxMrKGes9t8wxdzX6ErODzNxdSY1
 +X9SaGzIjMa25+R5c69d/fft6lnZMot+O+VNYm29YO/0ZFy5RMUqQzQ1iFYatF48GmeLolv
 8NsK0dvpOumD8022xjHsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sN8TpRPEG88=:xqhx/AVla85jg89VvfExI5
 HuovXWfErDB6joo8/rCwqnViHA1Edahy7OdakVFAM1rJFEi9pPtH1TeaI76SfZ+GKyOfSjvlm
 oM+ernZo3JvwOhLi8sr3oUJ9QJCSCXinNs1FORjqWl/IeG9SZmjCh7Y/dyVWZ9wIR0eWB1Vfs
 3Jpm/34aEGzGRzEfbTtfTXccAndkIImMmBQE1hzDKzzYOkhGZwgRG+/EvMNFDQg+S1hRYNEah
 A1g0TNVzsiuzQgkgNh5LaqEmnnB732OzZif1kiVH20C7FDRjTvxRroSUV69FrZ+TH5a2VnntC
 lT2DlRjnjR998tC1CIP+5BRTFCKTiBYfXnEOYR5IXfyjAb9W1zKGriwacA+BzzJWkPOm8DjS8
 7mrjZ/QSQ2RFnwJBBcXJOtkihcwJtIfxJ9KC8jh+yMqgLyMmTEjKZhxBGZKVH3U+EAFHKXoeW
 4MICZtPsg6Ui2hZRrnqVn3k98GZzrzFx6BWyadPNgAN5PjkzRD0xd6AbNAa+DA6gkAyW2ucHc
 0pay8OJwotOa/roLwldvYYYliYA7H/XBQHmBM6sV4WsW9QIqm9RhfJHJaoyF/9us+NfiejG87
 w3AS3RPq+VVTB5eZk4xbb4/zh7PWc/3R3qvXODth3ydD+IKlMLNrkaCRVtx9WYKk2V7wwwBsB
 LAif0+Oje8ESKtUQ7oNLvvlVv3YFVlQIPhC2t41/uI73q/6JA5HQSehViqntrxK9HJqwHLYl6
 MAV2JQNWCt8QmwXCM+x4RveIgpSxBeBU9qfzTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When neither CONFIG_OF nor CONFIG_ACPI are set, we get a harmless
build warning:

drivers/hwtracing/coresight/coresight-platform.c:26:12: error: unused function 'coresight_alloc_conns'
      [-Werror,-Wunused-function]
static int coresight_alloc_conns(struct device *dev,
           ^
drivers/hwtracing/coresight/coresight-platform.c:46:1: error: unused function 'coresight_find_device_by_fwnode'
      [-Werror,-Wunused-function]
coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)

As the code is useless in that configuration anyway, just add
a Kconfig dependency that only allows building when at least
one of the two is set.

This should not hinder compile-testing, as CONFIG_OF can be
enabled on any architecture.

Fixes: ac0e232c12f0 ("coresight: platform: Use fwnode handle for device search")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwtracing/coresight/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 5487d4a1abc2..14638db4991d 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -4,6 +4,7 @@
 #
 menuconfig CORESIGHT
 	bool "CoreSight Tracing Support"
+	depends on OF || ACPI
 	select ARM_AMBA
 	select PERF_EVENTS
 	help
-- 
2.20.0

