Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B0C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EB2206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099990;
	bh=XbF+Fbw0YUo7hx0ywMUR4QLETQp349Wrkcg+6+6D23A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYHIooXaMMFRRXO7BZzxNSmmTs7LohlZ/AjJDpd2JmZGBmyzlyOMBt4GbvJm7CYqc
	 d+QjK38p+odrZ13PniBc3T6fx0C4w/G37WXCezh4AA3L7RxB91UR0U/s/uw0YZPVV+
	 +4xdkgpOgTN27jFC/yt7h0Wvcr5xvHg45DlinbX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbfFIRG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389002AbfFIRG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:06:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B69204EC;
        Sun,  9 Jun 2019 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099986;
        bh=XbF+Fbw0YUo7hx0ywMUR4QLETQp349Wrkcg+6+6D23A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhDPY6obbKM6jd7NWV3gIHDbysgKmAkbA3bD/55Mp1QJfyNk13x2X0XAnlsK7rqHu
         EeOrKj5MkW+RN3x1W/ElKMuzKeUU2Pii/rmuIKf31I7acXXhDVSfZsVxev1+HewHpz
         B5/yonNR5Ovah6KRdReje962LfsiSlMXcWBRkrns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.4 238/241] genwqe: Prevent an integer overflow in the ioctl
Date:   Sun,  9 Jun 2019 18:43:00 +0200
Message-Id: <20190609164155.652936299@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 110080cea0d0e4dfdb0b536e7f8a5633ead6a781 upstream.

There are a couple potential integer overflows here.

	round_up(m->size + (m->addr & ~PAGE_MASK), PAGE_SIZE);

The first thing is that the "m->size + (...)" addition could overflow,
and the second is that round_up() overflows to zero if the result is
within PAGE_SIZE of the type max.

In this code, the "m->size" variable is an u64 but we're saving the
result in "map_size" which is an unsigned long and genwqe_user_vmap()
takes an unsigned long as well.  So I have used ULONG_MAX as the upper
bound.  From a practical perspective unsigned long is fine/better than
trying to change all the types to u64.

Fixes: eaf4722d4645 ("GenWQE Character device and DDCB queue")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/genwqe/card_dev.c   |    2 ++
 drivers/misc/genwqe/card_utils.c |    4 ++++
 2 files changed, 6 insertions(+)

--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -782,6 +782,8 @@ static int genwqe_pin_mem(struct genwqe_
 
 	if ((m->addr == 0x0) || (m->size == 0))
 		return -EINVAL;
+	if (m->size > ULONG_MAX - PAGE_SIZE - (m->addr & ~PAGE_MASK))
+		return -EINVAL;
 
 	map_addr = (m->addr & PAGE_MASK);
 	map_size = round_up(m->size + (m->addr & ~PAGE_MASK), PAGE_SIZE);
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -582,6 +582,10 @@ int genwqe_user_vmap(struct genwqe_dev *
 	/* determine space needed for page_list. */
 	data = (unsigned long)uaddr;
 	offs = offset_in_page(data);
+	if (size > ULONG_MAX - PAGE_SIZE - offs) {
+		m->size = 0;	/* mark unused and not added */
+		return -EINVAL;
+	}
 	m->nr_pages = DIV_ROUND_UP(offs + size, PAGE_SIZE);
 
 	m->page_list = kcalloc(m->nr_pages,


