Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DCC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7C72173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfHVFdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 01:33:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59300 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbfHVFdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 01:33:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0fil-0006LU-Tr; Thu, 22 Aug 2019 05:33:16 +0000
Date:   Thu, 22 Aug 2019 06:33:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] fs: fs_parser: avoid NULL param->string to kstrtouint
Message-ID: <20190822053315.GM1131@ZenIV.linux.org.uk>
References: <20190719232949.27978-1-nh26223.lmm@gmail.com>
 <20190816024654.GA12185@sol.localdomain>
 <20190822042249.GJ6111@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822042249.GJ6111@zzz.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:22:49PM -0700, Eric Biggers wrote:
> > > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > > index 83b66c9e9a24..7498a44f18c0 100644
> > > --- a/fs/fs_parser.c
> > > +++ b/fs/fs_parser.c
> > > @@ -206,6 +206,9 @@ int fs_parse(struct fs_context *fc,
> > >  	case fs_param_is_fd: {
> > >  		switch (param->type) {
> > >  		case fs_value_is_string:
> > > +			if (!result->has_value)
> > > +				goto bad_value;
> > > +
> > >  			ret = kstrtouint(param->string, 0, &result->uint_32);
> > >  			break;
> > >  		case fs_value_is_file:
> > > -- 
> > > 2.17.1
> > 
> > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> > 
> > Al, can you please apply this patch?
> > 
> > - Eric
> 
> Ping.  Al, when are you going to apply this?

Sits in the local queue.  Sorry, got seriously sidetracked into
configfs mess lately, will update for-next tomorrow and push
it out.
