Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B55FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB5D218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263284;
	bh=yLdyqNRs0OaeMc4Wvc+EGhk7FX3SMfpxKJbHsx81qjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GnKBhjo58wBImMjGgE+CNNcxyp9p37vCJQEi7gNw0E2uKgHOehlAcwNAtSmNGwFdW
	 WrEXQ2nhGM+Dz29w18kD8Tyv/0y/tD6YXrmHqxjYOeJUqF847Nue8GQw8kpOiqjkrc
	 OdhOZIhHQ7gbiAIw6Wn3XRTcodUgx9770T4WnP9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438899AbfJPWAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438584AbfJPV7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:40 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB01222BD;
        Wed, 16 Oct 2019 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263179;
        bh=yLdyqNRs0OaeMc4Wvc+EGhk7FX3SMfpxKJbHsx81qjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Rc86efdeEHrpgU91npmsP95ZB6kgomo7aj4d5O4IG8i8p5isnLn/7bM0Q0VqOM31
         4lcfY92w4TR0naCuNff+cR/g1SryWJeMOtp+aLadu0AAhVcSG2U3ZwEux2/hg2yjbw
         mUzchyyJpl5vkznf3zhxIKw7ea9BnzfH0pOo+L2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.3 107/112] hwmon: Fix HWMON_P_MIN_ALARM mask
Date:   Wed, 16 Oct 2019 14:51:39 -0700
Message-Id: <20191016214907.196006194@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

commit 30945d31e5761436d9eba6b8cff468a5f7c9c266 upstream.

Both HWMON_P_MIN_ALARM and HWMON_P_MAX_ALARM were using
BIT(hwmon_power_max_alarm).

Fixes: aa7f29b07c870 ("hwmon: Add support for power min, lcrit, min_alarm and lcrit_alarm")
CC: <stable@vger.kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20190924124945.491326-2-nuno.sa@analog.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/hwmon.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -235,7 +235,7 @@ enum hwmon_power_attributes {
 #define HWMON_P_LABEL			BIT(hwmon_power_label)
 #define HWMON_P_ALARM			BIT(hwmon_power_alarm)
 #define HWMON_P_CAP_ALARM		BIT(hwmon_power_cap_alarm)
-#define HWMON_P_MIN_ALARM		BIT(hwmon_power_max_alarm)
+#define HWMON_P_MIN_ALARM		BIT(hwmon_power_min_alarm)
 #define HWMON_P_MAX_ALARM		BIT(hwmon_power_max_alarm)
 #define HWMON_P_LCRIT_ALARM		BIT(hwmon_power_lcrit_alarm)
 #define HWMON_P_CRIT_ALARM		BIT(hwmon_power_crit_alarm)


