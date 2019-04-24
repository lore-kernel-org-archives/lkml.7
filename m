Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BCFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C115E21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125998;
	bh=BhA/5EtCpsFz+7+fREpuApLVcW9Z87+ouqrHBogYnTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PSw0f7+Fnfz2Auh+x7TOcy6FH1f6PJH/Gchf9NumCEknyzeFczvaXShfcNo7tffEb
	 YvIXzJaeuLveZihnLHBjbDRWyaSDMG85bGS6OpZFJMoFXP/p5idiilBUgGuWZXjuPV
	 KKY9Go+ounpDgzYWWOVZ6yK75xfbf39+949zYBb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfDXRNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387839AbfDXRNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:15 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631C721900;
        Wed, 24 Apr 2019 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125994;
        bh=BhA/5EtCpsFz+7+fREpuApLVcW9Z87+ouqrHBogYnTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EhZvVh+c9BtKQNzqPvi2J4EO4mtN5kIqcDEAGwsS+LTfvANa33IZplfH4aIyoIklZ
         RFmNUCjeRH+U1BX+uQybPbMN3fpivgzHAWkBw27wRlrGwuYL3RyJkiz1owNTVB8dYx
         ssW8q2x05oXb4H4abbzGkpOF/l+fZAzby8V6c2UQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 3.18 056/104] xen: Prevent buffer overflow in privcmd ioctl
Date:   Wed, 24 Apr 2019 19:09:13 +0200
Message-Id: <20190424170902.788752710@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
@@ -213,6 +213,9 @@ privcmd_call(unsigned call,
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
+	if (call >= PAGE_SIZE / sizeof(hypercall_page[0]))
+		return -EINVAL;
+
 	asm volatile("call *%[call]"
 		     : __HYPERCALL_5PARAM
 		     : [call] "a" (&hypercall_page[call])


