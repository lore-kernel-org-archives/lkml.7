Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4795C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF1620865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124445;
	bh=nv5tyfbfrOt8/5M/vZRl8GRVLkrUHUar+IwteF0cp3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWUTZKgyme3ZhcuQ3xWcq0EjpcTqSif+r9rtXAzXI/2OV3tw9xNVCbNB1ube26TTl
	 1yI/PuYwC9wgSx6UFCpVxSvBfLpLsqUeodWfS/SFJ3oUStboOPIyHi/C2MQLugO+EO
	 55hA9AB1qBv+aK1h8tK+AJKqFs24oVPyY3Glub4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbfJCRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731423AbfJCP7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:59:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6497D222CB;
        Thu,  3 Oct 2019 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118388;
        bh=nv5tyfbfrOt8/5M/vZRl8GRVLkrUHUar+IwteF0cp3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6+G/mLSFuonIBjZmJay27UjgEAR7FqXXxSWNdKTwaCfYYJTehyTW8PWVgJ37g+Br
         JMj550TmgCJ980Ug7sBSxLctrQyPGPs0dZCKY1UGBsCeJOYx42VgXkDN31xV5c1L0G
         7BBQtbYyWrqhO3tryb+LXOfJrxtYKI0/OUF89ywg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chien Nguyen <chien.nguyen.eb@rvc.renesas.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.4 94/99] i2c: riic: Clear NACK in tend isr
Date:   Thu,  3 Oct 2019 17:53:57 +0200
Message-Id: <20191003154341.692437022@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Brandt <chris.brandt@renesas.com>

commit a71e2ac1f32097fbb2beab098687a7a95c84543e upstream.

The NACKF flag should be cleared in INTRIICNAKI interrupt processing as
description in HW manual.

This issue shows up quickly when PREEMPT_RT is applied and a device is
probed that is not plugged in (like a touchscreen controller). The result
is endless interrupts that halt system boot.

Fixes: 310c18a41450 ("i2c: riic: add driver")
Cc: stable@vger.kernel.org
Reported-by: Chien Nguyen <chien.nguyen.eb@rvc.renesas.com>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-riic.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -212,6 +212,7 @@ static irqreturn_t riic_tend_isr(int irq
 	if (readb(riic->base + RIIC_ICSR2) & ICSR2_NACKF) {
 		/* We got a NACKIE */
 		readb(riic->base + RIIC_ICDRR);	/* dummy read */
+		riic_clear_set_bit(riic, ICSR2_NACKF, 0, RIIC_ICSR2);
 		riic->err = -ENXIO;
 	} else if (riic->bytes_left) {
 		return IRQ_NONE;


