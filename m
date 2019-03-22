Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356C8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBD621841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfCVPud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:50:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfCVPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:50:32 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mekzb-1gWvHE0xEr-00ajAd; Fri, 22 Mar 2019 16:49:41 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Lanqing Liu <lanqing.liu@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lanqing Liu <lanqing.liu@unisoc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 23/25] serial: sprd: clear timeout interrupt only rather than all interrupts
Date:   Fri, 22 Mar 2019 16:44:14 +0100
Message-Id: <20190322154425.3852517-24-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PsIPU5iB1xBa5v+WazbuNdzqA4mLLTpIT/uM/wir9xmBeICdEOl
 UCw4EkoxW5ya6R+rWhfhWa6CrpEV0UXiQ7ozxDNzguNZNFcrZ9IHmtjWiR+X3mChBqXh3sC
 yEr+wEbKBOpTsK6fFTziPo+iFeeJuFG6n3qDJTjMbOY48FkXw9WY3xKPxmFaSNChy8ONCkV
 FEGBZd6oxtzWbM5XUlrvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UYxcQTad6wk=:G49kiHoDPXJ0UQ2KyQlZlg
 pIjPzzLMgjXCJbwxZq43V0JrLrHOJ3csPyEAgynOvEa6ujyxBYxECg9K3ywNyJAmRB+86Msdo
 3rVYJmQ6H+rqukEri5p+pyTbvBmIZonsxEE46+kmWk2sCZLsKcDBn+3VCoUda7gdqbOWZao/4
 gCHj+To9b23s0fXXEym7mj1ufxl0edCObikCWOww8JUQZufQGeI+RVYsLcAej9OIRvAJSEisP
 d+KVXrpNbw+sw84krKa46QSZqDncqo0q/eaDQNv9ppQjbw0EVxuEX1wp9b7i1du6pCtUIe/2S
 MinfqZKzM1N4HpZOH7w8zoacAJ/q6QTxH+0epsrk8BKa+GOuqlLQXtj4A9/ZvJ0cWMytpP8OX
 IH2m+9M8PZzVuLTS9UldI/ZxOtJTZTUIDtQV1TpYZQmfAqizK1pOflm30JnlAJ+AvoaYWpYu5
 u7t8hwucKefny0KZYCYXuTBrdEeiK5pf3+o2l0T8WbHLTM89qn9BzosNvjYECoDEi6Ot2lsON
 U3q5N2Z5q5fNViLRYPD+knySm8te9de/W/FCatnzTbjcNA6SBKZToEqH8aqscstovAL/thoBE
 n6MCJYmmRG1yCXLSnDmzu/G/csUjpQr7blOlKLSImQkQWp0iL08wDe4r4L+cp2jzs1OLt6So6
 riGlPBmBWiR/qrIrurwss4gqsI2Q23ny3c2GDyzxpYgCG54vTAHjbREySL0DSb4tavKPezvAQ
 6ru4cLIoC76GiwcZZ7OS0zzAPNU7yLlxy4Sk6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

On Spreadtrum's serial device, nearly all of interrupts would be cleared
by hardware except timeout interrupt.  This patch removed the operation
of clearing all interrupt in irq handler, instead added an if statement
to check if the timeout interrupt is supposed to be cleared.

Wrongly clearing timeout interrupt would lead to uart data stay in rx
fifo, that means the driver cannot read them out anymore.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 4350782570b919f254c1e083261a21c19fcaee90)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/sprd_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 176f0a2bf9d9..c894eca57e73 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -63,6 +63,7 @@
 
 /* interrupt clear register */
 #define SPRD_ICLR		0x0014
+#define SPRD_ICLR_TIMEOUT	BIT(13)
 
 /* line control register */
 #define SPRD_LCR		0x0018
@@ -298,7 +299,8 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	serial_out(port, SPRD_ICLR, ~0);
+	if (ims & SPRD_IMSR_TIMEOUT)
+		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
 
 	if (ims & (SPRD_IMSR_RX_FIFO_FULL |
 		SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT))
-- 
2.20.0

