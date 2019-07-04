Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D204C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202CD218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQHpY4yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfGDXOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 19:14:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42623 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfGDXOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 19:14:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so4370736lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 16:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h0qJMdNciD39g3Q1jo3+1MbbNG9llP7wamgm8+ijc+0=;
        b=kQHpY4yAX9tuFqi39cDVI528gNTKLvGMgp0fqlEEE4DscT2m11B0xfPLDzS1j+aNlZ
         UGMk4PmMzG9FjNTsoVkPBdsX5iAy54gTqfhQ/kkz1CJfRr6/yZPK6hdSNfh52Ye2n2Z/
         7K1NL3GmJfoDXyyJRppCGfHFJcBQmsQ46cOe6yjy7ZT9VnXN/dCd6d5C5H+OXYUSIcU/
         HA/ERprLUpxQi6I5rKcKODbM6zC6zJ89Q9AXb1sKtMe4+xhPbdzfhVvc/TrPTPHtcCHR
         IOCXKtNAOOOZ5q4fu+AHhPqh1/fAlMu7ALbCkPIvW8scV45AIsE51nY0Q9hCsrzhCYk6
         NKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h0qJMdNciD39g3Q1jo3+1MbbNG9llP7wamgm8+ijc+0=;
        b=Nl0K9BREKvVZ+uh/YZXV5RzNRCjl4mBobp6RIUqPES2OmxT1bTYGZFwZi/ANOvIll2
         aGNw2mESMUCvv1cpg6nRw1S/XDCHfJ51DO0a4trKS+nC4woNpylQCkjbD/MlMps5ymH3
         0SqMYssNVPdXyQSRUiaOFqtjpfIl+KAWie6kOXPDZ1lX73ZDVKn8lxhuI7oYs3O+AfBB
         1InRvFLNgSw5dg33SLDjLx8w/PjfLS7EjhXd9FEIt/vTG0mb1QJ3Y5I2qDf/XBVGaw8s
         RoYR2tlZkvah+a2ktRXK341o5M1bz0dcv9HGfudcVmQvdqBsDVQZwxYV7Rc4rAlR5SrB
         za5w==
X-Gm-Message-State: APjAAAVtKd9YyuiNgrbIShNdiG72AJSfzq6QOPLCA6vUF6G9j04iBJTU
        rj14pFOnwqj96uHaFYzaBx1u5QrfDZs=
X-Google-Smtp-Source: APXvYqzfalFMVIaHNS8AIz3ENvdFXkSmu5akxzmRLBfyyInkhLR4IJea8MvWY4XesoVIHHVkHIME8g==
X-Received: by 2002:a05:6512:70:: with SMTP id i16mr413464lfo.26.1562282076772;
        Thu, 04 Jul 2019 16:14:36 -0700 (PDT)
Received: from localhost.localdomain ([46.211.39.135])
        by smtp.gmail.com with ESMTPSA id q6sm1407269lji.70.2019.07.04.16.14.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 16:14:36 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v7 net-next 4/5] net: ethernet: ti: cpsw_ethtool: allow res split while down
Date:   Fri,  5 Jul 2019 02:14:05 +0300
Message-Id: <20190704231406.27083-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190704231406.27083-1-ivan.khoronzhuk@linaro.org>
References: <20190704231406.27083-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's possible to set channel num while interfaces are down. When
interface gets up it should resplit budget. This resplit can happen
after phy is up but only if speed is changed, so should be set before
this, for this allow it to happen while changing number of channels,
when interfaces are down.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index c477e6b620d6..e4d7185fde49 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -620,8 +620,7 @@ int cpsw_set_channels_common(struct net_device *ndev,
 		}
 	}
 
-	if (cpsw->usage_count)
-		cpsw_split_res(cpsw);
+	cpsw_split_res(cpsw);
 
 	ret = cpsw_resume_data_pass(ndev);
 	if (!ret)
-- 
2.17.1

