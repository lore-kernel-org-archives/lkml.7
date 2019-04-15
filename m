Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ACEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6732E218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354101;
	bh=SY+UyONV8wP7f3PvhZP+xucsYBGez/OGqrhjyq/DTAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ywXjg/RAY49PHoGLHLtqsGwBBLlIhKgFLdISJ/7U8U/4l50Fy6zZoDkkcsKFDMHDy
	 9/tb+bEbFK0WjjIU6GG3uLdufentVA0pTWq6aYaXurCzhIEHco2AlXhQxrCQnv/jGz
	 WxMvAIfTSlVQTveRLD5mU4alOVkKl0DcB9G6kbSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfDOSsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbfDOSsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:48:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A91218A1;
        Mon, 15 Apr 2019 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354095;
        bh=SY+UyONV8wP7f3PvhZP+xucsYBGez/OGqrhjyq/DTAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4L/gzTGb2kvjCxMTT8MXbqFGGNiWzvOg6iWqviL6cTzrpqIwyg+aUlKtb+LtN0UI
         f4Vc61uPV2h2aJpNhVJ7nGUWdXjgwEDOcSSBZudfGnXkLuwrVK5G828qDe/toXXX0o
         30hQtOQusUqxPYn3lgT3ENcQ1MKb10bgr6PTtldQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.9 73/76] xen: Prevent buffer overflow in privcmd ioctl
Date:   Mon, 15 Apr 2019 20:44:37 +0200
Message-Id: <20190415183729.388192500@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
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
@@ -216,6 +216,9 @@ privcmd_call(unsigned call,
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
+	if (call >= PAGE_SIZE / sizeof(hypercall_page[0]))
+		return -EINVAL;
+
 	stac();
 	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM


