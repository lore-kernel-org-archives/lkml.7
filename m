Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9FC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2AE206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gipVWh4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfJLWTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:19:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45741 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJLWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:19:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so8158992pfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKNRZ7QA+ZEVI6VxEit6zyGpLvUFrfR83bS8N3vOnGI=;
        b=gipVWh4ZasAHndkuZHKi4c6oaHscFQkoNJSaLtErA9RtWN1/W1yK/34E+zx9c//o/x
         GoD4zWWBnXBz0qYqCs197z+EehDSjMnLXkvmntzSWWgHqdoAsWenAlr0QDfUxSruXkj4
         rwhfeoEzJBfv6u2Gzi8+GqL7AjMSg2+MR2Nx4lccKc1qfUM+5qN0vqfz1dLW5bUib5UR
         TeFvfifcTzO7dwLGvZhts2z03PaYwtCAonqH0H3kp9Qc6iNNa649lyNJOszRZXSICc3p
         1nAsOJf2ewPZb+UwSA2JKsd9Qc4OpCMGaNojnNP2Pck1ALgEbZyAJD+AFtUZlQ1zoR8d
         rlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKNRZ7QA+ZEVI6VxEit6zyGpLvUFrfR83bS8N3vOnGI=;
        b=rYic67Py+/i/gUF74b2FMI7CTXtUAXKp4g4A3LMKhWldJ08LKBwiF+TuMuX1zipgVR
         wez7XE7WT7aFxgZ8zkViIx1ttFPjH8zS9q7Z1blq4p33X4rD2FS7sOosfc/LSBf9q3Xk
         BRMBwEa8JZSNaXsH4zVzOB2tdReqpWPiivZS97zriDUSh2QK6vNqy9CHMGCsV5Ra/DTE
         m78NEbHMlBKaImiwxRSC2momHmBAe0gKvL/r/Q+UIun2oqULHLxONoRHFRB3W3wYUjQa
         UISLexjMiDzyNcrC0tUoRHCh8C9fObvIhINUNEv81lcdsybajLM22TvhCHOnI8ZGEMjF
         bYdg==
X-Gm-Message-State: APjAAAVCMrBCp/6aBWtMJEZmghScMzPciAsswfDIPQHCx/NxH+P5zkTk
        SgHt2VdCTXnvU+ZbumYzgdg=
X-Google-Smtp-Source: APXvYqxBSWxIWxd4Li/ZV/2NOdZd1c0t8nNdYjd85ZRSGSdHLpeC6BHHzrtUlPECMJvjOcPZxg/1Gw==
X-Received: by 2002:aa7:908b:: with SMTP id i11mr24895893pfa.140.1570918774118;
        Sat, 12 Oct 2019 15:19:34 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id 30sm13839562pjk.25.2019.10.12.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 15:19:33 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Subject: [PATCH 0/2] Formatting and style cleanup in rtl8712
Date:   Sun, 13 Oct 2019 01:19:14 +0300
Message-Id: <cover.1570918228.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the use of unnecessary return variables and
line-breaks in function headers, both in
drivers/staging/rtl8712/rtl871x_mp_ioctl.c. 

Wambui Karuga (2):
  staging: rtl8712: remove unnecessary return variables
  staging: rtl8712: clean up function headers

 drivers/staging/rtl8712/rtl871x_mp_ioctl.c | 103 ++++++++-------------
 1 file changed, 38 insertions(+), 65 deletions(-)

-- 
2.23.0

