Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEE4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3FD2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255660;
	bh=cnS2fEERMrsXpz+ta5VNVOqAKVTT+QKUwcFWQtZTlA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZ1HGU3SnD41u5N8ush1sEO53okkzOrmYXz8xmwbIO//m+uA7OivpXJO637ilypac
	 hH7mj4kcUEWBZOY+MkdkmVb4yhow+ujomsodLqxdwwvsONeHINsNYF+YwQaz7ygHag
	 8PiaY5Lltwm6D6yZdCZaPdNwQhhj3x26Vsivbh3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfCVLyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733141AbfCVLyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B661E21916;
        Fri, 22 Mar 2019 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255653;
        bh=cnS2fEERMrsXpz+ta5VNVOqAKVTT+QKUwcFWQtZTlA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Va5PjwHvFBFX8uTpvX56o6Mg9Fa23umgUyLxOQZFlRYdj7U0eCo7A/0HMfYMgy4cV
         8oVBDeZ6AMfpMN79mX7Qopka8by/2RPh2zdDOb3OOR5eiNThLZTvcUCCi3ZIBkw+Jr
         Z6FiBHaAiofV7lKS/QdQ1dXoLZMMlkDpj7me5lII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Neuschafer <j.neuschaefer@gmx.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 139/183] powerpc/wii: properly disable use of BATs when requested.
Date:   Fri, 22 Mar 2019 12:16:07 +0100
Message-Id: <20190322111251.836728223@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 6d183ca8baec983dc4208ca45ece3c36763df912 upstream.

'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
deny the use of BATS for mapping memory.

This patch makes sure that the specific wii RAM mapping function
takes it into account as well.

Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
Cc: stable@vger.kernel.org
Reviewed-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/embedded6xx/wii.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -104,6 +104,10 @@ unsigned long __init wii_mmu_mapin_mem2(
 	/* MEM2 64MB@0x10000000 */
 	delta = wii_hole_start + wii_hole_size;
 	size = top - delta;
+
+	if (__map_without_bats)
+		return delta;
+
 	for (bl = 128<<10; bl < max_size; bl <<= 1) {
 		if (bl * 2 > size)
 			break;


