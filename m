Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F9C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 21:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4D6208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 21:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfL1VWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 16:22:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52268 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfL1VWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 16:22:09 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ilJX2-0004zv-Ox; Sat, 28 Dec 2019 21:21:56 +0000
Date:   Sat, 28 Dec 2019 21:21:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH RESEND] erofs: convert to use the new mount fs_context api
Message-ID: <20191228212156.GU4203@ZenIV.linux.org.uk>
References: <20191226022519.53386-1-yuchao0@huawei.com>
 <20191227035016.GA142350@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227035016.GA142350@architecture4>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 11:50:16AM +0800, Gao Xiang wrote:
> Hi Al,
> 
> Greeting, we plan to convert erofs to new mount api for 5.6
> 
> and I just notice your branch
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=untested.fs_parse
> 
> do a lot further work on fs context (e.g. "get rid of ->enums",
> "remove fs_parameter_description name field" and switch to
> use XXXfc() instead of XXXf() with prefixed string).
> 
> Does it plan for 5.6 as well? If yes, we will update this patch
> based on the latest branch and maybe have chance to go though
> your tree if it can?

FWIW, I would add the following to what you've already mentioned:

> > +static const struct fs_parameter_spec erofs_param_specs[] = {
> > +	fsparam_flag("user_xattr",	Opt_user_xattr),
> > +	fsparam_flag("nouser_xattr",	Opt_nouser_xattr),
> > +	fsparam_flag("acl",		Opt_acl),
> > +	fsparam_flag("noacl",		Opt_noacl),
better off as
	fsparam_flag_no("user_xattr",	Opt_user_xattr),
	fsparam_flag_no("acl",		Opt_acl),

> > +	case Opt_user_xattr:
		if (result.boolean)
			set_opt(sbi, XATTR_USER);
		else
			clear_opt(sbi, XATTR_USER);
> > +		break;
....
> > +	default:
		return -ENOPARAM;

BTW, what's the point of using invalf() in contexts where
the return value is ignored?  Why not simply go for errorf()
(or errorfc(), for that matter)?

I do plan that branch (or an equivalent, as far as filesystems
are concerned - there might be a bit of additional rework in
the beginning + currently missing modifications of docs) for
5.6.  So updated patch would be welcome - I can do that myself,
but if you can rebase it on top of that branch it would save
time.
