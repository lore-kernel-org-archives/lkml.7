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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022CA20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni1mKPir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCQSbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35551 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfCQSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so8661229wrp.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=KaDi2iVOcodlzUomJ8CuqU7h3SZ/Mey4GdaKVkxnTuo=;
        b=ni1mKPir6uMjpPg9Ik5cJ36tQThgSkSYbVDt0q0v6P1KmK8wxtpPf0S7CgIdTNLy7J
         sajNYigX112mrGWKiSHDqIccr2S2j96l5mQOx5+88BltCl9N3nM/rwVsub9hG5mUNUVw
         Fq4E86/GrAmtbCDU0beA/AY+Z23a8H9iCu+xyKg46NHuae1BpmZA2tpKQCDHK0Jo8TWZ
         k3D5Hx6Lpdv6h+AJ+JmqJX70aAWF3KaK9/wgPnMmvE6QRcs6MyDJz1ZSbeGzCQRbbOO8
         2V2ftrcaL22IR55XIeeOamHvBtCaKxsaA0Cf1GOWyeeSolK735vuS2z40uRejnZ2x/b7
         bSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=KaDi2iVOcodlzUomJ8CuqU7h3SZ/Mey4GdaKVkxnTuo=;
        b=lAbX1gFXcrNd3jhC6WIt6+WxtKdflqnf9TN8lpCyys8/m0XnCV7e6GBSRWYTXqxti9
         RH3KtHEySrsBeCzOBg0I1JsvBpxAxKUGArERgt5eYTeC0uurU8yXRxfXudc9QWTuYKh8
         Q+b5+TFkvztsrFZ6ArpHRssbtsHZcVtHGnUkDydJaHvWv/M4RVM81slsOQqzSZDN8//g
         ncGXykC7WfX6ftgkagBbqr9UBCnkCbplJUN2lWOOne/kPL2FPNZUnfiEEB03b1tNiHCB
         9MQgrqP7NTgqDzLgtzdg/g0Mq8LlPI9USLLercSzJqG+fp8MSrg+aAPTbolY3LnYrHj6
         h0bQ==
X-Gm-Message-State: APjAAAW/TdwS5Nvz/P7JFtAYNGRB630TGXebvQvdLDUxzN8OFOUUSa4i
        8wUzaYJuKIbPV90vuqS13fFFx5Nm/Ls=
X-Google-Smtp-Source: APXvYqzmXqAmdMevSCc8LXXjC3H0fvgVtoWKcJ+Hh9oB0zrMdslnH7CuF1OIj72drPisH48Mphy67g==
X-Received: by 2002:adf:b591:: with SMTP id c17mr10052234wre.195.1552847493981;
        Sun, 17 Mar 2019 11:31:33 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:33 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 05/10] staging: rtl8723bs: Remove unreachable Code in core/rtw_cmd.c
Date:   Sun, 17 Mar 2019 19:31:08 +0100
Message-Id: <20190317183115.32393-5-benniciemanuel78@gmail.com>
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

The `case INTEl_WIDI_WK_CID`-Statement in Function `u8 rtw_drvextra_cmd_hdl`
wouldn't be used because of CONFIG_INTEL_WIDI.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 91520ca3bbad..6c6ddf461590 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -2007,11 +2007,6 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
 	case CHECK_HIQ_WK_CID:
 		rtw_chk_hi_queue_hdl(padapter);
 		break;
-#ifdef CONFIG_INTEL_WIDI
-	case INTEl_WIDI_WK_CID:
-		intel_widi_wk_hdl(padapter, pdrvextra_cmd->type, pdrvextra_cmd->pbuf);
-		break;
-#endif /* CONFIG_INTEL_WIDI */
 	/* add for CONFIG_IEEE80211W, none 11w can use it */
 	case RESET_SECURITYPRIV:
 		reset_securitypriv_hdl(padapter);
-- 
2.19.1

