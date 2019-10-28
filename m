Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66289CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EE7217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDBZQqYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfJ1VMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:12:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46500 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfJ1VMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:12:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id b25so7765838pfi.13;
        Mon, 28 Oct 2019 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LpLtDPgqTSExYcD+3Zq3oGqSdNVk6TYhbGQpCSsiyhw=;
        b=aDBZQqYVRTjqcOLPHqP93LA77KhRVsnLqLSjzX0fUt4OqAa6Smt/8dUT0nw13h6o7P
         fmz9BD3sB875PUkGIc6hJT/6tN4owz8x/uQALi1eIFKy6jCqkRS4OhriaopCMrPtDEQx
         6RLo5RrXUjq7c3vL/qV5OkhIiKqEXnKAPfZqxTYxnVjEw70Xs1O0A6dDPCuyUMEIZtIY
         p5G1kSmiim0gzMQHQIovhObnY8L0kX1OQRowg2A4Kv2ZlNnDfVx7arhscohJEHCHgU4l
         fRMv17JRtV24NFfd5pCuWb2bWTsCSfQ0nnrK7OvNT9AqEvWeea+Piw6FQE42Br8lx4N8
         6K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LpLtDPgqTSExYcD+3Zq3oGqSdNVk6TYhbGQpCSsiyhw=;
        b=L7WcU2qrx3Xfnlypuod6P5KwgxlPtm4D3tz3VuibzIvT5KnVX2SGPGJRjRxrkaSvbz
         omxIqAN0wNp67XhLEvdDw1VuxgGgrCu7Q1D0krBvm2bY1c2nZV//PeEAWV3GJ8qNJ41z
         EdvAOK63GYv72Gkzz35o/o60QG2fG9mODV4F3nnU39hKcQbjaej1Hn/5VnXVl0lUd2Bl
         E9EUQnmeU+udQ+lSxcEuOnRnthY/94w1Jy8v1tHHiJuPj20skd4g0ZeycJEioA62cz+C
         ryxptlRz88c/HR8VI7IcJXqIi3mO4yQwaInqKidWb+IVQLzgOfnfuiTtWhslhpIkGMOo
         3tGQ==
X-Gm-Message-State: APjAAAVKyANOjPYhUkvbc3EIujB4BxBSro/XDlqQkwnP2WSm6E88cbJc
        DqXXd7jnsUz0ywLUXYemAI0=
X-Google-Smtp-Source: APXvYqywtk+GNoyuBSErwjf7aGqZ1APTuJIEJNhsFcT6U7pLmh6xl4k0x0Ecvx2tUHEy4kmIfddpww==
X-Received: by 2002:a62:1ac6:: with SMTP id a189mr22685761pfa.96.1572297141812;
        Mon, 28 Oct 2019 14:12:21 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id w189sm11884010pfw.101.2019.10.28.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:12:21 -0700 (PDT)
Date:   Tue, 29 Oct 2019 02:42:14 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        saurav.girepunje@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: isp1760: isp1760-hcd.c: Drop condition with no effect
Message-ID: <20191028211214.GA30014@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the "else if" and "else" branch body are identical the condition
has no effect. So drop the "else if" condition.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/isp1760/isp1760-hcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 320fc4739835..579a21bd70ad 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -1032,8 +1032,6 @@ static int check_atl_transfer(struct usb_hcd *hcd, struct ptd *ptd,
 			urb->status = -EOVERFLOW;
 		else if (FROM_DW3_CERR(ptd->dw3))
 			urb->status = -EPIPE;  /* Stall */
-		else if (ptd->dw3 & DW3_ERROR_BIT)
-			urb->status = -EPROTO; /* XactErr */
 		else
 			urb->status = -EPROTO; /* Unknown */
 /*
-- 
2.20.1

