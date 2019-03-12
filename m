Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B1DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E3421741
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411044;
	bh=j/8o4WqWo2dK3oCa+x2NGlCQmwLnp8cmyauhKvo2sBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HyyQDOfxtaal+tt08WUpuk1VXQvGiWRM2w7onxXpbi7mcz5Hlpz8f9qHMkggaYYPV
	 Y5UbHCuv0yEjhazIqBk+3TDNZ/B7gyCYfF8Mq5mPkqkvyiyxXBIZhP7MacZW221jAP
	 BYPGJV9KaC7FZrAb7h1FmFs8dWDXq1jMPTFeNfHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfCLRRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbfCLRQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:12 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4961821871;
        Tue, 12 Mar 2019 17:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410971;
        bh=j/8o4WqWo2dK3oCa+x2NGlCQmwLnp8cmyauhKvo2sBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwyQJn+mfk5aUggT35lKfrGFl6RB9msvdLOcI5XuKi4pdvdv73L+F2/L0cqrzYXVs
         T1VoZz1rzUG+3hdliKII3XvW5BOrSVw/yhxsmf80WF1Gh3o56p8jmkTyAHHDGyig8O
         KQ5tHojyKorwwZkh4k9gTlu0ET5wWavOtyJNiU28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 052/135] xtensa: SMP: fix ccount_timer_shutdown
Date:   Tue, 12 Mar 2019 10:08:19 -0700
Message-Id: <20190312170345.971398177@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4fe8713b873fc881284722ce4ac47995de7cf62c ]

ccount_timer_shutdown is called from the atomic context in the
secondary_start_kernel, resulting in the following BUG:

BUG: sleeping function called from invalid context
in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
Preemption disabled at:
  secondary_start_kernel+0xa1/0x130
Call Trace:
  ___might_sleep+0xe7/0xfc
  __might_sleep+0x41/0x44
  synchronize_irq+0x24/0x64
  disable_irq+0x11/0x14
  ccount_timer_shutdown+0x12/0x20
  clockevents_switch_state+0x82/0xb4
  clockevents_exchange_device+0x54/0x60
  tick_check_new_device+0x46/0x70
  clockevents_register_device+0x8c/0xc8
  clockevents_config_and_register+0x1d/0x2c
  local_timer_setup+0x75/0x7c
  secondary_start_kernel+0xb4/0x130
  should_never_return+0x32/0x35

Use disable_irq_nosync instead of disable_irq to avoid it.
This is safe because the ccount timer IRQ is per-CPU, and once IRQ is
masked the ISR will not be called.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index fd524a54d2ab..378186b5eb40 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -89,7 +89,7 @@ static int ccount_timer_shutdown(struct clock_event_device *evt)
 		container_of(evt, struct ccount_timer, evt);
 
 	if (timer->irq_enabled) {
-		disable_irq(evt->irq);
+		disable_irq_nosync(evt->irq);
 		timer->irq_enabled = 0;
 	}
 	return 0;
-- 
2.19.1



