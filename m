Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0A8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188E6218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355644;
	bh=e2tOFBoU5wYtkPRHkaxNc1B5wnVXy5OOuGbYz/kMnbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nEUFLVSRnSKXxmQGyTdiScN5UcsVTgpQZHZnWFWWdVVrzNUPbiUHhegnMka+xgl6Z
	 QGfHLPPpVnblZqrJeqcoGpbx0hgOPr+ZH3SYMR2mte3IX+wMvNMQJ3PGdVkIrSTtRa
	 QdJ3uko8MB9512QlfM2gYZJyNVHWUa5i5adeR9Ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfDOTOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731673AbfDOTOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1233E218A1;
        Mon, 15 Apr 2019 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355640;
        bh=e2tOFBoU5wYtkPRHkaxNc1B5wnVXy5OOuGbYz/kMnbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUQtctVGFVCQweIzf1yveyWSe1CvtDQDW7cNX6LaCUp7Oi9cMWne64qy6Iyh0XrjP
         d/7DOx6U3DfR7UvmXcQxxAhtYvMRJy/Z446cvmGWYwd67OrxreNX93AsNJsTZ2uYBs
         NNjfUrgVajEGEhCyeu7a9uRfmqU2jFp8FxFrSISI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.0 097/117] xen: Prevent buffer overflow in privcmd ioctl
Date:   Mon, 15 Apr 2019 21:01:07 +0200
Message-Id: <20190415183749.748211194@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
@@ -206,6 +206,9 @@ xen_single_call(unsigned int call,
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
+	if (call >= PAGE_SIZE / sizeof(hypercall_page[0]))
+		return -EINVAL;
+
 	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM
 		     : [thunk_target] "a" (&hypercall_page[call])


