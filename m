Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745C5206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0OEX7pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfHOH6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:58:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43816 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfHOH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:58:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so1072229lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxYIVJXDl0DAiqdp8/QVOF+ggKcEMBtGLnHvtUKRSiU=;
        b=T0OEX7pfHxaxo4aOq3gWAKq/k0OH2V2V+0DlhgiT8Hrugb/ErCNRJlwXiF/Nr/oE/w
         4QYtPLkq3vH5b/AhdCSlkirEHFA5XypmeH9DrVATrPxXf/2iJ1FEHF4KhayWLtKLqt1Z
         okxEUthyOLkUCCJxiDwPdOgsa+jYUm0rwvb15ZWFrcAIW5BY08SehpOBA8iGpKfiYhLj
         qw5PevsY02PaqtX/tnUtCusfkEE2SkxjevazeUKUYxO1kcXuRl3MrRKHfdbMzWdCfycZ
         Nr0oJerFm+zm4wRsJ9JU+889w1msI+zFq7lHEvsyyfHNfdsJJEHWYzqYdY+CFIzD6VUl
         dbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxYIVJXDl0DAiqdp8/QVOF+ggKcEMBtGLnHvtUKRSiU=;
        b=SCThBbvXZkPJR7QEM8Z9GGdeweB0yvm4p0NTC2iqtrE9plcGhHaQlTUY00mhERorYv
         aOgkqt1VUCXQ1MgO24tfIbtrfvYtN2lttSBO6InYkpAneeXNu4q3dhHxIWAmfd8tyXnR
         EAa+kT6WB01WEMK6tPFJymv4PPQtyvW2obLCCcXN+P40cu8VMYN+x15vek0w2TY837xK
         X0JEjA7ZHjioHfYQNhrecQ0h1G5fa+fyPOhRTEvPwwRSNv7S+9ADXYZB3LVOfwHqp5lB
         dDdlc6ZPzCSw6f3HFmkWwuk66AzHLXGRH2ofSZl0cpGh0hYut4ZOZxelwzf4ikyVpL+o
         0ApA==
X-Gm-Message-State: APjAAAUo7KMmDv1adPybBl0psliyFICzILuzStUdEABYdc+2JZlDlDWx
        Cjm0rXT/7GWLqHfUUF4n463X706M4DVPhQ==
X-Google-Smtp-Source: APXvYqxls4X1ddxQTHCuwIDVXDZ78NOkk+luCUq8TVbBFysydFKTl+4JYn40PZg7QDBcqHkKXP/y1A==
X-Received: by 2002:a19:9111:: with SMTP id t17mr1694958lfd.113.1565855918902;
        Thu, 15 Aug 2019 00:58:38 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id w8sm319257lfq.53.2019.08.15.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 00:58:38 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, tim.bird@sony.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: net: tcp_fastopen_backup_key.sh: fix shellcheck issue
Date:   Thu, 15 Aug 2019 09:58:26 +0200
Message-Id: <20190815075826.13210-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running tcp_fastopen_backup_key.sh the following issue was seen in
a busybox environment.
./tcp_fastopen_backup_key.sh: line 33: [: -ne: unary operator expected

Shellcheck showed the following issue.
$ shellcheck tools/testing/selftests/net/tcp_fastopen_backup_key.sh

In tools/testing/selftests/net/tcp_fastopen_backup_key.sh line 33:
        if [ $val -ne 0 ]; then
             ^-- SC2086: Double quote to prevent globbing and word splitting.

Rework to do a string comparison instead.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/tcp_fastopen_backup_key.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_fastopen_backup_key.sh b/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
index 41476399e184..f6e65674b83c 100755
--- a/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
+++ b/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
@@ -30,7 +30,7 @@ do_test() {
 	ip netns exec "${NETNS}" ./tcp_fastopen_backup_key "$1"
 	val=$(ip netns exec "${NETNS}" nstat -az | \
 		grep TcpExtTCPFastOpenPassiveFail | awk '{print $2}')
-	if [ $val -ne 0 ]; then
+	if [ "$val" != 0 ]; then
 		echo "FAIL: TcpExtTCPFastOpenPassiveFail non-zero"
 		return 1
 	fi
-- 
2.20.1

