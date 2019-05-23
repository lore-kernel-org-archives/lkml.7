Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFDDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA217206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639726;
	bh=qpl016BkmSFCvPID8ZSSBPcjs49qlh2T94srlmxYxog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=011KzuVrcOXsNDwH7f4rDNCLZBwm0nQLBiCYM/X0oo3qL47JGvvpgUaXo+nu1fZ+z
	 J+CyOChJqBzQo9XCEKOVtB0KNLEbvPGEAdAAclUYXX9tZwlmKimqAnO4mmkCBkz7tz
	 6f+SplCzN3nBChBhkjEXTWxpvXFkqOS9aVOIm9VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391821AbfEWT2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391222AbfEWT2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:28:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889722054F;
        Thu, 23 May 2019 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639721;
        bh=qpl016BkmSFCvPID8ZSSBPcjs49qlh2T94srlmxYxog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snqvrKZqCR+dP+UrWIgD3uRcGQM/YfG8+KnUdeIGRwanRlOwujJ649N6DIQJ3psra
         5fboz1O9YQlvLwxfbQ9vPvJjF/Om1pm5FxBulruON4dQuXxpnFyGiUtkNncNRsJj9k
         YleBCdvxBQAV32nvmVhJaTWBgdIgAnieOj/Uc0tY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Douglas Anderson <dianders@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.1 070/122] gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < 6
Date:   Thu, 23 May 2019 21:06:32 +0200
Message-Id: <20190523181713.987899105@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

commit 259799ea5a9aa099a267f3b99e1f7078bbaf5c5e upstream.

Use gen_rtx_set instead of gen_rtx_SET. The former is a wrapper macro
that handles the difference between GCC versions implementing
the latter.

This fixes the following error on my system with g++ 5.4.0 as the host
compiler

   HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c:42:14: error: macro "gen_rtx_SET" requires 3 arguments, but only 2 given
          mask)),
               ^
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c: In function ‘unsigned int arm_pertask_ssp_rtl_execute()’:
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c:39:20: error: ‘gen_rtx_SET’ was not declared in this scope
    emit_insn_before(gen_rtx_SET

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
Cc: stable@vger.kernel.org
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
+++ b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
@@ -36,7 +36,7 @@ static unsigned int arm_pertask_ssp_rtl_
 		mask = GEN_INT(sext_hwi(sp_mask, GET_MODE_PRECISION(Pmode)));
 		masked_sp = gen_reg_rtx(Pmode);
 
-		emit_insn_before(gen_rtx_SET(masked_sp,
+		emit_insn_before(gen_rtx_set(masked_sp,
 					     gen_rtx_AND(Pmode,
 							 stack_pointer_rtx,
 							 mask)),


