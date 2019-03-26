Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55BEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796FE20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581934;
	bh=A942+mqL8OzBGjvq5Sm/9s5QYiiZbxx4r/iJZepqlBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wtWDXm90mt1gTvOwx1ZvXgyPKrVAaGe7BfzE/hnhwedORxOGWVZsBZIp6ZcDPY67m
	 tq5yvOCvbwqJigoujZSElPGfOHdQm3kINL3UzvgEXaBrn4OubHxy71Zk69ES/mOUfq
	 mB9fDdC8mYcdH2TcCMeXDeEfqEKXfVyBC5J4Sy1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfCZGcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731336AbfCZGcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:10 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9352E20823;
        Tue, 26 Mar 2019 06:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581929;
        bh=A942+mqL8OzBGjvq5Sm/9s5QYiiZbxx4r/iJZepqlBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p054MZsDBB6d5fslKqL8Pr1NhtTpm2AnuNCgIvmfU53V3JA+7bMJ01U07Xij/GFTO
         MK+sBeWYFmLCJXHIl79Z9HrI24KwDe4MPazw0d5AL8+NaionmJ3HPNtQOIVmbXAffF
         41WJkFiapJSmu+P7hwJQLmNBfi4SMI3M/7+O+hdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.9 27/30] rtc: Fix overflow when converting time64_t to rtc_time
Date:   Tue, 26 Mar 2019 15:30:06 +0900
Message-Id: <20190326042608.476146676@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


