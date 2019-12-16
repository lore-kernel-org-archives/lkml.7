Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4CDC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F49206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfLPPxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:53:36 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:42470 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfLPPxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:53:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6B78BFB03;
        Mon, 16 Dec 2019 16:53:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yYpcNGzE6ASE; Mon, 16 Dec 2019 16:53:33 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A743E498AE; Mon, 16 Dec 2019 16:53:32 +0100 (CET)
Date:   Mon, 16 Dec 2019 16:53:32 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
Message-ID: <20191216155332.GA29065@bogon.m.sigxcpu.org>
References: <20191212135724.331342-1-linux@dominikbrodowski.net>
 <20191212135724.331342-4-linux@dominikbrodowski.net>
 <20191216013536.5wyvq4vjv5efd35n@core.my.home>
 <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Dec 15, 2019 at 07:50:23PM -0800, Linus Torvalds wrote:
> On Sun, Dec 15, 2019 at 5:35 PM Ondřej Jirman <megi@xff.cz> wrote:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> 
> Duh. So much for the trivial obvious conversion.
> 
> It didn't take "data might be NULL" into account.
> 
> A patch like this, perhaps? Untested..
> 
>                Linus

>  init/do_mounts.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index f55cbd9cb818..d204f605dbce 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -391,17 +391,19 @@ static int __init do_mount_root(const char *name, const char *fs,
>  				 const int flags, const void *data)
>  {
>  	struct super_block *s;
> -	char *data_page;
> -	struct page *p;
> +	struct page *p = NULL;
> +	char *data_page = NULL;
n>  	int ret;
>  
> -	/* do_mount() requires a full page as fifth argument */
> -	p = alloc_page(GFP_KERNEL);
> -	if (!p)
> -		return -ENOMEM;
> -
> -	data_page = page_address(p);
> -	strncpy(data_page, data, PAGE_SIZE - 1);
> +	if (data) {
> +		/* do_mount() requires a full page as fifth argument */
> +		p = alloc_page(GFP_KERNEL);
> +		if (!p)
> +			return -ENOMEM;
> +		data_page = page_address(p);
> +		strncpy(data_page, data, PAGE_SIZE - 1);
> +		data_page[PAGE_SIZE - 1] = '\0';
> +	}
>  
>  	ret = do_mount(name, "/root", fs, flags, data_page);
>  	if (ret)
> @@ -417,7 +419,8 @@ static int __init do_mount_root(const char *name, const char *fs,
>  	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
>  
>  out:
> -	put_page(p);
> +	if (p)
> +		put_page(p);
>  	return ret;
>  }
>  

This unbroke tftpboot on arm64 on next-20191216 for me as well:

Tested-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido
