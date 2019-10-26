Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073CD2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxctGgrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfJZTLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 15:11:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38982 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfJZTLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:11:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id 15so4877523qkh.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4M2PPQu81RMk5nsX69ndHO0vXv7tXeNQzA+s8i3K/j0=;
        b=nxctGgrJoLNSbguV4WSIiZryHyyuV9e4Lvv6AkOUd+N/OEu6UteDzWWerdaNpG79vL
         jue5VXecsZTJHH3IrZBtMl34GEiwssY7I4lQxe2lnVY0A5a1GRtNi3SAms8iftHZxHzH
         /F817JeWeytYvt1RJgQYbjpGtbZbn8knYH1fBO9ckc1K0wqK83vrEZWq8QMoplEvf4ti
         n9yRs9zNiwzm3sxnV6dJ5HNKLmNvcwkQO9hvO/sLGlHIRh6UBYRW95a7tcUksgotx1Ah
         yK+IEPKFLdC+lH9Xlf/xODpQgN/XB0VC9dLqjZWvBtneTaj8VCHBoNOjlGL6WFPKJ6tE
         pQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4M2PPQu81RMk5nsX69ndHO0vXv7tXeNQzA+s8i3K/j0=;
        b=S3i+iPu0fpuwza8jrj8AT2XS4ykPp6gVQh0Al8FWMkthkkPa7i89AVev2vDe5zgrW4
         h4hYS57Zg0xvEHi2pDMOvyAqlE2se8aPd8IkkOd3RbDKyiFbUaRxPzI6coCM37cuyOmw
         jBCHf88oJLOG/X5KIgBy0p7FtUyqee8oDpNN4mOBcCT+bSlAv50Phv67uISbiBnyPcZX
         6XAzKz6T2DqfgDFEXSy07kUEmY8yUEJk5E+CV97O/YeEScVK1cKan5mXJ/MCrql/Kbr/
         MReSEtY19PR2seW4k0ylffkQoSoDKolweHq7HMNFdFWlYLjcOQjq/nc++UHCRB8uc/XS
         8UQQ==
X-Gm-Message-State: APjAAAUbW2YjtQP+6OhZ9gOY19e9dsH8yKme6g0RJwmSXjqc5xw3668+
        8lRwoLMBjKpqaNs+UJ97j/0=
X-Google-Smtp-Source: APXvYqzztmrBOC+SvoFFpb07U6iUNiAvUqvzeOLnRHzRvsJE/COvSKELq3ZUZ2EIJ8V7Rs+4/NO+Sg==
X-Received: by 2002:a37:9c44:: with SMTP id f65mr8995731qke.33.1572117066929;
        Sat, 26 Oct 2019 12:11:06 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id i5sm3004932qtb.94.2019.10.26.12.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 12:11:06 -0700 (PDT)
Date:   Sat, 26 Oct 2019 16:11:01 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v3] staging: gasket: Fix lines ending with a '('
Message-ID: <20191026191101.GA8973@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lines ending with a '('. Issue found by checkpatch.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
Changes since v2:
 - Join the two similar patches staging: gasket: Fix lines ending with a
   '('.

Changes since v1:
 - Arranging conflict between author name and signed-off-by.
---
 drivers/staging/gasket/gasket_ioctl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 240f9bb..e3047d3 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -34,8 +34,8 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
 
 	trace_gasket_ioctl_eventfd_data(die.interrupt, die.event_fd);
 
-	return gasket_interrupt_set_eventfd(
-		gasket_dev->interrupt_data, die.interrupt, die.event_fd);
+	return gasket_interrupt_set_eventfd(gasket_dev->interrupt_data,
+					    die.interrupt, die.event_fd);
 }
 
 /* Read the size of the page table. */
@@ -54,9 +54,9 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 	ibuf.size = gasket_page_table_num_entries(
 		gasket_dev->page_table[ibuf.page_table_index]);
 
-	trace_gasket_ioctl_page_table_data(
-		ibuf.page_table_index, ibuf.size, ibuf.host_address,
-		ibuf.device_address);
+	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
+					   ibuf.host_address,
+					   ibuf.device_address);
 
 	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
@@ -101,9 +101,9 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
-	trace_gasket_ioctl_page_table_data(
-		ibuf.page_table_index, ibuf.size, ibuf.host_address,
-		ibuf.device_address);
+	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
+					   ibuf.host_address,
+					   ibuf.device_address);
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
-- 
2.7.4

