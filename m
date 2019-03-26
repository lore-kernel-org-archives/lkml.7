Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F5FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952FA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582077;
	bh=wxXsOBgbbz5sskrOIIZhogfOxRdv57I7U8CxZCrvQSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JwjEV1QR6cc5/VEILXnvtHFx9JavWNXOkofNmI5DnUNzz0kZFk0C11Q2HpxpH4ZDH
	 P/DPU0fasly7o5cQIXGYJJ23+VGnSG+l//nf0QecUHQlfLVZcRNg1HggVqhgo2fewB
	 CGCEwuB9/wU+vfSuSZfAdixURLi6w5hQXVYNhqf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfCZGeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731869AbfCZGee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:34:34 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E00D2086C;
        Tue, 26 Mar 2019 06:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582073;
        bh=wxXsOBgbbz5sskrOIIZhogfOxRdv57I7U8CxZCrvQSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9RQJ8ZqpzBxPAuvbIlyag0YIjx/jxhR3BoluF60bdzaKcwqLN9/GY+WRweGC0zD0
         gaDN6xZR/2Up1jkspkxn+a9TbhiJPOQBLquZhrt1V2h037KH/zk1TNG4HmbQa5cjYq
         zxNlmKROJXk6RcyfeZxTfU8V3UMVTSS+1IGGtI/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.14 37/41] rtc: Fix overflow when converting time64_t to rtc_time
Date:   Tue, 26 Mar 2019 15:30:14 +0900
Message-Id: <20190326042651.912300536@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baolin Wang <baolin.wang@linaro.org>

commit 36d46cdb43efea74043e29e2a62b13e9aca31452 upstream.

If we convert one large time values to rtc_time, in the original formula
'days * 86400' can be overflowed in 'unsigned int' type to make the formula
get one incorrect remain seconds value. Thus we can use div_s64_rem()
function to avoid this situation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-lib.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -52,13 +52,11 @@ EXPORT_SYMBOL(rtc_year_days);
  */
 void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 {
-	unsigned int month, year;
-	unsigned long secs;
+	unsigned int month, year, secs;
 	int days;
 
 	/* time must be positive */
-	days = div_s64(time, 86400);
-	secs = time - (unsigned int) days * 86400;
+	days = div_s64_rem(time, 86400, &secs);
 
 	/* day of the week, 1970-01-01 was a Thursday */
 	tm->tm_wday = (days + 4) % 7;


