Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD91C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D9020811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfC0Gyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:54:37 -0400
Received: from shell.v3.sk ([90.176.6.54]:49630 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfC0Gyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:54:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C887A103523;
        Wed, 27 Mar 2019 07:54:32 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dLeMTF1Dff8i; Wed, 27 Mar 2019 07:54:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2665F103540;
        Wed, 27 Mar 2019 07:54:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g7T2WHuZJ3wc; Wed, 27 Mar 2019 07:54:29 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6D0D5103523;
        Wed, 27 Mar 2019 07:54:29 +0100 (CET)
Message-ID: <93930d9c577a7cf83dc7c96ae411dec4d6d47610.camel@v3.sk>
Subject: Re: [PATCH 2/3] *: convert stream-like files from nonseekable_open
 -> stream_open
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kirill Smelkov <kirr@nexedi.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Mar 2019 07:54:28 +0100
In-Reply-To: <8794193f3040b798010970228d978c05ad56ec52.1553637462.git.kirr@nexedi.com>
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
         <8794193f3040b798010970228d978c05ad56ec52.1553637462.git.kirr@nexedi.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 (3.32.0-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 23:23 +0000, Kirill Smelkov wrote:
> Using scripts/coccinelle/api/stream_open.cocci added in the previous
> patch, search and convert to stream_open all in-kernel nonseekable_open
> users for which read and write actually do not depend on ppos and where
> there is no other methods in file_operations which assume @offset
> access.
> 
> I've verified each generated change manually - that it is correct to convert -
> and each other nonseekable_open instance left - that it is either not correct
> to convert there, or that it is not converted due to current stream_open.cocci
> limitations. The script also does not convert files that should be valid to
> convert, but that currently have .llseek = noop_llseek or generic_file_llseek
> for unknown reason despite file being opened with nonseekable_open (e.g.
> drivers/input/mousedev.c)
> 
> Among cases converted 14 were potentially vulnerable to read vs write deadlock
> (see details in the previous patch):

...

> and the reset were just safe to convert to stream_open because their
> read and write do not use ppos at all and corresponding file_operations
> do not have methods that assume @offset file access:

...

> 	drivers/char/pcmcia/scr24x_cs.c:95:8-24: WARNING: scr24x_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.

...

> diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
> index f6b43d9350f0..04b39c3596cc 100644
> --- a/drivers/char/pcmcia/scr24x_cs.c
> +++ b/drivers/char/pcmcia/scr24x_cs.c
> @@ -92,7 +92,7 @@ static int scr24x_open(struct inode *inode, struct file *filp)
>  	kref_get(&dev->refcnt);
>  	filp->private_data = dev;
>  
> -	return nonseekable_open(inode, filp);
> +	return stream_open(inode, filp);
>  }
>  
>  static int scr24x_release(struct inode *inode, struct file *filp)

Acked-by: Lubomir Rintel <lkundrak@v3.sk> [scr24x_cs]

Thanks,
Lubo

