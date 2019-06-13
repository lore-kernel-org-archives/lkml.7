Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C24C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C681E2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea1jZnIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfFMPcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:32:33 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:36735 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfFMKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:48:27 -0400
Received: by mail-io1-f54.google.com with SMTP id h6so15819034ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r080oZfzTGw4PlNPynE57ID3Ar9Ahtv7iL/o1sb0dx0=;
        b=ea1jZnItELWGPu6bHxAH/mmHocHpLmDlCmmIL2DjSC0Sx7VqH0Ol3gF4IcXRnmg9yM
         aWTdWeTpwVEK5N9uUKAIwBKzkS7fWKmfEIRb4V668/k38X++IMjsYMDuE8rpvMNrJuD9
         SClkbjfnhXP8mup6eWm/jU0ElYl3JLd+TbWXANcbeoSguFsZy3w4qGPngJy267Wcejx5
         187akwnOcJwaH/eSOVrX0sKBU0vjA0jroIvFe1D6BMipVWVj5sRIyhYESsYCEq6n5n0J
         xj2uKE6W4zMuksq/Co6nd2kNVQRx/U0czve+f4jvbuPoLaM87hVgS5WovV2HN3YRdQqk
         RO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r080oZfzTGw4PlNPynE57ID3Ar9Ahtv7iL/o1sb0dx0=;
        b=tMJhGGJLCmSbvHwvqd+zKN1nMPI5w/jV2vGYgR27XEardGEVuhWj93i8Z0Pt5qpvXs
         X2/cZ3MZu3enW9hWY53GzXFoJIll370uqdEjVAnpB+mNQoKrcXXV5gjSnvQHmkyLa3r5
         kTjbsVocXA5QQmPQRw9x9XJc0EmsTd5yddH17LFuOk3Nh61rjKOJ46mVf2zv6wTOVkPs
         kz/oqF7413wnrRsnj+eh3za20Y2Wy5PZCOjzN8bgCFi+K0RheOC0z7ug9LasS+bfTdoW
         ezsdZZXdxRIw6Jy9zfyTkM0zTpHzymgllzghBrDt6JT3sYMlU6U6MWGL72eB0mq66hsj
         ZCXQ==
X-Gm-Message-State: APjAAAUydCS8f9TCvIqc3erBWWwQ2xcocUGDq/Aqc4QBTImyAFU9dExI
        ekG+49S4V6Kta3xnCgAXWJ18kJQuZHWrV0gGDg==
X-Google-Smtp-Source: APXvYqzwF3HmOhVDJq8nYtvL9kM9vETJJiWfoMI/eBiNbY/jmRS0SgwDC9W3GIwckpCQG/bo7cqE02EF1cqQIUlZ06A=
X-Received: by 2002:a6b:4107:: with SMTP id n7mr10681260ioa.12.1560422905974;
 Thu, 13 Jun 2019 03:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
 <87tvcwhzdo.fsf@linux.ibm.com> <2807E5FD2F6FDA4886F6618EAC48510E79D8D79B@CRSMSX101.amr.corp.intel.com>
 <20190612135458.GA19916@dhcp-128-55.nay.redhat.com> <20190612235031.GF14336@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190612235031.GF14336@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 13 Jun 2019 18:48:14 +0800
Message-ID: <CAFgQCTsO-C=Fy6im+VQnNwvyp74tV2dZ-0Pa8QfFyFrBX8Ohvg@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 7:49 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Wed, Jun 12, 2019 at 09:54:58PM +0800, Pingfan Liu wrote:
> > On Tue, Jun 11, 2019 at 04:29:11PM +0000, Weiny, Ira wrote:
> > > > Pingfan Liu <kernelfans@gmail.com> writes:
> > > >
> > > > > As for FOLL_LONGTERM, it is checked in the slow path
> > > > > __gup_longterm_unlocked(). But it is not checked in the fast path=
,
> > > > > which means a possible leak of CMA page to longterm pinned requir=
ement
> > > > > through this crack.
> > > >
> > > > Shouldn't we disallow FOLL_LONGTERM with get_user_pages fastpath? W=
.r.t
> > > > dax check we need vma to ensure whether a long term pin is allowed =
or not.
> > > > If FOLL_LONGTERM is specified we should fallback to slow path.
> > >
> > > Yes, the fastpath bails to the slowpath if FOLL_LONGTERM _and_ DAX.  =
But it does this while walking the page tables.  I missed the CMA case and =
Pingfan's patch fixes this.  We could check for CMA pages while walking the=
 page tables but most agreed that it was not worth it.  For DAX we already =
had checks for *_devmap() so it was easier to put the FOLL_LONGTERM checks =
there.
> > >
> > Then for CMA pages, are you suggesting something like:
>
> I'm not suggesting this.
OK, then I send out v4.
>
> Sorry I wrote this prior to seeing the numbers in your other email.  Give=
n
> the numbers it looks like performing the check whilst walking the tables =
is
> worth the extra complexity.  I was just trying to summarize the thread.  =
I
> don't think we should disallow FOLL_LONGTERM because it only affects CMA =
and
> DAX.  Other pages will be fine with FOLL_LONGTERM.  Why penalize every ca=
ll if
> we don't have to.  Also in the case of DAX the use of vma will be going
> away...[1]  Eventually...  ;-)
A good feature. Trying to catch up.

Thanks,
Pingfan
