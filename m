Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA0C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959EA20838
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="uFXDgE/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfL2CqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 21:46:22 -0500
Received: from sonic303-50.consmr.mail.gq1.yahoo.com ([98.137.64.232]:42524
        "EHLO sonic303-50.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbfL2CqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 21:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1577587580; bh=6/Q6SNynxNQ8G8c617T7+WEqsKRr7oL+1YtlRaUeq+g=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=uFXDgE/66xF3EsVJ5mGL8atE1oRVvcYc6hPaDiBcac66mzEHDWyJ8RhU3AmPuSlOxO8e0TwAFolvxlm3CMZ/snPwUa5Rtrx06Z+y/Hi1e66j5CbsllR/gzCnrSe/Jja7OLU5BwLnGStWQJwhVccBDTfaHyPP8tbbHXXW3PpAvqZasMJ3gzDSYt50VVZuedsHjduwJlRWMATPZMUkO52QBn5rfUWP5bz+JLtXE0Tvw4xkt4ggyl7uu0Rn1b2MzFhbaCg1Nf31LxmP3tK6PqfTzJP71i+7vxQssSjipJ9lAndoXSxUf9zGNflDuEuh6/Kj9pZbm6rqVo3y+xJKwiogQA==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 Dec 2019 02:46:20 +0000
Received: by smtp424.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9f863a345b562991edc35c48481656f9;
          Sun, 29 Dec 2019 02:44:18 +0000 (UTC)
Date:   Sun, 29 Dec 2019 10:44:08 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH RESEND] erofs: convert to use the new mount fs_context api
Message-ID: <20191229024406.GA2215@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191226022519.53386-1-yuchao0@huawei.com>
 <20191227035016.GA142350@architecture4>
 <20191228212156.GU4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228212156.GU4203@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 09:21:56PM +0000, Al Viro wrote:
> On Fri, Dec 27, 2019 at 11:50:16AM +0800, Gao Xiang wrote:
> > Hi Al,
> > 
> > Greeting, we plan to convert erofs to new mount api for 5.6
> > 
> > and I just notice your branch
> > https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=untested.fs_parse
> > 
> > do a lot further work on fs context (e.g. "get rid of ->enums",
> > "remove fs_parameter_description name field" and switch to
> > use XXXfc() instead of XXXf() with prefixed string).
> > 
> > Does it plan for 5.6 as well? If yes, we will update this patch
> > based on the latest branch and maybe have chance to go though
> > your tree if it can?
> 
> FWIW, I would add the following to what you've already mentioned:

Thanks for your reply and confirmation.

> 
> > > +static const struct fs_parameter_spec erofs_param_specs[] = {
> > > +	fsparam_flag("user_xattr",	Opt_user_xattr),
> > > +	fsparam_flag("nouser_xattr",	Opt_nouser_xattr),
> > > +	fsparam_flag("acl",		Opt_acl),
> > > +	fsparam_flag("noacl",		Opt_noacl),
> better off as
> 	fsparam_flag_no("user_xattr",	Opt_user_xattr),
> 	fsparam_flag_no("acl",		Opt_acl),

Got it. We didn't notice this new way. Will fix in the updated version.

> 
> > > +	case Opt_user_xattr:
> 		if (result.boolean)
> 			set_opt(sbi, XATTR_USER);
> 		else
> 			clear_opt(sbi, XATTR_USER);
> > > +		break;
> ....
> > > +	default:
> 		return -ENOPARAM;

Got it.

> 
> BTW, what's the point of using invalf() in contexts where
> the return value is ignored?  Why not simply go for errorf()
> (or errorfc(), for that matter)?

OK, We will check all invalf()s soon.

And may I ask one more question about this... I'm a bit confused,
since we have erofs_err() which print sb->s_id as well, so which
one (errorfc or erofs_err) is more perferred to choose in especially
fill_super()?

> 
> I do plan that branch (or an equivalent, as far as filesystems
> are concerned - there might be a bit of additional rework in
> the beginning + currently missing modifications of docs) for
> 5.6.  So updated patch would be welcome - I can do that myself,
> but if you can rebase it on top of that branch it would save
> time.

Yes, we will update this patch based on the latest branch later
for this convert.

Thanks,
Gao Xiang


