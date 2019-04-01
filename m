Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D148C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B5320856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139797;
	bh=rvDgQ9ZvYXZmV+FlgaYrZTYDytkJz8P4BaPupGVSxMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KY+bldIyeogz/FQkAW6kTrlPDVGjBbdT+uYjDFCsfeF7WClbp6aOK2YW8P1JsPjwr
	 3my6jPXUFEhXMORsLzuvCyemVy2WobrYBR8vxKqmuu4BFfK39rntan6f4ecLLJh/If
	 6/QRkXYYD3GtJHtw8DxAzNGJdA3IRtvlJeqip3CM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfDAR34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfDAR3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94FA020880;
        Mon,  1 Apr 2019 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139792;
        bh=rvDgQ9ZvYXZmV+FlgaYrZTYDytkJz8P4BaPupGVSxMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFh2L7qhCDumqiDMsn16wfq7kgPdrsP0eDIe95d/h6vIGHsrY0Or7DDp13ioYKH/8
         Mv1la9mHUSigNUBG3kBlaaR6CVuC2BO9l7RN1IHK/5gslqhXjutd2HgL6hXQggFHdN
         /PtuWaNJnbuv+3Ksa6apZhOjZSWtXvkd45SYJgoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuan Juntao <juntaox.yuan@intel.com>,
        Pawel Wodkowski <pawelx.wodkowski@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 016/131] mmc: debugfs: Add a restriction to mmc debugfs clock setting
Date:   Mon,  1 Apr 2019 19:01:26 +0200
Message-Id: <20190401170053.272201270@linuxfoundation.org>
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

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

commit e5905ff1281f0a0f5c9863c430ac1ed5faaf5707 upstream.

Clock frequency values written to an mmc host should not be less than
the minimum clock frequency which the mmc host supports.

Signed-off-by: Yuan Juntao <juntaox.yuan@intel.com>
Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -220,7 +220,7 @@ static int mmc_clock_opt_set(void *data,
 	struct mmc_host *host = data;
 
 	/* We need this check due to input value is u64 */
-	if (val > host->f_max)
+	if (val != 0 && (val > host->f_max || val < host->f_min))
 		return -EINVAL;
 
 	mmc_claim_host(host);


