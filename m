Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CBCC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BB020854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SLWChC7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfDOWxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:53:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39368 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfDOWxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:53:00 -0400
Received: by mail-io1-f66.google.com with SMTP id e13so16041380ioq.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ne5pjde4HF9lJsw056hcCinTNwk9gZ4Gsc2PETazukk=;
        b=SLWChC7su73E9YCNo30HEymjebC11nB28pHbTyvMXRljj6wGKJpLLLZdOei855VSy5
         715GG9vYQ+Yokih+hurV0vvDNs4giXKpGIFrNZJ90mzU5ZTnmOecEY8GLSrYgOmCIh1d
         eUkZUYp5h1f+v8IVpsh9sxli0s3LZQwIH2b38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ne5pjde4HF9lJsw056hcCinTNwk9gZ4Gsc2PETazukk=;
        b=GqvxlIhOxN5GPerahF1cwonwLL2I76lSsK+Y9/TU8ZdAnluxaS8mvrT6nrYnE1kOld
         hDzQdnuWkUwuZ03MOspe0ZTdoaYZlcdzQUXuCWHMSS7Aoe5d5sQxqKsreOMDHyp++73K
         Rb9N2QK1Jt6bDStjzF0h2Mf5qV5QofMMrG8GtrEvx/FGNsfmSWR5HRTPMV+E3c24XQm3
         1c4Rm1SI5Ja/QNHGRr8eCOFPt5DtNiVddJo5MrBew3cvK55IvEFpLpRpLWz9rq0kyhz3
         2rAyXCgtfAR/OHJUpfZJ+BGug+eba1dn2uq8ZC3id8DP6EbWnHnP71rbp3bJ2DbAnM5P
         WL/Q==
X-Gm-Message-State: APjAAAWzUSZEEr1tnql3JYiN2zhcVK7rJHE+y100dllqhiWBrY3LgxE2
        jL4B3iX7A+fT8TFmyA9N6GQXPg==
X-Google-Smtp-Source: APXvYqxL3Y1/5EY9rT1odg/U/wDCVci/c5Ayg9G8OwUTt1pbou2Sl7HGdCuZSnjch5kBpOPfOLD81w==
X-Received: by 2002:a5d:87d3:: with SMTP id q19mr25910171ios.29.1555368779666;
        Mon, 15 Apr 2019 15:52:59 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id a16sm8666316itc.36.2019.04.15.15.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 15:52:58 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/4] mmc: core: Add trace event for SD SCR response
Date:   Mon, 15 Apr 2019 16:52:38 -0600
Message-Id: <20190415225241.70088-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example:
sd_scr: mmc0: version: 2, spec3: 1, width: 5, cmds: 0, raw: {0x2b58000,0x0}

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/sd.c      |  4 ++++
 include/trace/events/mmc.h | 42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 265e1aeeb9d8..3bed7c4b6d75 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -21,6 +21,8 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 
+#include <trace/events/mmc.h>
+
 #include "core.h"
 #include "card.h"
 #include "host.h"
@@ -200,6 +202,7 @@ static int mmc_decode_scr(struct mmc_card *card)
 	if (scr_struct != 0) {
 		pr_err("%s: unrecognised SCR structure version %d\n",
 			mmc_hostname(card->host), scr_struct);
+		trace_sd_scr(card, NULL);
 		return -EINVAL;
 	}
 
@@ -221,6 +224,7 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	if (scr->sda_spec3)
 		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+	trace_sd_scr(card, scr);
 	return 0;
 }
 
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index 7b706ff21335..e45258e8a6cb 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -10,6 +10,48 @@
 #include <linux/mmc/host.h>
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(sd_scr,
+
+	TP_PROTO(struct mmc_card *card, struct sd_scr *scr),
+
+	TP_ARGS(card, scr),
+
+	TP_STRUCT__entry(
+		__array(u32,			raw,	2)
+		__field(unsigned char,		sda_vsn)
+		__field(unsigned char,		sda_spec3)
+		__field(unsigned char,		bus_widths)
+		__field(unsigned char,		cmds)
+		__string(name,			mmc_hostname(card->host))
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->raw, card->raw_scr, sizeof(card->raw_scr));
+		if (scr) {
+			__entry->sda_vsn = scr->sda_vsn;
+			__entry->sda_spec3 = scr->sda_spec3;
+			__entry->bus_widths = scr->bus_widths;
+			__entry->cmds = scr->cmds;
+		} else {
+			__entry->sda_vsn = 0;
+			__entry->sda_spec3 = 0;
+			__entry->bus_widths = 0;
+			__entry->cmds = 0;
+		}
+		__assign_str(name, mmc_hostname(card->host));
+	),
+
+	TP_printk("%s: version: %d, spec3: %d, width: %d, cmds: %d, "
+		"raw: %s",
+		  __get_str(name),
+		  __entry->sda_vsn,
+		  __entry->sda_spec3,
+		  __entry->bus_widths,
+		  __entry->cmds,
+		  __print_array(__entry->raw, 2, sizeof(u32))
+	)
+);
+
 TRACE_EVENT(mmc_request_start,
 
 	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
-- 
2.21.0.392.gf8f6787159e-goog

