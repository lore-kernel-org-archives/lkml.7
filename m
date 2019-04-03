Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C7C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4AB20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0oLvDCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDCRHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:07:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45077 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDCRHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:07:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so3114064wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz/glSIHhH70orAwX6M4+KrYsqgdQAVJsLPLDdsCvao=;
        b=E0oLvDCE10XK4oSYmVctu4i8+I1eDlhT7lW1v7rzEVD+mXPL1YbZvBHqDvKrbhrrdk
         h+K47c9BZcDES7WNbk23Abyn8fgS2qeHfzlsj7UJyHja0uSyzgRHgvuZsYhKbbj8suCG
         Efx6gCRnvnOegZlxYnATZvX0PJgBlZAM14Cpae6hKQBWkI6g02JT5L8D9Fd1v6C1Tr8E
         ElPjiyCFWoZedYiooF9+HonjfGH5FkxR8lj0mcyVzDmp9QsS22iWuh1j5xbJD+wqjNQr
         mizZqICXx14GAMottmLev6y15HsSR7o9n89icNztVlXaBOOZ4X4RDJRFCJjRVtU787Gx
         qaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz/glSIHhH70orAwX6M4+KrYsqgdQAVJsLPLDdsCvao=;
        b=oOSBsZzcDTrarHAwqrBbbIfC05TvirIqYLMitS2zSM5FiaPX1FPOtIXZsOIz6s/cE4
         hZuhuk/Wwk/KAzDkVzQw1ryzdiBc8rjU2PcknX+2McMyIRXmog0ajzlvJGGUHnOZhhE2
         LIx4wBDea8iHylVIndhBmUTNmaDI05db+2XLjON7CdwVwAaeT7wrqHK/bUNTdqWioQov
         +RBrI2lPpzq9Bcp1jahiw4H7O0KHDJpickGsysq5cAOCmjhXD2x+9T7vuOjBcMrziP/2
         MLUEVVrI78bihLSx4wB/gg5H2s8xf04j9viBwB0OcMOF5rrvQDB2BYC62O23afObTx3l
         3UNw==
X-Gm-Message-State: APjAAAUfArdCw6PBuedccI8HPuo0Bia4RjI1ga/rKEOBhINwuDQNRQta
        31Y72QAHHAj6XXRRyDU9tu0=
X-Google-Smtp-Source: APXvYqyhp0Q2grgpnk2xEFa2UCq1UkP368ivOICLC4DNecaI5nCpPzQTI/R5x/9qAnsN9+WlIL5rFQ==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr452922wrw.83.1554311239985;
        Wed, 03 Apr 2019 10:07:19 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb9a.dynamic.kabel-deutschland.de. [95.90.187.154])
        by smtp.gmail.com with ESMTPSA id a126sm21953306wmh.4.2019.04.03.10.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:07:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: make sta2sta_data_frame() static
Date:   Wed,  3 Apr 2019 19:07:09 +0200
Message-Id: <20190403170709.22088-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403170709.22088-1-straube.linux@gmail.com>
References: <20190403170709.22088-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function sta2sta_data_frame() is only used in rtw_recv.c.
So make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 3a621d58e53d..087f6c9a5826 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -632,8 +632,9 @@ static void count_rx_stats(struct adapter *padapter,
 	}
 }
 
-int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
-		       struct sta_info **psta)
+static int sta2sta_data_frame(struct adapter *adapter,
+			      struct recv_frame *precv_frame,
+			      struct sta_info **psta)
 {
 	int ret = _SUCCESS;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
-- 
2.21.0

