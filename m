Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77480C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD0221783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120528;
	bh=ZsSQ/Q9nhpssLAIx6yD5sSkzGLXOhaVzTnt0SeF9+v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBgwDRlRHfGGKixNy22rG/eKlgLKyBBiSqx+7Jq7WIXEywRoffjJfCoKZdW/+MX3g
	 iK5l5ou5K1EbUA1q9Rasd4bTshSJmn7yo9A/FCBZvrjfpgJ2b6jwSkAIRsTm9x/1kZ
	 sHJwLSKjV/ZKNTqN/aFWd+rInX0TSWiN5uCzUAdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404101AbfJCQf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404074AbfJCQfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:35:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D582070B;
        Thu,  3 Oct 2019 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120521;
        bh=ZsSQ/Q9nhpssLAIx6yD5sSkzGLXOhaVzTnt0SeF9+v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkWCfsnQl6SHN44K/2Sg1DZ2SRNJYmdEh5IbHnNSvqCZsBj7yjDpMYyuhn2t8dDst
         1hJv0B05pBk6Z7U5LOvMdic9SJm3IHp+hnu4dLOM51j4j29lKBsM4CojxPRMcBmVed
         OFrYswMqUUvKncPHnhCL7jSLRjP+6+zS7g3Ekigg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lihua Yao <ylhuajnu@outlook.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.2 254/313] ARM: samsung: Fix system restart on S3C6410
Date:   Thu,  3 Oct 2019 17:53:52 +0200
Message-Id: <20191003154558.054311010@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lihua Yao <ylhuajnu@outlook.com>

commit 16986074035cc0205472882a00d404ed9d213313 upstream.

S3C6410 system restart is triggered by watchdog reset.

Cc: <stable@vger.kernel.org>
Fixes: 9f55342cc2de ("ARM: dts: s3c64xx: Fix infinite interrupt in soft mode")
Signed-off-by: Lihua Yao <ylhuajnu@outlook.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/plat-samsung/watchdog-reset.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/plat-samsung/watchdog-reset.c
+++ b/arch/arm/plat-samsung/watchdog-reset.c
@@ -62,6 +62,7 @@ void samsung_wdt_reset(void)
 #ifdef CONFIG_OF
 static const struct of_device_id s3c2410_wdt_match[] = {
 	{ .compatible = "samsung,s3c2410-wdt" },
+	{ .compatible = "samsung,s3c6410-wdt" },
 	{},
 };
 


