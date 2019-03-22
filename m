Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F37DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF6218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253968;
	bh=58vDfN6oQo1Jj7dSL6HS2HUUZpUUJlBCo58rLnaR+Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lTrT283FFPA2OYtBtkR7zvS8sESrPt2cl0oxrtuXdR5UcDm4F6DrY5JnlCtlngTMI
	 6kPphxYzIjGFm1NFzReK6Opl/B+wEusphxOXzRrF/3VcmV0Htjk7btpwphUnR/Bt6l
	 pEKPNVrZiahcmPNEri9qc0NvdSEayEn77EigNuh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfCVL0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbfCVL0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:26:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF21218B0;
        Fri, 22 Mar 2019 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253964;
        bh=58vDfN6oQo1Jj7dSL6HS2HUUZpUUJlBCo58rLnaR+Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRbvQjbnUSqWeTn0uV8bXNZP0MJFFN3IN8qjU6bvEBV85XnsElOKlikMgVkBoJxOr
         GE5nXB208eKyBkrVcW5o5aPeOOhGpg/ToyexQ+4f8mDflda5j4KxVECx3lbjiYUCOe
         snPVMkV2qw4GC3Z1YvsL0BvOCAC6grfKonAW8ESQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Neuschafer <j.neuschaefer@gmx.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3.18 125/134] powerpc/wii: properly disable use of BATs when requested.
Date:   Fri, 22 Mar 2019 12:15:38 +0100
Message-Id: <20190322111219.494735102@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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


