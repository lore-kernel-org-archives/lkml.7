Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B54C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDB52073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ot6m6to1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfHBFCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:02:41 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47665 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfHBFCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:02:41 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E1F38806CB;
        Fri,  2 Aug 2019 17:02:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1564722158;
        bh=rpSZNOrtu8ZQ+NBLB2MkGMKd/4UQg6zVQsIynrawJko=;
        h=From:To:Cc:Subject:Date;
        b=ot6m6to1liCC374hNPw/XTFF8B5TDJpVo/FZdRiyN7jroz3Lv+Q34lPlZUwhZaM2d
         aquth2Kb8PnqdvS2T2huzA5Q1DZWRlVgQaQVNAi5053fOpJ/3NaM8+h//JtSCqefZ5
         vNX5TUcaDINe3rzrR7YohERtykISWqyumZlllRvaasOAagOmwteI7y/7DtHORwVR7t
         7T7BHhJIDpUjAwBWw7J+Byh63j6wQbbIZe57/HrBUNBEBJ4prwP2YFYJnexLlQgMzf
         JPCsu4u2a3C6kIjz6L2YaoD8ZOBjBT5f6Fs+gwPKv3UVsj2ol6rYwwf6BjzffLBkKX
         4qDLfiPpFSbjA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d43c3ee0000>; Fri, 02 Aug 2019 17:02:38 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 94DE413EC73;
        Fri,  2 Aug 2019 17:02:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 5909A1E0505; Fri,  2 Aug 2019 17:02:38 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] powerpc: Remove inaccessible CMDLINE default
Date:   Fri,  2 Aug 2019 17:02:32 +1200
Message-Id: <20190802050232.22978-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cbe46bd4f510 ("powerpc: remove CONFIG_CMDLINE #ifdef mess")
CONFIG_CMDLINE has always had a value regardless of CONNIG_CMDLINE_BOOL.

For example:

 $ make ARCH=3Dpowerpc defconfig
 $ cat .config
 # CONFIG_CMDLINE_BOOL is not set
 CONFIG_CMDLINE=3D""

When enabling CONNIG_CMDLINE_BOOL this value is kept making the 'default
"..." if CONNIG_CMDLINE_BOOL' ineffective.

 $ ./scripts/config --enable CONFIG_CMDLINE_BOOL
 $ cat .config
 CONFIG_CMDLINE_BOOL=3Dy
 CONFIG_CMDLINE=3D""

Additionally all the in-tree powerpc defconfigs that set
CONFIG_CMDLINE_BOOL=3Dy also set CONFIG_CMDLINE to something else. For
these reasons remove the inaccessible default.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
This should be independent of http://patchwork.ozlabs.org/patch/1140811/ =
but
I've generated this patch on a stream that has it applied locally.

 arch/powerpc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d413fe1b4058..6fca6eba6aee 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -844,7 +844,6 @@ config CMDLINE_BOOL
=20
 config CMDLINE
 	string "Initial kernel command string" if CMDLINE_BOOL
-	default "console=3DttyS0,9600 console=3Dtty0 root=3D/dev/sda2" if CMDLI=
NE_BOOL
 	default ""
 	help
 	  On some platforms, there is currently no way for the boot loader to
--=20
2.22.0

