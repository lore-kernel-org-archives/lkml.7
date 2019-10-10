Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C58C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50DD2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570698195;
	bh=oBREHTCqD/gGEukiA0iqbonD4Urkz3cKma22LzCtM84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+EBm0UpEMXer6HlHxZMHyefeaf5h4B7YNBxsxhl3QyV23A9+Xp/5PxXn2icc111y
	 4aUeLz5iCdxNDcoXeEiCo1h0iAFr73z2NhT/WAPIApHXwIOi5zwwGjrEG7JQ1gu7Ou
	 7hEgFjoURh3TdU8KiF/Oj34BSkG4z0Dtso3A3Kfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfJJIiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387574AbfJJIiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:38:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAF221920;
        Thu, 10 Oct 2019 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696696;
        bh=oBREHTCqD/gGEukiA0iqbonD4Urkz3cKma22LzCtM84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8rUlvqmGFxfiflHAFEklvdePFWJ4OaYkhmZ6IOXXyZp8ZQUgDvzn+6wZjjWWLnnF
         j3OCWdg6R02yyeoqCVoWYgHKvPDwH2YrguOxY89O4U+NEf+h26WeTYYjq/4e/OeT/s
         +YcKROVsWDIs+vvDyjZ1KiJbKg0aMnzoKga8QVoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.3 002/148] s390/sclp: Fix bit checked for has_sipl
Date:   Thu, 10 Oct 2019 10:34:23 +0200
Message-Id: <20191010083610.090992036@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Rudo <prudo@linux.ibm.com>

commit 4df9a82549cfed5b52da21e7d007b79b2ea1769a upstream.

Fixes: c9896acc7851 ("s390/ipl: Provide has_secure sysfs attribute")
Cc: stable@vger.kernel.org # 5.2+
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/char/sclp_early.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -40,7 +40,7 @@ static void __init sclp_early_facilities
 	sclp.has_gisaf = !!(sccb->fac118 & 0x08);
 	sclp.has_hvs = !!(sccb->fac119 & 0x80);
 	sclp.has_kss = !!(sccb->fac98 & 0x01);
-	sclp.has_sipl = !!(sccb->cbl & 0x02);
+	sclp.has_sipl = !!(sccb->cbl & 0x4000);
 	if (sccb->fac85 & 0x02)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
 	if (sccb->fac91 & 0x40)


