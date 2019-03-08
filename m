Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C43C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E05D20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCHIxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:53:24 -0500
Received: from app1.whu.edu.cn ([202.114.64.88]:51704 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbfCHIxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:53:21 -0500
X-Greylist: delayed 2291 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 03:53:20 EST
Received: from localhost (unknown [114.255.3.133])
        by email1 (Coremail) with SMTP id AQBjCgAnKYyDJIJc8kGaAA--.47176S2;
        Fri, 08 Mar 2019 16:15:05 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] fs/epoll: remove an unnecessary argument of ep_busy_loop()
Date:   Fri,  8 Mar 2019 16:14:20 +0800
Message-Id: <20190308081420.18719-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgAnKYyDJIJc8kGaAA--.47176S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1ftw1UZFW8Wr1DXF1kZrb_yoW8Gw45pF
        4Utr1av3WxtFnrWFsxJF48Ww1agwn3Wa9rAr4jk39xCa1rtr1rJFnYyr15ZF43Gryvqryj
        va1jkFW3urW3AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjxR65UUUUU==
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ep_busy_loop() is called, timed_out is always zero,
otherwise ep_poll() would return first.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 fs/eventpoll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a5d219d920e7..0b3981ffc7ae 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -399,12 +399,12 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
  *
  * we must do our busy polling with irqs enabled
  */
-static void ep_busy_loop(struct eventpoll *ep, int nonblock)
+static void ep_busy_loop(struct eventpoll *ep)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 
 	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on())
-		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep);
+		napi_busy_loop(napi_id, ep_busy_loop_end, ep);
 }
 
 static inline void ep_reset_busy_poll_napi_id(struct eventpoll *ep)
@@ -451,7 +451,7 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 
 #else
 
-static inline void ep_busy_loop(struct eventpoll *ep, int nonblock)
+static inline void ep_busy_loop(struct eventpoll *ep)
 {
 }
 
@@ -1781,7 +1781,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 fetch_events:
 
 	if (!ep_events_available(ep))
-		ep_busy_loop(ep, timed_out);
+		ep_busy_loop(ep);
 
 	eavail = ep_events_available(ep);
 	if (eavail)
-- 
2.19.1

