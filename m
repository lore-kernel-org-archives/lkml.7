Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFDDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F4321872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610311;
	bh=iOAR/jjnOTrW5Rk+msOHSS6OQhI/Ue1xT+DqPJeITNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a9TIvrta80yJeJIcduQHLXeJPSWzkpg6UrcEGZ3AG1MKH6+Z5bax2X/B4spW3O6pL
	 MXZNVhgZZosFb1i9Kanaa18hTR0BpufJOuES85rJmiNI4TxyetkHaA3gh9udoiav6E
	 huSBHET0p4y+FE+CJXqIOEmxDWlesCX9VlFmcwak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbfDRR6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389833AbfDRR62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:58:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6D1206B6;
        Thu, 18 Apr 2019 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610308;
        bh=iOAR/jjnOTrW5Rk+msOHSS6OQhI/Ue1xT+DqPJeITNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8wohnHhJq1v9/BdFMSiNSphbvY+C/qIBW+fO6UP8teIbla1o/0yxcMhyolGLF5EF
         iHrDFfqKwaoX5ub96jiSPn9wOek/zxOzCP/kutKhG00DmmJJHsGFUDmkeiAsMjkS2C
         3zTfM102kOSRXeggIK+1jke+ULI+rRil9W6m8B6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/110] auxdisplay: hd44780: Fix memory leak on ->remove()
Date:   Thu, 18 Apr 2019 19:56:00 +0200
Message-Id: <20190418160438.448680622@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
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
index f1a42f0f1ded..df3da49ff9e8 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -299,6 +299,8 @@ static int hd44780_remove(struct platform_device *pdev)
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 
 	charlcd_unregister(lcd);
+
+	kfree(lcd);
 	return 0;
 }
 
-- 
2.19.1



