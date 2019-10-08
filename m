Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4764C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4702070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570525665;
	bh=mBOH3in0hxcQxPxUoDAlYNiDp7sHCXmk89eRCMAhZgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LKnR9bp9ecXLGc9iRNm5tnyizxqAhQzcDzAFcBT+BivNjfZJqldx6BIBv/WB+cFEY
	 kbIVvPRBg5wI4ZrRIpwviCmxJKh+XkzD1BJVG8565wBhs76eKyE3lalsd4L4PTsUiz
	 ihZc32si7q740vOXYhDqZa+uVs6IIM46GhLSV1WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfJHJHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbfJHJHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:07:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD0AB206C2;
        Tue,  8 Oct 2019 09:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570525663;
        bh=mBOH3in0hxcQxPxUoDAlYNiDp7sHCXmk89eRCMAhZgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eucSvoHHLAFg0lPO/Co02dZBwpKBXKMT3GR/mf8wACX+eYl5VT0zWCumV/g+Arf5T
         2gqOVzlVw8skLi6QogIH8+fUNhKxKM8LgaA6XaG8HLFKI1wJzsSskCWJ/VBO9HxBu0
         VXFyZleUdvexYfwiJHOUh8iwDoceSI4vNE4qznVg=
Date:   Tue, 8 Oct 2019 10:07:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de, luto@kernel.org
Subject: Re: [PATCH v5 0/6] arm64: vdso32: Address various issues
Message-ID: <20191008090737.yari3gbtg65cuq7d@willie-the-truck>
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
 <20191007133106.j3gtsuatsw6hgllz@willie-the-truck>
 <a35ad8b6-fcd8-a681-b456-cc931f1e58cb@arm.com>
 <20191007141552.tbk3n6hgpq4cgane@willie-the-truck>
 <ba8f3b9a-714f-08da-f93e-d832283697e2@arm.com>
 <2b3b3255-6532-e70c-8d1a-8d60308adbe1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3b3255-6532-e70c-8d1a-8d60308adbe1@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:48:00PM +0100, Vincenzo Frascino wrote:
> On 07/10/2019 15:37, Vincenzo Frascino wrote:
> > On 07/10/2019 15:15, Will Deacon wrote:
> >> On Mon, Oct 07, 2019 at 02:54:29PM +0100, Vincenzo Frascino wrote:
> >>> On 07/10/2019 14:31, Will Deacon wrote:
> >>>> I've queued this up as fixes for 5.4, but I ended up making quite a few
> >>>> additional changes to address some other issues and minor inconsistencies
> >>>> I ran into. In particular, with my changes, you can now easily build the
> >>>> kernel with clang but the compat vDSO with gcc. The header files still need
> >>>> sorting out properly, but I think this is a decent starting point:
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/fixes
> >>>>
> >>>> Please have a look.
> >>>>
> >>>
> >>> Thank you for letting me know, I will have a look.
> >>
> >> Thanks.
> >>
> >>> I see acked-by Catalin on the patches, did you post them in review somewhere? I
> >>> could not find them. Sorry
> >>
> >> I pushed them out to a temporary vdso branch on Friday and Catalin looked at
> >> that. If you'd like me to post them as well, please let me know, although
> >> I'm keen to get this stuff sorted out by -rc3 without disabling the compat
> >> vDSO altogether (i.e. [1]). In other words, if you're ok with my changes on
> >> top of yours then let's go for that, otherwise let's punt this to 5.5 and
> >> try to fix the header mess at the same time.
> >>
> > 
> > No need to repost them. I just got confused by the fact that they got acked and
> > I could not find them anywhere, hence my question.
> > 
> > I am keen to sort this thing as well, my personal preference is to not disable
> > compat vdso in 5.4.
> > 
> > I will download your tree, have a look at it and let you know my thoughts.
> > 
> 
> I tested your patches and they look fine to me. I have just one request, in the
> commit message of patch were you rename COMPATCC to CC_COMPAT could you please
> add the make command with the update variable?
> 
>    $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
>         CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- CC=clang \
>         CC_COMPAT=arm-linux-gnueabihf-gcc
> 
> It took me a while to understand that the command in the commit message
> (c71e88c43796 "arm64: vdso32: Don't use KBUILD_CPPFLAGS unconditionally") was
> not working because of the renaming.
> 
> Thanks!
> 
> If it is not too late you can add my reviewed-by and tested-by ;)

Thanks, Vincenzo. I'd prefer not to rebase that branch, but I'll mention
your tags in the pull request so they may end up in the merge commit.

Will
