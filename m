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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CEBC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0CC204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRo/fDBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfESR1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:27:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32900 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:27:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so6075557pfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=u2lVPbWCs/nw7GnzyUIhDMrqS7+oEodUC8PkBDuay7I=;
        b=NRo/fDBPGQhDg7e7L2Cq6GJmTZKWrObVIfHPuz8uDY7bH2HMdU4ac3V54Skt3THW44
         s3Wi/iPla03SRCoQSgwlufGjwYTJ3HuS4OosoGDRU9DHipd0AcgnLsFnxmJEFqnCpr7k
         UCpjDiw3Nv6/j2dHEot66VQdym4BP6+UE80tUuJzaNSktSLcNnBE1ICS9cN2gUUGY9ls
         zFoioWW/V4DNGGqjShx6Xo8cYcl/aecbJjC5XwnSPYg2Rc/IHc9cHN6lZajeF6uCxZkT
         t81iT/AE86e06JJZR+5UFy6fSCUQ3IBrtqClC2Pee8HXuGjWi7Ign89F2G+xa5G3JduY
         yKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=u2lVPbWCs/nw7GnzyUIhDMrqS7+oEodUC8PkBDuay7I=;
        b=oA6ptAN6BmH72WcLbUe0s4R2mDuh1pKLrLfL1+ZUc0gCo3l/Iz5ckrPrv/78PqbNoi
         qakB5EcEOIyfxGu3Ud+cSqc7zugJjb1mQQ8HOvJOg2RPf8wYmOhTuQZRyJ9tg56RBmTU
         5zGXtSW98C8JXV89wfJCkTYcD6pXeDo8WXq/BwIqpsehG7Bu41l6ppG5fkrPMwLL5yM8
         KBknSbVens9LVbbLffISLINn5LCVW9f7ls5s187UeYLfRxtAizW5kC2Ao7ty79cf3uPs
         cJR6uIk/HPUV2SsOOzA6wkZPucUfiqYLlnbgGv6CAttmTIrvfMeJF4RNRG+zleb1JCW8
         LDCQ==
X-Gm-Message-State: APjAAAX6Vk+s2B4yT+jHDb2ChZy7ytUt54mdeZ0O5l0pL4Y9tdYl73yP
        lQq/XIWv97n44IRRHdOg09M=
X-Google-Smtp-Source: APXvYqy95PTGfppcoksREPaceYCdDH/7TXPCeJ3K9hlWWD5C+YgPSFmlUTIpVtSRCKW5b51Rx2oS9A==
X-Received: by 2002:a63:2260:: with SMTP id t32mr32743695pgm.222.1558286849851;
        Sun, 19 May 2019 10:27:29 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id o20sm18727736pgj.70.2019.05.19.10.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 10:27:29 -0700 (PDT)
Date:   Sun, 19 May 2019 22:57:24 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: rtl8723bs: hal: odm_HWConfig: odm_HWConfig:
 Unneeded variable: "result". Return "HAL_STATUS_SUCCESS"
Message-ID: <20190519172723.GA9329@hari-Inspiron-1545>
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
-----
Changes in v2:
  - fixed typo in commit message
---

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

