Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A040F20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDqnDhlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfCHTrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:47:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44710 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHTrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:47:36 -0500
Received: by mail-qk1-f195.google.com with SMTP id u22so2989641qkj.11;
        Fri, 08 Mar 2019 11:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2Ize1qdd/+pcZ9Tq8J7ceDNACDDuhrJ3Re5syZqpYs=;
        b=EDqnDhlOqoC3k/JHRM46+brhChFEDWpche5SR6l8Bkgenep3WEH+bpoth0fTEoxwpD
         sV5n2S8tm64ekKym1+aKfHggu6CI/FGqzY7rThSRA2Ayqb3oxL2tyB2b+JS/Rwo3+w70
         XcHWLV7dIddHHqnhDqV3t5ldgJxxqHRw4hXCZVThmbjEYx+HDv+0NvPp1zV/8N33SlAb
         r/NYXgc7lLXGFZ+BPJ6pitkveehqEUX7LrPxRe4dn6aoCyUig7L55VbRdTUu0T7HoXrY
         puOaGLvT4EhD49zS46QPNtNCc9Yi0yh2iIkKMkgFLqhbTn+H9kNJAHL6rxhhVMpaGmjn
         Z2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2Ize1qdd/+pcZ9Tq8J7ceDNACDDuhrJ3Re5syZqpYs=;
        b=c4pJ9faokuQJECd8+6uR9u+rGaWbUihpydoB+5x6L3lEGeNJMRVQabmgDnvE5vvvTz
         6+QR/1dE+x0XfE/bvujcrSkkTEykoL5Z4KgKLt7TgV2FpXwFxjuAL9yTCluJs5FMM/SW
         MYdcWZC7RvVQHBb8XO/KQYW88QJ4YP3YADpreP1czWxpPSbl+BESaKjTIgkFVUkmNS7j
         o7tk7kR80winG5PRAvNhC0+kwCS4TYdyjhEiMNAxkSeX/Vg4hZa6M+M99CEb0Kb1dp0N
         3de3cDmnV6hzCXl46b3jk8P2aN/VtCrTbn6o28d+XvXe95m0fs4RY/oiiqmd8fZgwRXx
         Y1cw==
X-Gm-Message-State: APjAAAUspNJZwSM2dV3O/Iwy6+f5Vs5OBwxuAZNQtl9xzOg+IWJvBIMw
        rDwx8PF0qc7GVmLu/JpRWdE=
X-Google-Smtp-Source: APXvYqwt9TmSP17ftfGUKD7wujl6S9fp9XXmpebaLPA+biK2RSO9sjDEOQq9dXu0W4Qod9Tp0v6UYQ==
X-Received: by 2002:a05:620a:15a8:: with SMTP id f8mr2801331qkk.127.1552074455750;
        Fri, 08 Mar 2019 11:47:35 -0800 (PST)
Received: from crypto.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n27sm2393038qtf.11.2019.03.08.11.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 11:47:35 -0800 (PST)
From:   Anderson Reis <andersonreisrosa@gmail.com>
X-Google-Original-From: Anderson Reis <anderson.reis.rosa@usp.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, matt.ranostay@konsulko.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Lucas Oshiro <lucasseikioshiro@gmail.com>,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH v2 1/4] iio:potentiostat:lmp91000: remove unnecessary parentheses
Date:   Fri,  8 Mar 2019 16:46:52 -0300
Message-Id: <20190308194655.5983-2-anderson.reis.rosa@usp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Oshiro <lucasseikioshiro@gmail.com>

Remove unnecessary parentheses on line 116, and solve these checkpatch.pl
CHECKs:

- lmp91000.c:116: CHECK: Unnecessary parentheses around 'state != channel'
- lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel == LMP91000_REG_MODECN_TEMP'

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 90e895adf997..03d277621861 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -113,7 +113,7 @@ static int lmp91000_read(struct lmp91000_data *data, int channel, int *val)
 		return -EINVAL;
 
 	/* delay till first temperature reading is complete */
-	if ((state != channel) && (channel == LMP91000_REG_MODECN_TEMP))
+	if (state != channel && channel == LMP91000_REG_MODECN_TEMP)
 		usleep_range(3000, 4000);
 
 	data->chan_select = channel != LMP91000_REG_MODECN_3LEAD;
-- 
2.20.1

