Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A7EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ADA21907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127515;
	bh=xpVBqCJY58kY47VAjaz+q/BMuLlYfmFiGVlHcxnWGSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y5f1Mt0HJlxEztyL28yT4GqgvOtuoT5T8iJh027l48kBfsN7qzUYnvNPkeghSA4+I
	 PnRE74T4yyGb9SOo+kxPEqb4CSaGHiFbi3VYSlTzpGVLt/EVbJFWDMK8STUDd2oZfA
	 yIlobDfZ6+gwUh7Lpys9zS/QbY6SvrkCInOYyHxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392435AbfDXRie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392421AbfDXRib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:31 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB13218B0;
        Wed, 24 Apr 2019 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127510;
        bh=xpVBqCJY58kY47VAjaz+q/BMuLlYfmFiGVlHcxnWGSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAtGG0PGYekMYcUZkd0j2kk8dENnGlhqS7NveXd06fi3/3NNGQ0uBYJWr1apO3mtN
         enNPYHfqoMzNqWZhwDkUCZQJET7kcx0SFOtHyDfXeRUcB/YTl/9myNBCCQ6rknUl+m
         mEW+n1RkNQiqoKl/DvzmIU2G7TQNiJfgO2zciv6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 5.0 075/115] vt: fix cursor when clearing the screen
Date:   Wed, 24 Apr 2019 19:10:11 +0200
Message-Id: <20190424170929.418421921@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit b2ecf00631362a83744e5ec249947620db5e240c upstream.

The patch a6dbe4427559 ("vt: perform safe console erase in the right
order") introduced a bug. The conditional do_update_region() was
replaced by a call to update_region() that does contain the conditional
already, but with unwanted extra side effects such as restoring the cursor
drawing.

In order to reproduce the bug:
- use framebuffer console with the AMDGPU driver
- type "links" to start the console www browser
- press 'q' and space to exit links

Now the cursor will be permanently visible in the center of the
screen. It will stay there until something overwrites it.

The bug goes away if we change update_region() back to the conditional
do_update_region().

[ nico: reworded changelog ]

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
Cc: stable@vger.kernel.org
Fixes: a6dbe4427559 ("vt: perform safe console erase in the right order")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1518,7 +1518,8 @@ static void csi_J(struct vc_data *vc, in
 			return;
 	}
 	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
-	update_region(vc, (unsigned long) start, count);
+	if (con_should_update(vc))
+		do_update_region(vc, (unsigned long) start, count);
 	vc->vc_need_wrap = 0;
 }
 


