Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91719C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62726222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="OIOLw79F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfIZRf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:35:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43888 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfIZRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:35:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so2466447qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=gOTzEof5klKVQo3+CdQSO2adftwo/URuU7QVTqox3lo=;
        b=OIOLw79FMBKboX+ChDCsXF7yh4nyY0Jz0vfT+O2NJmqW2PCooaIRKy8d708gJFfu0E
         MJodEs+HkbXXd7zMVzNQZ1KMKXtQWcAGeizsOR2lQ/RvUeAZ11lmViV2RUexKlJKbKLr
         YSAKHiRWso176eAXixb7GPRjMnLqO/PIaFFCaBM46A/oz6K8LzxouZloyxysxzrjZxPY
         NViBKb3ApOxuV0KSgrjfLSAQPeXix25YwoZfRNGfmIuyv8AyJB0tOY7nHKq0abu6v6cg
         Tz468lEUP5vn65mOGklD6ggrAqwlju51d96mNHJgo+MnWI/XjxSDvbRV/pO+3aSC2CRw
         TThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=gOTzEof5klKVQo3+CdQSO2adftwo/URuU7QVTqox3lo=;
        b=n9Z75HK3vuXfpFb5+NJypo90it5+Z9N4tniuSVqiyYBQDHP384v2L+DIAk8HhSrIZO
         8+LO0ZF/vgiW0uQiGTX1gBRbe4mU4E/gOfqBDRGQkGYM167lPQxTQ0SgoAMGRP/B/oIB
         efCV6b2URKd4fqDVpSPdDZFiJT+cBHS+iIWDmWnBATnnPRaMs/INIvuVkOz893+22Wha
         c++cDLF5yTjUJepiO06Bowe+8yG8SKqZ6+Oub+wvRsRyx/Mj3rPsp5LU2MQoASzxHvtu
         LnH/3r5Bz72/k+1rKPc42KDVGWYYR5581bjfhi7ocwTMDl88a2u8Bktd1bNFxZtg79Rd
         aJEA==
X-Gm-Message-State: APjAAAWvGtUdc4pMPK44/G9dlr3gQXc8UVejOLz/PDB3hYEUdGFO8Vku
        jLpblMc5YKkpxCVBagyYTOvAlA==
X-Google-Smtp-Source: APXvYqy1XvJX0L11q054XISBpDfblJVcmimI7PoachCq4oIDdaf8w+a2feWJiMeIFHppEJuwLwTcqw==
X-Received: by 2002:a37:a683:: with SMTP id p125mr4624315qke.173.1569519324626;
        Thu, 26 Sep 2019 10:35:24 -0700 (PDT)
Received: from graymalkin ([2605:a601:a604:fe00:3545:534f:2d69:c606])
        by smtp.gmail.com with ESMTPSA id f21sm1210415qkl.51.2019.09.26.10.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:35:24 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@graymalkin>
Received: by graymalkin (sSMTP sendmail emulation); Thu, 26 Sep 2019 13:35:22 -0400
Date:   Thu, 26 Sep 2019 13:35:22 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB changes for v5.4
Message-ID: <20190926173522.GA15861@graymalkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes and a new AMD device support for v5.4.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.4

for you to fetch changes up to 4720101fab62d0453babb0287b58a9c5bf78fb80:

  NTB: fix IDT Kconfig typos/spellos (2019-09-23 17:20:40 -0400)

----------------------------------------------------------------
A few bug fixes and support for new AMD NTB Hardware

----------------------------------------------------------------
Alexander Fomichev (1):
      ntb_hw_switchtec: make ntb_mw_set_trans() work when addr == 0

Colin Ian King (1):
      NTB: ntb_transport: remove redundant assignment to rc

Randy Dunlap (1):
      NTB: fix IDT Kconfig typos/spellos

Sanjay R Mehta (3):
      ntb: point to right memory window index
      ntb_hw_amd: Add a new NTB PCI device ID
      ntb_hw_amd: Add memory window support for new AMD hardware

 drivers/ntb/hw/amd/ntb_hw_amd.c        | 22 ++++++++++++++++++----
 drivers/ntb/hw/amd/ntb_hw_amd.h        |  8 ++++++--
 drivers/ntb/hw/idt/Kconfig             |  6 +++---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  2 +-
 drivers/ntb/ntb_transport.c            |  2 +-
 drivers/ntb/test/ntb_perf.c            |  2 +-
 6 files changed, 30 insertions(+), 12 deletions(-)
