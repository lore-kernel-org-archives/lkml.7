Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0781EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD94C21929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931701;
	bh=MJwYI1KVbjryZ/U0QHBipNr+8bajKoJ+EZOTakjitT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i00W1V3iGp86U8P2hUo9GKYGTrmvAMogxTrrHSgaj9jI/QqubkecSu1hjezh6iAUy
	 bVJ9wDDfE5DUxDjjs6bTqs+iVSOD44L8WEhxOsMNfRgK+OYppXXaRM3q/mrS9N8dgf
	 tH701nO+MAs3Ls/DXUah64xHvFNUSXPl4eorCuD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391128AbfISWVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404844AbfISWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:21:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D835E20678;
        Thu, 19 Sep 2019 22:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931697;
        bh=MJwYI1KVbjryZ/U0QHBipNr+8bajKoJ+EZOTakjitT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWv3xZJAptqbZkZ6/WWrzOWJ5FAxEMEE8ikTqZlC1GUlAkTSxZnJ4NbE6Z4L09O9h
         cPBNUNSOEDkYzRVv6NytR+NsIT/8DOb5OTjXVW0xd+fP3KJMKNWBOIBtGlqlq+Hmbr
         gwhBXluNgYKk+dJeOX+XD9NQGnwhMfvWLEZxxI4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.9 74/74] ARC: export "abort" for modules
Date:   Fri, 20 Sep 2019 00:04:27 +0200
Message-Id: <20190919214811.564310227@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <Vineet.Gupta1@synopsys.com>

This is a custom patch (no mainline equivalent) for stable backport only
to address 0-Day kernel test infra ARC 4.x.y builds errors.

The reason for this custom patch as that it is a single patch, touches
only ARC, vs. atleast two 7c2c11b208be09c1, dc8635b78cd8669 which touch
atleast 3 other arches (one long removed) and could potentially have a
fallout.

Reported-by: kbuild test robot <lkp@intel.com>
CC: stable@vger.kernel.org	# 4.4, 4.9
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/kernel/traps.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -163,3 +163,4 @@ void abort(void)
 {
 	__asm__ __volatile__("trap_s  5\n");
 }
+EXPORT_SYMBOL(abort);


