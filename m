Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6036AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BF92148D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTl8v+cN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfCQSbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43458 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfCQSbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so14599898wre.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=myky0ef5OvvVSHnhntzEUKLe/1Qi1XrMR09z854PJyo=;
        b=dTl8v+cNeOKnGXWxSvbdBzHHZh0S95RnR6PwsYoz8k7+zzNw8zCgDng7r2cBvJQ3w/
         wdwp8+YIGqJXqn6qQnzexd+FA/L6/+9E3QF8NePl+yUi3VOLlPg+aU3yYAFfmAF4+zHl
         zIa/50JMGuO7wGE6pclg1FK7E3rMEwhugiwxhdEVCfiHHZWc9SO70cIYXnm8Z0qSGbiv
         5iOdVvxa5nc2Vbtp8x7ExGBN+enVpPm96Dc8/jh+oLC6dXvQxJrgpKPQfnD1qO9ZiFgf
         oB3HlCSM4jNShTwtw1YSxaMJ7+7av9/Wsnx5x1ulKGjt0xW+b1gwjDx/YICSJrRBOuqy
         1Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=myky0ef5OvvVSHnhntzEUKLe/1Qi1XrMR09z854PJyo=;
        b=HLYLhaILy5Fi2Pv75LFm8Qtg6pxXqaMllZnz9G1oUb52yA1wMkycDXctsO0vNWUtfW
         Pf05+Bs07EIurJn3kT4i9EA6+U1NTgp1+53cxp33In7M5uBR5i3IvDSeH8seHkfCGgqF
         LDvplMpqDSziXNnpGvYZ79kpHlINFCCD9w/d5wYKvQRYt1C1aRomylt+rRFLGemFrzcV
         v/0OQXGrpWDUgxdGn3w+ev6X8/oRI05qGCVsSLtpRf+/RZvLvqNm0BtyDe10zptmYRmM
         SHHbI0u4/909jX3iN3a9dSHxGRRnENFGwEXEk9ZIrS3TfVodw0R0mmNZum/DJTDAnGTC
         e/tg==
X-Gm-Message-State: APjAAAUZDfMZvJT0GQHkD52tRjt3O+BPUZYGXmUgThBakBRNOWByJwe/
        pH8bTAIBHe9ZXFM5jX1sXduxqYlMmVY=
X-Google-Smtp-Source: APXvYqzzuKFZBYMNTGS+M6qnEgYVATyxyYyN0gnovgHysXyaeL0oyB2Sy83m6YxjzuHHExt2lcUkcA==
X-Received: by 2002:adf:9c85:: with SMTP id d5mr9423391wre.68.1552847498009;
        Sun, 17 Mar 2019 11:31:38 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:37 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Subject: [PATCH 06/10] staging: rtl8723bs: Remove Dead Code in os_dep/os_intfs.c
Date:   Sun, 17 Mar 2019 19:31:09 +0100
Message-Id: <20190317183115.32393-6-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190317183115.32393-1-benniciemanuel78@gmail.com>
References: <20190317183115.32393-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`uint loadparam` uses the Macro CONFIG_INTEL_WIDI witch doesn't exists
anymore.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 143e3f9b31aa..4980fedb2fcc 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -309,9 +309,6 @@ static uint loadparam(struct adapter *padapter, _nic_hdl pnetdev)
 	registry_par->hw_wps_pbc = (u8)rtw_hw_wps_pbc;
 
 	registry_par->max_roaming_times = (u8)rtw_max_roaming_times;
-#ifdef CONFIG_INTEL_WIDI
-	registry_par->max_roaming_times = (u8)rtw_max_roaming_times + 2;
-#endif /*  CONFIG_INTEL_WIDI */
 
 	registry_par->enable80211d = (u8)rtw_80211d;
 
-- 
2.19.1

