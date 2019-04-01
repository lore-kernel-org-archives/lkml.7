Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE5920830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140970;
	bh=rEjGZ3diTpwT7/5FEQcwt4dWPkrVT0G1vtoKgymMUNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MvK+kCQBsTHDc4nNdQ0htErRQ1tozcw/nm4ffUYsniDGN4dI57FRZHovbN9Gt+sS+
	 5Qzo4oWKJ14t00R6OBU+LV2Dyif90rsfFxI/C6p3868/YWmSZXI6UbmrHsdyovnBAn
	 4lapu2FG0FkrFGymDFjJLFcXyCNxgnkZlCaNz4X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbfDARaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733021AbfDAR37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C4320856;
        Mon,  1 Apr 2019 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139798;
        bh=rEjGZ3diTpwT7/5FEQcwt4dWPkrVT0G1vtoKgymMUNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ykbRffrIbwWiQla/ysc6pnisRD5hLdiN6t6iUKq+NPo+gnUIZSuodEen86I6UcCWQ
         YxdsbonXqBNXwrdohMtpVNzfcwEpe+hBQW2wUdq71S9eNquYAT55d+As0lWQqzmqzo
         skQK1Tkr92aJTk4DbNQ4hUIiNmhHtplBwVSJjCe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 018/131] mmc: sanitize bus width in debug output
Date:   Mon,  1 Apr 2019 19:01:28 +0200
Message-Id: <20190401170053.508878566@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ed9feec72fc1fa194ebfdb79e14561b35decce63 upstream.

The bus width is sometimes the actual bus width, and sometimes indices
to different arrays encoding the bus width. In my debugging case "2"
could mean 8-bit as well as 4-bit, which was extremly confusing. Let's
use the human-readable actual bus width in all places.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/core.c |    2 +-
 drivers/mmc/core/mmc.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1039,7 +1039,7 @@ static inline void mmc_set_ios(struct mm
 		"width %u timing %u\n",
 		 mmc_hostname(host), ios->clock, ios->bus_mode,
 		 ios->power_mode, ios->chip_select, ios->vdd,
-		 ios->bus_width, ios->timing);
+		 1 << ios->bus_width, ios->timing);
 
 	host->ops->set_ios(host, ios);
 }
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -952,7 +952,7 @@ static int mmc_select_bus_width(struct m
 			break;
 		} else {
 			pr_warn("%s: switch to bus width %d failed\n",
-				mmc_hostname(host), ext_csd_bits[idx]);
+				mmc_hostname(host), 1 << bus_width);
 		}
 	}
 


