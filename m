Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73435C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB522075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfKFTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:12:26 -0500
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:38615 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727411AbfKFTMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:12:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3B3AF8384366;
        Wed,  6 Nov 2019 19:12:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: club05_4efb27ab1d741
X-Filterd-Recvd-Size: 2816
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Nov 2019 19:12:22 +0000 (UTC)
Message-ID: <e3ee9e75d7c25e2d25b74fd1d4709f8dacb79efc.camel@perches.com>
Subject: Re: [PATCH] staging: gasket: gasket_ioctl: Remove unnecessary
 line-breaks in funtion signature
From:   Joe Perches <joe@perches.com>
To:     Valery Ivanov <ivalery111@gmail.com>, rspringer@google.com,
        toddpoynor@google.com, benchan@chromium.org,
        Simon Que <sque@chromium.org>,
        John Joseph <jnjoseph@google.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Nov 2019 11:12:09 -0800
In-Reply-To: <20191106180821.GA19385@hwsrv-485799.hostwindsdns.com>
References: <20191106180821.GA19385@hwsrv-485799.hostwindsdns.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 18:08 +0000, Valery Ivanov wrote:
> 	This patch fix the function signature for trace_gasket_ioctl_page_table_data
> 	to avoid the checkpatch.pl warning:
> 
> 		CHECK: Lines should not end with a '('
> 
> Signed-off-by: Valery Ivanov <ivalery111@gmail.com>

All of this stuff is no-op and could just as easily be removed
completely as GASKET_KERNEL_TRACE_SUPPORT is not #defined anywhere.

Is the actual trace #include file supposed to be available somewhere?

#ifdef GASKET_KERNEL_TRACE_SUPPORT
#define CREATE_TRACE_POINTS
#include <trace/events/gasket_ioctl.h>
#else
#define trace_gasket_ioctl_entry(x, ...)
#define trace_gasket_ioctl_exit(x)
#define trace_gasket_ioctl_integer_data(x)
#define trace_gasket_ioctl_eventfd_data(x, ...)
#define trace_gasket_ioctl_page_table_data(x, ...)
#define trace_gasket_ioctl_config_coherent_allocator(x, ...)
#endif

trace file not found...

> ---
>  drivers/staging/gasket/gasket_ioctl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
> index 240f9bb..55cb6b1 100644
> --- a/drivers/staging/gasket/gasket_ioctl.c
> +++ b/drivers/staging/gasket/gasket_ioctl.c
> @@ -54,9 +54,10 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
>  	ibuf.size = gasket_page_table_num_entries(
>  		gasket_dev->page_table[ibuf.page_table_index]);
>  
> -	trace_gasket_ioctl_page_table_data(
> -		ibuf.page_table_index, ibuf.size, ibuf.host_address,
> -		ibuf.device_address);
> +	trace_gasket_ioctl_page_table_data(ibuf.page_table_index,
> +					   ibuf.size,
> +					   ibuf.host_address,
> +					   ibuf.device_address);
>  
>  	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
>  		return -EFAULT;

