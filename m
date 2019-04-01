Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8460C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890E1218FF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139118;
	bh=aCs+YMqqCjKCWBTOdHxcBj9YdgKsJRkw+C8tgdM0xOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DISvd+sXfHebnkpIlNGCWtpjCA7+vRpRRu7uFTw9hVi6A8TDc6Bay+9xtn7RZMahJ
	 rCuEwU4Mgts74lViyAouQuXRNZjOAH4LNEUCwJXjI29MfYeWw+ilbKGJF7qTJZHSAa
	 Q4ow0PqLSmu61F81ebsSWG7P83zMazoyY3NXQi+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfDARSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbfDARSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F15C1218FE;
        Mon,  1 Apr 2019 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139113;
        bh=aCs+YMqqCjKCWBTOdHxcBj9YdgKsJRkw+C8tgdM0xOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ung8mHz6LwcceIx8lXnh7HF28laR91HsQDeytDRP5R3wlf2+yslDTEGaRF2Ov0Wvc
         JH9ZABo73oIyfDlf/MZmjTnMraLZn19Rh8M7QVclPHBF0rw57ubX3C3MyErAh+/Ssq
         jQe2dUWYgeQ2djAPJgFlH8uet+IvCYVmlBFQRpzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fredrik Noring <noring@nocrew.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.19 070/134] kbuild: modversions: Fix relative CRC byte order interpretation
Date:   Mon,  1 Apr 2019 19:01:46 +0200
Message-Id: <20190401170051.016293263@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fredrik Noring <noring@nocrew.org>

commit 54a7151b1496cddbb7a83546b7998103e98edc88 upstream.

Fix commit 56067812d5b0 ("kbuild: modversions: add infrastructure for
emitting relative CRCs") where CRCs are interpreted in host byte order
rather than proper kernel byte order. The bug is conditional on
CONFIG_MODULE_REL_CRCS.

For example, when loading a BE module into a BE kernel compiled with a LE
system, the error "disagrees about version of symbol module_layout" is
produced. A message such as "Found checksum D7FA6856 vs module 5668FAD7"
will be given with debug enabled, which indicates an obvious endian
problem within __kcrctab within the kernel image.

The general solution is to use the macro TO_NATIVE, as is done in
similar cases throughout modpost.c. With this correction it has been
verified that a BE kernel compiled with a LE system accepts BE modules.

This change has also been verified with a LE kernel compiled with a LE
system, in which case TO_NATIVE returns its value unmodified since the
byte orders match. This is by far the common case.

Fixes: 56067812d5b0 ("kbuild: modversions: add infrastructure for emitting relative CRCs")
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Cc: stable@vger.kernel.org
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/mod/modpost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -640,7 +640,7 @@ static void handle_modversions(struct mo
 			       info->sechdrs[sym->st_shndx].sh_offset -
 			       (info->hdr->e_type != ET_REL ?
 				info->sechdrs[sym->st_shndx].sh_addr : 0);
-			crc = *crcp;
+			crc = TO_NATIVE(*crcp);
 		}
 		sym_update_crc(symname + strlen("__crc_"), mod, crc,
 				export);


