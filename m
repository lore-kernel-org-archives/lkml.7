Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ECFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51E820836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688163;
	bh=bEFp7G5ee5yXFJQMrmFPXY4YJEHznxy5UBc9ttfLwKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKr3zEpXNpc3RnLZjgbFR4/hd97USqBwsMZjBX/P0GjJAHm9fe9nP1c1AIZ2S21qD
	 G4dt6eIMAWfhEC1L4EdSmdHsDPW6VaNqFG0+2lI/CHapyqYXtasPfCaDgGcBj5i2LR
	 GOOK4qchl7KApCTtyGbfT0CON3WLZOWN7mwp/eqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCDI3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfCDI3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:29:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0660A20836;
        Mon,  4 Mar 2019 08:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688158;
        bh=bEFp7G5ee5yXFJQMrmFPXY4YJEHznxy5UBc9ttfLwKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4+Hkg1iHxN93n/Ynj55geLWohXNd2EKKRRB5ev5n7RY2Sjvf3IzRpKMDHaJYMCJi
         UslM9ttcFE8wNNLfG/1nHhPRfxrOxdKTD5ivM+TG6oldonuRt27nZ/1HMaKaoA0JIr
         6L1vFSlum+IOv1XU7ORfbWdFwjDN32koeWB7bVbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/78] selftests: rtc: rtctest: add alarm test on minute boundary
Date:   Mon,  4 Mar 2019 09:22:01 +0100
Message-Id: <20190304081626.315972549@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

[ Upstream commit 7b3027728f4d4f6763f4d7e771acfc9424cdd0e6 ]

Unfortunately, some RTC don't have a second resolution for alarm so also
test for alarm on a minute boundary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/rtc/rtctest.c | 102 ++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index dea4e3d6d9e18..b2065536d4075 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -211,6 +211,108 @@ TEST_F(rtc, alarm_wkalm_set) {
 	ASSERT_EQ(new, secs);
 }
 
+TEST_F(rtc, alarm_alm_set_minute) {
+	struct timeval tv = { .tv_sec = 62 };
+	unsigned long data;
+	struct rtc_time tm;
+	fd_set readfds;
+	time_t secs, new;
+	int rc;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	secs = timegm((struct tm *)&tm) + 60 - tm.tm_sec;
+	gmtime_r(&secs, (struct tm *)&tm);
+
+	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Alarm time now set to %02d:%02d:%02d.",
+	       tm.tm_hour, tm.tm_min, tm.tm_sec);
+
+	/* Enable alarm interrupts */
+	rc = ioctl(self->fd, RTC_AIE_ON, 0);
+	ASSERT_NE(-1, rc);
+
+	FD_ZERO(&readfds);
+	FD_SET(self->fd, &readfds);
+
+	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+	ASSERT_NE(-1, rc);
+	ASSERT_NE(0, rc);
+
+	/* Disable alarm interrupts */
+	rc = ioctl(self->fd, RTC_AIE_OFF, 0);
+	ASSERT_NE(-1, rc);
+
+	rc = read(self->fd, &data, sizeof(unsigned long));
+	ASSERT_NE(-1, rc);
+	TH_LOG("data: %lx", data);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	new = timegm((struct tm *)&tm);
+	ASSERT_EQ(new, secs);
+}
+
+TEST_F(rtc, alarm_wkalm_set_minute) {
+	struct timeval tv = { .tv_sec = 62 };
+	struct rtc_wkalrm alarm = { 0 };
+	struct rtc_time tm;
+	unsigned long data;
+	fd_set readfds;
+	time_t secs, new;
+	int rc;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
+	ASSERT_NE(-1, rc);
+
+	secs = timegm((struct tm *)&alarm.time) + 60 - alarm.time.tm_sec;
+	gmtime_r(&secs, (struct tm *)&alarm.time);
+
+	alarm.enabled = 1;
+
+	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Alarm time now set to %02d/%02d/%02d %02d:%02d:%02d.",
+	       alarm.time.tm_mday, alarm.time.tm_mon + 1,
+	       alarm.time.tm_year + 1900, alarm.time.tm_hour,
+	       alarm.time.tm_min, alarm.time.tm_sec);
+
+	FD_ZERO(&readfds);
+	FD_SET(self->fd, &readfds);
+
+	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+	ASSERT_NE(-1, rc);
+	ASSERT_NE(0, rc);
+
+	rc = read(self->fd, &data, sizeof(unsigned long));
+	ASSERT_NE(-1, rc);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	new = timegm((struct tm *)&tm);
+	ASSERT_EQ(new, secs);
+}
+
 static void __attribute__((constructor))
 __constructor_order_last(void)
 {
-- 
2.19.1



