Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B1CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89ED6206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe1LOh5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfDDRT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:19:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39933 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDRT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:19:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so4160608qte.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E14NuixZcfpW6ZIZGxU2+H0Iu5JxI+fgQkVKXhhmJms=;
        b=Qe1LOh5KVPfNL6wPbHdeWSUElN4bKTQTBG1ARCLcOsuS+sVYv1vao+zmPjH2Gdb0+D
         HBHYRDhOXFS/+C4H9J9XcEPUs1+BWbye40DIfvmQm1bo2Ax7UBAQ8Nuo9gSnm+gbkF2r
         yduUX3YWwlIa2e6VqH7KpNpjVFO/A91TQ8n75u7wdQKvaEW8yONxiaERXG0bwDWdOgWk
         NTB/pn5j+UdvTW9ZTxIDpICXE37AjRXrwDk2/H+7gamIFLPkL8vxJ5P+yfL5rBUtUShf
         rxFo1DGIhXFIOZh/nzQCPeA+qDDB2c5a6jEv/uQW11Sg5BdQvHfDPzUfbb/kTwMMi5wC
         IVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E14NuixZcfpW6ZIZGxU2+H0Iu5JxI+fgQkVKXhhmJms=;
        b=Urq321FwCsz7P2kg8DPIpZaYi2Jvcmf4dVCpMX6te1Su2S8IQIV4dYyZtW3KqdqyOB
         8K4VIbrBiNGl0Okc0YihJHk6p5H6o2I3PhjKrLkblvbxljBer7xvHkyy5DgTOqBoqyaV
         SobSDgLQ5EDiNdRw8FpLfDXOIef9oj7HGHoujFVYQ+1SdA3QHB8ODiTMmzise+reVaXG
         0eJsLU/BTgjRGyOmvIHm/eGOrM4SWIlClZCPUGUm9PVejUfvr61wJa7nHm4zXSvon3o6
         ILQUbWRMGl9Zo7H9wXvFDy2n2Mg33cMQWOnYV1YrekNvn2PHaiQqVzs3iJ1bfHyt6Niq
         57/A==
X-Gm-Message-State: APjAAAVy75eSn26ileMf0w9GlpdA0MqimPifvMRfcqfu7CFNmKRuyfoh
        g+zTgXUdXliCBGpAL8HMps8=
X-Google-Smtp-Source: APXvYqzYCCDMt8/o+qoMtrJp5Kd945JN+mp8SBV2b78HD5t6XgsKQP195u5PDXiQK/wNHQdS8gbSxA==
X-Received: by 2002:ac8:71c3:: with SMTP id i3mr6460917qtp.140.1554398395830;
        Thu, 04 Apr 2019 10:19:55 -0700 (PDT)
Received: from localhost.localdomain ([201.82.148.205])
        by smtp.gmail.com with ESMTPSA id v15sm9092243qkb.81.2019.04.04.10.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 10:19:54 -0700 (PDT)
From:   Gabriel Siqueira <gabriel.gabrielhs@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [Lkcamp] [PATCH] staging: rtl8192u: Add missing space
Date:   Thu,  4 Apr 2019 14:19:07 -0300
Message-Id: <20190404171907.15908-1-gabriel.gabrielhs@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error: "ERROR: space required after that close brace '}'".

Signed-off-by: Gabriel Siqueira <gabriel.gabrielhs@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 64d5359cf7e2..b7769bca9740 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -107,13 +107,13 @@ typedef struct _HT_INFORMATION_ELE {
 typedef enum _HT_SPEC_VER {
 	HT_SPEC_VER_IEEE = 0,
 	HT_SPEC_VER_EWC = 1,
-}HT_SPEC_VER, *PHT_SPEC_VER;
+} HT_SPEC_VER, *PHT_SPEC_VER;

 typedef enum _HT_AGGRE_MODE_E {
 	HT_AGG_AUTO = 0,
 	HT_AGG_FORCE_ENABLE = 1,
 	HT_AGG_FORCE_DISABLE = 2,
-}HT_AGGRE_MODE_E, *PHT_AGGRE_MODE_E;
+} HT_AGGRE_MODE_E, *PHT_AGGRE_MODE_E;

 /*
  *  The Data structure is used to keep HT related variables when card is
--
2.21.0
