Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F897C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B83220870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0JV9Vht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDHLRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:17:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38780 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:17:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so7450999pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6P6o9qAqcuLTVLKt4jm8gq5/Z1+vsBcYk02pbXhkOI=;
        b=k0JV9VhtuxlQxVOkKoJv7WMMx/qmhMLtZAvcNtz7oCAXc324do1ie4b0+qNDV2Gg5i
         6WwV3n/DTS5Mh4ZthxTmnfnaDkIq5E3QIu0Kg3t4VNbaPrxW2Gy4QThzWhztt1M8YpNU
         wVsM6iq3aV0EjMJacd2T6gPpQlEjP1KGVagxOGOGqm6jQ/LHjMg8DtDyW0cqFy/R3w/L
         yOrTQEzAGM+8CiiQVNuHMxdVn04Wc7LX82nu2QleX6oh6ez1hjeeO41SdmQ4E3L4wpm+
         FsLJ06jVeSgNARTGjvpltZK3QIUlHr2WEecNY7G7OGg3k6p8dF+qFbnS7kBFXSo6Ciu7
         IFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6P6o9qAqcuLTVLKt4jm8gq5/Z1+vsBcYk02pbXhkOI=;
        b=s1En6sIq2VsG9OebBO909gqQXyvr+lwptbEnkiYEaG6KWRLDD1WblZ/rKAgY69UL0o
         UuNxxxvOXVmGsl/CXeRF82Rk8eDtijG3fsddhT3+DyFwKyKRU0cQFCRPziWCaJp1ja1e
         2GQga3oTHXqeDKrdMDQM5KSgRqdSNcIZgnxWQBxh0YHDwfcJzOXhAREinbDMFpCgYwKU
         Vl/bG+6x9sSpaNkGG/CKmBBKrQoAHKh/sHCXCyuTUDLLZsaBFzCT1Cwp5oCos5xJ2OTB
         cSOuMUPxE7sT5y1jQ45aT9d7N0x/BsdpBtytET8lp3kNMkxrSc1gYQvlAi+th5GqaB7k
         ZcCA==
X-Gm-Message-State: APjAAAVq+mQxXI97kRkn7X96tZnwl84mpshuKddiCVmrYXsTlgmbkuBk
        lLOa3G6mJX4FMZIIHI6Cy3RJqPAZ
X-Google-Smtp-Source: APXvYqz9rNLOjUqGEILElRmAumeKawraBVBRI5qnXoY8HBVS2TZn7USjlgGM4OfFOlo1uGt96lSf5w==
X-Received: by 2002:a63:5405:: with SMTP id i5mr27565726pgb.212.1554722264003;
        Mon, 08 Apr 2019 04:17:44 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-230-174.dynamic-ip.hinet.net. [114.36.230.174])
        by smtp.gmail.com with ESMTPSA id a80sm64069626pfj.61.2019.04.08.04.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 04:17:43 -0700 (PDT)
From:   Morris Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH4/4] Add support for SUNIX Multi-I/O board
Date:   Mon,  8 Apr 2019 19:16:53 +0800
Message-Id: <20190408111653.4260-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=Y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lee,
Thanks for review, my replies are inline:

Signed-off-by: Morris Ku <saumah@gmail.com>
---
+
+On 03 Apr 2019, Lee Jones wrote:
+
+> >Please do not drop the list from your recipients.
+
+>On Tue, 02 Apr 2019, Morris Ku 古文俊 wrote:
+
+> Hello , Lee ,
+> 
+> 
+> Sunix multi-io card is a composite device,
+> contains serial and parallel port , before we
+> trying to place the driver in the /drivers/char,
+> but maintainer suggests go to /driver/mfd,so we move to here.
+> this driver is special,it supports more than one interface,
+> so we combine to a single driver.
+
+> The MFD subsystem is designed to register child devices.  MFD drivers
+> do not contain any true functionality themselves.  If this device does
+> multiple things, you can split the functionality into their relevant
+> subsystems and register each of them from here.
+
+> There are 10's of examples available.  Please take a look around some
+> of the existing drivers to see how their functionality is split.
+

Could you please clearly tell me the name of driver for reference.

+
+> On Tue, 19 Mar 2019, Morris Ku wrote:
+> 
+> > Driver for SUNIX Multi-I/O card.Based on parport_pc.c, ppdev.c
+> > and lp.c by Linus Torvalds, Theodore Ts'o.
+> 
+> Parallel port drivers should live in 'drivers/parport' and
+> 'drivers/char'.  LP drivers should live in 'drivers/char'.
+> 
+> Please them there.
+> 
+> > Signed-off-by: Morris Ku <saumah@gmail.com>
+> > ---
+> >  mfd/sunix/snx_ieee1284.c     | 144 +++++++
+> >  mfd/sunix/snx_ieee1284_ops.c | 258 +++++++++++++
+> >  mfd/sunix/snx_lp.c           | 717 +++++++++++++++++++++++++++++++++++
+> >  mfd/sunix/snx_lp.h           | 119 ++++++
+> >  mfd/sunix/snx_parallel.c     | 397 +++++++++++++++++++
+> >  mfd/sunix/snx_ppdev.c        | 454 ++++++++++++++++++++++
+> >  mfd/sunix/snx_ppdev.h        |  15 +
+> >  mfd/sunix/snx_share.c        | 629 ++++++++++++++++++++++++++++++
+> >  8 files changed, 2733 insertions(+)
+> >  create mode 100644 mfd/sunix/snx_ieee1284.c
+> >  create mode 100644 mfd/sunix/snx_ieee1284_ops.c
+> >  create mode 100644 mfd/sunix/snx_lp.c
+> >  create mode 100644 mfd/sunix/snx_lp.h
+> >  create mode 100644 mfd/sunix/snx_parallel.c
+> >  create mode 100644 mfd/sunix/snx_ppdev.c
+> >  create mode 100644 mfd/sunix/snx_ppdev.h
+> >  create mode 100644 mfd/sunix/snx_share.c
+> 
+
-- 
2.17.1

