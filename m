Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEFD20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139874;
	bh=Frl8uVjT/vnM9piadZCdYglK9FbhmLgZwTrBWgAr7Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=raEFR5zkEEGACRhEP+yRgjmxKvyJuv5VCSR7er0YrOieCgMhRQDKukIhKkd8xARoJ
	 Ho+lV5xAHHYbIJbJbGDPtA/vGMKM5PJ0nQxlVJxbo+UbDsYbs6t5QmifElVdu0Kd8W
	 u+ZZETL1y31hyhaM8xyqf9Vy+Bcmy6LmieO3SxPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbfDARbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732807AbfDARbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A1620830;
        Mon,  1 Apr 2019 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139870;
        bh=Frl8uVjT/vnM9piadZCdYglK9FbhmLgZwTrBWgAr7Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOriPE/jq8m/T2vUyvvOW6axLjfh1JpOTfuuSSB97C6iMYsrrtI2m/1v5FP3cZwA8
         II+tlf+SvA95/2oAm7p6mqlfgxFtWdvod5Yd6PtUI4ZCpTCIsE+e/bX2QQWkXP/aqI
         9lW7OceFxFETNa63CIkjtTivM1IpdAP656yqaOvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 037/131] ath10k: avoid possible string overflow
Date:   Mon,  1 Apr 2019 19:01:47 +0200
Message-Id: <20190401170055.368280653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 6707ba0105a2d350710bc0a537a98f49eb4b895d upstream.

The way that 'strncat' is used here raised a warning in gcc-8:

drivers/net/wireless/ath/ath10k/wmi.c: In function 'ath10k_wmi_tpc_stats_final_disp_tables':
drivers/net/wireless/ath/ath10k/wmi.c:4649:4: error: 'strncat' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]

Effectively, this is simply a strcat() but the use of strncat() suggests
some form of overflow check. Regardless of whether this might actually
overflow, using strlcat() instead of strncat() avoids the warning and
makes the code more robust.

Fixes: bc64d05220f3 ("ath10k: debugfs support to get final TPC stats for 10.4 variants")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/wmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -4065,7 +4065,7 @@ static void ath10k_tpc_config_disp_table
 							    rate_code[i],
 							    type);
 			snprintf(buff, sizeof(buff), "%8d ", tpc[j]);
-			strncat(tpc_value, buff, strlen(buff));
+			strlcat(tpc_value, buff, sizeof(tpc_value));
 		}
 		tpc_stats->tpc_table[type].pream_idx[i] = pream_idx;
 		tpc_stats->tpc_table[type].rate_code[i] = rate_code[i];


