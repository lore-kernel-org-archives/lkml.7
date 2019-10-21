Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A431CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5F02084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="H7NHbbP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfJUV2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 17:28:18 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54238 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUV2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:28:17 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 96032806A8;
        Tue, 22 Oct 2019 10:28:15 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571693295;
        bh=/9WEDL+fNPGUYcD1D7L8SeMPWVImYAJaQx7z2ohQhEE=;
        h=From:To:Cc:Subject:Date;
        b=H7NHbbP6GUyoF08lrnjLonUPXH+RxcN3DUX0TYoVELO/iN50BjToNITiUSnd+rhNk
         NRgETb4mHZNRuxkI+hBIMBTz59UZznBaGlqHT1i4yh1KFoBeCudyIRU8YqzNM+eRKO
         lWJJFakhZzIyogTgd+xjrknZ7UFyqOO2PhsaUfZvfwiKDNNXTER4soerECO6DHSHJS
         RhaIIDyL8WXxC087zJtTBRdbYk4lIAi4yqgdqGcEnGgxrSNGq271k6P5FnIbws0AwU
         uMjQdn1v1DK1+NaRLf9Fjyt4pKOtpSkoLFF/4TZ5TnIwgTo/cIqRr4FWlwF01FNuhi
         1CiuOBbtWY0MA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dae22ed0000>; Tue, 22 Oct 2019 10:28:15 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id B688013EEEB;
        Tue, 22 Oct 2019 10:28:16 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D9A47280059; Tue, 22 Oct 2019 10:28:10 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net, willy@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] docs/core-api: memory-allocation: mention size helpers
Date:   Tue, 22 Oct 2019 10:27:47 +1300
Message-Id: <20191021212751.21300-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention struct_size(), array_size() and array3_size() in the same place
as kmalloc() and friends.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/core-api/memory-allocation.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation=
/core-api/memory-allocation.rst
index e59779aa7615..6a131767becd 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -91,7 +91,9 @@ The most straightforward way to allocate memory is to u=
se a function
 from the :c:func:`kmalloc` family. And, to be on the safe side it's
 best to use routines that set memory to zero, like
 :c:func:`kzalloc`. If you need to allocate memory for an array, there
-are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers.
+are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers. The helpers
+:c:func:`struct_size`, :c:func:`array_size` and :c:func:`array3_size` ca=
n be
+used to safely calculate object sizes without overflowing.
=20
 The maximal size of a chunk that can be allocated with `kmalloc` is
 limited. The actual limit depends on the hardware and the kernel
--=20
2.23.0

