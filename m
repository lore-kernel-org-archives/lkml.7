Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E29C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3026821582
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLSHIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:08:48 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49774 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfLSHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 02:08:47 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 58C662009A2;
        Thu, 19 Dec 2019 07:08:46 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 189DD20BB5; Thu, 19 Dec 2019 08:08:36 +0100 (CET)
Date:   Thu, 19 Dec 2019 08:08:36 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     youling 257 <youling257@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as
 stdin/stdout/stderr
Message-ID: <20191219070836.GA496264@light.dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com>
 <20191217064254.GB3247@light.dominikbrodowski.net>
 <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com>
 <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
 <CAOzgRdaRDnd3gi0QO-b_2Nm4RXf_+UJ+Ec1Ne0=cx00fKpZN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzgRdaRDnd3gi0QO-b_2Nm4RXf_+UJ+Ec1Ne0=cx00fKpZN8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 05:50:19AM +0800, youling 257 wrote:
> 2019-12-18 5:14 GMT+08:00, Linus Torvalds <torvalds@linux-foundation.org>:
> > This should be fixed by 2d3145f8d280 ("early init: fix error handling
> > when opening /dev/console")
> 
> this fix no help for me.
> 
> > I'm not sure what you did to trigger that bug, but it was a bug.
> 
> alt+f1, type bash command,
> bash: cannot set terminal process group (-1): Inappropriate ioctl for device
> bash: no job control in this shell

Could you test this patch, please? And if it does not work: What is the
content of /proc/1/fd/ and /proc/1/fdinfo/* for the working and non-working
case? That are the only changes visible to userspace...

Thanks,
	Dominik

diff --git a/init/main.c b/init/main.c
index 1ecfd43ed464..8886530e9dec 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1162,7 +1162,7 @@ void console_on_rootfs(void)
 	unsigned int i;
 
 	/* Open /dev/console in kernelspace, this should never fail */
-	file = filp_open("/dev/console", O_RDWR, 0);
+	file = filp_open("/dev/console", force_o_largefile() ? O_LARGEFILE | O_RDWR : O_RDWR, 0);
 	if (IS_ERR(file))
 		goto err_out;
 
