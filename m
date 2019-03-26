Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F28B2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLtFnYna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbfCZUr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:47:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55113 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfCZUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:47:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so14156649wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouBPg+ImuhkElC1A5gmZvHBCT5kkBeXVc/HxCuxh1Ho=;
        b=JLtFnYnaI5m9A1TbNOlBa+13UOpbcz14XGNsbBjl3Qxg9w5JhgYnsoPd3V3ccmYwEQ
         5PHOF4gN2MXrw60EgOl9aLW1XFAmhAe6ZrmwnlzNj+S7uKFFHUembq3taRAROiwgHyKX
         RG2/TN72+1BU661kPcW0K8N7kADddKmryAoCU9aL8/ZWIWE3/xPolLudUbEJEI7GXqFo
         nZqQo8OFzpjV5TGDe3mfkHwRDP16Nc+0K6+PvIm1FIe7jPl7Bm+eC4cIGv+8crO+GQt2
         GkIndCFYinHvHyjcw2RTBRlkMseMveC8nXtDWYIwZtm6HFn/p+reIhF7hNj938EcwA24
         CQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ouBPg+ImuhkElC1A5gmZvHBCT5kkBeXVc/HxCuxh1Ho=;
        b=daduSlhKlubdx6VCKH23Ii2Qd6JfrmkPD4ggP81BgJh/Zo3gmllQX5kwOL8yg2eaki
         xMfWURtTl7p98r2Nr0a3K8uYPTTw0jxip0zVwhWFJLy+8JvSfZHhG3ESa91teETK6HHf
         QrSQluBXQKBQScDdSuDShH1GNSVSuAxOtliNxCVoC9GHhTzAAC5UZZF+sRTOkg9pPxsl
         PR98ZuABajDfwHlyCm1+ZwS1z/+pvXvmvE2KrOEbCDzPXCuNWM7x/HLMUdMONgh9lQNF
         Nd0de9qM+e2rBrYU6sIRfWfFNTIxw1hY7w6BnMw9NZCl90IRFxfaZassLD/co12W4dfD
         egUQ==
X-Gm-Message-State: APjAAAXXlnzT46S/YiFn3lFLfuxyUSnPAUaukleMUiRYydA7qqXCfQaU
        z/cBvNZJvwBsFIROvgeVqMRxo/lV
X-Google-Smtp-Source: APXvYqzpGUcZhdQ2s6T/pGJASsG8ikg8UoWZcbHoPfm7Wf0mxIoCkypvVdFsZMtZCODSObZTyUtdIg==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr16549013wmj.120.1553633244165;
        Tue, 26 Mar 2019 13:47:24 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id y66sm13837211wmd.37.2019.03.26.13.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 13:47:23 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 3C440114237E; Tue, 26 Mar 2019 21:47:22 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Remove functions holly_power_off and holly_halt since unused
Date:   Tue, 26 Mar 2019 21:47:19 +0100
Message-Id: <20190326204720.18882-2-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326204720.18882-1-malat@debian.org>
References: <20190312203140.31785-1-malat@debian.org>
 <20190326204720.18882-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence the following warnings triggered using W=1:

  arch/powerpc/platforms/embedded6xx/holly.c:236:6: error: no previous prototype for 'holly_power_off' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:243:6: error: no previous prototype for 'holly_halt' [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/embedded6xx/holly.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 9d2eefef7b7b..829bf3697dc9 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -234,18 +234,6 @@ static void __noreturn holly_restart(char *cmd)
 	for (;;) ;
 }
 
-void holly_power_off(void)
-{
-	local_irq_disable();
-	/* No way to shut power off with software */
-	for (;;) ;
-}
-
-void holly_halt(void)
-{
-	holly_power_off();
-}
-
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
2.20.1

