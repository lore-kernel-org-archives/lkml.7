Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D41C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B0420866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582119;
	bh=LTRSSPUv7S4MNjBZrPFVvzhGW3NhPxuMDC/u8pKVC3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lisaLk5PhUh/TgAjCGthyVKvmcsREY1mAI7qVyB5poD0RRuDQEi6ITlYkOz72qbys
	 TCgKccPtb7WG1EjpQSCtn3G7tdIfl74oaZbZX2pCReiiqgKszUT5YbBUVoDxa7uK9B
	 QYKbbezANTPTvgEi2B9CTnQ4+vIocelEDRAeGuQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfCZGfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731383AbfCZGfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:16 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D9220866;
        Tue, 26 Mar 2019 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582116;
        bh=LTRSSPUv7S4MNjBZrPFVvzhGW3NhPxuMDC/u8pKVC3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9RD4JSrYEYg6vuWah89RZk0k5qrkMhqCa+rVins/xmVuJ5PotVcxRzLWtPI651om
         vAH/rqRpD1Qt2Koqx5UO2pWrq4X6CBUcQWPAnEC1Y4Lmp1xpq5DA6xuzrYd8Mc+7hh
         P6pCRdc2DoQ50WtmOZhFsOQfmDEDqJupcKdfYl8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 41/41] ath10k: avoid possible string overflow
Date:   Tue, 26 Mar 2019 15:30:18 +0900
Message-Id: <20190326042652.119179406@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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
@@ -4309,7 +4309,7 @@ static void ath10k_tpc_config_disp_table
 							    rate_code[i],
 							    type);
 			snprintf(buff, sizeof(buff), "%8d ", tpc[j]);
-			strncat(tpc_value, buff, strlen(buff));
+			strlcat(tpc_value, buff, sizeof(tpc_value));
 		}
 		tpc_stats->tpc_table[type].pream_idx[i] = pream_idx;
 		tpc_stats->tpc_table[type].rate_code[i] = rate_code[i];


