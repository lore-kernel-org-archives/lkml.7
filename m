Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E4C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C8D20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556826465;
	bh=tT3dxNpGuYBhbduvDygoS6CeszKx4PgZRS95HuVKCOE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=id3FnNkCA/+giT0MkriJtucpQbbE7jam+dgxunmRFXHpXavpuLz0NwNIcCvEBQQ8k
	 wQfWuPtqQ6drDVofGE4aR2zg4801Syb8I3QefqehPLtlue/YiPmI7HpuTPToWsESU9
	 y390utJZw/CU0HM5Y3WqGm50bthE0ilAYz1x7eyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEBTro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:47:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33014 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfEBTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:47:43 -0400
Received: by mail-it1-f195.google.com with SMTP id u16so1479094itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlRlXXCdCQ8ojS85wg4oVL7jRwgqCApJr9d2CW9N/kk=;
        b=hlmMwKaTwo8QkQ4w59AlaHa1gPjDqmFKP51ibnEIOqxvpVM4+UHLOj35EdfiGp9C1i
         g7B7YmNkJtO8upmjc7K+jEym4Fyf4w+4UzkCuroDMQxsNLAS1DjyfCCM3mi9zNkZHmaX
         W9BdloyTGe2xFOCDO8SMbUzbt1HoTTeAB47cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlRlXXCdCQ8ojS85wg4oVL7jRwgqCApJr9d2CW9N/kk=;
        b=XAHDQb200onrcXAPxl5lxwjOkI4bHJcCMn8M8wciKXDfTjzJYLNK4ONSpTP1r7AkW6
         BIrTOh7ckoO+74c7CvyZIolVfPvqRxxhzpHnnxA9tmGSgh8qiCXPKzGoDm4FO3TQZFdT
         BL76I0R7Htg7IgVy/HmZkjyiFwi2b7VCWP8PCQTIbdjTil0Eudj8JwpgGc/j9ulZhrds
         FzVah5nhxoLWi1WSetBu0Y5CKOjsSJ95dbtmbT0B3F1osWZbgPtd7pCjfC/FqxN0WZPs
         JKPnUEX5xOf/iiOuKT9yP1sDlpPqWgqkUxiWsHrouJqxQEROCr0ASsoyWJ3Hd0c5LLgR
         LwIQ==
X-Gm-Message-State: APjAAAVkkkwZo8Ebi1y4wBKsC9J4aVW4uFml+Z15zlIIA40QBr2Y8lyG
        V5vM07t57H90X2sJ3t/E5kU96Q==
X-Google-Smtp-Source: APXvYqzxV1flOpU2yjAYsjvpcGQ06uNmg+YUXTWwTD4S3a4FvSgciwOuQPCWH1C2VXlxaZHzEYUFTg==
X-Received: by 2002:a02:3b55:: with SMTP id i21mr4012523jaf.128.1556826463209;
        Thu, 02 May 2019 12:47:43 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n4sm14741ioh.52.2019.05.02.12.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:47:42 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: add sleep between detach and usbip list -l
Date:   Thu,  2 May 2019 13:47:40 -0600
Message-Id: <20190502194740.15344-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sleep between detach and check for exportable devices to avoid
the following segfault from libc-2.27.so

[ 6268.136108] usbip[5565]: segfault at 0 ip 00007f2a947bddfd sp 00007ffd1a8705e8 error 4 in libc-2.27.so[7f2a94703000+1e7000]

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
index 128f0ab24307..beacf24a8df7 100755
--- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
+++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
@@ -171,10 +171,14 @@ echo "Detach invalid port tests - expect invalid port error message";
 src/usbip detach -p 100;
 echo "=============================================================="
 
+# let detach complete. Avoid segfaults from libc-2.27.so
+sleep 3;
+
 echo "Expect to see export-able devices";
 src/usbip list -l;
 echo "=============================================================="
 
+
 echo "Remove usbip_host module";
 rmmod usbip_host;
 
-- 
2.17.1

