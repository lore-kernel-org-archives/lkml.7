Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76221C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419442084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 06:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p19fqKaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDMGrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 02:47:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50421 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfDMGrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 02:47:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so13882361wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 23:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PrZJERGrfHS5fuAJa2beU5my6+1VVNvDPkNccq7f28c=;
        b=p19fqKaHVbhXQKlUoCid51WvLBamHxDjo41FEuhYmZEKguSgAM1zyYkFmQVPsR+yn1
         rARavEm/FdsLdqKyRO6mgUXX8vo4+406Q+vFRNtUcDZpQUL1JvTawyhspg/9s+xvKtTx
         5gvUPsTuQbTS/k7cDiKkzGjSB1DEv3d1ebzbIEzTTJo/j+XOUKa4yZa8ivDo9dYFxSzt
         KqKkawAb6+Y4YlifOWg6zihtqBU8J29KVrib1gvico7moeYJBmFkW9EyRzWriJ9nq5aj
         xzkSTPLNMxTka/Ym1K3CZYe36/Vy2snFXs1nSAZ1ji7/C31/JrmbsCJRfU3NNcXO1OzK
         c8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PrZJERGrfHS5fuAJa2beU5my6+1VVNvDPkNccq7f28c=;
        b=DUA7rt906irDDKIVsUbRhaDkjH2fptGz1rvh1vw/j7jnC+68U+pkoetH4qLGYvFhQW
         hDX2Omdi2M7jySBXsMPp2PWz8Cf3naAIhGYTdUMy1Ak2S+qwMTZB1jxXEYpNMyreIeDK
         ZYW0PK0kCpaUWLC+HpKWIOrVFoUceib9omYlR1lyR+JyrQmD9cxEmE19t/knvvvih/gr
         S3eQ+stvrjhtfvBqqsrDsANyKfjjleo1gQ2nJliiMpn14lz8RstagtC1ncuff67W4Uiq
         42ePBoh9jvaH7A1AlSY0XzLosvnQ+zq13hx6rhxWDtSNf2M9KomHiHFTEEdESR1B8e3f
         6Hhw==
X-Gm-Message-State: APjAAAVgUgKsnjFKtAqGuayF7O3M83ttvKLCohvHQrO78rpjDA/iiMKz
        X8uN/ZtEEuYKDifJgiFN2J5nT5ga
X-Google-Smtp-Source: APXvYqxJOcBh4b5DJD0XWa8pL2gfBAHcYZ+mtYvu/NpvhT500QfFmuGXokQQcg85+57X2vZOle54ig==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr14415919wmk.103.1555138055302;
        Fri, 12 Apr 2019 23:47:35 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2def:500:2ca3:f513:3ec4:694])
        by smtp.gmail.com with ESMTPSA id x14sm13493237wmj.3.2019.04.12.23.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 23:47:34 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: mark simple firmware interface (SFI) obsolete
Date:   Sat, 13 Apr 2019 08:47:24 +0200
Message-Id: <20190413064724.8430-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown has not been active in this part since around 2010. The recent
activity suggests that Thomas Gleixner and Jiang Lui were maintaining
this part of the kernel sources. Jiang Lui has not been active in the
kernel sources since beginning 2016. So, the maintainer's role seems to
be now with Thomas.

The referenced git tree does not exist. Instead, I found an sfi branch
in Len's kernel git repository, but that has not been updated since 2014;
so that is not worth to be mentioned in MAINTAINERS now anymore either.

Len Brown expects no further systems to be shipped with SFI, so we can
mark it obsolete and schedule it for deletion.

This change was motivated after I found that I could not send any mails
to the sfi-devel mailing list, and that the mailing list does not exist
anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Thomas, please pick this patch.

v1: https://lore.kernel.org/patchwork/patch/1033696/ 
  - got Acked-by: Len Brown <len.brown@intel.com>

v2:
  - also change status to Obsolete

 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..07bf81c52fe6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14150,11 +14150,9 @@ F:	drivers/video/fbdev/sm712*
 F:	Documentation/fb/sm712fb.txt
 
 SIMPLE FIRMWARE INTERFACE (SFI)
-M:	Len Brown <lenb@kernel.org>
-L:	sfi-devel@simplefirmware.org
+M:	Thomas Gleixner <tglx@linutronix.de>
 W:	http://simplefirmware.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
-S:	Supported
+S:	Obsolete
 F:	arch/x86/platform/sfi/
 F:	drivers/sfi/
 F:	include/linux/sfi*.h
-- 
2.17.1

