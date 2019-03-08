Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A0C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A9220854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc6yfexM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCHECw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:02:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40147 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCHECv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:02:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so15305764eds.7;
        Thu, 07 Mar 2019 20:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSUWPDkLCMVP3WJ97ekDdUYsu5f2Sgo2jFY9E7ZYMaQ=;
        b=qc6yfexMtIIcmudMi7dXFk9Rbj7ISAqmEW2FTPhIWF9g2kMK13JK+VyYUsVoc7PsxL
         fTItgYtUv1YVo4uEyA/07pDfzVlghrms703ZMGU3ee7sgTugUmEN9Jk5Q3vcNw1Otwlc
         G0z9akZYVxgJ6y2sFrQETUImGtLE6CflvhIuS2EIffZaszGr11rviEXEXog6+uz89dzZ
         NOVJf0SQnMdsIeNhENPtzFnfSendWhLIElgiLJQCtVQ6UrMHUo3xO6gE/znw4y8tUnwK
         5M2WJK5M8rzOIZYezSespJjDTw1O7YT6xAB4TdFbyLM82IbHbscxyqsT6TP31dkF0dfV
         BxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSUWPDkLCMVP3WJ97ekDdUYsu5f2Sgo2jFY9E7ZYMaQ=;
        b=tAEwAwL68p/dtXwfTkcv7Vw9ofAmVu3QCTx4eOnDxRZRC33pJ+sncFjayjXtN0rTcL
         k5mBvZYx+62Zspfzo6SrDfYWQECQwBQ5ZY7+rj4kqBjoomQSItuR9RT3kglg0SCBJPuK
         RphgdFEjCdmGfhEo5GORQDT6X0Soostxjnah5TGuC5WjqSUYyp0YndFmeLiiyb9dTrPT
         ca+kcShZc2Xs59OvxfdpObnzbHEv4qEl5hNoXbpnX6c6PAf9lzd0VysblbMCUN/rt/L2
         mpasHH1AECxTmLYzgrsMej29/30F4DlnYva/vicJnzsvcyg+FR6LhuW+znm6v9BX5iuN
         TQ8Q==
X-Gm-Message-State: APjAAAVEHo5Loy3qJvhPMICsJYfgDNvNsOkZlHTQwlS3go6f/peihq55
        XhLp/dqWVeT3arqfBLYVuTo=
X-Google-Smtp-Source: APXvYqxirboss2GDcOk2fMGEMYjCv52n6JtNGRIrevzS0YeyOY9kIPA7Ftebb5nhGik6XLjBamrLKw==
X-Received: by 2002:aa7:d444:: with SMTP id q4mr31591342edr.278.1552017769430;
        Thu, 07 Mar 2019 20:02:49 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id x18sm1895395edd.4.2019.03.07.20.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 20:02:48 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] net: stmmac: Avoid one more sometimes uninitialized Clang warning
Date:   Thu,  7 Mar 2019 21:02:39 -0700
Message-Id: <20190308040239.9400-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307162101.29204-1-natechancellor@gmail.com>
References: <20190307162101.29204-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:111:2: error: variable
'ns' is used uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:111:2: error: variable
'ns' is used uninitialized whenever '&&' condition is false
[-Werror,-Wsometimes-uninitialized]

Clang is concerned with the use of stmmac_do_void_callback (which
stmmac_get_systime wraps), as it may fail to initialize these values if
the if condition was ever false (meaning the callback doesn't exist).
It's not wrong because the callback is what initializes ns. While it's
unlikely that the callback is going to disappear at some point and make
that condition false, we can easily avoid this warning by zero
initializing the variable.

Link: https://github.com/ClangBuiltLinux/linux/issues/384
Fixes: df103170854e ("net: stmmac: Avoid sometimes uninitialized Clang warnings")
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 2293e21f789f..cc60b3fb0892 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -105,7 +105,7 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	unsigned long flags;
-	u64 ns;
+	u64 ns = 0;
 
 	spin_lock_irqsave(&priv->ptp_lock, flags);
 	stmmac_get_systime(priv, priv->ptpaddr, &ns);
-- 
2.21.0

