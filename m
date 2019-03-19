Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92211C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E57A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSM8bcfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfCSCU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40996 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfCSCUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so12726242pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
        b=WSM8bcfnzprJdWx5H+Bbv4NvzZb7wmLUkYvEXRdyRIA5Wek38wiyF5fe3XVDp6HxhT
         SvVyViH+yOhwKt5+i0vurYanvZ8p+7/XaZT+N/09Z4mb0j1ffPYCdO/VV/Rmg1j8OXR6
         l6vfFMjD9dK320LX88jeEMALCpeYCU+OZQFHRrJB7BYXIx+Wf/mTqJevt5oMTgUEhjNO
         HhGi9v8uHsnhCYu4jocHvOqIx1oxeMs3wYpDBpUnKWFzF2ByzT1hFXJfEWfMxZ9sjOVQ
         qa2yU0L1O2tZ7bhBxG+k+KBlp+I2vnJMt0+oDT36Q/jj6m8hTO9q1IET22Be90zWrdWm
         P+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
        b=iBlF8y58TYsweP/KFyKFfh8PI+dA38mchijtFlL4GO11m2Mx6NKaqkudFOS4ey/4kb
         aSGjBgE9x/2TFfvliG5TBcfoH6sNH2jD0eVSpJD9WFCbRf5p9mosxjwbN7P70sFnz2C3
         fHatLpE80xqDpEgVZasY897tCRyBuR62pn+K4E13M450BHVDGHELD9W57RadMe539GhX
         HjrjEwky8uI1nPTyTKfac897mlWBwOW551JJlR7n59NT7Kd3569nYSToVlcrQF0ls0KJ
         GqioiT5X9m1J+kHFv05a+6XxANuwuwCJRXa6FOYyUUahijiDtOIn7Vzfe4ozFqsQrNVr
         hHJw==
X-Gm-Message-State: APjAAAURdSlpz+teBCzJW6C/NSt1cDHTAtL8xCZ5RqNW4b/mWvoFJ2Bn
        zn974LPo2Ca8+MBCxV+xzqA=
X-Google-Smtp-Source: APXvYqydjAiDuBrPLoPLHvLscIhaXBUi7pdqSp5G6oVnWTJMUlOMWrMZhOnpVN474rtNeCUPGWjaAg==
X-Received: by 2002:a63:4550:: with SMTP id u16mr20189420pgk.73.1552962053552;
        Mon, 18 Mar 2019 19:20:53 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([106.51.22.39])
        by smtp.gmail.com with ESMTPSA id m3sm13043728pgp.85.2019.03.18.19.20.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 19:20:52 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:55:27 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [RESEND PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_map_pages_zero()
Message-ID: <88645f5ea8202784a8baaf389e592aeb8c505e8e.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages_zero() to map range of kernel memory
to user vma.

This driver has ignored vm_pgoff and mapped the entire pages. We
could later "fix" these drivers to behave according to the normal
vm_pgoff offsetting simply by removing the _zero suffix on the
function name and if that causes regressions, it gives us an easy
way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..5414eb1 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
 int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 			  struct vm_area_struct *vma)
 {
-	unsigned long uaddr;
-	int i, err;
-
-	uaddr = vma->vm_start;
-	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
-		if (err)
-			return err;
-
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_map_pages_zero(vma, buffer->pages,
+					buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1

