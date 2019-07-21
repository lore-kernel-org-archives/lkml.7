Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF8FC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 22:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FC8208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 22:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="succyzJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfGUW4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 18:56:01 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52693 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGUW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 18:56:00 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2A9E7891A9;
        Mon, 22 Jul 2019 10:55:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1563749758;
        bh=ovlcuYNvidxvSKD/QxmtBakA4LY0nVMfXfU5c2EM+yo=;
        h=From:To:Cc:Subject:Date;
        b=succyzJzYfb47De4gPCdy4X3CDUGLLT6MXc3ehvZNeD4dlv2e2CtFA9Ox5i4Hlses
         EvAhOId4Fe8ilz3o5Ml7YEAW1YiCmcEn7P1NO2BkDEeXMgQLQXzQ3CzcIFSSa1vrVS
         /Tezq1kFD+YElE7sQZNWqBXAjknxYa0ZWqJzKm5gKLIUOf8mqgaXL1SVEh09V/I42w
         AZGzbyY+9vjET/d3EcDJlZmhzMM+MldT2Y/3UXtqju+z9KU6fiedT1v73NNm3PXZ4L
         puReB9h1RAYUt+giZIJqvOY7dgfztkUk12Gc3wPpCPfi2383tGV92liGLBdzSujwVx
         b+r8Zaip4IdEg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d34ed7e0000>; Mon, 22 Jul 2019 10:55:58 +1200
Received: from grantmc-dl.ws.atlnz.lc (grantmc-dl.ws.atlnz.lc [10.33.24.16])
        by smtp (Postfix) with ESMTP id EAD0713EECE;
        Mon, 22 Jul 2019 10:55:59 +1200 (NZST)
Received: by grantmc-dl.ws.atlnz.lc (Postfix, from userid 1772)
        id E48F0100E0A; Mon, 22 Jul 2019 10:55:57 +1200 (NZST)
From:   Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
Subject: [PATCH v2 0/1] hwmon: (adt7475) Convert to use hwmon_device_register_with_groups()
Date:   Mon, 22 Jul 2019 10:55:29 +1200
Message-Id: <20190721225530.28799-1-grant.mcewan@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:=20
Addressing maintainer feedback,
- Increased attribute array from 8 to 9, to accommodate NULL terminator.
- Removed #define ATTR_GROUP_COUNT.
- Replaced hwmon_device_register_with_groups() with=20
  devm_hwmon_device_register_with_groups() api.
- Removed the adt7475_remove_files() as no longer necessary with new API.
- Replaced goto eremove calls, with simple returns.
- Removed .remove function.=20

Grant McEwan (1):
  hwmon: (adt7475) Convert to use hwmon_device_register_with_groups()

 drivers/hwmon/adt7475.c | 146 ++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 96 deletions(-)

--=20
2.22.0

