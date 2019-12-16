Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3AAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFD3205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLPJvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:51:39 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:43154 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLPJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:51:39 -0500
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id A6B3C200AB8; Mon, 16 Dec 2019 09:51:37 +0000 (UTC)
Date:   Mon, 16 Dec 2019 10:51:37 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] init: use do_mount() instead of ksys_mount()
Message-ID: <20191216095137.omiovbgt5bwjahku@isilmar-4.linta.de>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191212181422.31033-4-linux@dominikbrodowski.net>
 <20191216094556.GA32241@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216094556.GA32241@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:45:56AM +0100, Borislav Petkov wrote:
> On Thu, Dec 12, 2019 at 07:14:20PM +0100, Dominik Brodowski wrote:
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index 43f6d098c880..f55cbd9cb818 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -387,12 +387,25 @@ static void __init get_fs_names(char *page)
> >  	*s = '\0';
> >  }
> >  
> > -static int __init do_mount_root(char *name, char *fs, int flags, void *data)
> > +static int __init do_mount_root(const char *name, const char *fs,
> > +				 const int flags, const void *data)
> >  {
> >  	struct super_block *s;
> > -	int err = ksys_mount(name, "/root", fs, flags, data);
> > -	if (err)
> > -		return err;
> > +	char *data_page;
> > +	struct page *p;
> > +	int ret;
> > +
> > +	/* do_mount() requires a full page as fifth argument */
> > +	p = alloc_page(GFP_KERNEL);
> > +	if (!p)
> > +		return -ENOMEM;
> > +
> > +	data_page = page_address(p);
> 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> That doesn't work in my guest as it gives a funny address:
> 
> [    3.155314] mount_block_root: entry
> [    3.155868] mount_block_root: fs_name: [ext3]
> [    3.156512] do_mount_root: will copy data page: 0x00000000adf0ddb8
> 
> leading to the splat below.

Does

https://lore.kernel.org/lkml/CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com/

solve the issue?

Thanks,
	Dominik
