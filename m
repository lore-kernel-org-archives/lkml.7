Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34B5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88982216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzkpmxk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbfETNyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:54:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33969 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390358AbfETNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:54:09 -0400
Received: by mail-io1-f65.google.com with SMTP id g84so11097473ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KapGiunwwx5p5z/8cIELmJy7chJVMEDGUUi3pAZirR8=;
        b=yzkpmxk6Ixt7Vl80qvoHTPb21ID7tx7gUl5mLADJHRIA+mwJh+3RgoLGGk3FLTk54T
         YiScf7OxLAxGZZO9LC3+c8gtM0a7Ny2oW1diBfNo/KFgJgeeoC6QMtMvwqVezCPM64Mp
         Vqa2IRutPqE8aDKy5pSCg0SoCU7x3XEmR9EhpHbWBcQfO0t7f0HIZTkPOFFny9fs2ft/
         SubZ6bAz3fd+WTZssKs0U/8XN4Bvy28hyjoIYHIsrx1TFdoJk2enr7kbvfSS3KDsuUkm
         SnglFiYSqw9p+9YZ7rokP3YXlNVR+BjVzrA4BlMeUzKXro+jzAtArTeK6j2I5+Cf7jRR
         miAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KapGiunwwx5p5z/8cIELmJy7chJVMEDGUUi3pAZirR8=;
        b=Bo46zEf1H1ypuJyjm8zTj5c497GVd1gAA96BeJYAjf42R/k1JfAhNnU6+0CQMFjZ2c
         Ug3TTJ8YkW8HEezzBeAlap1XXTCUdO1oupIW99k4Knx+3UrItjwJ6cbb6Dx9SgJTD03a
         0pbgoHvTWQCpKPULL9+nojz2Se/f4SOFDFaxv4NMRhCnerQKyo3mtq/a/WPQVKFPiU2p
         1plosAoc7/LlVZuqlq2mve3DoYx+gUM/BJwBtWNKXzFQT/OxylH1lqHNlIbnXmby3AyO
         yvzesilUeo2LlN+DB8eW70/TDVCofvf7VAJ3st2F5dKx1uG7fjY5B04SRoNoKdEXuwwK
         fm8g==
X-Gm-Message-State: APjAAAXnJ1bjr8hwXxbqt7qRstl8akmSgsuiQZyz33YSAfIuVxnjwM6t
        C2W4qhbmqjs7Gk+UFt0zpYnYqw==
X-Google-Smtp-Source: APXvYqwP2yeMVfgpj5IAJSVo21lcBFOvcGIwfuZQCYo5tTMis4c0FbPs3j4lcwnYFd0aeSJGTibCsQ==
X-Received: by 2002:a6b:f404:: with SMTP id i4mr7597663iog.251.1558360449000;
        Mon, 20 May 2019 06:54:09 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id n17sm6581185ioa.0.2019.05.20.06.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 06:54:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     arnd@arndb.de, subashab@codeaurora.org, david.brown@linaro.org,
        agross@kernel.org, davem@davemloft.net
Cc:     bjorn.andersson@linaro.org, ilias.apalodimas@linaro.org,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] net: qualcomm: rmnet: mark endianness of struct rmnet_map_dl_csum_trailer fields
Date:   Mon, 20 May 2019 08:53:53 -0500
Message-Id: <20190520135354.18628-8-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520135354.18628-1-elder@linaro.org>
References: <20190520135354.18628-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two 16-bit fields (csum_start_offset and csum_length) in the
rmnet_map_dl_csum_trailer structure are currently defined to have
type u16.  But they are in fact big endian values, so should be
properly represented as __be16 values.

No existing code actually references these fields (they're ignored by
rmnet_map_ipv4_dl_csum_trailer() and rmnet_map_ipv6_dl_csum_trailer()).
Changing their type therefore causes no harm, so just fix them.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index fb1cdb4ec41f..775b98d34e94 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -52,8 +52,8 @@ struct rmnet_map_header {
 struct rmnet_map_dl_csum_trailer {
 	u8  reserved1;
 	u8  flags;		/* RMNET_MAP_DL_* */
-	u16 csum_start_offset;
-	u16 csum_length;
+	__be16 csum_start_offset;
+	__be16 csum_length;
 	__be16 csum_value;
 } __aligned(1);
 
-- 
2.20.1

