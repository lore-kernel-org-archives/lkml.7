Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111F2218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907068;
	bh=eEPcgkDpG2R/rJqJFiTbLb6xDWxnrahvFAH4gOSPCIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZ/1Z0R6p4R+0ezAGtgWvqLj5kxlAJ0Ic2zPJ1h6JrdRYcH1aVqPrG97QutQMxF83
	 PdoOFlgSXRZ1HXADoAv8bqUbZMPVPnnQwq7DNbxjRAoj62EWo055U8lNvAsgIYpEOb
	 FERXgkNN1H4ttWIGXOq/PkhKsySmTsqmoUjYQq9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfC3AvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbfC3AvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA86218AC;
        Sat, 30 Mar 2019 00:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907060;
        bh=eEPcgkDpG2R/rJqJFiTbLb6xDWxnrahvFAH4gOSPCIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIZuufMTu14pxdah7fWsUkSng2qt4FfMFxEnV9NQfKH43+TIv/VDscg4ZzpHvNOU/
         FMd7kulMRVA0tJD1eS3vBJrFvuFKBltB+fGD9KT1lpMKYSgrwg2UAc8/08e4E1sZH+
         bUlauDHYi8MvCeVJJvwSKcJSTb8diD1h2QNaJwXs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 12/67] auxdisplay: hd44780: Fix memory leak on ->remove()
Date:   Fri, 29 Mar 2019 20:49:52 -0400
Message-Id: <20190330005047.25998-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 41c8d0adf3c4df1867d98cee4a2c4531352a33ad ]

We have to free on ->remove() the allocated resources on ->probe().

Fixes: d47d88361fee ("auxdisplay: Add HD44780 Character LCD support")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/auxdisplay/hd44780.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 9ad93ea42fdc..3cde351fb5c9 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -280,6 +280,8 @@ static int hd44780_remove(struct platform_device *pdev)
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 
 	charlcd_unregister(lcd);
+
+	kfree(lcd);
 	return 0;
 }
 
-- 
2.19.1

