Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C34BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F1C2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887614;
	bh=QxKfCyVgcTd31Jg08AbzORDVuP+QIgFWO6/9Nc98H1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVpMWj8NsA2q/d0Z52dMOu8dKTg1iL+cOKyEF9qY982//mcoeOBqShllaSmTxzqXE
	 qNVD/lYkiF9Aj5FlmP7n74aeOYKP+vk2QM1PmVac8ySop6SP0TEWEZnRupn/QKptCI
	 9L/HX3kNWN9nEQ40diPcfBMC+TyOTgdSpXlFHOR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfK0Uqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfK0Uqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:46:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83C42166E;
        Wed, 27 Nov 2019 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887609;
        bh=QxKfCyVgcTd31Jg08AbzORDVuP+QIgFWO6/9Nc98H1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YILtucLq5flSU3pOrG1oj6Y6/f7JfTeXZW1JQETA/cSMy3UP/KqdHRJMHmkcZgVNM
         ZRElP76E5vOyNt4lB1vh/ad7MGj6DycdeleFVz7sxTgkpnjU4spXhJEHKD6HWOzpOW
         oBvPUO9P8ILME3YLlOACH/NjiHOpeVW+i+oWFdX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 025/211] powerpc/eeh: Fix use of EEH_PE_KEEP on wrong field
Date:   Wed, 27 Nov 2019 21:29:18 +0100
Message-Id: <20191127203053.545212723@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit 473af09b56dc4be68e4af33220ceca6be67aa60d ]

eeh_add_to_parent_pe() sometimes removes the EEH_PE_KEEP flag, but it
incorrectly removes it from pe->type, instead of pe->state.

However, rather than clearing it from the correct field, remove it.
Inspection of the code shows that it can't ever have had any effect
(even if it had been cleared from the correct field), because the
field is never tested after it is cleared by the statement in
question.

The clear statement was added by commit 807a827d4e74 ("powerpc/eeh:
Keep PE during hotplug"), but it didn't explain why it was necessary.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh_pe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 8545a9523b9bc..7339ca4fdc19e 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -381,7 +381,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		while (parent) {
 			if (!(parent->type & EEH_PE_INVALID))
 				break;
-			parent->type &= ~(EEH_PE_INVALID | EEH_PE_KEEP);
+			parent->type &= ~EEH_PE_INVALID;
 			parent = parent->parent;
 		}
 
-- 
2.20.1



