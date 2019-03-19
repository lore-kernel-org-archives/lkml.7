Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA73C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A02120811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CDRaOIDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCSSmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:42:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39812 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCSSmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:42:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so11271748otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWxmWiMBWpI9PbQuON8dITDlnyzakUDvlB+9hBH1Ids=;
        b=CDRaOIDr7xEbWdkSWHxkSt92zwgalV46Gy1oD8i1LIvOi7IbJAf6KZa6N+ffH9Y8vP
         xttdPrp5cEdzGBKDYbSE0mqgkFZXnu6mnC4uTzRWIUsFOcVCQnSoX+/BJ+yB8sxj0crp
         WHtiyXiOP51RdMLhdhqQ65UDDyPeZHHLpSElmKfrWJL53Ukntprdm52hpjnoYnHpPGNF
         jrP5MMkZT4/+HDIXeuG3a0k+sa+gcalCFRuEA9qOCuvRKxtzkr/X4zIfEhDcM8Lo+QDR
         ySabqrj0PvLlNkldased5jAwHXmzaW+EXT+zkIaKWEIpD+S1kEHQmENLzU9DFKi7//b/
         xjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWxmWiMBWpI9PbQuON8dITDlnyzakUDvlB+9hBH1Ids=;
        b=FyoWV1FztaFm71j+R74coWVH5HLmATp01XuCEHJgt403/0K6+aOhg39NnNHEWYn23H
         9AdmUYRZb3u15ozmRSzNBHGRI7MEOI4+wzI9PRDntQxIXS+15jKBgSYYUi5f2P9v6o9x
         Ir5tprZ5qMRcmA1SsHa1yHsv3Tuf6hfo5du2YA4dHfTikzdTtYxzWM2//mzJt0t11QtU
         Of9jxPU6+t7bfOfgPi0/uTzU58vueoTpuTqJ0Cql7tJesallriO1f6OFFuoc2Bs2G79E
         cS1EUZVFP1y6Hed3VBFtlV2NRcAEnPZzuRzQazvw6rJ27o22Uyn30wd1oSMxbJY6qtxu
         IkRA==
X-Gm-Message-State: APjAAAXagveMUl8S5B/iJPExexNuiFNcEiluCZ2WIMpYQ2pTRUz9DN9b
        w4fttsuQ9FFLAWqGqHde+Dkmw/hquG0zCH8yDYOHXA==
X-Google-Smtp-Source: APXvYqyahvBwQYIcUDTqr0Q4YyUcML89NFCLSqd+Kz3QIKSS3JZTj1jVT4LvJzG7zKr8/In8vsgYSeZhBPIbrQOkTBI=
X-Received: by 2002:a9d:4d0b:: with SMTP id n11mr2080569otf.98.1553020930814;
 Tue, 19 Mar 2019 11:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
 <20190318170404.GA6786@redhat.com> <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
 <20190319165802.GA3656@redhat.com> <20190319101249.d2076f4bacbef948055ae758@linux-foundation.org>
 <20190319171847.GC3656@redhat.com> <CAPcyv4iesGET_PV-QcdBbxJGgmJ_HhoGczyvb=0+SnLkFDhRuQ@mail.gmail.com>
 <20190319174552.GA3769@redhat.com>
In-Reply-To: <20190319174552.GA3769@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 11:42:00 -0700
Message-ID: <CAPcyv4hFPOO0-=v3ZCNFA=LgE_QCvyFXGqF24Crveoj_NTbq0Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:45 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Mar 19, 2019 at 10:33:57AM -0700, Dan Williams wrote:
> > On Tue, Mar 19, 2019 at 10:19 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > >
> > > On Tue, Mar 19, 2019 at 10:12:49AM -0700, Andrew Morton wrote:
> > > > On Tue, 19 Mar 2019 12:58:02 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> > [..]
> > > > Also, the discussion regarding [07/10] is substantial and is ongoing so
> > > > please let's push along wth that.
> > >
> > > I can move it as last patch in the serie but it is needed for ODP RDMA
> > > convertion too. Otherwise i will just move that code into the ODP RDMA
> > > code and will have to move it again into HMM code once i am done with
> > > the nouveau changes and in the meantime i expect other driver will want
> > > to use this 2 helpers too.
> >
> > I still hold out hope that we can find a way to have productive
> > discussions about the implementation of this infrastructure.
> > Threatening to move the code elsewhere to bypass the feedback is not
> > productive.
>
> I am not threatening anything that code is in ODP _today_ with that
> patchset i was factering it out so that i could also use it in nouveau.
> nouveau is built in such way that right now i can not use it directly.
> But i wanted to factor out now in hope that i can get the nouveau
> changes in 5.2 and then convert nouveau in 5.3.
>
> So when i said that code will be in ODP it just means that instead of
> removing it from ODP i will keep it there and it will just delay more
> code sharing for everyone.

The point I'm trying to make is that the code sharing for everyone is
moving the implementation closer to canonical kernel code and use
existing infrastructure. For example, I look at 'struct hmm_range' and
see nothing hmm specific in it. I think we can make that generic and
not build up more apis and data structures in the "hmm" namespace.
