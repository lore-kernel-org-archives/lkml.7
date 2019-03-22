Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B12C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F43218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258512;
	bh=fraNlDS94Ao2ZiqrhxUgY8CrkVyXX4xbQL1UwjEU58k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CRHtSnk9IifSqk7JDKZcFgMM1q9b1R/s8NH27c8KjVbLLwGu6jRyuo5xfCqOcV8QP
	 nDkL1XSTdTBjm1T+JYjtiHc3VRng7YH0+woUQYkQpC+ZtyyuAxnDj1smLfSDCHs1T+
	 umbaxHiOl94j0FkSzGMtFn3CW7BR1qEqqKYgVLJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfCVMlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388227AbfCVMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A6721934;
        Fri, 22 Mar 2019 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256302;
        bh=fraNlDS94Ao2ZiqrhxUgY8CrkVyXX4xbQL1UwjEU58k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEymDbX8vNodZNCVHnPVEv/3p0DRf+/J02MlovxQUDZ7QYx+kTtx2yeit5Czlb9sW
         doADDSm88Kv5jR37pe6UBHMb08XRRs1yQznJPKNhB7onPd3FFe6rPvmK5506t+a7Jr
         kWeedXJZ4rhGn5Yvfyfy2RMzuPJawalk5DawnqfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiong Wu <Lohengrin1024@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 146/280] mmc:fix a bug when max_discard is 0
Date:   Fri, 22 Mar 2019 12:14:59 +0100
Message-Id: <20190322111319.371532427@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiong Wu <lohengrin1024@gmail.com>

commit d4721339dcca7def04909a8e60da43c19a24d8bf upstream.

The original purpose of the code I fix is to replace max_discard with
max_trim if max_trim is less than max_discard. When max_discard is 0
we should replace max_discard with max_trim as well, because
max_discard equals 0 happens only when the max_do_calc_max_discard
process is overflowed, so if mmc_can_trim(card) is true, max_discard
should be replaced by an available max_trim.
However, in the original code, there are two lines of code interfere
the right process.
1) if (max_discard && mmc_can_trim(card))
when max_discard is 0, it skips the process checking if max_discard
needs to be replaced with max_trim.
2) if (max_trim < max_discard)
the condition is false when max_discard is 0. it also skips the process
that replaces max_discard with max_trim, in fact, we should replace the
0-valued max_discard with max_trim.

Signed-off-by: Jiong Wu <Lohengrin1024@gmail.com>
Fixes: b305882fbc87 (mmc: core: optimize mmc_calc_max_discard)
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2378,9 +2378,9 @@ unsigned int mmc_calc_max_discard(struct
 		return card->pref_erase;
 
 	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
-	if (max_discard && mmc_can_trim(card)) {
+	if (mmc_can_trim(card)) {
 		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
-		if (max_trim < max_discard)
+		if (max_trim < max_discard || max_discard == 0)
 			max_discard = max_trim;
 	} else if (max_discard < card->erase_size) {
 		max_discard = 0;


