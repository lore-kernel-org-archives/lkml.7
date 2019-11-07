Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00132C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27562178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqZSnsIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbfKGONx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:13:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34489 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKGONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:13:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id v3so4997378wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 06:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=727/3hXNrCpMzc8Pu8pq1fTYwENsqPgwGKKHUIkJ+iQ=;
        b=mqZSnsIbvbCPOezMyABP9kgRU/q8s09FqoL+8rtW1HFh/g10TeHhxA3n0jGhJtQKNF
         4paJCGdNtrAXBwgxE9NcJMDDBpwA0F9Id33qIiNyP9KjnIrJS5bhuErPyPM7M4ypeB4C
         uYV6wtRBYDpk62xEyorrnKCmoryyUzWIK45XRMDeqItXcC/Wo+tfYytK3lPJPIFU3PLZ
         kXxJum2HliNF/fn/07JJyHbJJ/EmRxr2qaqFVcpy6vTBSxWwa3flDwggY9ntSym1pYhZ
         pjdkwB09T1Cu6v8H225hdP6Vf+wgl8j4uADWp4L48fIu+30FDF/z/lFZg2zU5Y+5xGe4
         vcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=727/3hXNrCpMzc8Pu8pq1fTYwENsqPgwGKKHUIkJ+iQ=;
        b=Dx4+Qgzj6n86uKeT4roIvYgiwn02F8ptUJhqk5UDCl0WoMkiA0DqJ7ZLTN0QuXksh+
         dovMkBtLK3dNN69lLYeuqK60iekjGGuZ6rrl3LuST8lryR5oBwGTTNJh/9O8ItY9qekq
         2LIjXDzjKYcdilziHh6NC5XDQdNMPXUTifDkNmsLNfIOFnObjXoNNAB+U/wtbGsJ6zn0
         yLnDVaFSokZ+I9RXG/WHxtWV69RZZ+BEjX2h/gorSgAw/jr/R0CjK6/MXsXhnE6+CMRM
         9rcmNwtJA92DR3gPrw4DXTujJoal8oAu7AnH9DdPyufaGMst8rZ82lSLxL4Zg8mZxErn
         RjKg==
X-Gm-Message-State: APjAAAURdcLboNHtgkC7BSpPPQFJReBh+0nT9Iyf3P1pzA0GG0MRnlJe
        KKamTNsuh72meplGWBU44jg=
X-Google-Smtp-Source: APXvYqxrDB0OVg0ERQNnmg5c6UHBM/XNtCaWKes8hIeX19qwgG4w6OzxLz8Zz96+lz5tx0cuPQPCvw==
X-Received: by 2002:a1c:a943:: with SMTP id s64mr3086918wme.170.1573136031041;
        Thu, 07 Nov 2019 06:13:51 -0800 (PST)
Received: from hwsrv-485799.hostwindsdns.com ([2a0d:7c40:3000:11f::2])
        by smtp.gmail.com with ESMTPSA id x9sm2194691wru.32.2019.11.07.06.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:13:50 -0800 (PST)
From:   Valery Ivanov <ivalery111@gmail.com>
To:     devel@drivrdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Valery Ivanov <ivalery111@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: octeon: fix missing a blank line after declaration
Date:   Thu,  7 Nov 2019 14:13:22 +0000
Message-Id: <20191107141335.17641-1-ivalery111@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch fixes "WARNING: Missing a blank line after declarations"
	Issue found by checkpatch.pl

Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index d53bd801f440..ed9d44ff148b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1375,6 +1375,7 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
 	int port)
 {
 	union cvmx_gmxx_rxx_rx_inbnd r;
+
 	r.u64 = 0;
 	return r;
 }
-- 
2.17.1

