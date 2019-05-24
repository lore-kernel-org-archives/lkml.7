Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5FBC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686C521773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="L/bL+9Z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbfEXLIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:08:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42861 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390714AbfEXLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:08:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so6805167lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atMxjy9C7OQe8GpIdLJBQm8m+GFrGLxyYvK8iCvKAkM=;
        b=L/bL+9Z8mZNNx+wl9m98wo7ZK+zr37ugLt5TV7nnKt6uGIBbJFF0/TeWU8Pp7SEjuQ
         B68D6NNM65F9KwR6tbKSIg4S1YTISVzWxrq08LMtuhu/pgSPeT0OeEoGSz0HoIXVxyaN
         /3G2RaHyeLjSSJcEnO4aly7WO7qEGHRlSi54cAWtxRcteau5BfyZnY3i7GPzNOFdTJfr
         tRncjpwajX6jtDBaQ2L63Tgf+f/4hOIX3NnkNIyho/H5KD9zwYegHW7cK2hO/fqRVSDR
         WcQYiVyhlHhHRyDEvz9Mcn8xN/F9Fm3JBRD4MFuPT2KMjEuoZpw4AY059zawd3WksfLV
         uryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atMxjy9C7OQe8GpIdLJBQm8m+GFrGLxyYvK8iCvKAkM=;
        b=FOs7EPP6gMbRC6gxz324AxT8NxUus49yL6oHobAZTL5We5ocpjeTvJs5+L2P7oKFgW
         EPdb0rSvdJoCrz77EVBfYx8QFmavaWOVh5Ulwk4CIjEfKBxcDFv2EVDwUZ4pcBJm5bY8
         o8how2UMY/wXrKmy7v2ovviKNZVw5xUbT4d7SQcoYgh9712bA/v+CN0XtHCaJidVv+oh
         aNL9Uq12EZyHust+wxuFzBtpK8MRrB0pDL+Kq0dVUDTqKRIU1EBUf5hYujgBvNacf7Zb
         MzVSaOuY3Fu4PCYy5xdoGm3/tyZlMQFgHNyMfnu8m3awUqh9VX4BuGdjfqEkLoV+9pSa
         VDDw==
X-Gm-Message-State: APjAAAXh3FCIeSedRPVal6kb+xy2KDOWoLGLZ+l3cYiwsO2SvJjKZs97
        8yjeLJgtRIxoMjDuuxVPE526Pg==
X-Google-Smtp-Source: APXvYqyr0iuyuv6cZDN1lY/dPIGjPQ9/in/uZeJ9teIO4j6Z9AEA6St3vAvqSRW1cfTePD0qHmXROA==
X-Received: by 2002:ac2:482a:: with SMTP id 10mr1204546lft.51.1558696090033;
        Fri, 24 May 2019 04:08:10 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x21sm446234ljj.43.2019.05.24.04.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:08:09 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: kpc2000: add spaces around operators in core.c
Date:   Fri, 24 May 2019 13:07:59 +0200
Message-Id: <20190524110802.2953-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524110802.2953-1-simon@nikanor.nu>
References: <20190524110802.2953-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl check "spaces preferred around that <op>".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 4110032d0cbb..b464973d12ad 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -276,18 +276,18 @@ static ssize_t kp2000_cdev_read(struct file *filp, char __user *buf,
 	if (WARN(NULL == buf, "kp2000_cdev_read: buf is a NULL pointer!\n"))
 		return -EINVAL;
 
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Card ID                 : 0x%08x\n", pcard->card_id);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Build Version           : 0x%08x\n", pcard->build_version);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Build Date              : 0x%08x\n", pcard->build_datestamp);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Build Time              : 0x%08x\n", pcard->build_timestamp);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Core Table Offset       : 0x%08x\n", pcard->core_table_offset);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Core Table Length       : 0x%08x\n", pcard->core_table_length);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Hardware Revision       : 0x%08x\n", pcard->hardware_revision);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "SSID                    : 0x%016llx\n", pcard->ssid);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "DDNA                    : 0x%016llx\n", pcard->ddna);
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "IRQ Mask                : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK));
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "IRQ Active              : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE));
-	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "CPLD                    : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG));
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Card ID                 : 0x%08x\n", pcard->card_id);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Build Version           : 0x%08x\n", pcard->build_version);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Build Date              : 0x%08x\n", pcard->build_datestamp);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Build Time              : 0x%08x\n", pcard->build_timestamp);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Core Table Offset       : 0x%08x\n", pcard->core_table_offset);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Core Table Length       : 0x%08x\n", pcard->core_table_length);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Hardware Revision       : 0x%08x\n", pcard->hardware_revision);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "SSID                    : 0x%016llx\n", pcard->ssid);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "DDNA                    : 0x%016llx\n", pcard->ddna);
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "IRQ Mask                : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK));
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "IRQ Active              : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE));
+	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "CPLD                    : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG));
 
 	if (*f_pos >= cnt)
 		return 0;
-- 
2.20.1

