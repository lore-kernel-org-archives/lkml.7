Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC0921871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610983;
	bh=nogilSUF5E56CMWrVKlOeHpIEupOKB/TMUJXYz1NinQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mDNyM67TFhHs91Q1IMSu8eoUIyIs5bNd1KBqUPamATZ9Jf7dtxRn5Af9a5y9VVbNo
	 Hi1EQEUfe+rRHxpKluv1qcukKc99m21YZbBYPfdZVXa1zV0dlcESZStwcj1SUNINnM
	 pP2DZxogy+vaOJYyNLx17QTRDoo72yN5036mhYBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391637AbfDRSJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391431AbfDRSJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16CE21872;
        Thu, 18 Apr 2019 18:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610977;
        bh=nogilSUF5E56CMWrVKlOeHpIEupOKB/TMUJXYz1NinQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxoFHAPR2w9gMW7gSXeDzbutc1z+bd5gi51oWlxJPA01cDttGs4/THAGbZtAF+APM
         dAG3/RLfCaMaFeCO0bfXrmgS9GpLAhEEK/hHdYZRETepgPDGypNaKFsYFso1vO5Tcl
         FxcCJ56TO3ZCEGanxh6jE9tGOWLowPV8o3JtSCCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 12/93] auxdisplay: hd44780: Fix memory leak on ->remove()
Date:   Thu, 18 Apr 2019 19:56:50 +0200
Message-Id: <20190418160438.125756125@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



