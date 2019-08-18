Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD0C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 17:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862222183E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 17:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/xaDGSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfHRRAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 13:00:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44675 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfHRRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:00:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so5502269pgl.11;
        Sun, 18 Aug 2019 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yc219Aj1bi5akUr6C+VEItZb9oqP5EGh5K613uvjY0o=;
        b=V/xaDGSosY9BoU9lSHk+AsdK3u2fYRctnCOSz2Pvi5thzhcLVSGDQCgaumSHtvlB9J
         g8lPmPiewegowAXZQx7lWMikzkKoJlitvFQsbUKfbR9UO+U9abRsv9cwCcg49VsHsSkC
         ocYQTnJ8zE8jqcOpdYLVq7Eul22FxOgG7F5FPODBd2zm5ePEl90F2D80hqXXHyymU9hT
         mC5L1vLsmWcw0XTHeOc8W63n3djf7QfvJLo1MreWlfGAaWVC7CR2cZP4Rxl70iZVb3Lb
         PjCnH3rg/Te3qTKp/pDNuMQXZibWOB9T64a/1E+pFprlLYnlRI5f+fT2XisJsizQ1BW4
         eT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yc219Aj1bi5akUr6C+VEItZb9oqP5EGh5K613uvjY0o=;
        b=LEWayiIMtsMn0Qd/+KNFYJiPsvoMgdU6iuFXz3xwmVVsX9trhdJWO8pJHd70n33qjg
         oPVPQX8niHw1nx0CbBwSU4x1yvuNXgkoHWfN0wfo6SaGqzNGR3Q8qaGaf6/ZlOBFWkjW
         xFhfBi1ucqVSWLVMlDgKszL3CMvlR00yGFPyJ4kH79NgOWNNZanGqUpEnrg9dQM8lvGS
         kQ2ztYfhZZOcnwjZqAxCej45IgWnH2nr8rjWPPreQRisbo7anhpH5x1ES3x/FOGJjNC5
         TzIF+UWDxiFFxPMtHbLBEbspvmQZybfLLbiaOAV6b548eGa9RDCb/Z8u5hcIoQ03IVKX
         FrKw==
X-Gm-Message-State: APjAAAV/n7kfCxOwE6cdhETAkXDYs0DoEI4fYl/HLpxcI0UJTaH+wIp/
        fZaFsPEhA69O9Nj/HYkfAoE=
X-Google-Smtp-Source: APXvYqwc49bVGlBZJ+ea5wgKMEj4ypc8J+NoD8zYw9CFpcbCLb36a3nT1zj20DYBqHsy/iOEVBDA1w==
X-Received: by 2002:a17:90a:22f0:: with SMTP id s103mr17550576pjc.56.1566147606746;
        Sun, 18 Aug 2019 10:00:06 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 10:00:06 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, tony.luck@intel.com
Subject: [PATCH v8 19/20] pstore: fs superblock limits
Date:   Sun, 18 Aug 2019 09:58:16 -0700
Message-Id: <20190818165817.32634-20-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaving granularity at 1ns because it is dependent on the specific
attached backing pstore module. ramoops has microsecond resolution.

Fix the readback of ramoops fractional timestamp microseconds,
which has incorrectly been reporting the value as nanoseconds since
3f8f80f0 ("pstore/ram: Read and write to the 'compressed' flag of pstore").

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: anton@enomsg.org
Cc: ccross@android.com
Cc: keescook@chromium.org
Cc: tony.luck@intel.com
---
 fs/pstore/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 2bb3468fc93a..8caff834f002 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -144,6 +144,7 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
 	if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu-%c\n%n",
 		   (time64_t *)&time->tv_sec, &time->tv_nsec, &data_type,
 		   &header_length) == 3) {
+		time->tv_nsec *= 1000;
 		if (data_type == 'C')
 			*compressed = true;
 		else
@@ -151,6 +152,7 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
 	} else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu\n%n",
 			  (time64_t *)&time->tv_sec, &time->tv_nsec,
 			  &header_length) == 2) {
+		time->tv_nsec *= 1000;
 		*compressed = false;
 	} else {
 		time->tv_sec = 0;
-- 
2.17.1

