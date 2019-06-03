Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B0C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A569226D67
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559586687;
	bh=tKu+9YnqIJM7WkSdcJxKhcrVSljhwHnaTXwK03T/uwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sqIcBFP6Jch1tODhzmWFYv20Ih163avzhm7HGVYkl4poPpgAwLcMGV7/EkiSg9glk
	 lsocLlTVAbSm8+cyjRgQugOA0Y76Mdf42LMYF0CyTyIkhQz7Dj6jTBQf7+G+2RVVm7
	 j2XDi9e5JTZiqQuhiCpp0okWigQoBPHjEqTJLanw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFCSbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFCSbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:31:24 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A7E26DF3;
        Mon,  3 Jun 2019 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559586684;
        bh=tKu+9YnqIJM7WkSdcJxKhcrVSljhwHnaTXwK03T/uwU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LMV4WcMUZELWXQQR0e73PHu/2quC/Tw33p3nhKKIX9SDsD264VVlQXxMFnBVoxqD5
         Fmsb20qeZkPxCHDqyXzNe4TG7g6aRe+xd15pqHD41tTsQTAGYhiNUOcnG0lXioNcMs
         LVc9VItMI6RFTLHtF4Aqe5+2Xt7KX0Q02bRVJ4uk=
Received: by mail-lj1-f181.google.com with SMTP id a10so13962807ljf.6;
        Mon, 03 Jun 2019 11:31:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWycHsDQbLoXt4SfC7oC7/ZRRGUsTpsmbjA59u7529a0h00FX+B
        ci9vFnaSYWnDtRS6nZjEiH1Sr2SMwW33cZFsukw=
X-Google-Smtp-Source: APXvYqztKMTjaCNLajYG7cSZz9qvxdLn+E1v/4LiZh5vlmfrNayaC9kf2W0/Ic+i1ixVwYQjuUcOqMbLrwS6Jx67Gmo=
X-Received: by 2002:a2e:568d:: with SMTP id k13mr14358606lje.194.1559586682175;
 Mon, 03 Jun 2019 11:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
 <20190603135939.e2mb7vkxp64qairr@pc636> <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
 <20190604003153.76f33dd2@canb.auug.org.au> <CAJKOXPed=npnfk0H2WUDityHg5cPLH_zwShyRd+B2RS8h6C7SQ@mail.gmail.com>
 <20190604011125.266222a8@canb.auug.org.au>
In-Reply-To: <20190604011125.266222a8@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 3 Jun 2019 20:31:10 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf3LZuQ5o5sERL_b6+4SfERWyQR0jUaVUJs12m7WdD3gQ@mail.gmail.com>
Message-ID: <CAJKOXPf3LZuQ5o5sERL_b6+4SfERWyQR0jUaVUJs12m7WdD3gQ@mail.gmail.com>
Subject: Re: [BUG BISECT] bug mm/vmalloc.c:470 (mm/vmalloc.c: get rid of one
 single unlink_va() when merge)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 at 17:11, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Krzysztof,
>
> On Mon, 3 Jun 2019 16:35:22 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Mon, 3 Jun 2019 at 16:32, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Mon, 3 Jun 2019 16:10:40 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > Indeed it looks like effect of merge conflict resolution or applying.
> > > > When I look at MMOTS, it is the same as yours:
> > > > http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/commit/?id=b77b8cce67f246109f9d87417a32cd38f0398f2f
> > > >
> > > > However in linux-next it is different.
> > > >
> > > > Stephen, any thoughts?
> > >
> > > Have you had a look at today's linux-next?  It looks correct in
> > > there.  Andrew updated his patch series over the weekend.
> >
> > Yes, I am looking at today's next. Both the source code and the commit
> > 728e0fbf263e3ed359c10cb13623390564102881 have wrong "if (merged)" (put
> > in wrong hunk).
>
> OK, I have replaced that commit with this:

Thank you!

Best regards,
Krzysztof
