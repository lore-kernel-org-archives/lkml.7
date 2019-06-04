Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC3FC46460
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA1524BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+BZYPLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfFDIuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:50:51 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55937 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:50:51 -0400
Received: by mail-it1-f196.google.com with SMTP id i21so12419812ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3hHFGqrMn1+Csc7ogJAJELfMmtCK4b/mNGsWqPXMSs=;
        b=s+BZYPLTRv9v6rWK+5uRT0LvtuHd27GSQqarKWyjG4BSEOqHjud5FUNVi/8iI3dkem
         9Drf+GABFNUsxGyrX+qJXJWnu/vozq02OmSZ1BqWSkOcGYhR/roexxgha4TMNMFN1zYM
         VaFgUnwre/5yA0nUzztImy0YlNyFGjXOQPgWh25UqIjKz+XRbjHig/+sxfaP/NSrhIUO
         CRUJhlPJ2y0QEOm4de4tNcGrXeYX3diaMyzQcIDusACY4/IB7o6U1cHfAdwJDfart49j
         3w0dS2vtWAZu0qsYojxtpJUZr0SrVK9caR49lxGzFz7ekq4VDcmmoTu9Fl5ALhw3GcoQ
         j4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3hHFGqrMn1+Csc7ogJAJELfMmtCK4b/mNGsWqPXMSs=;
        b=M0i8S30OXmJVu1uz5vDlyW196maTyTzPwLPxWAchiwi8gnJUr9qYggPXioBiJdVGH5
         7ruhksKvxahXFaaN907YLyWJez1bS8VfpWWxBK275cOnKk5y7K2oBUjZ0q6h8a7CqAKf
         60FOKlr2vlPPpHYsedUPuoahr4fS06wTu1R1y2lVYNFd0tC2QqFtMFfTr+LOPWjcgd7K
         ls3gcU0fFdc8rtnXSO2QHkiGTtmW/GX5qsb8aPoKGwq2/HNVooMq5CQyTJMfoAaTfHJd
         kX3pIf0lXMmWuJwH9NRFj8NXmL3gLCU6NMtfPuGJYA4M+SQ9d6rVkeYLzeHynaCwcl9M
         lKHA==
X-Gm-Message-State: APjAAAUNH6XHO/uWX/HPSPlseEaSNmG3/kDnppk6rcAnOkitzd9m2UEe
        2b1LU6pyObmbOp8HLCi0fAoTawwjEOQcv2A0jiCa
X-Google-Smtp-Source: APXvYqw2d+Pigp+yuoJfD957oHtsC9aPSPUuB2VxrEocEVkZT5Yq3MSS4N88NNppLN6LiDVtF65M6ErW0QGe0lmhFo4=
X-Received: by 2002:a02:5489:: with SMTP id t131mr18326627jaa.70.1559638250407;
 Tue, 04 Jun 2019 01:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <1559633160-14809-1-git-send-email-kernelfans@gmail.com> <bb4fe1fe-dde0-b86b-740a-4b3dfa81d6f0@linux.ibm.com>
In-Reply-To: <bb4fe1fe-dde0-b86b-740a-4b3dfa81d6f0@linux.ibm.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Jun 2019 16:50:39 +0800
Message-ID: <CAFgQCTvu7vcp0DqG43XxFQmoOOqXWbCfRDNcWUDm7vro5GmdtA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: remove unnecessary check against CMA in __gup_longterm_locked()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 4:30 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 6/4/19 12:56 PM, Pingfan Liu wrote:
> > The PF_MEMALLOC_NOCMA is set by memalloc_nocma_save(), which is finally
> > cast to ~_GFP_MOVABLE.  So __get_user_pages_locked() will get pages from
> > non CMA area and pin them.  There is no need to
> > check_and_migrate_cma_pages().
>
>
> That is not completely correct. We can fault in that pages outside
> get_user_pages_longterm at which point those pages can get allocated
> from CMA region. memalloc_nocma_save() as added as an optimization to
> avoid unnecessary page migration.
Yes, you are right.

Thanks,
  Pingfan
