Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B13C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ED52146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139792;
	bh=w3xBXm0FQyvJfDU2cgYTFhtdx/CwrmSbT+AaKw19cbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EIbH2g7zP7fzZHZsR1bxaO0eRarnPxSW9jzqu3W3Ade8swgLnxfsYv8uSBkJJFiC7
	 ZiTqMAi7fPLJg0BLDtN3oDYo7Q/Zh0zI16M9dPErMyc7za8xsqdG0APiT+ijuuc7mS
	 HYLQAmCmwHWPbYlL6FrB3Z75Hz2tP1n76On8JAz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbfDAR3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfDAR3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C642146E;
        Mon,  1 Apr 2019 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139789;
        bh=w3xBXm0FQyvJfDU2cgYTFhtdx/CwrmSbT+AaKw19cbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMJdgfW+qwLQggGp/Z6L34PhVCdn1XQjsaPzZrvWD+fCYepAFFqWM2+4cnHUch/G6
         MH7qZ+Is8lwAKD4Lm3V+B/7H0YNNMWuuqHFxj/NkkjMxeW1C45THXfhRLISDnEEoC2
         GJDCAAei9nyB9nW+4UUWfG3NS/Zhks+bYlUX2i3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Martin Fuzzey <mfuzzey@parkeon.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 015/131] mmc: pwrseq_simple: Make reset-gpios optional to match doc
Date:   Mon,  1 Apr 2019 19:01:25 +0200
Message-Id: <20190401170053.164303582@linuxfoundation.org>
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

From: Martin Fuzzey <mfuzzey@parkeon.com>

commit 64a67d4762ce3ce4c9466eadd152d825fbf84967 upstream.

The DT binding doc says reset-gpios is an optional property but the code
currently bails out if it is omitted.

This is a regression since it breaks previously working device trees.
Fix it by restoring the original documented behaviour.

Fixes: ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/pwrseq_simple.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -29,15 +29,18 @@ struct mmc_pwrseq_simple {
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 					      int value)
 {
-	int i;
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
-	int values[reset_gpios->ndescs];
 
-	for (i = 0; i < reset_gpios->ndescs; i++)
-		values[i] = value;
+	if (!IS_ERR(reset_gpios)) {
+		int i;
+		int values[reset_gpios->ndescs];
 
-	gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
-				       values);
+		for (i = 0; i < reset_gpios->ndescs; i++)
+			values[i] = value;
+
+		gpiod_set_array_value_cansleep(
+			reset_gpios->ndescs, reset_gpios->desc, values);
+	}
 }
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
@@ -79,7 +82,8 @@ static void mmc_pwrseq_simple_free(struc
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
-	gpiod_put_array(pwrseq->reset_gpios);
+	if (!IS_ERR(pwrseq->reset_gpios))
+		gpiod_put_array(pwrseq->reset_gpios);
 
 	if (!IS_ERR(pwrseq->ext_clk))
 		clk_put(pwrseq->ext_clk);
@@ -112,7 +116,9 @@ struct mmc_pwrseq *mmc_pwrseq_simple_all
 	}
 
 	pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(pwrseq->reset_gpios)) {
+	if (IS_ERR(pwrseq->reset_gpios) &&
+	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
+	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
 		ret = PTR_ERR(pwrseq->reset_gpios);
 		goto clk_put;
 	}


