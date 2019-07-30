Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7648FC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6F0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVBvxgZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfG3DEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:04:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41546 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfG3DES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:04:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so18903723pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 20:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gD5mfEMWuXarGCctKEueAm1TQYwfzvdTbbmFFyNOtWo=;
        b=UVBvxgZ6r/zLyKNUUmC7qzvDk5EBxkpH1aC3y+kIo97u1sg42yewB7FkZdIpZMqvpS
         QIB4TpEnF3SyEtGHbXb/AB4jlJ9mRLrxHLY5bz5G9UFc70g+I+IJA+g1/ySrcOw/pfWt
         tzD7FDrpyDosPIvxQacedkrga26Bv7MfrsThJiWoy5ymskilTpMy8SO2zzUd7beqKfsl
         u4Bbb9PSRp/zymco+TgOhWf3RH0SNTve4sqmjJQ8YX7KeQehRXgKMlEsLB5DVtQL2FOR
         sfTCYP4R/1c2eDlXt/0WCDtWBVhW7r29c2S1WcHEstdLYrR/syUqDu72U6O9LfaWd3Qt
         0WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gD5mfEMWuXarGCctKEueAm1TQYwfzvdTbbmFFyNOtWo=;
        b=jr2YxxwkZB144QFs+EM7HhCpaGkjj2wW9umSfAv7QGoMM6MfirOQcodRh0agiJTKJj
         EliL/kx5uJ1TNFu6LxkSjJf3ELh8xy4Umh6Rn2fqYoKFoZp/3DzrHTkTiaKmNEBsVjNI
         2HrnPi6OTx+ZgF2VgSZa43VDG6EbyHsnM9c4amBDKpZw8UTLyQ4ydVhd7riRvUpY33jp
         SuFRPhNa1y4grVCMf+cJg//cRMYWUOLewVmsaFcSzDugseWGfG+m2rkz4/Ek7hMmJaeE
         VC5tL7zPVID9B0Qj3N0h9Nq1PntR138mnSlWc1e+MXezn2J97z7xDIyJzqfov51ry6z/
         04eQ==
X-Gm-Message-State: APjAAAXnyrmAYaFkycbmNgiA3687iBEKXplkwbgEaut1kLCdzPgRNaTZ
        P8U1VozEsNTxV/bV2yPqTJ8=
X-Google-Smtp-Source: APXvYqzdWv0EJeJ8yPP/yNdZlsxyvWTQ6kqL8q4wcSPSHXHBf6Lp1lQKBVsPsqDq/ZrNU2RgtE/OJA==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id p33mr116749314pjp.27.1564455858074;
        Mon, 29 Jul 2019 20:04:18 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id n185sm45771965pga.16.2019.07.29.20.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 20:04:17 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:34:11 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: core: Remove Macro
 "IS_MAC_ADDRESS_BROADCAST"
Message-ID: <20190730030411.GA6140@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macro IS_MAC_ADDRESS_BROADCAST. In future if one wants use
it ,use generic API "is_broadcast_ether_addr"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 8eb0ff5..eb08569 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -9,13 +9,6 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-#define IS_MAC_ADDRESS_BROADCAST(addr) \
-(\
-	((addr[0] == 0xff) && (addr[1] == 0xff) && \
-		(addr[2] == 0xff) && (addr[3] == 0xff) && \
-		(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
-)
-
 u8 rtw_validate_bssid(u8 *bssid)
 {
 	u8 ret = true;
-- 
2.7.4

