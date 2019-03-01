Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60D8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C76206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BXthCjy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbfCARi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:38:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40125 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCARiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:38:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so26788208wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpFbWZjb8R6pbiLHLaaQoaYVFWfx50E2CHn4tXQQCBE=;
        b=BXthCjy5jN1VAcuPVkWE/qu1WqbDAS5UUUcC0kqy14N93Gq8CA9KXDxMgddLqSfsmQ
         E026msUYesDxtWjrd0B2vBffAhTa7vDNUjwoJlgYs85y/8XRBM+V+bqpunlfUablLxrr
         uux0CCdoVLgDAZceGwWR9mApjSV2NMAsFbjlc3v+8+DAXO71l1d00HRNdeSXsk42ot6T
         /Ed8jjTxXKedNtcrDttu2WBukQPopuByaKfhQUDvTJNFAAM+ZHSvISSPu3EghdUN+Eo9
         HY+Ava/J3tDN9XHsorOs4MOv2gBaVsHEAjeEXIRtM1/pM5ESKaVDqJiLjiCyG1aMEeDe
         6fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpFbWZjb8R6pbiLHLaaQoaYVFWfx50E2CHn4tXQQCBE=;
        b=d3r9/6Tjqbquzfoub4Z/tan0yTqgY9CF9nOBYMdie01rX9Og2z85w94w7KryLEmAr/
         BfufLe/rfwHo8gehPh/bBWNwRpU0HfyJEurwKSUqPD3FFPnTnPkvY76/sxe8D/eqHLCF
         bcGrdsTUSZZP+mgLUbnqjpvQLCJkz9cz2/ZH1wZ8v6QqU1/+XQX4a39ST0tTS55JmHbo
         ezGzhJqM5o+dKjI+8VHw3X1wPpNDUz69vRL1WSD5azj32T6RDp9gABSOI/Xb7UT+pDFh
         2e2PxCH7rj3GmXXC0v4EIJ7MrP4rScg2v37R07KgEc/XrhMebLeT2NsWfOUIRy5wkkXs
         5dKQ==
X-Gm-Message-State: APjAAAWQv6+IRne4A5sLEo2J3dyLp1AHO0pu2ov0/6nlhq74JBSwlw8H
        Xw10UY/GqU6o9uD9i4DUrg7ETTdU
X-Google-Smtp-Source: APXvYqwpRmC3py2dyI4jDeNTDLpLOmh+UhMVhBwfhi7Gr0xFHo5UABkpV1n98clqbiymRmwhs4p8KA==
X-Received: by 2002:adf:fdcd:: with SMTP id i13mr4028827wrs.212.1551461933870;
        Fri, 01 Mar 2019 09:38:53 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD7109200428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d710:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id y5sm48577069wrd.97.2019.03.01.09.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:38:53 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        liang.yang@amlogic.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] meson-nand: two small memory related fixes
Date:   Fri,  1 Mar 2019 18:38:18 +0100
Message-Id: <20190301173820.30776-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to add support for older Meson SoCs to the meson-nand
driver I was experiencing a crash in meson_nfc_read_buf(). While trying
to find out why that happened I inspected the code in that function and
found that there's:
- a missing check on the return value of a kzalloc() call
- a potential memory leak in it

Both fixes have nothing to do with my original crash (for which I'll
open a separate thread).


Martin Blumenstingl (2):
  mtd: rawnand: meson: add missing ENOMEM check in meson_nfc_read_buf()
  mtd: rawnand: meson: fix a potential memory leak in meson_nfc_read_buf

 drivers/mtd/nand/raw/meson_nand.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.21.0

