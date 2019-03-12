Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D62214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411821;
	bh=YVUyCY4LJ9u185fUuYteblF/WNkNrXhBmiOnqWQTh7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZLFVmBDR06zNZIj3hRaV4I4TM8ePJbFddbMz1HxcDNpOFs9r4R0CA/R1kE9t1yQHq
	 Ucnh/KppoOj60pFt4UhYdbscENWJST6cE4ezpd5O8XfZzsDmvR1bX5njtuluQ2A01n
	 D7q86cW+jcBSgZGTcxJw37gjz+fE9Cz7ULW5b+9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfCLRaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfCLRRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:19 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5106F21741;
        Tue, 12 Mar 2019 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411038;
        bh=YVUyCY4LJ9u185fUuYteblF/WNkNrXhBmiOnqWQTh7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBXywWGwX7/bE7efHZoMnCJ0irxhXOmqy/UQNVlS1U0Egqm2GPEXGL2oplL4vUo0T
         AdEF1w8oPdZ6bG6IaB6tp+mt2Z/XV9+rZEND3ckAqaFJ8UkR9UsbSGzOrvw6zlFOGT
         G4rUkdaO2Xvp1BCU5gotkEs5IINfbwTJ6pAhIYBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 17/96] netlabel: fix out-of-bounds memory accesses
Date:   Tue, 12 Mar 2019 10:09:35 -0700
Message-Id: <20190312171035.848088242@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit 5578de4834fe0f2a34fedc7374be691443396d1f ]

There are two array out-of-bounds memory accesses, one in
cipso_v4_map_lvl_valid(), the other in netlbl_bitmap_walk().  Both
errors are embarassingly simple, and the fixes are straightforward.

As a FYI for anyone backporting this patch to kernels prior to v4.8,
you'll want to apply the netlbl_bitmap_walk() patch to
cipso_v4_bitmap_walk() as netlbl_bitmap_walk() doesn't exist before
Linux v4.8.

Reported-by: Jann Horn <jannh@google.com>
Fixes: 446fda4f2682 ("[NetLabel]: CIPSOv4 engine")
Fixes: 3faa8f982f95 ("netlabel: Move bitmap manipulation functions to the NetLabel core.")
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/cipso_ipv4.c        |    3 ++-
 net/netlabel/netlabel_kapi.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -667,7 +667,8 @@ static int cipso_v4_map_lvl_valid(const
 	case CIPSO_V4_MAP_PASS:
 		return 0;
 	case CIPSO_V4_MAP_TRANS:
-		if (doi_def->map.std->lvl.cipso[level] < CIPSO_V4_INV_LVL)
+		if ((level < doi_def->map.std->lvl.cipso_size) &&
+		    (doi_def->map.std->lvl.cipso[level] < CIPSO_V4_INV_LVL))
 			return 0;
 		break;
 	}
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -903,7 +903,8 @@ int netlbl_bitmap_walk(const unsigned ch
 		    (state == 0 && (byte & bitmask) == 0))
 			return bit_spot;
 
-		bit_spot++;
+		if (++bit_spot >= bitmap_len)
+			return -1;
 		bitmask >>= 1;
 		if (bitmask == 0) {
 			byte = bitmap[++byte_offset];


