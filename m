Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B45C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CF520663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCDTnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:43:21 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCDTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:43:21 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MORN0-1gc2oN3miE-00Pvyq; Mon, 04 Mar 2019 20:43:17 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacob Feder <jacobsfeder@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: add CONFIG_OF dependency
Date:   Mon,  4 Mar 2019 20:43:00 +0100
Message-Id: <20190304194316.774357-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oQnlbuE8DelHdt4nRR5Z+kTBsGh3+P92CbFtPbkNQZOKou77+ZV
 9PVRqWQC54YRAsVluZlEFAUemiMf13GckaJkjjxsKtgRXmgUHQU1u9Hpq4kkxdoxXsgWsP5
 cKstoyxX/LNn0L66xuGq81cVxDyRb+7o0lRDVbKKxPpdoncPyFnfZ8p86u/pweA8a5G30hf
 3XxP5ZDVLnnl1oEsmVjjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Do+Y4yrH4SY=:/vC8uBY1XfQo8goTempual
 6tMD0zMXz+xZRngUIyAj2t7fL9zA1gc61Zz/HPinJcyZKqdGYAPtT86w0yKySMYrY4VyU7TJG
 rjvqt/u3aDe9iMgPbEKbI8PXUtXCKGv2Jn2Sryjou75nKFf7v69j6PuwGbJCf4szH7dAZkUiR
 AdzOwXdjInUlaseCUITxHZ4x8e4zsZVGPh2o5Kv5Ja7xvTaBdvxRZCObS/lx4HqlR1n2JShtE
 RDj8z4JEFktxWFekVp8GZ9GuckJK8VT9E8891gUiFA8vUTE1aFczJhZxuCyi7jClyEXRcXuaa
 xNpEWWBsxmdvoodn6xXUc4Bi/k3dgBKOxrHoUfpiLHTeIZZgZhNSa+aVjKo2h5puBawYJHsYS
 iU3Jrm+vlU3SqSozpE0WiAYrrHoIjzA/vqjVj46P4sYOHq8D0KkPNpUx7WHzmTcXBmG5ayVht
 A3pXXQLdzqr6t0fP+PO7z2mrsOQQXMUzhr2IA1bDWFLxelcoEFMQe8hWkohsJ7GoU0j4s3lQa
 trJ4N1gb1q002y/zMCX8yjO/MnHfH473eHJYHMR5qB4UWT1NHwxbTrB0Dsf6daKVS1bncVtSq
 z5ZgR8XgWmELOdUE7d3mtmi2IR0jo5rT5QQx1k7UjfGLJG4k8lK3tN5g/C2LEdFWlNRmlWFwa
 ksw21b5vlcZ8ZdhbzDexw0A1rF9OF85Y3rW9YVjfC0X65hJGO6G1SO2Zktnte2ch1wBqSMu61
 uZK0tZN6EwBstaic6ZhdDVUuDssLIuSCtpLUGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building without CONFIG_OF, the compiler loses track of the flow
control in axis_fifo_probe(), and thinks that many variables are used
without an initialization even though we actually leave the function
before the first use:

drivers/staging/axis-fifo/axis-fifo.c: In function 'axis_fifo_probe':
drivers/staging/axis-fifo/axis-fifo.c:900:5: error: 'rxd_tdata_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (rxd_tdata_width != 32) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:907:5: error: 'txd_tdata_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (txd_tdata_width != 32) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:914:5: error: 'has_tdest' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (has_tdest) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:919:5: error: 'has_tid' may be used uninitialized in this function [-Werror=maybe-uninitialized]

When CONFIG_OF is set, this does not happen, and since the driver cannot
work without it, just add that option as a Kconfig dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/axis-fifo/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/axis-fifo/Kconfig b/drivers/staging/axis-fifo/Kconfig
index 687537203d9c..d9725888af6f 100644
--- a/drivers/staging/axis-fifo/Kconfig
+++ b/drivers/staging/axis-fifo/Kconfig
@@ -3,6 +3,7 @@
 #
 config XIL_AXIS_FIFO
 	tristate "Xilinx AXI-Stream FIFO IP core driver"
+	depends on OF
 	default n
 	help
 	  This adds support for the Xilinx AXI-Stream
-- 
2.20.0

