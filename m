Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D4C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8655B22525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="o8kq/FV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfLEXDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:03:52 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:56064 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLEXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:03:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47TWVX4CPvz9vjdH
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 23:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Aut7QrSlRYPd for <linux-kernel@vger.kernel.org>;
        Thu,  5 Dec 2019 17:03:48 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47TWVX3Cb4z9vjd4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 17:03:48 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id 199so3740657ywe.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MO10ke4bfA3Py2gapxPNJKqGZHjnWV9jw2bft4Kl1Hw=;
        b=o8kq/FV8cXLWxcKrmWwqxkUDv66DAT2G+5F8dgPlPsK2l/4v0bLFuw/zZ4WkoJUOra
         j7d1rGmVPr1XObXlyoBCxoAbInrvrXSEM+7T9Q6Q4wgxzS7JLdnQIFeulqvLZr2ONMBT
         TQ2P7rIP4szjGmrDnCCMZetziNAYCEtGnPREfJkkooWoZHwtYH+3xSHusomUuPG9t9b0
         WbcwXT+JPAdQ6v9lbTR4jO0+1jSajHx1OrXCBdBxb89fUIU4Ur+cp8tZj2C0IaJCyjof
         T4l7YuRus+ot8Yy0JmZ2SL6gXNSwFPkD4g02BZEI4gWsjd1C4KNwlHVfdqQ5q4n35Xr2
         RuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MO10ke4bfA3Py2gapxPNJKqGZHjnWV9jw2bft4Kl1Hw=;
        b=TXs6j/eu8EtX3pFJ5xBWs5RA2MPGHwNjevwzuYiWWhZMAiILqZ4cm1+HSmxp2JVo5n
         dhr9aOBP8zm08G2ypDVvJmIo5h73uIuIEpWyXO65oFur6SdhSTwzDCV07oljRvRgYMMv
         ES+OUKA4rXqzD6/GfxRZ9Ym0tfimjdMv2a+8t5ELqc0o9dpNeRrrPDfB0BcGwUmiJr50
         jgX5ErMzd0CsrEwKzXdlWmBe2/9UAGXjCRsQTkgh2HVCpuot0Twxs8v5jxhP/8+166Vo
         8KhS3Fcptxg9X/edV4IcbO5DSs8zEXwstMPvrnVtodkaxdA5p3uwaPozpywfFZF1wthC
         pxpw==
X-Gm-Message-State: APjAAAUGZqqEVoUQQZTNZcUT/OFr4DcfioY8rtFiiXhyQc1un7wIwJWa
        /HNiS4cZXVKuJPfNz1Uxe78Ms7FYedA+ZDBwpZVp8fwM8rtqIdz577k2/gwXe6NzjcRBx8jnqmW
        bEg6+lbjtmaAwqElJXD5PoC7x44Tu
X-Received: by 2002:a25:d14f:: with SMTP id i76mr7709790ybg.247.1575587027834;
        Thu, 05 Dec 2019 15:03:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkEHr8jIGy9mRSBGOgEGBohtY9oZQx2HZqcHGHp7PRlziWpgnmiW+FCdEbCYBPqiawfQdx7A==
X-Received: by 2002:a25:d14f:: with SMTP id i76mr7709757ybg.247.1575587027551;
        Thu, 05 Dec 2019 15:03:47 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id y17sm5373245ywd.23.2019.12.05.15.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:03:47 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     klju@umn.edu, Michal Ostrowski <mostrows@earthlink.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pppoe: remove redundant BUG_ON() check in pppoe_pernet
Date:   Thu,  5 Dec 2019 17:03:42 -0600
Message-Id: <20191205230342.8548-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing NULL to pppoe_pernet causes a crash via BUG_ON.
Dereferencing net in net_generici() also has the same effect. This patch
removes the redundant BUG_ON check on the same parameter.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ppp/pppoe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index a44dd3c8af63..d760a36db28c 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -119,8 +119,6 @@ static inline bool stage_session(__be16 sid)
 
 static inline struct pppoe_net *pppoe_pernet(struct net *net)
 {
-	BUG_ON(!net);
-
 	return net_generic(net, pppoe_net_id);
 }
 
-- 
2.17.1

