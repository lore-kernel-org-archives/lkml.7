Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEBDC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03668208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099774;
	bh=HvJL7t2idgccN7TE0yztFjS3HveqVYCdJcj2hPPEAWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KIKGfN9xw88yShJ27giStVO9Lz3oN9Q56RBQU8qZ4X64qgVOWgemauiPxQGstRm2k
	 pkyOPN1jkwPa8PzgyYuhtZLGs0QZwXQpTUrjI+ddQlZ7rRLzq9Fu/Xr7Fjj45MB8Z5
	 6Mj3ehOyaZVJoGeU7q8AT9puW/mIld5hMdA3d+ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbfFIRCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388302AbfFIRCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:02:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7FC7204EC;
        Sun,  9 Jun 2019 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099766;
        bh=HvJL7t2idgccN7TE0yztFjS3HveqVYCdJcj2hPPEAWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwEDYWt8fLq5kPQI4b+vWeaIDurasVakP8bm6/VSUZuXX3Ggs2MIxlkiXB72MDMV6
         StAK67VsVGkh8Oi0oLWYm7u/17Ryg/eV9W6dAPY+A7MbAXV+HyjSI3a7KZtPYjd3J6
         F9NsVxOtZV/IIFtiXLfhBGbV9F4HQ3FQGeIetC28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 158/241] arm64: cpu_ops: fix a leaked reference by adding missing of_node_put
Date:   Sun,  9 Jun 2019 18:41:40 +0200
Message-Id: <20190609164152.326381415@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 92606ec9285fb84cd9b5943df23f07d741384bfc ]

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
  ./arch/arm64/kernel/cpu_ops.c:102:1-7: ERROR: missing of_node_put;
  acquired a node pointer with refcount incremented on line 69, but
  without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpu_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index b6bd7d4477683..fbd6aead48e10 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -73,6 +73,7 @@ static const char *__init cpu_read_enable_method(int cpu)
 				pr_err("%s: missing enable-method property\n",
 					dn->full_name);
 		}
+		of_node_put(dn);
 	} else {
 		enable_method = acpi_get_enable_method(cpu);
 		if (!enable_method)
-- 
2.20.1



