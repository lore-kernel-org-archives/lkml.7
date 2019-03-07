Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE70DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC63520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdRQzcbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfCGVqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:46:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46267 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGVqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:46:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so14748608edy.13;
        Thu, 07 Mar 2019 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8b6kaUN12uayEfN2kOwfbxwsunjkll19OqppazKd/bM=;
        b=NdRQzcbk5NMkbWEmaUpuT6Fs/Z7b3BBMBIIVu3StO4FdGvWB0ymkemAPihwj1GlhIb
         axOwQ4ImCpPx+RnhWR29Ke1rfdyFHzM9oU4ejm24UsVaBh7ZQFV7n8TH5MH53ZacqmrZ
         wAxZxMuNuxUu1SscL9KsbTwL3fd+kmPjExa7yqK16ruSijigcdxvhNvTr5t9kuSf3j84
         TinOgxZ0vfLc6ZB9H7QOZyu+O8eqc2n35+dG7kPnrrrtdofFq7C2L99EMmzrk7XkTai1
         jVyAF6UsSU6sOITFyJVyrGj0CU72+Y4dBtAteMYCNeklc17fv6EsUpt6eIuOvCYOZIPc
         D9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8b6kaUN12uayEfN2kOwfbxwsunjkll19OqppazKd/bM=;
        b=LLkmKJdbAD93lsYZG1gyneJtXKlvlOzdGD53mXZDzaNfxaX8DLhU/mcRHwc4qSnTXx
         NVhdrsmEKNwybrHU9l3nPCHBPEh7MKZAGlMewPNJiEsM8jE6TZN+lvPQtCRzQWXIdgVl
         5X9BcroGqZDaEIoJVfg1gU9z0ZALqwWe4gbxwt3dMRnbsCFtfmMf6qIinDPDv9MDNwyp
         JWyeC7tv2GLc81bUuTAfSIcTVny8mBaW5xb4+AhMTqOUePfVUGIrMofPwCTQAiJDAt9i
         pJWPn2y1Ce22Dqu6FSNaJy/LQgNJiErXaffMCY0zlihEPKeasLLaoJr1oSMvdpzbicGj
         Q5LA==
X-Gm-Message-State: APjAAAV6zxA2g0peIxFhY6jjC1WAaMoiT0n4uWR6a1k6AaJy/1BcrkI4
        fxSD8sgwYPCNoJNJ9RcnFvM=
X-Google-Smtp-Source: APXvYqyqW1IJ30WsXhO/KW6V32G0v/PryQEFr89RarkpxGwIJOnqpyJQkWi18ffwX6+27E0JmTuGOg==
X-Received: by 2002:a17:906:d69:: with SMTP id s9mr9294748ejh.205.1551995161961;
        Thu, 07 Mar 2019 13:46:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id o1sm1087019eja.18.2019.03.07.13.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 13:46:01 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] iio: common: ssp_sensors: Initialize calculated_time in ssp_common_process_data
Date:   Thu,  7 Mar 2019 14:45:46 -0700
Message-Id: <20190307214546.9624-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/iio/common/ssp_sensors/ssp_iio.c:95:6: warning: variable
'calculated_time' is used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

While it isn't wrong, this will never be a problem because
iio_push_to_buffers_with_timestamp only uses calculated_time
on the same condition that it is assigned (when scan_timestamp
is not zero). While iio_push_to_buffers_with_timestamp is marked
as inline, Clang does inlining in the optimization stage, which
happens after the semantic analysis phase (plus inline is merely
a hint to the compiler).

Fix this by just zero initializing calculated_time.

Link: https://github.com/ClangBuiltLinux/linux/issues/394
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_iio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index 645f2e3975db..e38f704d88b7 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -81,7 +81,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 			    unsigned int len, int64_t timestamp)
 {
 	__le32 time;
-	int64_t calculated_time;
+	int64_t calculated_time = 0;
 	struct ssp_sensor_data *spd = iio_priv(indio_dev);
 
 	if (indio_dev->scan_bytes == 0)
-- 
2.21.0

