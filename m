Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49637C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EC2206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642385;
	bh=irBTXJO5M41OcAwgoz9Wl6r8hqKKns6HU2jay+CD41M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OUXY7RtZfVpuESO5ofaGH9iwjiHY63FL6ZjMgODh0vNL20U76HBYdZgBWuL6Ysg0T
	 mWVeSsQ2jvJ7cBbcmc2CYrTK5MAxUHEwmLZl+I1Nxc5fDLCk5WP+bwdSrIJtkNkk76
	 GY3i+w78pdWqf9UQHflKRJrs3YK5Hhu37VTCzK6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfL2R7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387528AbfL2R61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:58:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630E1208C4;
        Sun, 29 Dec 2019 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642306;
        bh=irBTXJO5M41OcAwgoz9Wl6r8hqKKns6HU2jay+CD41M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQVAn8i7/q4Om/Txl2EtrgiUFOPBHEh0pFoCpzqRgL96xU2VfuyDoOoA77Kc8ZYUd
         6rgTfEVvLwE50842kuDoxaTHynCd+Crm6Sv1ajKhr3OkjNWgkcgHo7xp1DavwhEfER
         ueK4pM5eaPm4oN705AIUdZRJvrizkWRtozCEXwVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 429/434] mmc: sdhci: Update the tuning failed messages to pr_debug level
Date:   Sun, 29 Dec 2019 18:28:02 +0100
Message-Id: <20191229172731.819065335@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

commit 2c92dd20304f505b6ef43d206fff21bda8f1f0ae upstream.

Tuning support in DDR50 speed mode was added in SD Specifications Part1
Physical Layer Specification v3.01. Its not possible to distinguish
between v3.00 and v3.01 from the SCR and that is why since
commit 4324f6de6d2e ("mmc: core: enable CMD19 tuning for DDR50 mode")
tuning failures are ignored in DDR50 speed mode.

Cards compatible with v3.00 don't respond to CMD19 in DDR50 and this
error gets printed during enumeration and also if retune is triggered at
any time during operation. Update the printk level to pr_debug so that
these errors don't lead to false error reports.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: stable@vger.kernel.org # v4.4+
Link: https://lore.kernel.org/r/20191206114326.15856-1-faiz_abbas@ti.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2406,8 +2406,8 @@ static int __sdhci_execute_tuning(struct
 		sdhci_send_tuning(host, opcode);
 
 		if (!host->tuning_done) {
-			pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
-				mmc_hostname(host->mmc));
+			pr_debug("%s: Tuning timeout, falling back to fixed sampling clock\n",
+				 mmc_hostname(host->mmc));
 			sdhci_abort_tuning(host, opcode);
 			return -ETIMEDOUT;
 		}


