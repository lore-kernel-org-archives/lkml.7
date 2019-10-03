Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B462C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6251D20867
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119973;
	bh=dFcVQl6E0c+wU1d5wfNevRmUe9k+SvO0hOvFIQK6V7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aH9/iZDmNH9GwrFiiVPneSB2MHBHWOYS3cAHRoM5L6Hrsa/1IZ7dQfKNNEwM+mHiS
	 zl+GG7HzuU56ZMk5o7aXffpPKlFAY8ZrpqZSp72ZTvNKN7taAMcmcsL7ipzUuG65Q5
	 VCLihT9fkDBQyQ8PMpBDnhHaotQOX00uzHMzvU3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391035AbfJCQ0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391000AbfJCQ0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:26:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A933222CD;
        Thu,  3 Oct 2019 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119961;
        bh=dFcVQl6E0c+wU1d5wfNevRmUe9k+SvO0hOvFIQK6V7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuFBqs+pLET0XO1N1HJhhHJXdG9ZeMPMYGzRtrJoCA98ogxrPiJO8fiLXMBeizpm6
         RKNpaRj7B8zwTg8oxL4lFsm77HI+uTjbonnlnl+dDJc51iwdNEK4n5gxUcD5/Tf7Gt
         kUobC/e2cCHGOy+9EmHr477cqr1SN4xBjrtkfGeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 046/313] ASoC: SOF: pci: mark last_busy value at runtime PM init
Date:   Thu,  3 Oct 2019 17:50:24 +0200
Message-Id: <20191003154537.681403696@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Xiuli <xiuli.pan@linux.intel.com>

[ Upstream commit f1b1b9b136827915624136624ff54aba5890a15b ]

If last_busy value is not set at runtime PM enable, the device will be
suspend immediately after usage counter is 0. Set the last_busy value to
make sure delay is working at first boot up.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/sof-pci-dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index b778dffb2d25c..49daf1390dac0 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -203,6 +203,9 @@ static void sof_pci_probe_complete(struct device *dev)
 	 */
 	pm_runtime_allow(dev);
 
+	/* mark last_busy for pm_runtime to make sure not suspend immediately */
+	pm_runtime_mark_last_busy(dev);
+
 	/* follow recommendation in pci-driver.c to decrement usage counter */
 	pm_runtime_put_noidle(dev);
 }
-- 
2.20.1



