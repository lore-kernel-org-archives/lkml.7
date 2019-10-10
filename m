Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CEEC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB240208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZbjJKd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbfJJDkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:40:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36665 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfJJDkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:40:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so2759099pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZK2sCc0LVeILJIcSjSFvo/+6Nag3nmcw2niS7MjL9pk=;
        b=MZbjJKd7k1YG/Oj7W2lWYjKMxRW1Q5nh1GwhgnqilvVgXbJ8KtkSCh3i7cxrHzefov
         O+xCscx/l35nQbKifkoW/aJQwMtIUmPz5BxoKQcZUql+jRB4L4TeQa2z2Yu8h8u+VhNq
         yJcVVNApCTsmOwFyar3Nrui/jODAtPl5lNTr4eIcPfRakt+wAzm9DJ+e2lt9xuuu5Ypg
         m9o+mtOmYACJ17RT7tt87N0Q/Hz4ZfRvsufZpzS8skWZcvJHQNZt3b8/+67I3o8i9F2y
         PlNE4OP2l9zcrvk4HDsoOqNahY+soNus1/iBHVIYxQA+KR4hFDuu4okSbZfDIb9g261I
         43mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZK2sCc0LVeILJIcSjSFvo/+6Nag3nmcw2niS7MjL9pk=;
        b=mFwjn0hlHamg1zp3Wq48KuY2WAtnJBxkCIM6bJh50Nbw/lBavz6LkVkqbIuYJnGbRt
         f9CD27uKoxjjlpAGNvIsPoMyLd8C5niGRb01ATxNPcBMdgA0j+qWuqUN5LPrgDW/XuhG
         cPjPGm31YnzC28/xMSbKaCglP9RMGcnChSI1c5ErXgpjY1Ba/i3hPN9B2Ypyk6zgsNaJ
         emiDmPL1zPXM9me4zAlX0WAqozXYXOHODlgeJRuCNvmTVLgaTi7YGKHJA9vqNmO6Jpov
         edaOIDcMMTdWTdSls/pABugOuvWlCPj0w7g/Dj++jPOSGe+c0bGFIxoWX6Hnnfl9PcoL
         1+bg==
X-Gm-Message-State: APjAAAWgMiJ7UIm3hZ2UmF8bHilh2GMiZVEVWIsN6YqCbs0vFyVShDKB
        xjK/HymUJ5s7w+VAYfnuH/k=
X-Google-Smtp-Source: APXvYqyTemc/FWjKdm29DImmjDESmjkYF2U0EP9wwKKCmUQjHADNu/eEOJjURdO74K3fMt7mZBGrRA==
X-Received: by 2002:a63:d450:: with SMTP id i16mr8226993pgj.126.1570678808149;
        Wed, 09 Oct 2019 20:40:08 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id k95sm3517741pje.10.2019.10.09.20.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 20:40:07 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH 0/4] Fix style and formatting issues in rtw_mlme.c
Date:   Thu, 10 Oct 2019 06:39:20 +0300
Message-Id: <cover.1570678371.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchest addresses multiple style and formatting issues in the
file drivers/staging/rtl8723bs/core/rtw_mlme.c.
These issues are all reported by checkpatch.pl

Wambui Karuga (4):
  staging: rtl8723bs: Remove comparisons to NULL in conditionals
  staging: rtl8723bs: Remove unnecessary braces for single statements
  staging: rtl8723bs: Remove comparisons to booleans in conditionals.
  staging: rtl8723bs: Remove unnecessary blank lines

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 157 +++++++---------------
 1 file changed, 48 insertions(+), 109 deletions(-)

-- 
2.23.0

