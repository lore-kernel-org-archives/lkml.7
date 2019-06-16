Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F6FC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0C22063F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl49fisH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfFPQUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:20:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32962 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfFPQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:20:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so4388948pga.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7c4Ii2lIRg4WK3LnUHH3EukYlQjj7xEBu6zgZJFeNk=;
        b=Kl49fisHXJsYiIBKU06XjHxEyTJHRp+V38FFaOPlaFMjG84Yo0oq8RqsbqMiIIN7XZ
         ngPuYX9FsazrftHHyXrK1WSIuzykC8s+g4hUNkypGY9mgbY9RRnlZ9vFl2PvIYYjoKuU
         BPF/GwrnvCiuc6vypLX/NswQCxARywR7xJgJKlP/PNgmnAK4WRcqGUSAHgxVAG8D8EbH
         E7A1s2itc/S5969rHUhkTbi/0KYEQP1ZD8ih8crAqM/Npx65R9B+3HlK12GWW06AX563
         Fl4DT9L4m+eNUu07oOl190IISweJCsO6oP9HJ4rlxZbfmrjj3A8nWv0zRfZZtzvOSbPS
         jQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7c4Ii2lIRg4WK3LnUHH3EukYlQjj7xEBu6zgZJFeNk=;
        b=j4HpxD4DVD4fdv6bkycgQfwV0KokrOdQ26ThZGy7oge5Y2abFMKvjdp5M2JBgcmBXu
         Jp2NcDxdsqFkKLHVVjGb6dKuNhDXJ0oA32zvSz2Ygaa9bDa4kqCbt4MPv4KOzM5UHWzy
         a1ssUuIooNN2E9jUjVWNl1RLtnPpdiWum+0uplEeTy9mUx97VMsW5pWllVtM31GFQdEk
         6OeXy2eM7t/y9pG5ARoLGgOp8h7H3VGIBpqECg63GA3bDkZRFTCqLcrrATMrhmusKUJV
         0DL0bscR2ONr9LJ6OgOomQFsVjumkEZCEt6pxnFoBcShSD5d8bZjzuJTXSURR3q1aljZ
         SQ3w==
X-Gm-Message-State: APjAAAVpIbRbGawpe35F45qGOG/UacDx2UvihsFIlPqVYeXLoC2pKFuC
        rdJGxwBzAtkV3/mE8BG9cMA=
X-Google-Smtp-Source: APXvYqw+6nLTcradR7JO8k4lVxHqCgfn1DsqASSPlvp5sfwnmu6BNo/Nn/SXUUNTnGziemLe1aHlLA==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr44191744pgk.81.1560702017175;
        Sun, 16 Jun 2019 09:20:17 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id 8sm1687908pgc.13.2019.06.16.09.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Jun 2019 09:20:16 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v3 0/3] Resolve checkpatch if/else brace style errors
Date:   Sun, 16 Jun 2019 09:19:48 -0700
Message-Id: <cover.1560701271.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190616131145.GA30779@t-1000>
References: <20190616131145.GA30779@t-1000>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the following errors reported by checkpatch in the 
staging/rtl8723bs driver.

Patch[1/3]: Fix check patch error "that open brace { should be on the previous line"

Patch[2/3]: Fix the error else should follow close brace '}' 

Patch[3/3]: Fix Indentation Error

version 3 changes:
	- Converted the patch to a patchset
	- Resolve checkpatch errors:
		else should follow  close brace '}'
		Fixed Indentation Error to use tabs
	- Compiles and builds, untested on real hardware.

	
version 2 changes:
	- Removed Trailing whitespace introduced in the previous patch
        - Moved comments to a new line in the else statement

Shobhit Kukreti (3):
  staging: rtl8723bs: Resolve checkpatch error "that open brace { should
    be on the previous line" in the rtl8723 driver
  staging: rtl8723bs: Resolve the checkpatch error: else should follow  
      close brace '}'
  staging: rtl8723bs: Fix Indentation Error: code indent should use tabs
        where possible

 drivers/staging/rtl8723bs/os_dep/mlme_linux.c     | 19 ++---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c     | 90 ++++++++---------------
 drivers/staging/rtl8723bs/os_dep/rtw_proc.c       |  6 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      | 54 ++++++--------
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c | 24 ++----
 5 files changed, 71 insertions(+), 122 deletions(-)

-- 
2.7.4

