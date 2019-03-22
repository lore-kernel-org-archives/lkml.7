Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAFCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30230204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254747;
	bh=/dRj5GDuMBGcjiBidW3vzfvOc16HqPmFJaCLNOrZWfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vMFoqm0VsMUjNbZH90KOg273q1+zu50ZK+PPdFN4oyqjZrAdnizYdMlzvdsqWHdhC
	 PFwNsoBOqvXD1E/rRhO4/SIY0T4OJTG/zyDykoUGBjMhQebCJUA5iRylx3zAidKzr7
	 y7Y5z0wy6jN6VpYAB6OKSrHcbxaKMAUrg+vu+/es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfCVLjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731051AbfCVLi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA332082C;
        Fri, 22 Mar 2019 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254738;
        bh=/dRj5GDuMBGcjiBidW3vzfvOc16HqPmFJaCLNOrZWfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBBsy+orDyZvc2EpJAkT/DXYutooufwnrgGGstnYRk2nhbqGrnZFB8+ltKl60Bady
         lP4pOiRybGYTrLtfxquSMHRy4nV686g0p5QI2a5EzloTn1PoTaGW2IuKNqwsZrNBiX
         lP5JHIBVtjH3kq/2axdPiTQfsET9mApIqE21mB/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Neuschafer <j.neuschaefer@gmx.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 210/230] powerpc/wii: properly disable use of BATs when requested.
Date:   Fri, 22 Mar 2019 12:15:48 +0100
Message-Id: <20190322111251.635165517@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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


