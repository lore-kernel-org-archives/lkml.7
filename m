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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5549C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93761214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNJMQ8eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfF2KWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:22:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45823 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2KWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:22:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id z19so3709237pgl.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mk94RXz9RbYmNlsAwePZkKE+FVfS/zkDopugHxCtBXc=;
        b=JNJMQ8eCufU2eLT/mkS3juwj8990gOhfuYb7cNLs8ZykSRwiYQPiY0LHx7vJoK4Tba
         GMxIEMDN1f5SIWqGhy35JSQHVy0DISAeFsTWII54AvRZOpttM0wJudF51tvozSImnmSO
         GdWX33zavKjkB7IgT4QKYONDFfeXOvau4AhPEDgODF+II+pq4xpc5YLXjC9tFOYTCkYp
         SobHX1eLaA/rs6rdYHDi8zik5Da66faE2ssmAkI1WTedL/DHIIAKoEi+Bp223hzXDdQd
         LqGJ98RPBrIglKLq7uYwE18+VhXtM12d8Khd1TAS1qiU1fCNbRGVBwmIXytnKo52Q1j5
         LrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mk94RXz9RbYmNlsAwePZkKE+FVfS/zkDopugHxCtBXc=;
        b=iigZSf0/zUDhG/zc7fz5Azgu8BJ1A5T87KXkYkd9miKgS6N/+P/5yEpk2PTHVcCqKs
         Zih44Xa2qzelmC1wubXLL0JrEP+cessUpmTAAVo9obVHM6cYOyXovSRzqsWFsR7zrOs3
         yJmrz+QS2rpL/NExe+48EIGEMvojCXZ8LB3H+nS2Jk+HMgI0LT81ufH/oNXX6QAS3EBp
         ijqKoX8+AoM3p/Slc8h+9cP9KzkkKT+suVFWciC2q+DHn2cp/A3dQQ+J0Q4lmydhrPxf
         GnrqF9ZmEGD8Tp8rUEplHokgDLezf9WFloh9XqYg+TVY9v00m+5T67s2WWF94w+Gq/69
         W8Wg==
X-Gm-Message-State: APjAAAXva9j+NHqtEPkLluhd+4oOWxRmRzGmMPx3gcEmfmKVvVoK5xJr
        8z2w4OoUV2cX+jMa2BqPyAI=
X-Google-Smtp-Source: APXvYqx3xbe5HQEZFR4EEL8IU0+as94egYt5mWZnuF90qF7kkJ5onMxWwsWRgE6a866YgzE+tlcBdA==
X-Received: by 2002:a63:7f07:: with SMTP id a7mr13589957pgd.26.1561803771236;
        Sat, 29 Jun 2019 03:22:51 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id f7sm4778667pfd.43.2019.06.29.03.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:22:50 -0700 (PDT)
Date:   Sat, 29 Jun 2019 15:52:46 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Beatriz Martins de Carvalho 
        <martinsdecarvalhobeatriz@gmail.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629102246.GA15070@hari-Inspiron-1545>
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
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 3367644..aabcb32 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1191,7 +1191,7 @@ s8 PHY_GetTxPowerTrackingOffset(struct adapter *padapter, u8 RFPath, u8 Rate)
 	PDM_ODM_T pDM_Odm = &pHalData->odmpriv;
 	s8 offset = 0;
 
-	if (pDM_Odm->RFCalibrateInfo.TxPowerTrackControl  == false)
+	if (!pDM_Odm->RFCalibrateInfo.TxPowerTrackControl)
 		return offset;
 
 	if ((Rate == MGN_1M) || (Rate == MGN_2M) || (Rate == MGN_5_5M) || (Rate == MGN_11M)) {
-- 
2.7.4

