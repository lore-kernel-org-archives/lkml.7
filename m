Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11809C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE38E2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576076927;
	bh=cRi5G9C0XWPPCnV+02MMDB3bXkRsVGf0Rh3K1z24W0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JunRVjzoxs04fWp7t/x4lfNGnUcLp1WjUkD/g45XrKgNPBSSLOFFM17/0gYp08vPA
	 kwxzJ2rGxnCs54SiHGiqGmxD4vG107yjtc9GXDcBQdA5ODjNbDG5UM1rytBZwNGVl/
	 fqGBXxhUmsYHsvSQvd4wMuAvm53r4grWkW07pvNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfLKPIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbfLKPIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:08:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981AD2173E;
        Wed, 11 Dec 2019 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076924;
        bh=cRi5G9C0XWPPCnV+02MMDB3bXkRsVGf0Rh3K1z24W0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tG9/eKBj6q7FojlEGo8U1gZxjhoEtjErd8oJv9GsWL+3Gf6QtTiMyPvBzeCfpVd7t
         5/xUolbovOx849FDi/XIuDb0zngmiI2J97yB2wNo4SKUQb0OcwCCj3W0skAwcDfFGS
         3dPo9b9pljo4ghV/XOd54nvLldqHDWz4dYVP67jU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.4 06/92] lp: fix sparc64 LPSETTIMEOUT ioctl
Date:   Wed, 11 Dec 2019 16:04:57 +0100
Message-Id: <20191211150223.378611864@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 45a2d64696b11913bcf1087b041740edbade3e21 upstream.

The layout of struct timeval is different on sparc64 from
anything else, and the patch I did long ago failed to take
this into account.

Change it now to handle sparc64 user space correctly again.

Quite likely nobody cares about parallel ports on sparc64,
but there is no reason not to fix it.

Cc: stable@vger.kernel.org
Fixes: 9a450484089d ("lp: support 64-bit time_t user space")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20191108203435.112759-7-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/lp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -713,6 +713,10 @@ static int lp_set_timeout64(unsigned int
 	if (copy_from_user(karg, arg, sizeof(karg)))
 		return -EFAULT;
 
+	/* sparc64 suseconds_t is 32-bit only */
+	if (IS_ENABLED(CONFIG_SPARC64) && !in_compat_syscall())
+		karg[1] >>= 32;
+
 	return lp_set_timeout(minor, karg[0], karg[1]);
 }
 


