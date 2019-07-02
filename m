Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF12C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF3A2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwplpaWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGBLwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:52:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46291 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfGBLwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:52:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so16821681ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fUAgbAMqKNku6wAR/i42DQOgnry+BJIVEUNtTrD/bls=;
        b=TwplpaWzSJwwXJl/kevHVibUDcoZoN47NijeFdvawHyiqOjNpW3kyU8/UWXglV+VqL
         hiRnZ+dndcrYdDnKvMQhQNwlOkVtROB+ER9CLEXaOLg6NxsRmwHCN7L/urW2rmnx6lgG
         2x764ztR3E/QoskDHkEK01aQrf1eJ+7Dz4FJLFUdJXSp+a6/gTDT6xbV5jmWyW3QNYh5
         eW3/JV/e0PwYcfCRMDGR7Kxu6PJ8NuhdDZ08fzKCTqjIO73e0GJWY7RqCwBWKVf4OhgW
         rbGUkWqIvgoF+jjDUjtA1fy2kcPQ+JJAZ3K7SdyLMRikwFlGiV/v3GF4zy1VrWN4yZcm
         HY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fUAgbAMqKNku6wAR/i42DQOgnry+BJIVEUNtTrD/bls=;
        b=Fs/pD3XygRyQ1bznAKy7RBYc+mlLv7Gee28vCgqcBxax5Ma1rU7nPk2GTR+jCbDMSs
         K5Dy8f4wCmZnUgbjM/ydtMLnmAwFJTqQZmWLVshY1/LlwtDfXSZpyA2lOgDTTxIEBAco
         hsIbZUCveJtwSw6nOmRwJMr0JlNfV3ZS8T63XluuVSh6T1E5rwH+DY/wibu0cEcSBIpA
         TxOd0HcY0sbq/iWaicGrjPht7aYAHYQsxnE3yG+bP/K43RC2wyetuNgj5WSaHaoATubs
         bGsypR566VjVBaL9HlGKhU7wqIolX50BvWBHccPbX0QQVB4GHDafOtUM5RQd7OopLF2o
         kQDw==
X-Gm-Message-State: APjAAAVOs+ObQULcbhTtBVpCs9O5mQ30LmqbvLaPRBksQ5empO4y5/k5
        ollmKTmVmjksY/WfiWcEW9dNl1wWWGcD8yHu/Cs=
X-Google-Smtp-Source: APXvYqyVo5SJxrDdlm0tkmwJLz8dVGc7228Y1I8ugG05SWKDquXCGm4PbTVv7Y6kqpcpNDqZRAG74O8rxuDWKX/z0o0=
X-Received: by 2002:a05:6830:2098:: with SMTP id y24mr1506012otq.173.1562068331167;
 Tue, 02 Jul 2019 04:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190630075650.8516-1-lpf.vector@gmail.com> <20190701092037.GL6376@dhcp22.suse.cz>
In-Reply-To: <20190701092037.GL6376@dhcp22.suse.cz>
From:   oddtux <lpf.vector@gmail.com>
Date:   Tue, 2 Jul 2019 19:51:59 +0800
Message-ID: <CAD7_sbHzn4PTOvEYw7FVUapQ9xVH4VU8X3WUarrAs1rcvnQFEQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm/vmalloc.c: improve readability and rewrite vmap_area
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com,
        rpenyaev@suse.de, guro@fb.com, aryabinin@virtuozzo.com,
        rppt@linux.ibm.com, mingo@kernel.org, rick.p.edgecombe@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=881=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun 30-06-19 15:56:45, Pengfei Li wrote:
> > Hi,
> >
> > This series of patches is to reduce the size of struct vmap_area.
> >
> > Since the members of struct vmap_area are not being used at the same ti=
me,
> > it is possible to reduce its size by placing several members that are n=
ot
> > used at the same time in a union.
> >
> > The first 4 patches did some preparatory work for this and improved
> > readability.
> >
> > The fifth patch is the main patch, it did the work of rewriting vmap_ar=
ea.
> >
> > More details can be obtained from the commit message.
>
> None of the commit messages talk about the motivation. Why do we want to
> add quite some code to achieve this? How much do we save? This all
> should be a part of the cover letter.
>

Hi Michal,

Thank you for your comments.

Sorry for the commit without any test data.
I will add motivation and necessary test data in the next version.

Best regards,

Pengfei

> > Thanks,
> >
> > Pengfei
> >
> > Pengfei Li (5):
> >   mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
> >   mm/vmalloc.c: Introduce a wrapper function of
> >     insert_vmap_area_augment()
> >   mm/vmalloc.c: Rename function __find_vmap_area() for readability
> >   mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readabilit=
y
> >   mm/vmalloc.c: Rewrite struct vmap_area to reduce its size
> >
> >  include/linux/vmalloc.h |  28 +++++---
> >  mm/vmalloc.c            | 144 +++++++++++++++++++++++++++-------------
> >  2 files changed, 117 insertions(+), 55 deletions(-)
> >
> > --
> > 2.21.0
>
> --
> Michal Hocko
> SUSE Labs
