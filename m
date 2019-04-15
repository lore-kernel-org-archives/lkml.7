Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A99EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7CD218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354308;
	bh=sYQ1QMXpv/wJsV49N0KY/s+KsKF9a1gsPHX4kxWj84Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lNRmZYaGQiKu99qTePKFrimDDVVC4XKFCFIHIH+PlODHVuMaT3p7WBtEMAwQXriYy
	 eIOvta1KFIvq4PMCUxDP4XD3O3LtzDwrv+84Fd3vPBz2o5CJWQGmlLd1LqVS5jz86J
	 k2t+CTIHn4e6/K1u1WhOqC98QynV2h6gkTFLZ04c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfDOSvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbfDOSpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82CBC218A1;
        Mon, 15 Apr 2019 18:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353923;
        bh=sYQ1QMXpv/wJsV49N0KY/s+KsKF9a1gsPHX4kxWj84Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqpNPBrutPahpVeCDDo3fjtjMG2NC502kRlmc22HYxUncFwf7prKKVUQ1pho4NOkl
         ECofpGBhrUzAfiU9aN4jkzR3sbQX+OhqbObaClqHfvCv+WottvC04/iMXTEfkTztB6
         SNjiGj/jygh+JwGHsLEJ+JasERAgvKkz1RdAupyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/76] powerpc/64: Disable the speculation barrier from the command line
Date:   Mon, 15 Apr 2019 20:43:44 +0200
Message-Id: <20190415183712.869759410@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit cf175dc315f90185128fb061dc05b6fbb211aa2f upstream.

The speculation barrier can be disabled from the command line
with the parameter: "nospectre_v1".

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/security.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index bf298d0c475f..813e38ff81ce 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -17,6 +17,7 @@
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
 bool barrier_nospec_enabled;
+static bool no_nospec;
 
 static void enable_barrier_nospec(bool enable)
 {
@@ -43,9 +44,18 @@ void setup_barrier_nospec(void)
 	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
 		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
 
-	enable_barrier_nospec(enable);
+	if (!no_nospec)
+		enable_barrier_nospec(enable);
 }
 
+static int __init handle_nospectre_v1(char *p)
+{
+	no_nospec = true;
+
+	return 0;
+}
+early_param("nospectre_v1", handle_nospectre_v1);
+
 #ifdef CONFIG_DEBUG_FS
 static int barrier_nospec_set(void *data, u64 val)
 {
-- 
2.19.1



