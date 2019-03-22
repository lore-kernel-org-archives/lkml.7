Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA61C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFFF2196F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257053;
	bh=/sYybjV4ZXrhU8fVI1P/yGqG3xnY+lsZ/Tc5+odlpM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y/05GFMLGXMLdvPsziDGrKxFApkl2xE3oBE0r2xuFjeYJhycVlxk3Lgg0+MuuLuAZ
	 zhuDwVtOO/4AQBbkfd0b7vdXy2Dxlq88mjdRpn5JyI0k+PybzSiqvW9PfwpPZGqKbd
	 HPX72DfqEsw1xaJRuthbZG6FGVIQFNoMksZdmEkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390381AbfCVMRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390362AbfCVMRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4376A21939;
        Fri, 22 Mar 2019 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257049;
        bh=/sYybjV4ZXrhU8fVI1P/yGqG3xnY+lsZ/Tc5+odlpM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piR3nT42H10WE1x1vww9RN/P4eoxxvphU5ZEv92m4Ivd7k6amj0IlVVUqrBAgn5C3
         JxXdsguVkXhHk5a7yXSAqY2c7baAraEXvdzzRlg6VmN9R2H+YQCplLjJTkEt34fHpd
         CEEt3XIrgX8ZkrMl5IKPpABydwr8ip0YEfogjcRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        QiaoChong <qiaochong@loongson.cn>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5.0 116/238] parport_pc: fix find_superio io compare code, should use equal test.
Date:   Fri, 22 Mar 2019 12:15:35 +0100
Message-Id: <20190322111305.355583482@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: QiaoChong <qiaochong@loongson.cn>

commit 21698fd57984cd28207d841dbdaa026d6061bceb upstream.

In the original code before 181bf1e815a2 the loop was continuing until
it finds the first matching superios[i].io and p->base.
But after 181bf1e815a2 the logic changed and the loop now returns the
pointer to the first mismatched array element which is then used in
get_superio_dma() and get_superio_irq() and thus returning the wrong
value.
Fix the condition so that it now returns the correct pointer.

Fixes: 181bf1e815a2 ("parport_pc: clean up the modified while loops using for")
Cc: Alan Cox <alan@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: QiaoChong <qiaochong@loongson.cn>
[rewrite the commit message]
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/parport/parport_pc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -1377,7 +1377,7 @@ static struct superio_struct *find_super
 {
 	int i;
 	for (i = 0; i < NR_SUPERIOS; i++)
-		if (superios[i].io != p->base)
+		if (superios[i].io == p->base)
 			return &superios[i];
 	return NULL;
 }


