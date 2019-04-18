Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A88C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02D6218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610676;
	bh=SsPSQ7zPUl+yDxAlWp8uqZY4AqscNNBoI8Zj1fN7Yo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V0Ss8apX9zlu0/MndplXa6ZczogVN/pxznR8I7YY/0I5qS6fbLBCW8AapvuLc/Xte
	 xMgrZGun17CXYrDrliUFkUDIca9scAvCeHiR7R9el5IZHCTXPUeqsuVZEoETrBTMUb
	 G5K/cYEM5NdQ3n+r8R6SB9GQUcJDZCQmz/E1T03A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbfDRSEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391125AbfDRSEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:04:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B29B217FA;
        Thu, 18 Apr 2019 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610670;
        bh=SsPSQ7zPUl+yDxAlWp8uqZY4AqscNNBoI8Zj1fN7Yo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emeKJZzpOgsXJoiU1s3Q2RkuOMuzd8NoX7JuID6lNETvhtSVuYnW7Zl1l0V6IYRYF
         BkGSvErvNq2Ye/2It6cJpFpF0YQGXUdjNUsaNCoBlnGUt214PslhDoKk7u5Bfn2lnj
         JGF4Va4aGicvbGIu22qv3Y8yrol//OCnX2vML2oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/92] auxdisplay: hd44780: Fix memory leak on ->remove()
Date:   Thu, 18 Apr 2019 19:56:26 +0200
Message-Id: <20190418160431.157765334@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
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
index 036eec404289..2d927feb3db4 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -302,6 +302,8 @@ static int hd44780_remove(struct platform_device *pdev)
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 
 	charlcd_unregister(lcd);
+
+	kfree(lcd);
 	return 0;
 }
 
-- 
2.19.1



