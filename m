Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322CCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0605620828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012793;
	bh=ForF08Nmv+/fRCvlgZGiU/ze2U4OXlse6twfxuvrWBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2FPMXL7SYa6CdJiSLzHDmqiJURrP67BKvhuKROkeyUYR/8LtQf/68mvwPKFIGWEk+
	 5uGMPM3MxbUaZlnV/A785sFegIlon0w9QnFPIKZuU+d9WPvN+D+XEDbn3eayGkfwsB
	 JV+oHB4LAQ1wMyMuMLkh68izyCvszuyh2EHZLoGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfLJVTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfLJVMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:12:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B09246A2;
        Tue, 10 Dec 2019 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012339;
        bh=ForF08Nmv+/fRCvlgZGiU/ze2U4OXlse6twfxuvrWBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxIT0OItVw7BWj+wBJkNIJbD+VyB6BQJatRuL8HBL0gNx8CBWzISA0PRTgzwWyP5q
         gh2mn6EhH8LlnWPTkuimw0AE9Z9ZE5fKndSz6EQCr3jgWVBjVLqwT/5QAkNQyTjI/1
         ukTAg7szvCrXtzWYmBe7VGJGLst9KoGLI7ENtkOI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 270/350] net: dsa: sja1105: Disallow management xmit during switch reset
Date:   Tue, 10 Dec 2019 16:06:15 -0500
Message-Id: <20191210210735.9077-231-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit af580ae2dcb250719857b4b7024bd4bb0c2e05fb ]

The purpose here is to avoid ptp4l fail due to this condition:

  timed out while polling for tx timestamp
  increasing tx_timestamp_timeout may correct this issue, but it is likely caused by a driver bug
  port 1: send peer delay request failed

So either reset the switch before the management frame was sent, or
after it was timestamped as well, but not in the middle.

The condition may arise either due to a true timeout (i.e. because
re-uploading the static config takes time), or due to the TX timestamp
actually getting lost due to reset. For the former we can increase
tx_timestamp_timeout in userspace, for the latter we need this patch.

Locking all traffic during switch reset does not make sense at all,
though. Forcing all CPU-originated traffic to potentially block waiting
for a sleepable context to send > 800 bytes over SPI is not a good idea.
Flows that are autonomously forwarded by the switch will get dropped
anyway during switch reset no matter what. So just let all other
CPU-originated traffic be dropped as well.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index aa140662c7c20..4e5a428ab1a4c 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1389,6 +1389,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv)
 	int speed_mbps[SJA1105_NUM_PORTS];
 	int rc, i;
 
+	mutex_lock(&priv->mgmt_lock);
+
 	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
 
 	/* Back up the dynamic link speed changed by sja1105_adjust_port_config
@@ -1420,6 +1422,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv)
 			goto out;
 	}
 out:
+	mutex_unlock(&priv->mgmt_lock);
+
 	return rc;
 }
 
-- 
2.20.1

