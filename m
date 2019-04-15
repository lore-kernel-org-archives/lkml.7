Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE37C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4420880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355076;
	bh=FSot5ajDooOK5ejFH0Px/bpFGRjRkguVbJL6pzZxERY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NBD6LQlFPshgp72Kdiz8WDS8VBlEC5/qQ3+YgCgnAUa3y1aY4Ss/e6u863lNg1PpM
	 drVXOOvwsKfj3v9f5OL4iVBuc7n6XDaBuNYSNOxM13UcGQq2o5wLnRS1S98tf3U+FR
	 Tn1qXeZHcZVVLSjJvW9oBflwjydivEhRGlJA7AcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfDOTEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbfDOTE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596D1218DA;
        Mon, 15 Apr 2019 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355066;
        bh=FSot5ajDooOK5ejFH0Px/bpFGRjRkguVbJL6pzZxERY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQfx1ZfvW+42acFMTQ5X4KaJDYCxkBm9b7Ik1q1ZdSs7U9mdyTal/IxP9JFSNL/9N
         LlPhCNZhkNvajtNjRDXZiBw/4V0awkRDpLYHLM/0fcjQ2Ty9scy2BPsHsVYXfs0jdT
         PT/GPP0WodOgTxH231yLKA9722ppuytYkRJVC3iI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.14 60/69] xen: Prevent buffer overflow in privcmd ioctl
Date:   Mon, 15 Apr 2019 20:59:18 +0200
Message-Id: <20190415183735.614134038@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 42d8644bd77dd2d747e004e367cb0c895a606f39 upstream.

The "call" variable comes from the user in privcmd_ioctl_hypercall().
It's an offset into the hypercall_page[] which has (PAGE_SIZE / 32)
elements.  We need to put an upper bound on it to prevent an out of
bounds access.

Cc: stable@vger.kernel.org
Fixes: 1246ae0bb992 ("xen: add variable hypercall caller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/xen/hypercall.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -217,6 +217,9 @@ privcmd_call(unsigned call,
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
+	if (call >= PAGE_SIZE / sizeof(hypercall_page[0]))
+		return -EINVAL;
+
 	stac();
 	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM


