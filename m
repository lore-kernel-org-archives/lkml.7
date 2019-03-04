Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D687C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FC92070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="T5Jh0MLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfCDWwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:52:15 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53672 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfCDWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:52:15 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2477E8364E;
        Tue,  5 Mar 2019 11:52:12 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551739932;
        bh=MA8yGFL1oGnce1p29rOjE5IpIBjc3hYH1RdYA+FXsvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T5Jh0MLPtQz7HDePpbK5kcz6dqDHiEiSbrPVnLMWLEXjQT9/IWoKFHTrgGiB+Usfu
         uBFRuX+LSxYwTj96rZ6eSVLsxeJ32pwTMB/SWRgh9eTiDrPPQr+V1FQNGeC0WDQwMO
         +VVvPx9o9UEm96qESTpI0kmona9UZrafWey0NKErUnAsUuHuFrpTEJ1ZfjMXOeEi5f
         QMHYd4+vpmu3bvc6WQFRyryVsB15H9c0SFA6fmTni8TQ/sefpi5sYtp4MVSDBUB5zM
         eC7sPqThy7//PlBcpwI8MoG9kNka0iZkYjMebsRU9VSkNih7BJH4t1mSBwdrvr3D7f
         h8E3rs72qV9rw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c7dac170000>; Tue, 05 Mar 2019 11:52:10 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 44FF413ED4A;
        Tue,  5 Mar 2019 11:52:09 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 069EC1E1D96; Tue,  5 Mar 2019 11:52:09 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        jason@lakedaemon.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] watchdog: orion_wdt: add pretimeout support
Date:   Tue,  5 Mar 2019 11:51:50 +1300
Message-Id: <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190227230707.GA28635@roeck-us.net>
References: <20190227230707.GA28635@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up from https://lore.kernel.org/lkml/20190227230707.GA28=
635@roeck-us.net/

It appears that the kernel has only ever used timer0 on the
orion/kirkwood/armada platforms so timer1 appears to be spare on all of
these. Armada-XP and Armada-385 also have timers 2 and 3 which could be
used in a similar way if it is deemed that timer1 should be kept for
some other purpose.

Chris Packham (2):
  watchdog: orion: remove orion_wdt_set_timeout
  watchdog: orion_wdt: use timer1 as a pretimeout

 arch/arm/boot/dts/armada-38x.dtsi |  1 +
 drivers/watchdog/orion_wdt.c      | 66 ++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 28 deletions(-)

--=20
2.21.0

