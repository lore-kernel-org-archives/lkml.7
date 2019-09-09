Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE3C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC834206A1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3A3SuBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfIIOcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:32:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40213 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfIIOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:32:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so5173885qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nB56A57AoyNRyVPYSkSiIG8z/DKVcHYWbRMJROXBVZs=;
        b=n3A3SuBEOsX4sJKFvwwRlbK2DLpNzRA/Y2fQbBpHxnQ1JPuEDug9rMnHbmmKiBAYbJ
         lroXsTtteqs44K9uuzYAbFjhWhUT2D4Bx3uFhsntfJFu6AyScMn9zdizF34tKkEA9wIv
         SazKmonLK3tbTKMv2De6mOVe1pp58GC0oZQQnrzE5XXaxaQ+TVrfk67gmX0u4OO6i0hN
         0anmiiWYZCSzZXHAUBFuzErv2zeAKV3v9IG1MPxXC15jVmPEiYNjpYwiUYRSW3sqs+1y
         aBGOP8KrNYrhow67bOipVrXOgk6mzsIl9/DrmPj0znF8pFJDeuqdeI+LTooHycFDDnB5
         sEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nB56A57AoyNRyVPYSkSiIG8z/DKVcHYWbRMJROXBVZs=;
        b=htpGccMJUNdexUzMQB7OTNw9lcnvUqBAe9IwShetyxDrGTrDRSDNu0dkbzu7dEbto7
         1z7Q0cNrG9nkPCn85Kl7WdeK2as5lB48NLdI4c23MbgYGdRbIJn5qW9N1sRPw7qICLrb
         B6XEtXxZ1RdXgYxRMU/7M9qXRNKXJ/w/u+cFFUoIUTTfu5gF+t4FQNUyoZIJ7Z+KaZYV
         kNfrVmXtBnsEzVzWsgJby8/Gcm2EFMpPKsPEqGGXdvNM6wt4gAOSoGIcXquo181yiNQG
         nD92jMODJY6MjrIy30JDtokUVXOWKuyIK3EpyvWFnzYlAcLOfu3J8gUABwe4HO81ZJ85
         JLSw==
X-Gm-Message-State: APjAAAXtpl1/jjwaBkyl4jeeFiWFX/iyPCLSVjhZFsFHnFMR65xf3qxY
        Mp4I3lxxE2vfLD7G088hsmiVamya
X-Google-Smtp-Source: APXvYqy4+0bJz0i4RqatiNd+TkqwqmaVpq5uWSNuVgiLEEEcBHGccDyBnANV5//HcaxMkwm6XEYLBw==
X-Received: by 2002:a37:9547:: with SMTP id x68mr6126614qkd.6.1568039569425;
        Mon, 09 Sep 2019 07:32:49 -0700 (PDT)
Received: from localhost.localdomain (201-42-109-60.dsl.telesp.net.br. [201.42.109.60])
        by smtp.gmail.com with ESMTPSA id x55sm9363799qta.74.2019.09.09.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:32:49 -0700 (PDT)
From:   Julio Faracco <jcfaracco@gmail.com>
To:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     elder@kernel.org, johan@kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2] staging: greybus: loopback_test: Adding missing brackets into if..else block
Date:   Mon,  9 Sep 2019 14:32:44 +0000
Message-Id: <20190909143244.371-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside a block of if..else conditional, else structure does not contain
brackets. This is not following regular policies of kernel coding style.
All parts of this conditional blocks should respect brackets inclusion.
This commit removes some blank spaces that are not following brackets
policies too.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>

---

Changes from v1:
- fixing patch description
- including more cases that brackets does not fill kernel code policies.

---
---
 drivers/staging/greybus/tools/loopback_test.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index ba6f905f2..22e79f197 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -238,7 +238,6 @@ static void show_loopback_devices(struct loopback_test *t)
 
 	for (i = 0; i < t->device_count; i++)
 		printf("device[%d] = %s\n", i, t->devices[i].name);
-
 }
 
 int open_sysfs(const char *sys_pfx, const char *node, int flags)
@@ -273,7 +272,6 @@ float read_sysfs_float_fd(int fd, const char *sys_pfx, const char *node)
 	char buf[SYSFS_MAX_INT];
 
 	if (read(fd, buf, sizeof(buf)) < 0) {
-
 		fprintf(stderr, "unable to read from %s%s %s\n", sys_pfx, node,
 			strerror(errno));
 		close(fd);
@@ -366,7 +364,6 @@ static int get_results(struct loopback_test *t)
 			r->apbridge_unipro_latency_max - r->apbridge_unipro_latency_min;
 		r->gbphy_firmware_latency_jitter =
 			r->gbphy_firmware_latency_max - r->gbphy_firmware_latency_min;
-
 	}
 
 	/*calculate the aggregate results of all enabled devices */
@@ -406,7 +403,6 @@ static int get_results(struct loopback_test *t)
 			r->apbridge_unipro_latency_max - r->apbridge_unipro_latency_min;
 		r->gbphy_firmware_latency_jitter =
 			r->gbphy_firmware_latency_max - r->gbphy_firmware_latency_min;
-
 	}
 
 	return 0;
@@ -535,8 +531,8 @@ static int log_results(struct loopback_test *t)
 			fprintf(stderr, "unable to open %s for appendation\n", file_name);
 			abort();
 		}
-
 	}
+
 	for (i = 0; i < t->device_count; i++) {
 		if (!device_enabled(t, i))
 			continue;
@@ -549,10 +545,8 @@ static int log_results(struct loopback_test *t)
 			if (ret == -1)
 				fprintf(stderr, "unable to write %d bytes to csv.\n", len);
 		}
-
 	}
 
-
 	if (t->aggregate_output) {
 		len = format_output(t, &t->aggregate_results, "aggregate",
 				    data, sizeof(data), &tm);
@@ -739,7 +733,6 @@ static int wait_for_complete(struct loopback_test *t)
 		ts = &t->poll_timeout;
 
 	while (1) {
-
 		ret = ppoll(t->fds, t->poll_count, ts, &mask_old);
 		if (ret <= 0) {
 			stop_tests(t);
@@ -801,8 +794,9 @@ static void prepare_devices(struct loopback_test *t)
 			write_sysfs_val(t->devices[i].sysfs_entry,
 					"outstanding_operations_max",
 					t->async_outstanding_operations);
-		} else
+		} else {
 			write_sysfs_val(t->devices[i].sysfs_entry, "async", 0);
+		}
 	}
 }
 
@@ -879,10 +873,8 @@ static int sanity_check(struct loopback_test *t)
 			fprintf(stderr, "Bad device mask %x\n", (1 << i));
 			return -1;
 		}
-
 	}
 
-
 	return 0;
 }
 
-- 
2.20.1

