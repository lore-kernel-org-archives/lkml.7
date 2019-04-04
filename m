Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A54C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C9C206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554405048;
	bh=EQaIMZMrA9rRfWRUtSzTgrE5ZBBorf6KBVaFmMqIMCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pw4giR6mMc8v/dqDJ0+9WSlzkClolZG4JM8U2HLWzvbBAmG+B354Cbu3w/rdICTC0
	 9igRgfN5Ta+KUurjEuUDR4MufqS6zK1YWA7XqeiF6Mujn+bv7oNr30vUPew6Ie/Oy9
	 I3zWClrA7EK3dTut3b9UTXUHsHdHq/IjhizW8864=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfDDTKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:10:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfDDTKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:10:47 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 843481CE3;
        Thu,  4 Apr 2019 19:10:45 +0000 (UTC)
Date:   Thu, 4 Apr 2019 12:10:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Timur Tabi <timur@freescale.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Mihai Caraman <mihai.caraman@freescale.com>,
        Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] fsl_hypervisor: dereferencing error pointers in
 ioctl
Message-Id: <20190404121044.a38ba5895a485abcdc57f297@linux-foundation.org>
In-Reply-To: <20181218082003.GD32567@kadam>
References: <20181218082003.GD32567@kadam>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 11:20:03 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The strndup_user() function returns error pointers on error, and then
> in the error handling we pass the error pointers to kfree().  It will
> cause an Oops.
> 

Looks good to me.

I guess we should fix this too?


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/util.c: fix strndup_user() comment

The kerneldoc misdescribes strndup_user()'s return value.

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/util.c~mm-utilc-fix-strndup_user-comment
+++ a/mm/util.c
@@ -204,7 +204,7 @@ EXPORT_SYMBOL(vmemdup_user);
  * @s: The string to duplicate
  * @n: Maximum number of bytes to copy, including the trailing NUL.
  *
- * Return: newly allocated copy of @s or %NULL in case of error
+ * Return: newly allocated copy of @s or an ERR_PTR() in case of error
  */
 char *strndup_user(const char __user *s, long n)
 {
_

