Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27212075D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2RKyvcgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDDC0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:26:05 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55224 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDC0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:26:05 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0C849806B6;
        Thu,  4 Apr 2019 15:26:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1554344762;
        bh=C/Vl4b4/WKwrIuLC3TGftDWsZMiZp//VsiHckM1ilA0=;
        h=From:To:Cc:Subject:Date;
        b=2RKyvcgsNf/A6MjtiT5/B8oCYYFhFSOpE+jxuX+p7bN/OhEkBraplLx0/JTfieKx/
         kfmfawmiSiyQGmENjbqml+FGQpFng7ejMXLGd6GcWUB2L2T1M19Z7sLFqPSAGcA4aK
         rTpkSaPw/qMZJYbVPhMvD/gIJ0YQisxyKqoJf+EXRbi99GzWjxB3VS9zP7eJHQb0pq
         P5SioSfMNERG09SwCY45bRwI19QcO5bdtE5zsRYhlZDOUEIBGxDPpt9iE79nvoTxxC
         6QXtvL/yASPgUyAB5Swtyw0F0ASoHM3r2r2y2Q9yYGYJTj0de54VHSZ65QVvIrnUg4
         uegJpSUjo0s8Q==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ca56b3a0000>; Thu, 04 Apr 2019 15:26:02 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id EB86513EC0E;
        Thu,  4 Apr 2019 15:26:01 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C2AF91E1105; Thu,  4 Apr 2019 15:26:01 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     pantelis.antoniou@konsulko.com, frowand.list@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] of: Documentation: Correct return value from of_overlay_fdt_apply
Date:   Thu,  4 Apr 2019 15:25:55 +1300
Message-Id: <20190404022555.29382-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from of_overlay_fdt_apply() just indicates success or fail.
The cookie is returned via reference.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/devicetree/overlay-notes.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/d=
evicetree/overlay-notes.txt
index 725fb8d255c1..62f2003d6205 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -88,7 +88,8 @@ Overlay in-kernel API
 The API is quite easy to use.
=20
 1. Call of_overlay_fdt_apply() to create and apply an overlay changeset.=
 The
-return value is an error or a cookie identifying this overlay.
+return indicates success or failure. A a cookie identifying this overlay=
 is
+returned via reference on success.
=20
 2. Call of_overlay_remove() to remove and cleanup the overlay changeset
 previously created via the call to of_overlay_fdt_apply(). Removal of an
--=20
2.21.0

