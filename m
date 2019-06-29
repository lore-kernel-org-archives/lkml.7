Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56269C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AACC2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZQWoed5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfF2KhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:37:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37602 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2KhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:37:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id g15so1829014pgi.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9mH2XccuZeODfxZbBcYEVAm/fyB1IljuBm5N/klAdV0=;
        b=vZQWoed5/6nx3bfawcj951wiGTtCCPQtMTXJMr6fDiwrBnAWwz6KKXR/9l4nkzd70Z
         VA6Bjw0K9xF87awHmDkarSSkRLSKLu5snbe4CdFZg+fI5kU9fIoDUtsC2XJrXR2ooONa
         UDuFnLjLEmraTlueTcZPECMeY4rx6dfdOkDqIsqrcK3VTaPMxxzvAupGNlLYhNS9FWJm
         A2RHauruG9OVU49OzYa3F9HsiSHp3h+TOPF0RAmgmLxELvokE5jGKhL8Rx4QcrrZhcGr
         n1Hjgz5d/dd9tGS56PM8W3osOFT+e/6i17Pe9kz09J7O9+H/c8m/HNErKVMNuVqMtpV1
         Xn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9mH2XccuZeODfxZbBcYEVAm/fyB1IljuBm5N/klAdV0=;
        b=CpPFkGF9aprVLEG6tUdt3uDGjnFwYaLgW2zVxWtA8hPkXtDR7VPGDXst0/Kmc6s/0u
         QKiWp/Aq3OwR2c15kpedFquQfJMtUNmNLiLihYuIywrbHPULNXJfAcP57b3zRFHXW/MU
         srtZ2VIFk4D7c7MIyTRnp8BceP3nlN0TDjNuWFe0W2hd6zSOE+lR25bcuvVi1uy7Drpf
         fw84NbLVEz4dBFsdS9rJxo23r1er3q+Qomj7HXDiqNkEMON32d56VtdBFpkxuVa7Qj+W
         WjENeyMsQM7n44v8q4RFMInyhF6qG6XKRiNe0X6Ec7y3l6tNxVc/sfLCQdVqPgE3PFDw
         hU3A==
X-Gm-Message-State: APjAAAXAjYfyEkjJF6eu+ohRfTfb2UK9hkarvOu1ksVBrluo+OUkdDVj
        wckCYc6hnX87Lze4fA9aWhNNiO82
X-Google-Smtp-Source: APXvYqyFJ1ddt4Ke79mZkiwYHtw/sfjAsdAF2EVubRYaC1xaRMEHJi/B/IFd5JKTq9jouIoZ1WsRvg==
X-Received: by 2002:a63:4006:: with SMTP id n6mr13228072pga.403.1561804619567;
        Sat, 29 Jun 2019 03:36:59 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id k3sm4566600pgo.81.2019.06.29.03.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:36:59 -0700 (PDT)
Date:   Sat, 29 Jun 2019 16:06:54 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629103654.GA15592@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 2763479..d3025ca 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -140,7 +140,7 @@ u8 hal_com_config_channel_plan(
 	}
 
 	if (
-		(false == pHalData->bDisableSWChannelPlan) &&
+		(!pHalData->bDisableSWChannelPlan) &&
 		rtw_is_channel_plan_valid(sw_channel_plan)
 	)
 		chnlPlan = sw_channel_plan;
-- 
2.7.4

