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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17385C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32192086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdBm/5W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfF2KgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:36:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46056 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfF2KgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:36:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so4644346plb.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5LHkBJhseA7dswWKyXE2Jck+WxMFtGP/bseyhBGdc+o=;
        b=kdBm/5W3nCQHYCHkDl3RPvqQ77+P01XIG8cKg5dIOThq36njd2kH8bzO+dXt+6jtff
         u1nwN19fXhEiJbSxCG0+vEJPA6hJR2zNl3faM/igk2C7iQY+LRcjvcfk8YvvEAkICQMc
         /01P08NoKF03qF4lRmC04VieWwaFWLGP5uOXlzIhoxT6+PfhRch2N/95Fe3UBL/tQ5bq
         DBDn3pbIY71TMv6kOhh3hLg3pUPInqG1Ab9SpuScRbrVwKch0GoZm2FMO95KeERn7J1O
         +RBrjYE414hSyrmtS8b9uitql24/WZLc8SQ/ubTYibLQH7XmopfJ8cbT4F3kH6XiTvl8
         UJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5LHkBJhseA7dswWKyXE2Jck+WxMFtGP/bseyhBGdc+o=;
        b=av/yB4V4jPCzsRvffSck7hfc23jUmgvNFLHWM0qJH4SPSNpA8neKRxjAhYFte9U8eO
         5A+vPVwL1RGAgh3E/wNMPK6hwugGh/sWGvA0UXALwOYQaAqgCNOzMp8V2tH78VEnl96k
         fIZ/lX3hN9H7kP9PZzFJmhj9Gj6OFaG+gRyecmiESPmvaJQBuPhsgNhaDjowbV7Q7CCV
         ko1f/XCa0oHh2MnfhZqm0qMnFRAmlR7UTbp+Ufgij5STb0SlvSn54uGaozFLwWfjbl22
         0Mqiwy1WdyXEkAaIGZoqb/tEe2gv7w1DAcvXoyuvBesKegC7TUVnFLVo6IrRzD0TUtvP
         771A==
X-Gm-Message-State: APjAAAXz8dfeQJnqy0uMMJcrO2aAYwVjiVi9S9Wl/vtGq9GfEYso9Af7
        gUOXHeigXDnY6M181lGPcVw=
X-Google-Smtp-Source: APXvYqwMrWBD5H8o3UVSrF+L8X2bCKm5bqMVp9I6iEetozmgmMMea+YSQpZIG2AbN7yNfHV5ShX6Qw==
X-Received: by 2002:a17:902:7c8e:: with SMTP id y14mr15913012pll.298.1561804567526;
        Sat, 29 Jun 2019 03:36:07 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id 65sm4306022pgf.30.2019.06.29.03.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:36:07 -0700 (PDT)
Date:   Sat, 29 Jun 2019 16:06:03 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629103603.GA15524@hari-Inspiron-1545>
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
 drivers/staging/rtl8723bs/hal/hal_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_phy.c b/drivers/staging/rtl8723bs/hal/hal_phy.c
index ebaefca..520f860 100644
--- a/drivers/staging/rtl8723bs/hal/hal_phy.c
+++ b/drivers/staging/rtl8723bs/hal/hal_phy.c
@@ -81,7 +81,7 @@ bool PHY_RFShadowCompare(IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset)
 {
 	u32 reg;
 	/*  Check if we need to check the register */
-	if (RF_Shadow[eRFPath][Offset].Compare == true) {
+	if (RF_Shadow[eRFPath][Offset].Compare) {
 		reg = rtw_hal_read_rfreg(Adapter, eRFPath, Offset, bRFRegOffsetMask);
 		/*  Compare shadow and real rf register for 20bits!! */
 		if (RF_Shadow[eRFPath][Offset].Value != reg) {
@@ -100,9 +100,9 @@ bool PHY_RFShadowCompare(IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset)
 void PHY_RFShadowRecorver(IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset)
 {
 	/*  Check if the address is error */
-	if (RF_Shadow[eRFPath][Offset].ErrorOrNot == true) {
+	if (RF_Shadow[eRFPath][Offset].ErrorOrNot) {
 		/*  Check if we need to recorver the register. */
-		if (RF_Shadow[eRFPath][Offset].Recorver == true) {
+		if (RF_Shadow[eRFPath][Offset].Recorver) {
 			rtw_hal_write_rfreg(Adapter, eRFPath, Offset, bRFRegOffsetMask,
 							RF_Shadow[eRFPath][Offset].Value);
 			/* RT_TRACE(COMP_INIT, DBG_LOUD, */
-- 
2.7.4

