Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D3C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1085220872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUNo+Y0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfDQCbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:31:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44951 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDQCbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:31:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so11251445pgj.11;
        Tue, 16 Apr 2019 19:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNjFbnu8u9RjlmWMqrz6jLuk1Q3vyr4xqxngo2C0xMk=;
        b=WUNo+Y0YGDsK1OSdQ0Db/uT/uqZNWr6ONErfP3y/SW8JDnfxUPFV75Y5rkecEMP0i6
         3vYU0p8/iXm6f8FtMtltPvQU1dWUJdEn80s6RreGo6Zk0+Cj2/17q/pDESqAppSs4Eib
         n3IJO1lzJzVVApQjDHMc4g57RN8HTpY57qbKlwx8MicJkPxfPxyLzBpc8wfUAHiDDKJA
         c2rt7HAw8tnH+S4X28qR3L2GxZ5KvYTElyo2F12e5athF6693FALSiiC6tbyp4DGxPqm
         ZX8IktD0kXBbtfBakovqT65R/f/bVFPqGx/VuShLpCOlY8f+vzVzdwGJd2nS7cHu6fyM
         4Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNjFbnu8u9RjlmWMqrz6jLuk1Q3vyr4xqxngo2C0xMk=;
        b=JENzcp5NXOn+juoqQ7qZM1Q+ZbhSn/5NEIm4Hv2/st3/I9udYAdf5uOe3MuE4j+TKX
         rBaMHtNUnFzTSGqPcNr5fsUq/UhKwCHP3nY4+/FN+vN16ZIKWFhIHzxYzt3O9uXhMXTK
         NQ/JwuhiSFqbXyjJTYK6r0EQVNpXyTkosADqg+wWKwhGeRVKQk34ccUCbjoDFFNVIe/u
         XG6zfoEQDdlSoGfpCQSHxHyWqLuGwSGn/FHac6uEGVCjBV6N93wM76rzN+GZ9u0V4oub
         t9CEpzb9EtYv2tTitFvnrSUDCurb9YeeQmBwqkGblOrlpTgbIXKrcPHBVls477mPd9SO
         pe4g==
X-Gm-Message-State: APjAAAWUiMVYrzEighDT5SmMwsH4D2zSQecHGavYFoh3j+j60sUj5KrP
        KGCRb/RQCq9PHWXyPCoVIqLxUUXdhfN9apMVb7c=
X-Google-Smtp-Source: APXvYqyL74XDGR9b4ElX53MVSVd9IuFnixVO0/yvrp8NnFzQ7FnRv4uMDJAKsflDo7VDM606UJxkr6RfCCsuZTGhaYk=
X-Received: by 2002:a65:5342:: with SMTP id w2mr58098671pgr.220.1555468306516;
 Tue, 16 Apr 2019 19:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic> <20190416221852.GA10781@agluck-desk>
 <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com>
 <20190416232833.GA17372@agluck-desk> <CAM_iQpXBJ2eAz4TW_GmOWRLrkyJcO=u-8VSnmv91ZABG-21Agg@mail.gmail.com>
 <20190417015351.GA28490@agluck-desk>
In-Reply-To: <20190417015351.GA28490@agluck-desk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 19:31:34 -0700
Message-ID: <CAM_iQpWXYTivg6tmGxB0xVSrcz8_Envb+yRh_6tBuX-DYKuL1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 6:53 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Apr 16, 2019 at 04:47:55PM -0700, Cong Wang wrote:
> > 229 static void del_elem(struct ce_array *ca, int idx)
> > 230 {
> > 231         /* Save us a function call when deleting the last element. */
> > 232         if (ca->n - (idx + 1))
> > 233                 memmove((void *)&ca->array[idx],
> > 234                         (void *)&ca->array[idx + 1],
> > 235                         (ca->n - (idx + 1)) * sizeof(u64));
> > 236
> > 237         ca->n--;
> > 238 }
> >
> > idx is ca->n and ca->n is MAX_ELEMS-1, then the above if statement
> > becomes true, therefore idx+1 is MAX_ELEMS which is just beyond
> > the valid range.
>
> Is that really the memmove() where we die?  It looks like
> it has a special case for dealing with the last element.

Yes it is, I have a stacktrace in production which clearly shows
del_elem.isra.1+0x34/0x40, unlike the one I triggered via fake
PFN's. I can show you if you want, it is on 4.14, so very unlikely
it is interesting to anyone here.



>
> But this:
>
> 296         ret = find_elem(ca, pfn, &to);
> 297         if (ret < 0) {
> 298                 /*
> 299                  * Shift range [to-end] to make room for one more element.
> 300                  */
> 301                 memmove((void *)&ca->array[to + 1],
> 302                         (void *)&ca->array[to],
> 303                         (ca->n - to) * sizeof(u64));
> 304
>
> looks like it also needs a special case for when "to ==  MAX_ELEMS-1"
> (we don't need to memmove).

In the specific I talked about, find_elem() returns non-negative, so it won't
even hit this branch. Remember how it passed the if check
(this_pfn == pfn)? ;)


Thanks.
