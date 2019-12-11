Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117B3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182322B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077413;
	bh=J0/dCpkbwviskgvf/sHrToY2GUEYWtA7wO3SVXlQHQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJz+n0u8SVXL/Qm1QjnzdIu0ORvnHr4pj5aK3M5r83LT9pCTM/nbfUruGk5kYLixc
	 /tl5EmcWfa8pl2o2vqVvzQm8nsEClrHGFmOB1x716iJSHthTwecOnur5SBfL/+os8N
	 QLSikZ/hQRNsdLnsm0HAeoyKd79CLunv4aRoPI4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfLKPQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731950AbfLKPQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:16:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55F620663;
        Wed, 11 Dec 2019 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077407;
        bh=J0/dCpkbwviskgvf/sHrToY2GUEYWtA7wO3SVXlQHQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+zGKl4V7I8+eRLtUVzVWSTJQXXhDfmVM+QdDHyuk/srT1zhWM/vngVY4rkbrJRrb
         ygJMYjBuLusTw4Nj2jecv3v1wJxgSdYZxLKmNDY+37216xCRdqMleOqULC3Gvphik2
         GPiCNHDtr5z/hLqyPWWjd2dzeDOl1MY+2ybGqids=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Tuowen Zhao <ztuowen@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 003/243] sparc64: implement ioremap_uc
Date:   Wed, 11 Dec 2019 16:02:45 +0100
Message-Id: <20191211150339.383790721@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuowen Zhao <ztuowen@gmail.com>

commit 38e45d81d14e5f78cd67922596b1c37b4c22ec74 upstream.

On sparc64, the whole physical IO address space is accessible using
physically addressed loads and stores. *_uc does nothing like the
others.

Cc: <stable@vger.kernel.org> # v4.19+
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sparc/include/asm/io_64.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -409,6 +409,7 @@ static inline void __iomem *ioremap(unsi
 }
 
 #define ioremap_nocache(X,Y)		ioremap((X),(Y))
+#define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
 


