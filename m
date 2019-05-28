Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA37C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF9120883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtF6ldLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfE1TLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:11:06 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:37285 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfE1TLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:11:06 -0400
Received: by mail-qk1-f182.google.com with SMTP id d15so308786qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gl9QC/m/fsiWrDx5+nZH3TzCoFkna4QThy+GU0aDdZ4=;
        b=OtF6ldLF9S05cd2AxV30QQsn875NSFUtwfXHcTQgP732DO7bszsP4Pbn4js4kDpXDS
         b3QzdAumetRD/CznBT9yWgYJ3gIn5dQv/ldnXBfNHs+1/KdNhE2c+La7KvfFiX0IRwMC
         j0uG/pD/zvZ4cZsYiCDBArxnEzk9QD6c55x9s0hLnFE04ra0xwvFezwLlZnzSKrxavlT
         TnFxVs7/DfMmWi9mKci9JiH47ufHdVIdEvTabwe8GO82+yXpj0bRFuSX8Ifxk940H3EB
         j8Myv+43M+hhkWb4FnT9KRSrYEaSmOHtZjdsU/Q8O9pold+6F4YWhsvdMwfKlhGuFJ06
         nE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gl9QC/m/fsiWrDx5+nZH3TzCoFkna4QThy+GU0aDdZ4=;
        b=XsI3cEQ9NqA8Iqrm+1Q5GtjY7upd1yInQMUug7jo3Fhft6WtU50QY4XaM5mMlWJefM
         cT5ABAvk/rlQLmW/ZseMBfrU7lDVTnUS6bbMHINBZjDc94OJ/+eBv6Gd60X1nAtwMneo
         iujqPbGBOXVWPL++MdTbfiFUlhMKLNBE5/BebHMhQCSLXpbxWO5sdFd2jPLFQIjLlU8F
         njMCdibygv+OR8bBPMHjWpG6USUsWhnCDQaH1xK39pG9DhibvKvjBeKxYnqhAfFAoV43
         8uZ8gdvUSUoKSQmgVOtQwb8h7R7Lc8f8qhUeb9+fj6JPRtgjksYtcfxNx8vZdjB1whqL
         ntSg==
X-Gm-Message-State: APjAAAX0HizLmDh9FThfWkIXV5RdcHKFcIfAEjObqowIiYWO/mP8W44t
        cFlkYe7uCuyeIbRQCd5jOY4=
X-Google-Smtp-Source: APXvYqxbvRQ82453mYRnFjJ9SAK0KNL9jn459TDS7mWeRJ9orMJ+bKYKgpfCTjvjdKC7Gs3KUj78Tg==
X-Received: by 2002:ac8:13c4:: with SMTP id i4mr4433492qtj.63.1559070665068;
        Tue, 28 May 2019 12:11:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id y201sm4493408qka.23.2019.05.28.12.11.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 12:11:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3468D41149; Tue, 28 May 2019 16:11:02 -0300 (-03)
Date:   Tue, 28 May 2019 16:11:02 -0300
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Patch] perf stat: always separate stalled cycles per insn
Message-ID: <20190528191102.GD13830@kernel.org>
References: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
 <20190520065906.GC8068@krava>
 <CAM_iQpXoD3YzkUzyLSF9qKLpbGxXVeOdFccLbv-mCTVfshx-2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXoD3YzkUzyLSF9qKLpbGxXVeOdFccLbv-mCTVfshx-2w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 28, 2019 at 11:21:38AM -0700, Cong Wang escreveu:
> On Sun, May 19, 2019 at 11:59 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, May 17, 2019 at 03:10:39PM -0700, Cong Wang wrote:
> > > The "stalled cycles per insn" is appended to "instructions" when
> > > the CPU has this hardware counter directly. We should always make it
> > > a separate line, which also aligns to the output when we hit the
> > > "if (total && avg)" branch.
> > >
> > > Before:
> > > $ sudo perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
> > > 4565048704,,instructions,64114578096,100.00,1.34,insn per cycle,,
> > > 3396325133,,cycles,64146628546,100.00,,
> > >
> > > After:
> > > $ sudo ./tools/perf/perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
> > > 6721924,,instructions,24026790339,100.00,0.22,insn per cycle
> > > ,,,,,0.00,stalled cycles per insn
> > > 30939953,,cycles,24025512526,100.00,,
> > >
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Thanks for reviewing it. Is there anyone takes this patch?

Enough time, acked already, picking it.

- Arnaldo
