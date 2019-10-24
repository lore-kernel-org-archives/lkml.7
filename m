Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58043CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2885E2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="G8ldo2dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437520AbfJXTuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:50:23 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59734 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437127AbfJXTuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:50:22 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D1D86891AB;
        Fri, 25 Oct 2019 08:50:18 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571946618;
        bh=Hs8NcqdoljgJGEwJZDugNhLtA/5VyqVGE/xZcIF5ZMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G8ldo2dqp4J5lq1pnturQcTs3+2QXGPrAwl3SDqG1M4YDQXBC+A5mdgvmrMw4GGvk
         gGEwXd9lJ6xp4Nh6SXO4afBzSqb3Jccxy7UOcE+uXPNE9sZIg7hhr3XkHeViYVwasM
         X2DU1jlUKZnGOfkuYDVbZC89Ia7z4pJElSWNPFgwbpjWmYzNDoLBgTRnoQEsl+DhjD
         y7309s0e2pmijL8o8RLN07iPqlXMt9s5X+V4R7VqCaZwYeKPUOMEmgVugNcd50yYGR
         Dh1001ZeYdsU5ToF/Vn8N3wHMfZSNqeHs1DCREj92STg0JkFe09rGKChiEw3j8wcKZ
         phQDI5Dak+f1w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db2007a0000>; Fri, 25 Oct 2019 08:50:18 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id E513313EEFC;
        Fri, 25 Oct 2019 08:50:22 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id B140728005C; Fri, 25 Oct 2019 08:50:18 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net, rppt@linux.ibm.com, willy@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 3/3] docs/core-api: memory-allocation: mention size helpers
Date:   Fri, 25 Oct 2019 08:50:16 +1300
Message-Id: <20191024195016.11054-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
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

Notes:
    Changes in v3:
    - rebase against v5.4-rc4
    Changes in v2:
    - Drop use of c:func:

 Documentation/core-api/memory-allocation.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation=
/core-api/memory-allocation.rst
index e47d48655085..4aa82ddd01b8 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -91,7 +91,8 @@ The most straightforward way to allocate memory is to u=
se a function
 from the kmalloc() family. And, to be on the safe side it's best to use
 routines that set memory to zero, like kzalloc(). If you need to
 allocate memory for an array, there are kmalloc_array() and kcalloc()
-helpers.
+helpers. The helpers struct_size(), array_size() and array3_size() can
+be used to safely calculate object sizes without overflowing.
=20
 The maximal size of a chunk that can be allocated with `kmalloc` is
 limited. The actual limit depends on the hardware and the kernel
--=20
2.23.0

