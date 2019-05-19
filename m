Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088FBC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E93206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWa0lihc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfESRDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:03:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43566 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfESRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:03:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so6022578pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mwcMY0VK0yx/OQxigRKnWF/1+9CrvrV9U/DB+F7KGAw=;
        b=gWa0lihcO1Y5ONlmmU0LQ1eEAIlhK6f/aJU1utdVeo0XCYYtEatwMTpEY5kr45Pi5J
         lfkS21DWq0pWC0tceRES+F56ZHsIKGTk5G5r2i5vuJhieEwMB3nXPsTKkUbnsyS4DhlY
         dc2RjJ3qf0rVLnhufld77d/RuyYe823BdKP0ljeDqd1xcKqUNX6EEctCYls9PeBumyXE
         MVz9YpBdJnsszIncMEyW7IFJjccQgZdiiW/9OQR/QJT4sa7s0KyNhCIri9/7dOs9jDsK
         pK+z0ICK82Sn/Mf9CXm24v1Ywe/SZkgk81kGWRDmv9aRHI+28b3IGw32LTkDeuT9b7NB
         ArsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mwcMY0VK0yx/OQxigRKnWF/1+9CrvrV9U/DB+F7KGAw=;
        b=JuvJorUfsbLnj2fDW+/QJmjZUo+3937bhX9QG0PKS1Bu6X42hTAQn97lyn633wMnU4
         AuxxfHd0ZeehceeTMIhG6zDrvL79sopf1c7MiAXgoDlAWIa8ofMMxY1Co3QEonCiZeCX
         89uGF8CfslQCqfMQHXu8azawA8Lbi1CtMLi3yYhMGPqfa1XrC9kI3KQIYas7ZFzDiIsS
         EmJNBZONBJSyLDMJvQ8e1Yk4wB7tPU7LqVNy786P8L8A5wMAAqbqqTtQFIty9CQeLQ8F
         kNjzbQvvhhevJkCyvAx6JmcSUlRM4rrM1a+WDrjDInO2TaTZBQS/P8DrHvZHVvW8hpEW
         kURg==
X-Gm-Message-State: APjAAAW1xxWzJtiZltPNb8KnnlMly7U1jW5O0UBYtpcrYAqcKdMbBkyh
        7ZWb/VFGj4bXztV2HTNVLnU=
X-Google-Smtp-Source: APXvYqwN11CwT/b0nxrOEpz3Q6XeVBQSUgejFOtkNHoJMx6vFIoAVi+3hhmQ2zsppRxBem7n3E4H3w==
X-Received: by 2002:a63:e94e:: with SMTP id q14mr69861840pgj.110.1558285409956;
        Sun, 19 May 2019 10:03:29 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id l7sm13308033pfl.9.2019.05.19.10.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 10:03:29 -0700 (PDT)
Date:   Sun, 19 May 2019 22:33:25 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] taging: rtl8723bs: hal: odm_HWConfig: odm_HWConfig: Unneeded
 variable: "result". Return "HAL_STATUS_SUCCESS"
Message-ID: <20190519170325.GA6982@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warnings reported by coccicheck

drivers/staging/rtl8723bs/hal/odm_HWConfig.c:501:4-10: Unneeded
variable: "result". Return "HAL_STATUS_SUCCESS" on line 526

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index d802a1f..4711c65 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -498,8 +498,6 @@ HAL_STATUS ODM_ConfigBBWithHeaderFile(
 
 HAL_STATUS ODM_ConfigMACWithHeaderFile(PDM_ODM_T pDM_Odm)
 {
-	u8 result = HAL_STATUS_SUCCESS;
-
 	ODM_RT_TRACE(
 		pDM_Odm,
 		ODM_COMP_INIT,
@@ -523,5 +521,5 @@ HAL_STATUS ODM_ConfigMACWithHeaderFile(PDM_ODM_T pDM_Odm)
 
 	READ_AND_CONFIG(8723B, _MAC_REG);
 
-	return result;
+	return HAL_STATUS_SUCCESS;
 }
-- 
2.7.4

