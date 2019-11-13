Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A6C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F70A222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs/pQRhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfKMM6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:58:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36163 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKMM6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:58:48 -0500
Received: by mail-qk1-f195.google.com with SMTP id d13so1595235qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 04:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0nSm7gb4z8GZQn6QeHwHxTL1neWvhE090o7mmpSAeTg=;
        b=Hs/pQRhfCk+m8dkX3NfD70VkNaa7GXPgSHiV/jFz4IqWN3GyxMJTDp0OZDR7yBaii3
         6L3FCvIko+mzn21mevTREzYmPWDiq601IIK4yDTbbbFSnxH3/QzEp5CLFasjpiRaH7f6
         8y5yXiKgyM8kgArW9Sime3KFagR+pR7wNQiMuabguUHN857UuTSLlSiXBISpIOisgp6l
         xDquNwujpMYnUHiRD7DG6/9U/OdfCI0L58RoFpqJmpIULkC4HJ0Zde6RvpMWhBEjHhkn
         XN9L397ckSjUpGNKbgvl4q18xFWd65JL50QR7Gz1XlEH6Vz6N7N6TiODG0fJeM1FVDkZ
         YDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0nSm7gb4z8GZQn6QeHwHxTL1neWvhE090o7mmpSAeTg=;
        b=DtR5d9U8dSnY0nmg8TvBk9LPkuAnyXAwCxbhuyFlITJ+B8EV2HRO2SVatP2t9XHT5Y
         96LwwfrXikvAQlUGpnAtu3Vkq/RL1z6u5jMvErBqLPuicaprHH2bisIhfSgl2EXZYcmv
         bHG+MhhVx1SJwNUwbutdKTn8BigeaJi2CsZhlBNBqnChOklagmuyAiTrHW2ZhpK22DX9
         O56SlZT9pY/nz35tz7tPNvSgqXbpb8EWg+Y70gn4X2nf98YVMZuXh7ZaOupsXINxHcVV
         LO5566boU7z6OOeNR+ArNf/BpNGejBa59W2keNXDtXg/2PAmH9G9DwNTdiXHFwts/isB
         Yolg==
X-Gm-Message-State: APjAAAV1KQ0B71e7fJ7oFFP8PiC2h868SOy2yNRw5oWwhyRQZdchLbDH
        5Bcyz4LW2TTvYeoy8Kp4cmg=
X-Google-Smtp-Source: APXvYqzCA4NM+AC8Rq5DuahzoE8rHXIV0hSTsXTsQNWhmROP41GSbE2cB2V6APAkoYTCDA2rxdZVSw==
X-Received: by 2002:ae9:e851:: with SMTP id a78mr2250473qkg.312.1573649926500;
        Wed, 13 Nov 2019 04:58:46 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id w24sm1245125qta.44.2019.11.13.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 04:58:45 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A336E40D3E; Wed, 13 Nov 2019 09:58:43 -0300 (-03)
Date:   Wed, 13 Nov 2019 09:58:43 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: exported-sql-viewer.py: Fix use of
 TRUE with SQLite
Message-ID: <20191113125843.GD14646@kernel.org>
References: <20191113120206.26957-1-adrian.hunter@intel.com>
 <20191113121515.GC14646@kernel.org>
 <41d1d659-9e66-7f63-9132-41d43a93ee42@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d1d659-9e66-7f63-9132-41d43a93ee42@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 13, 2019 at 02:28:24PM +0200, Adrian Hunter escreveu:
> On 13/11/19 2:15 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 13, 2019 at 02:02:06PM +0200, Adrian Hunter escreveu:
> >> Prior to version 3.23 SQLite does not support TRUE or FALSE, so always use
> >> 1 and 0 for SQLite.
> >>
> >> Fixes: 26c11206f433 ("perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column")
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> Cc: stable@vger.kernel.org
> > 
> > Thanks, applied and added the first tag with that fixed cset:
> > 
> > Cc: stable@vger.kernel.org # v5.3+
> 
> Thanks, but I just noticed it doesn't apply to 5.3 or 5.4-rc7, sorry :-(.
> I guess the Fixes and stable tags should be dropped and I will send the
> stable patch separately.

Humm, I think this is still appropriate, i.e. the fixes/stables should
not be taken literally as being the patch to apply to those older
versions, just that this patch addresses a problem that was introduced
at that tag and that affects the stable kernels since tag v5.3.

Which in turn makes people try to apply it, if it fails, then the stable
guys ask for guidance.

Of course you can be proactive and do what you say you'll do, i.e. test
it and provide patches for the stable kernels, taking into account
whatever adjustments needed due to this code having been touched after
that problem.

So I'm keeping the fixes and cc stable lines,

Thanks,

- Arnaldo
