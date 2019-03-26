Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDE8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D50A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581945;
	bh=/i3rSP7nZxgFxoyoBMCaPxxD6AYjPn5K7aKOhYFgnkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=khAaeLo0/ltNxflYC0WCVUWr5FGfy8KvpZNWMs+yMjky6sj7fLccNF29v46yQBQjz
	 bziFw+XfA9RoCQ2QZJeoklkaB+ttU2BZ3ulsiqlBjEBl/fZi34fx/mhUoBVAPYygGJ
	 vEBxWsB9CHmxnHVEJeyKttUW2XbwxuES456Evm/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfCZGcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731406AbfCZGcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:20 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2D020823;
        Tue, 26 Mar 2019 06:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581939;
        bh=/i3rSP7nZxgFxoyoBMCaPxxD6AYjPn5K7aKOhYFgnkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZQQEfSpP8c/Tn9/q5ncz2N3gsaTVFJ1508UwVT6LLkY6qm3Es9Si988jicU0ynDj
         XGoyG+HrzIe0ayQqiCrhDA7ZkkTu/x1B2LVvVWVa0/ccruVJW7eJ0APVRLr6E9xErm
         MyXaFuugEfYO7ieWX7QeAmd/VaHrV3xeedY0HaAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 30/30] ath10k: avoid possible string overflow
Date:   Tue, 26 Mar 2019 15:30:09 +0900
Message-Id: <20190326042608.571293448@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4277,7 +4277,7 @@ static void ath10k_tpc_config_disp_table
 							    rate_code[i],
 							    type);
 			snprintf(buff, sizeof(buff), "%8d ", tpc[j]);
-			strncat(tpc_value, buff, strlen(buff));
+			strlcat(tpc_value, buff, sizeof(tpc_value));
 		}
 		tpc_stats->tpc_table[type].pream_idx[i] = pream_idx;
 		tpc_stats->tpc_table[type].rate_code[i] = rate_code[i];


