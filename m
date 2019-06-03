Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB893C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C65527A91
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559572537;
	bh=hk/xMLxFXk4kJBGBwlcG++wGkbLPTKk2rGWiw3Ye9mQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I+tEbjSLnTz4k/HtS1mLqzSVVVvSVedP0HSMVrBs/qH99aqqaxYIz9FLUGLbTlvPX
	 r1bjDQNpT2H3LtImHK343yekBaLmXioxYhvYN4EtMAbwfOFSY85Tb0Yxhfao8SuijW
	 OqSxMUybYMid0moc8FQlVwS8dJltFc/cb5A4cBBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFCOfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbfFCOfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:35:36 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8423227AF4;
        Mon,  3 Jun 2019 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559572535;
        bh=hk/xMLxFXk4kJBGBwlcG++wGkbLPTKk2rGWiw3Ye9mQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xRY+ChZwcxFTR01zBWEpCDzqDawzaXX8BoxQ0hmqSrh2c+43cmgeskejeZ2bdG25X
         vRPjSFEyjtGBkNKFUbEn3pOB1Ubc6IkL+wNksi7gfju4OwJjpwhSuOFaCRWfP5229N
         ZPfaGKPgvA6q8jvaV/hupBv4lNEgmua37PINB+R0=
Received: by mail-lf1-f46.google.com with SMTP id y13so13771879lfh.9;
        Mon, 03 Jun 2019 07:35:35 -0700 (PDT)
X-Gm-Message-State: APjAAAU8lvTy+JzUyncGZ/BV6VOyE6XJtIgUvo8obSn6bJFnxRF7dcIY
        Rupsv9K+pZEDORPnwFrzi6nLUFhrKmw3UYwkRSk=
X-Google-Smtp-Source: APXvYqweQ+vKT3uUCXOStqdayFxBRi48G3kwhXvoDIjzC25dmMqP23a+ZySiUA8IqV9rXywdcuG6d+pcD6+MWJ+InEE=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr2053137lfc.60.1559572533667;
 Mon, 03 Jun 2019 07:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
 <20190603135939.e2mb7vkxp64qairr@pc636> <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
 <20190604003153.76f33dd2@canb.auug.org.au>
In-Reply-To: <20190604003153.76f33dd2@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 3 Jun 2019 16:35:22 +0200
X-Gmail-Original-Message-ID: <CAJKOXPed=npnfk0H2WUDityHg5cPLH_zwShyRd+B2RS8h6C7SQ@mail.gmail.com>
Message-ID: <CAJKOXPed=npnfk0H2WUDityHg5cPLH_zwShyRd+B2RS8h6C7SQ@mail.gmail.com>
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

On Mon, 3 Jun 2019 at 16:32, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Krzysztof,
>
> On Mon, 3 Jun 2019 16:10:40 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Indeed it looks like effect of merge conflict resolution or applying.
> > When I look at MMOTS, it is the same as yours:
> > http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/commit/?id=b77b8cce67f246109f9d87417a32cd38f0398f2f
> >
> > However in linux-next it is different.
> >
> > Stephen, any thoughts?
>
> Have you had a look at today's linux-next?  It looks correct in
> there.  Andrew updated his patch series over the weekend.

Yes, I am looking at today's next. Both the source code and the commit
728e0fbf263e3ed359c10cb13623390564102881 have wrong "if (merged)" (put
in wrong hunk).

Best regards,
Krzysztof
