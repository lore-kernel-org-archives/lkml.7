Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE1C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E09E22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620774;
	bh=Qt0pZTBm2HLd9hNL3X5vWaW/wEcU1poUIWeHPEe82YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tclvfkFem3i4Fj/Vp2XoHGr2RFY5q9zShzjbcUaQJPajn83R+/5UknfYDPEHV/vkT
	 H5clh8ZUJjq+rqnM3FR2JovUStoqzxsj9UKOjWniEGFTOH34hoHvc291YDwffQRJcM
	 GHAVxQ1aCx6tRani34sLtyaEclxv4RIhTtQliG2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390573AbfIDSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389947AbfIDSMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:12:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B86E206BA;
        Wed,  4 Sep 2019 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620768;
        bh=Qt0pZTBm2HLd9hNL3X5vWaW/wEcU1poUIWeHPEe82YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPAI8I20L/jdgUsmpZs/GJyw2fbgqYzFFrR52ougpGbGD/JudUxIKsE2XZQ0y6rjs
         Y6+tplZ3r/DHxSLEwla5cvsTH50abk8UaAVxCJDqRRWmgVhCIKel0eeH8GRhLZwZuX
         UykpswWRcasGp0WFiEwK+aNO1FT/HGGpiKonlU5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pu Wen <puwen@hygon.cn>,
        Calvin Walton <calvin.walton@kepstin.ca>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 5.2 087/143] tools/power turbostat: Fix caller parameter of get_tdp_amd()
Date:   Wed,  4 Sep 2019 19:53:50 +0200
Message-Id: <20190904175317.487175133@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pu Wen <puwen@hygon.cn>

commit 9cfa8e042f7cbb1994cc5923e46c78b36f6054f4 upstream.

Commit 9392bd98bba760be96ee ("tools/power turbostat: Add support for AMD
Fam 17h (Zen) RAPL") add a function get_tdp_amd(), the parameter is CPU
family. But the rapl_probe_amd() function use wrong model parameter.
Fix the wrong caller parameter of get_tdp_amd() to use family.

Cc: <stable@vger.kernel.org> # v5.1+
Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/power/x86/turbostat/turbostat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4002,7 +4002,7 @@ void rapl_probe_amd(unsigned int family,
 	rapl_energy_units = ldexp(1.0, -(msr >> 8 & 0x1f));
 	rapl_power_units = ldexp(1.0, -(msr & 0xf));
 
-	tdp = get_tdp_amd(model);
+	tdp = get_tdp_amd(family);
 
 	rapl_joule_counter_range = 0xFFFFFFFF * rapl_energy_units / tdp;
 	if (!quiet)


