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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5207CC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 07:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D7223429
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 07:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ79Hi/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfHaHck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 03:32:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34923 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHaHck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 03:32:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so4678008pgv.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 00:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4xeK59h0dqCDcu/8tG2EqDqz6mbyedjvxBCh7CZRZvQ=;
        b=UZ79Hi/R760hKF/v9HJQR4DXHYNs5Z8azbjqxFeLlLuQhNSFkXEOoR4lKhFNp40MOt
         kfWD/QjgyedpmYbkQEpu/7vVpXYf4sTzTbKxPpRy/vwUA2Jamu1JYHa6mnsby/V2NVOM
         aZHIIRTao9Mr8LHsk29ppnTh1TMQZPdJZtprI4rvqo1iKjj35MhN8HNPeRcARG8b72tH
         oM/0VGoER74bg9tN4si0amvbui5pPMi/TL7xhkx4T+Yu1HjMFDeXohBXHQTm7t31c/o/
         sKPANOj+M1tiAr3TqdZoAvEvDsl3h6PAhZ6W7bsrYZv8nfkDZoyvMyALKrXU7f/u9don
         +aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4xeK59h0dqCDcu/8tG2EqDqz6mbyedjvxBCh7CZRZvQ=;
        b=T9pWze0+lUQCMbw0PoYf24Qp7SqORBQko6XreBga6kauQhab1HcVxp4V2ugTsW/o1p
         a23Nm69WnJh2PK0cqvI83z4eH1/PfcVcTVJKKzyYT5UWnzFx7qYJJfIQvM2RkeoImRVm
         LtJaRwnmjl4nuE4Vpp/e/LZtAqsrJVcRPJCj9taOyqGMZ8iX4E+AUOeNhdvfRU2vFaKV
         j/39zVgb+ObZNYFSA39T1A9jpKjH87/SkHFdUeYZfgbTIQ9ZvvDcY6ST5+Ttu/wqfZDa
         o8+dBLPEdutEwoDLjNI/opr4s68hhh6DzEF2D6L9PbS89L81CFYa2AC24lempuZ3REpA
         2X0Q==
X-Gm-Message-State: APjAAAXrQRNyvnbqvIbDBONq8oIlYrI4rAPU3sNvCIEPOCmoQNhedi4U
        wkeFuJkpMFYAGeYkFSCDjmkqp+cDls0=
X-Google-Smtp-Source: APXvYqwA3BKO6wzDlauVQwkzCt4StF88WSRKsYSj3W4wWU5sP2nmxNeTgT2dENm5rRfTf+IYeyDj7A==
X-Received: by 2002:a63:6c02:: with SMTP id h2mr17043219pgc.61.1567236759334;
        Sat, 31 Aug 2019 00:32:39 -0700 (PDT)
Received: from dell-inspiron ([117.220.112.196])
        by smtp.gmail.com with ESMTPSA id e6sm21247686pfl.37.2019.08.31.00.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 00:32:38 -0700 (PDT)
Date:   Sat, 31 Aug 2019 13:02:24 +0530
From:   P SAI PRASANTH <saip2823@gmail.com>
To:     gregkh@linuxfoundation.org, sabrina-gaube@web.de,
        qader.aymen@gmail.com, tobias.niessen@stud.uni-hannover.de,
        kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Fix checkpath warning
Message-ID: <20190831073224.GA6197@dell-inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpath warning
in file drivers/staging/rts5208/xd.c:1754

WARNING: line over 80 characters
+                                           index, offset, DMA_TO_DEVICE,
chip->xd_timeout);

Signed-off-by: P SAI PRASANTH <saip2823@gmail.com>
---
 drivers/staging/rts5208/xd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index f3dc96a..e62eee3 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -1751,7 +1751,8 @@ static int xd_write_multiple_pages(struct rtsx_chip *chip, u32 old_blk,
 
 	retval = rtsx_transfer_data_partial(chip, XD_CARD, buf, page_cnt * 512,
 					    scsi_sg_count(chip->srb),
-					    index, offset, DMA_TO_DEVICE, chip->xd_timeout);
+					    index, offset,
+					    DMA_TO_DEVICE, chip->xd_timeout);
 	if (retval < 0) {
 		rtsx_clear_xd_error(chip);
 
-- 
2.7.4

