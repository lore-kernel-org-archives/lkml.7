Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC268C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA73E23774
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYMDd3QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfHaDth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 23:49:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46527 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfHaDth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:49:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so5780278pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 20:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MBr117tQvPTRQqk10pzx+/iwqvgLO4n/m8eLZy0iFhQ=;
        b=XYMDd3QOoif0Jj8jidwXaz8mlr6A6VgLz84KHPk6iDRTtFftR5WzS/bT1L/faX7xk5
         pawVLkQgl6tMyr4OxWPFhXhlJSdNuBdaYBcxKW4OpZzS8813lnniGH0yj6A6WsaKdK9H
         zygQ2GR9DF7WemZbZR+tAZnisz2bHudbUEtJ7E2uLWenZi+qLJ/pphuyFUi+1Wnc4GON
         i6uJ7lWo4zAHnaDGh3dFJClG2xhYYSHboEapJhftJ2nOctk1TDUPqvc4EVrXgDXQgL5y
         wydQFHF+ofh5fbGRGB6B8QMSCirZ7yM4wRxUGWvbuMKrk8lql22MxNkUnZdbS3z+4U2U
         iwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MBr117tQvPTRQqk10pzx+/iwqvgLO4n/m8eLZy0iFhQ=;
        b=hjbNuDtBSygfIPdnW8xe/qcShLtYwasdh6gQkCLizsRQpu5+jtDRmwlqbEXiJ8bKk5
         cwY/D2QlxcGNS2eYPIS/bWQt2bOhR0xeEVzfFpOM6eQ7tXHa6c+xQOo48aCpfY5wlMD+
         IdxLYrjoKHo6IhIIbXXlmTN+RFTjxFxFVXsFEUopo4lIoOhPF1e5XSVF4II5kR4vu3qW
         bOKXxpDCiWw5sI3mGRCzG6A0TUKKSqXOWuzDy35YyAHHnuFAD0hUPOfIHQGjOYg/7Ci0
         VdyvI7j838VWWTc8BgRhK2v6x5qjMmsDRY/XMw/au3TTnL2JkuJqny1fx7JNFAEGmSrL
         aHtg==
X-Gm-Message-State: APjAAAUwIH2nW1wSMHd+9LYORn9iltqqpwW9HX7iigqKFRjV03VL5yMJ
        YtQ82Kdq3c+ytCrZE4pbvhc=
X-Google-Smtp-Source: APXvYqzhLXPO8wMaG49CtLBAxNVbcJuJOIGOR3t6Giyj/2CBsmRF2hPan43P8Dd2JnF2T4OgExbn9A==
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr22320284pfi.234.1567223376786;
        Fri, 30 Aug 2019 20:49:36 -0700 (PDT)
Received: from dell-inspiron ([117.220.112.196])
        by smtp.gmail.com with ESMTPSA id t70sm6759467pjb.2.2019.08.30.20.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 20:49:36 -0700 (PDT)
Date:   Sat, 31 Aug 2019 09:19:26 +0530
From:   P SAI PRASANTH <saip2823@gmail.com>
To:     gregkh@linuxfoundation.org, kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: rts5208: Fix checkpath warning
Message-ID: <20190831034926.GA17810@dell-inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpath warning
in the file drivers/staging/rts5208/rtsx_transport.c:546

WARNING: line over 80 characters
+                               option = RTSX_SG_VALID | RTSX_SG_END |
RTSX_SG_TRANS_DATA;

Signed-off-by: P SAI PRASANTH <saip2823@gmail.com>
---
Changes in v4:
 -Fix extra tab issue which was causing same blank line to be added and removed
  in git diff.

 drivers/staging/rts5208/rtsx_transport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d78..c1d99c4 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -541,10 +541,9 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 			dev_dbg(rtsx_dev(chip), "DMA addr: 0x%x, Len: 0x%x\n",
 				(unsigned int)addr, len);
 
+			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
 			if (j == (sg_cnt - 1))
-				option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
-			else
-				option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
+				option |= RTSX_SG_END;
 
 			rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
 
-- 
2.7.4

