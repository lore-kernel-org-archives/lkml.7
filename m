Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618FC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925562075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CUt74S70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfDPSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:33:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38924 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfDPSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:33:14 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so350970ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIDqxxqztE2jOgZOgI8qrgI9gmHi2GmWCm0V06l/nB4=;
        b=CUt74S70/N1xpKsCTnqgFUJlJf8322fRk0pGHzVvVRn4Qv2APnTP2H6nvTQnyhonY7
         HlOPEne5p8nDJkvSsL8FNmWkuHODyXn7C7Smm5P97HSXfE39EbihL5+9+kVl0ZrGdFkn
         Q03tlXUZ23xxqwOKAO5jcZyfBPymoG7vINi30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIDqxxqztE2jOgZOgI8qrgI9gmHi2GmWCm0V06l/nB4=;
        b=IKHy6poAEergzmE4ciw+af9bbjmFmoFXhiuvx+aKr2O3Eh3tlRVrHVvMVnloowfLin
         DAfIubOTFiIowSQyBZCJirQHh2scHQDvBxURPXIGzEQNrEaDiqipL61DgSAQWTA0LTeB
         jsAvx2iJS1Umrpli1kGuxKdSTtpOhmlRWR0NmcsUGIkyCIppABShW0PF821oTc+AtCx3
         l7FU610Zlck4tN2p8DCTsrEVZIMCJdVR7uGPvbZvVL3+ke6OWtonpTjLM4szRBpvS8wT
         ncu3dfFL1uYpXYzTOYDsF/KMoZA93bt6nBp02vSbcaFHZWHFLwD6Ve/uzpstw3ekSa+m
         MhLg==
X-Gm-Message-State: APjAAAXxZ9hE6+PkyFrLMANpXRUPeWb1o4VoOEE09MTDRjqXqNqBgBi6
        8KIxIadUlhy1i3QRtWQgP1te2A==
X-Google-Smtp-Source: APXvYqxnB/KycclqM0AuhAq3iK59bz4PqOUVtPK2s9yABsRN20ILC34p4x3ITbTV7bRxO/Zn8yeX1A==
X-Received: by 2002:a24:bd08:: with SMTP id x8mr26681438ite.46.1555439593029;
        Tue, 16 Apr 2019 11:33:13 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id z24sm19096762ioi.67.2019.04.16.11.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:33:12 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/4] mmc: core: Add trace event for SD SSR response
Date:   Tue, 16 Apr 2019 12:32:55 -0600
Message-Id: <20190416183257.247902-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190416183257.247902-1-rrangel@chromium.org>
References: <20190416183257.247902-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example:
sd_ssr: mmc0: au: 8192, erase time: 0, erase offset: 0x0, raw: {0x0,0x3000000,0x1019000,0x10000,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/sd.c      |  2 ++
 include/trace/events/mmc.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index f1772972d6a3..908c3087cdcd 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -292,6 +292,8 @@ static int mmc_read_ssr(struct mmc_card *card)
 	card->erase_arg = (card->scr.sda_specx && discard_support) ?
 			    SD_DISCARD_ARG : SD_ERASE_ARG;
 
+	trace_sd_ssr(card);
+
 	return 0;
 }
 
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index 9761d3db16db..463cf318d762 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -61,6 +61,38 @@ TRACE_EVENT(sd_scr,
 	)
 );
 
+TRACE_EVENT(sd_ssr,
+
+	TP_PROTO(struct mmc_card *card),
+
+	TP_ARGS(card),
+
+	TP_STRUCT__entry(
+		__array(u32,			raw,	16)
+		__field(unsigned int,		au)
+		__field(unsigned int,		erase_timeout)
+		__field(unsigned int,		erase_offset)
+		__string(name,			mmc_hostname(card->host))
+	),
+
+	TP_fast_assign(
+		BUILD_BUG_ON(sizeof(card->raw_ssr) != sizeof(__entry->raw));
+		memcpy(__entry->raw, card->raw_ssr, sizeof(__entry->raw));
+		__entry->au = card->ssr.au;
+		__entry->erase_timeout = card->ssr.erase_timeout;
+		__entry->erase_offset = card->ssr.erase_offset;
+		__assign_str(name, mmc_hostname(card->host));
+	),
+
+	TP_printk("%s: au: %d, erase time: %d, erase offset: %#x, raw: %s",
+		  __get_str(name),
+		  __entry->au,
+		  __entry->erase_timeout,
+		  __entry->erase_offset,
+		  __print_array(__entry->raw, 16, sizeof(u32))
+	)
+);
+
 TRACE_EVENT(mmc_request_start,
 
 	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
-- 
2.21.0.392.gf8f6787159e-goog

