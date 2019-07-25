Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F27C22CBE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbfGYPEH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:04:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:28455 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388312AbfGYPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:04:06 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-185-V1oKFtahOA2D_7DwL36tsA-1; Thu, 25 Jul 2019 16:04:03 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 25 Jul 2019 16:04:02 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 25 Jul 2019 16:04:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qian Cai' <cai@lca.pw>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "tobin@kernel.org" <tobin@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        "jack@suse.cz" <jack@suse.cz>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] writeback: fix -Wstringop-truncation warnings
Thread-Topic: [PATCH v2] writeback: fix -Wstringop-truncation warnings
Thread-Index: AQHVQva1OgqbodGKtUurRIlIY2xLmqbbbehQ
Date:   Thu, 25 Jul 2019 15:04:02 +0000
Message-ID: <4017a4af4b0e4b96a6d7ed66afe18120@AcuMS.aculab.com>
References: <1564065511-13206-1-git-send-email-cai@lca.pw>
In-Reply-To: <1564065511-13206-1-git-send-email-cai@lca.pw>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: V1oKFtahOA2D_7DwL36tsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai
> Sent: 25 July 2019 15:39
> 
> There are many of those warnings.
> 
> In file included from ./arch/powerpc/include/asm/paca.h:15,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/thread_info.h:21,
>                  from ./include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from fs/fs-writeback.c:19:
> In function 'strncpy',
>     inlined from 'perf_trace_writeback_page_template' at
> ./include/trace/events/writeback.h:56:1:
> ./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified
> bound 32 equals destination size [-Wstringop-truncation]
>   return __builtin_strncpy(p, q, size);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by using the new strscpy_pad() which was introduced in the
> commit 458a3bf82df4 ("lib/string: Add strscpy_pad() function") and will
> always be NUL-terminated instead of strncpy(). Also, changes strlcpy()
> to use strscpy_pad() in this file for consistency.
> 
> Fixes: 455b2864686d ("writeback: Initial tracing support")
> Fixes: 028c2dd184c0 ("writeback: Add tracing to balance_dirty_pages")
> Fixes: e84d0a4f8e39 ("writeback: trace event writeback_queue_io")
> Fixes: b48c104d2211 ("writeback: trace event bdi_dirty_ratelimit")
> Fixes: cc1676d917f3 ("writeback: Move requeueing when I_SYNC set to writeback_sb_inodes()")
> Fixes: 9fb0a7da0c52 ("writeback: add more tracepoints")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Use strscpy_pad() to address the possible data leaking concern from Steve [1].
>     Replace strlcpy() as well for consistency.
> 
> [1] https://lore.kernel.org/lkml/20190716170339.1c44719d@gandalf.local.home/
> 
>  include/trace/events/writeback.h | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index aa7f3aeac740..41092d63a8de 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -66,8 +66,10 @@
>  	),
> 
>  	TP_fast_assign(
> -		strncpy(__entry->name,
> -			mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
> +		strscpy_pad(__entry->name,
> +			    mapping ?
> +			    dev_name(inode_to_bdi(mapping->host)->dev) :
> +			    "(unknown)", 32);

Shouldn't the 32 be 'sizeof (something)' ??

Oh, and a horrid line break.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

