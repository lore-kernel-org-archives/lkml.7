Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA0C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A72F206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="pisRV2Ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGDGIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:08:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43553 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGDGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:08:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so4873513ljv.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 23:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0OL21aoHCmJUqSyRuOUM6JM8EbwmZkWEvcS1f/VXQc=;
        b=pisRV2Ql3caw37w/QiGUOintN93G2+qRu20I6q2ASQHFK062ygqw8DiWiyOgkuMFyC
         R3MJKsqM8VXcZ/8UU32WRTw4NhVeyj3u5UHMHC35teZWLGp+2z2l33Qy2UilGIm2QQdg
         ODNSbSZZ5fRl+2AKebqHNOTbwqKTpHxpeosS2fsXPIk4GAfiCBVq+A5+60Ggjb31u2z9
         2YqlqAg7BCipF+lk7+uUABXVyhJ8uOA0NApR/D7CyzloDa4rYHRBkpPpCkO3l0MqlXdg
         HiGP6/b5Pat1u9zL5GFx2afzoaIuiRbS27DEfUihOR5OMjeBD75QFv9eG07Y+1TT0LyF
         80Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0OL21aoHCmJUqSyRuOUM6JM8EbwmZkWEvcS1f/VXQc=;
        b=pw/ZBVoUDDcClvby083WcmK7RKz8E+dOTwlEvcPJ9slbu8iP/VNYANUN8w16jNLNv/
         dkzu5T3IhuiLsPhifWhWzBHPVdXENsqZoY+TpXp9S4KYAkcSTvKi/tPBmxLdGu2ygI/g
         uNm8VoJqdwaStrCW8Lok/tDlK8Oo8XxDgcg/VwUv1VgFO/hn34HDir95t4e5hs0z5VUb
         ly/HvlBQ4BCqOsqES0s/PUSnpauNPlpOYhggbBY1zZw2OWtfsYLc855g1MOYHUqVS4A8
         XipxJHRSHf1P7a6H9v+vp0G1s58VAWw4CQI/su86znEBq5viLr/Nnel1WRlyPjpiFPfc
         EgpQ==
X-Gm-Message-State: APjAAAWGyrmB+d160o5cK5WxtiZxtALbBv8D4ouxitTLY/G5QirE0SqA
        MyQP3LIEEfHCezg1l6cBnp9jZw==
X-Google-Smtp-Source: APXvYqzOsXtBUXJs0TfRsT8D7cp3MEyHCUv0RtiN18pdJ1gLOipAwZAXHhpPYU5ZHSciK3oCZAebog==
X-Received: by 2002:a2e:86c1:: with SMTP id n1mr7144917ljj.162.1562220499357;
        Wed, 03 Jul 2019 23:08:19 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id b4sm710440lfp.33.2019.07.03.23.08.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 23:08:18 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 0/3] Simplify NULL comparisons in staging/kpc2000
Date:   Thu,  4 Jul 2019 08:08:08 +0200
Message-Id: <20190704060811.10330-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches simplifies a few comparisons to NULL ("foo == NULL" =>
"!foo") in staging/kpc2000, as reported by checkpatch.pl.

- Simon

Simon Sandström (3):
  staging: kpc2000: simplify comparison to NULL in kpc2000_spi.c
  staging: kpc2000: simplify comparison to NULL in dma.c
  staging: kpc2000: simplify comparison to NULL in fileops.c

 drivers/staging/kpc2000/kpc2000_spi.c     | 4 ++--
 drivers/staging/kpc2000/kpc_dma/dma.c     | 4 ++--
 drivers/staging/kpc2000/kpc_dma/fileops.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.20.1

