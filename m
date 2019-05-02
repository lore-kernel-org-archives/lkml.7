Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE8BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 03:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA402081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 03:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556768556;
	bh=ApmPWhKcbXqiUmCqMT7flsb2t6g+TFEMVI5IYvB+0aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UhhHYD+9+piVGYZHywunNTfzuuOOEpkPl1MQINzDzawavCNVm/0SJaAemauylQCHZ
	 Sgzf9DA4t7Crv6j/LOTukDOZUCiOOTbf+8jWYLoUhJ9/WXjc/EIp2hOWbFkuuiwJxj
	 WG3Pqv17RD4a/TO+0ZPqrD6cXS6ZFrjFezXrWASU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBDmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 23:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfEBDmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 23:42:16 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269D32081C;
        Thu,  2 May 2019 03:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556768535;
        bh=ApmPWhKcbXqiUmCqMT7flsb2t6g+TFEMVI5IYvB+0aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuW936WeaX+HEtMiWEAyxQLaLlidHsg44K4UqS0IuKqyabPiIUagL/3UKUZEWuBda
         u4fKXo7hQTj/ql/5Xvg+s5yxLU4jqFR629CeqmbFmdWrHhjR8ds5BKksSIzZ1dC8kv
         Dj7zFuDtojlc1rpEqiNV9HqasVtXYSv6dqdyGtZc=
Date:   Wed, 1 May 2019 20:42:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: linux-next: build failure after merge of the f2fs tree
Message-ID: <20190502034214.GA37709@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190502105309.7ad51660@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502105309.7ad51660@canb.auug.org.au>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02, Stephen Rothwell wrote:
> Hi Jaegeuk,
> 
> After merging the f2fs tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/trace/define_trace.h:96,
>                  from include/trace/events/f2fs.h:1724,
>                  from fs/f2fs/super.c:35:
> include/trace/events/f2fs.h: In function 'trace_raw_output_f2fs_filemap_fault':
> include/trace/events/f2fs.h:1310:3: error: '_entry' undeclared (first use in this function); did you mean 'dentry'?
>    _entry->ret)
>    ^~~~~~
> include/trace/trace_events.h:360:22: note: in definition of macro 'DECLARE_EVENT_CLASS'
>   trace_seq_printf(s, print);     \
>                       ^~~~~
> include/trace/trace_events.h:79:9: note: in expansion of macro 'PARAMS'
>          PARAMS(print));         \
>          ^~~~~~
> include/trace/events/f2fs.h:1287:1: note: in expansion of macro 'TRACE_EVENT'
>  TRACE_EVENT(f2fs_filemap_fault,
>  ^~~~~~~~~~~
> include/trace/events/f2fs.h:1307:2: note: in expansion of macro 'TP_printk'
>   TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %lx",
>   ^~~~~~~~~
> include/trace/events/f2fs.h:1310:3: note: each undeclared identifier is reported only once for each function it appears in
>    _entry->ret)
>    ^~~~~~
> include/trace/trace_events.h:360:22: note: in definition of macro 'DECLARE_EVENT_CLASS'
>   trace_seq_printf(s, print);     \
>                       ^~~~~
> include/trace/trace_events.h:79:9: note: in expansion of macro 'PARAMS'
>          PARAMS(print));         \
>          ^~~~~~
> include/trace/events/f2fs.h:1287:1: note: in expansion of macro 'TRACE_EVENT'
>  TRACE_EVENT(f2fs_filemap_fault,
>  ^~~~~~~~~~~
> include/trace/events/f2fs.h:1307:2: note: in expansion of macro 'TP_printk'
>   TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %lx",
>   ^~~~~~~~~
> 
> Caused by commit
> 
>   90a238561901 ("f2fs: add tracepoint for f2fs_filemap_fault()")
> 
> I have applied the following patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 2 May 2019 10:44:46 +1000
> Subject: [PATCH] f2fs: fix up for "f2fs: add tracepoint for
>  f2fs_filemap_fault()"
> 
> Fixes: 90a238561901 ("f2fs: add tracepoint for f2fs_filemap_fault()")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/trace/events/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 6a53c793cf20..53b96f12300c 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1307,7 +1307,7 @@ TRACE_EVENT(f2fs_filemap_fault,
>  	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %lx",
>  		show_dev_ino(__entry),
>  		(unsigned long)__entry->index,
> -		_entry->ret)
> +		__entry->ret)

My bad. I was so hurried up. Uploaded again w/ fix.

Thanks,

>  );
>  
>  TRACE_EVENT(f2fs_writepages,
> -- 
> 2.20.1
> 
> -- 
> Cheers,
> Stephen Rothwell


