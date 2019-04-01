Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D522C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D542084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141277;
	bh=zpIPinEcZQZvt83QWiKcwLX/oNZY2PYRi82VBsMcHb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nhQvHUfnK1AC/rQBBHeXa+XSyxR88sE0+u49p1g+sRXoabWuIes2qyBEC124oYd7k
	 9sJhNOfKJ6igqCaEwIOlfqaaLePzoCMK9BOs14etcOWvHtTdUUYUfUBbr0DGbR34iO
	 TADFHbQrDOxd0Efqqgukma2GWGKUQShyJjhAaMR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbfDARYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbfDARYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9D920856;
        Mon,  1 Apr 2019 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139449;
        bh=zpIPinEcZQZvt83QWiKcwLX/oNZY2PYRi82VBsMcHb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLBhWWD2Nuu0HxSw9QR6rHHca6HbZrcafy5CIacjvPrGqwmS+W9eZdS1f6vc+CFrn
         oyEhBk4savzpUgHpoMzOO/H1G96Ia6711Q1yF/FdwfVwdY+GOEpG+iogW2fU0UZtH2
         ELHOia8NJ30S+VuETQqILs4doFV55/F2JkTdi98g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.14 078/107] staging: vt6655: Remove vif check from vnt_interrupt
Date:   Mon,  1 Apr 2019 19:02:33 +0200
Message-Id: <20190401170052.738038744@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Priestley <tvboxspy@gmail.com>

commit cc26358f89c3e493b54766b1ca56cfc6b14db78a upstream.

A check for vif is made in vnt_interrupt_work.

There is a small chance of leaving interrupt disabled while vif
is NULL and the work hasn't been scheduled.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
CC: stable@vger.kernel.org # v4.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6655/device_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1079,8 +1079,7 @@ static irqreturn_t vnt_interrupt(int irq
 {
 	struct vnt_private *priv = arg;
 
-	if (priv->vif)
-		schedule_work(&priv->interrupt_work);
+	schedule_work(&priv->interrupt_work);
 
 	return IRQ_HANDLED;
 }


