Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE31C00307
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6692178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567824164;
	bh=FUP4jikvmgxt3jNITmvO9vbkaVXhXmpV7aPrr6kR2X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m81FTnvnmHokzE7ztB4hXNhmYzarSidT8HjbXk1f669G3aczYd5+ihs9H6nFAWzYD
	 shaX2gfoCx7lEvl0lsTvje/GABMjjT9+sp4JcG455yq0T+BYqp/GPD0XCb+mENL9D9
	 URYlrxfc6OKOojeF8FlkwIWVkReP8bS8JkCtUsyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394079AbfIGCmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 22:42:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44809 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394005AbfIGCmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 22:42:35 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so17192526iog.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=294+1pNE1QvrA8K+k/rIQCwQYW84ev1PmbYotCH5RCQ=;
        b=SH623TYFdX1L/2A+QyRyAkCxAqF+GYDPcODRe2Sz8FqEtEIIgfuF5rtfHQdogDC30K
         rrJCT6IPdrcEVFFN0lp3D1YkhqW78HeJqHA4lYKkxuv4Gz2KQbNF7ytlBUYXfD8TmTcR
         eidC8au4ObhVtrHeHobx9O2OqlGZFOOoiHXIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=294+1pNE1QvrA8K+k/rIQCwQYW84ev1PmbYotCH5RCQ=;
        b=a1t1JXn2y+Hjz5v6+rZ6pVxV1LbDo/unfmaW+z2/mrsknhGgOsvBEtNQ91VU8UMtiD
         mwDO0s2nFCPxMiUJOZB9/w+LlPK7l7hXCztdjwb6X4AuyC49teBCD5NpM6P17H0S0dYx
         OOLkrWRKBxlgOedT+qmLRuGWbjwYjYAq8VBf6MB/KuyH09ppbt1wxX67c9MxiBUoXo/1
         C5kwsEdpiBpgYnZIiVb31v/IVDQ9XAPTht3zyxdcsdptRnETho3nUVkzgsZhHSjxY+mK
         kc2SJVaU0Of6uyozCX60hLXX6O45gBDG6qxl/G1bp1WrOD56huPjkmbH972ylt6dFTbw
         zMpg==
X-Gm-Message-State: APjAAAUs6jqF+59fBq5Rjzo7IgR08kdGtm48xLhqiZfLHUTS6jcdmj0K
        PWDmAWicJW2aw3LJo6rb2wS6IA==
X-Google-Smtp-Source: APXvYqxYaeCcIgKAbH28UnlzMdq9hP8U2U6gO5o2E1+TocctiGgOEScJrVkUHXNA6/lAVDHHcRch7Q==
X-Received: by 2002:a6b:7109:: with SMTP id q9mr14767182iog.239.1567824154808;
        Fri, 06 Sep 2019 19:42:34 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b7sm6441427iod.78.2019.09.06.19.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 19:42:34 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, helen.koike@collabora.com,
        skhan@linuxfoundation.org, andrealmeid@collabora.com,
        dafna.hirschfeld@collabora.com, hverkuil-cisco@xs4all.nl,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] MAINTAINERS: Add reviewer to vimc driver
Date:   Fri,  6 Sep 2019 20:42:19 -0600
Message-Id: <a22e8a061fd0d9d8c9392e748a3182ce01f830e7.1567822793.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1567822792.git.skhan@linuxfoundation.org>
References: <cover.1567822792.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After practically re-writing the driver to collpase it into a monolith,
I am adding myself as a reviewer for vimc driver.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c62b45201d7..4529d257f8db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17041,6 +17041,7 @@ F:	include/media/videobuf2-*
 
 VIMC VIRTUAL MEDIA CONTROLLER DRIVER
 M:	Helen Koike <helen.koike@collabora.com>
+R:	Shuah Khan <skhan@linuxfoundation.org>
 L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 W:	https://linuxtv.org
-- 
2.20.1

