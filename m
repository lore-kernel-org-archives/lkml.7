Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26096216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558356138;
	bh=Wfi5sjJAO0p3rdmcBrx/KKtYN2W7HX4627JgRQ/b/QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0XlkBFjaTLqfNaFT6rJrxJVNCyU4ykOPEBFehudlO/gW+Nsa2wqKSX19R99sJqQ+
	 W4VDofBfO1iBJKNvJ16CT0Ib5ZBeGEp5J7/qh07GdUK2mGS1JXAuFcONlcZw6PTxt9
	 OW+eHKM12RlODuI1v3xqB8+UXXcPMVbtradAUfro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbfETMa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390093AbfETMaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:30:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 072C620815;
        Mon, 20 May 2019 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355423;
        bh=Wfi5sjJAO0p3rdmcBrx/KKtYN2W7HX4627JgRQ/b/QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0ACGartGJYCOXG2zIVkWu4IYjMkj+azW7sYUGREwYIZqILEb9yyZiWWl5Thc1/jz
         FALeYN7gUL8n0rqSPpmGUS0N2hSAe6rO0tVmq3AbAobjszS3QiEIWuyrGxtHs88mq2
         XtSZpMlt9LGcZupgh2qNmRFMMLe/l/PvudPSohu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 5.0 114/123] xen/pvh: set xen_domain_type to HVM in xen_pvh_init
Date:   Mon, 20 May 2019 14:14:54 +0200
Message-Id: <20190520115252.714061220@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Pau Monne <roger.pau@citrix.com>

commit c9f804d64bb93c8dbf957df1d7e9de11380e522d upstream.

Or else xen_domain() returns false despite xen_pvh being set.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/enlighten_pvh.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -27,6 +27,7 @@ void __init xen_pvh_init(void)
 	u64 pfn;
 
 	xen_pvh = 1;
+	xen_domain_type = XEN_HVM_DOMAIN;
 	xen_start_flags = pvh_start_info.flags;
 
 	msr = cpuid_ebx(xen_cpuid_base() + 2);


