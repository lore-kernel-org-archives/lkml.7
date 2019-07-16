Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1680C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C3D2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb+pTSaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbfGPUna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:43:30 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:39782 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:43:30 -0400
Received: by mail-qt1-f182.google.com with SMTP id l9so21049608qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NsI9sHwk7SiGJWJO0rcF5KElYA0lXlmxFOmec+tKj2A=;
        b=Rb+pTSaWWIU4FjIlSnAhpf/UtxZdw1GPJD1ZG2QrIlL5kPxoZQoYwgj4LH5h1wIGVO
         O9lcQb32qbqfAW4fmwwaK1IpktbQTBBRtgkn+XfoUYR7oc5yubMRgNeCQ8Dagm1ZJH32
         HMsfxc+w3pm+jyTEFdeWpBIPD5vud3TPbcSR9qI/Y7haITlswPmhuz+u5j52L+7p05AN
         tPb/Saqz2lfqOVqTSMJ+PoRAz76CUehuEooq9oARlqpEmw4MrxHhc0xwVL4N4Uwvvdwo
         UXAyOS1fdREBhiwrB3wcskvnbmhEkhGaVKF5ybz565JXfk5OIHBBrKC1sMf6P778bJau
         ckEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsI9sHwk7SiGJWJO0rcF5KElYA0lXlmxFOmec+tKj2A=;
        b=ob7RqBcAq/hNXSO3BaM1f7x8ZkFvlClULc/IR7BGt2cIW1ZA2CnIA4N2PIp1FFFX2w
         ifUFE7UQVC8bgfwwuodqVEsHvNsydKuqhFC55eetnK8BnmPLLfZ/JRWtT+yywvBFlqZ7
         qR1bLO6eNbCBdgvoe9P5QX2l5AcWXWEdTbCFXQ0zbXG4lg+QX7bbVpAeSxzNnyjGCF/a
         kFUEf7m8G6a7pJpSJujxgIO+BOSIZXZhc09h/Djrni9PrjV24/Yg4QHLhgQS8W7lti7n
         yr4QCK3ZlFkefC0675yrwJdYt++UoThJbSOKGihtzWfeAbYa2ojrYhd9wvWCZeoIxDSI
         QZHw==
X-Gm-Message-State: APjAAAUacVhANiXS0N0Mc3PCmZiUvJaNgB3z/F83LpQuM5D9dBohxryF
        rzSWDqzM8TFTOhB7KQOA+34=
X-Google-Smtp-Source: APXvYqyPUmHTAYc6s4b/2Pj3qBOUc9jC4oPGzFcgndVL5zZAjQD41iCuQFa4ngu21cbm3+xsi2zvPg==
X-Received: by 2002:ac8:3f81:: with SMTP id d1mr24787497qtk.5.1563309809427;
        Tue, 16 Jul 2019 13:43:29 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-184-65.3g.claro.net.br. [179.240.184.65])
        by smtp.gmail.com with ESMTPSA id r4sm7575167qtt.51.2019.07.16.13.43.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 13:43:28 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4036B40340; Tue, 16 Jul 2019 17:43:24 -0300 (-03)
Date:   Tue, 16 Jul 2019 17:43:24 -0300
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Patch] perf stat: always separate stalled cycles per insn
Message-ID: <20190716204324.GH3624@kernel.org>
References: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
 <20190520065906.GC8068@krava>
 <CAM_iQpXoD3YzkUzyLSF9qKLpbGxXVeOdFccLbv-mCTVfshx-2w@mail.gmail.com>
 <20190528191102.GD13830@kernel.org>
 <CAM_iQpWxAYqUsC8TEOfhp12d8gbLmJ+xpLmcE_DwTV7gKm6_ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpWxAYqUsC8TEOfhp12d8gbLmJ+xpLmcE_DwTV7gKm6_ww@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 16, 2019 at 12:24:41PM -0700, Cong Wang escreveu:
> Hi, Arnaldo
> 
> On Tue, May 28, 2019 at 12:11 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, May 28, 2019 at 11:21:38AM -0700, Cong Wang escreveu:
> > > Thanks for reviewing it. Is there anyone takes this patch?
> >
> > Enough time, acked already, picking it.
> 
> Where is this patch landed? I don't see it in Linus tree. I guess you
> are still holding it somewhere?

Got it now, will push upstream in the next batch, sorry for the delay.

- Arnaldo
