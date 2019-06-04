Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF52C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09072075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tfm30alF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfFDRI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:08:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37138 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfFDRIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:08:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so848150wmg.2;
        Tue, 04 Jun 2019 10:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pdvAf1mFWkk7aaJwf7fmuVKozOhhZKw0DpkWW6ujI0s=;
        b=Tfm30alFR/zDSIs9Y7K+mEui3JbkkyrNF8l31A33+j+VFbVRhXwRFkOHTFbEgvXsfR
         BFe2zkFarltTQpRchK1mscUyK3x1b8QjHRAbexHMVjH8W/d9a0yqYSv9YN++F5ldn3pT
         kxlvAhw/c4SWwOJfIUoe5mFxDzIYMZekotpIP9HAaY3FpbCZMicuBpK0EwsYgHsIjn1d
         jBimTfVRNRP3bH9nANJBs5r/2URgwt51U5Q3sIV6ZhJkx2LfkrwcVYciilRJ2ojHL64K
         BeeD5zWehs4FAW/qlTOZcvuCRAlYtI5nFFkNkgQgR+0jji/hBwGD8t/oYQHPqhV+gmGb
         pvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pdvAf1mFWkk7aaJwf7fmuVKozOhhZKw0DpkWW6ujI0s=;
        b=d6jJobPLoc/Mk/KFdHVErSbC/SOPQVOUclBRRbQzf1AsmBmeF/Yr5f6767SIRMxeiq
         Ow0Bo7uIgp5O1DR1bzyno+sr9vF7MCgrRuFaUMykxymEIHqocpb4XRrkOzCgVz9apCEx
         Y0OP/yuetSUc8FjVrHQRGvHvTZaW77oZhf6xcly/zN4UWf0a7ZPsSpeihivDkw501poB
         1B6C35/YK5XfmFokRpJWMCrIQ3h6xme/f/m8UQEqWUW0WQs7Eu7uHnpLfc97bAt688/R
         ipAsfORXWAYlvres+NDdCmlZmiGpUz0A09aSQFgDjaQlcc6+ORqzut1vAOpn0S/zijf9
         ELHA==
X-Gm-Message-State: APjAAAWnwdJXATguZhqvyJxnLzUaSJIVVSkXJUkOWaPwpvGumbzEREr1
        A/CXlFTvt77VqiuW4hoN2WE=
X-Google-Smtp-Source: APXvYqyanbKljFrCHQHGpyxNjOQOcWLKgdl4NmP2rcSzrCVNCV2XWu7rOq31705aghxEe70hlcAlUw==
X-Received: by 2002:a1c:3942:: with SMTP id g63mr17394098wma.61.1559668100033;
        Tue, 04 Jun 2019 10:08:20 -0700 (PDT)
Received: from localhost.localdomain ([86.121.27.188])
        by smtp.gmail.com with ESMTPSA id f2sm19692218wme.12.2019.06.04.10.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:08:19 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net, richardcochran@gmail.com,
        john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 15/17] net: dsa: sja1105: Increase priority of CPU-trapped frames
Date:   Tue,  4 Jun 2019 20:07:54 +0300
Message-Id: <20190604170756.14338-16-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604170756.14338-1-olteanv@gmail.com>
References: <20190604170756.14338-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without noticing any particular issue, this patch ensures that
management traffic is treated with the maximum priority on RX by the
switch.  This is generally desirable, as the driver keeps a state
machine that waits for metadata follow-up frames as soon as a management
frame is received.  Increasing the priority helps expedite the reception
(and further reconstruction) of the RX timestamp to the driver after the
MAC has generated it.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v3:

None.

Changes in v2:

None.

 drivers/net/dsa/sja1105/sja1105_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 9dd2ab2725b6..fceca0e5984f 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -389,7 +389,7 @@ static int sja1105_init_general_params(struct sja1105_private *priv)
 		.mirr_ptacu = 0,
 		.switchid = priv->ds->index,
 		/* Priority queue for link-local frames trapped to CPU */
-		.hostprio = 0,
+		.hostprio = 7,
 		.mac_fltres1 = SJA1105_LINKLOCAL_FILTER_A,
 		.mac_flt1    = SJA1105_LINKLOCAL_FILTER_A_MASK,
 		.incl_srcpt1 = false,
-- 
2.17.1

