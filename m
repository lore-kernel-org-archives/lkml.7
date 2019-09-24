Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB62C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 22:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485322146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569364713;
	bh=9SBeTOSbULmiFqoG4YjKk9u2jWvbRynHaxfnaPUXVWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1QumsSTfDv9e9JW6xLdhY35BBwj12oy968h+mpCsuJADXW5S9Fg1XBIITvyaR2rsG
	 mSAnJYqkVELFP9YNM3VXuhJz5fOjrIHt0ahn6atLidGIRTrPokojcr+0R3+vWRS95m
	 V2BGJTLkucBdPcwgOunbwAO3Fban5p1q29yNnj64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410833AbfIXWic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 18:38:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45412 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389629AbfIXWic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 18:38:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so2627780lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90Q+eXMjNvFFuPrMWBbl3/f3JdViBcTYUczXFgEA6fY=;
        b=M0dmwTrsklIGws4kec6f2o+YuDHRLxHqB8mnf+ZjLpSHn2z41biSEEnbbQ4ulG2QKl
         zgjM8Sxa8KzwBByQmS1aUcgWEJJ8vr0fJiZS2v/v9Q8VGNBsvrDWW6dVSylnAo6i1hA5
         d5GqmmE2XYq6jDFMbF8B0/1swDJifG9Vi/p9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90Q+eXMjNvFFuPrMWBbl3/f3JdViBcTYUczXFgEA6fY=;
        b=CDKbrDpjsN3ZAUvayJXikpBUYhM3r4aFi850v4OR9PUpolXHxMy7E3b30H6xnBO+oJ
         ldVYVnFZImI4zHQfbAzzRnaMyymDmoNLpOvMGaLwlBWrWt4Pvo0q80YI4mOXsgyo/42W
         ajQDNOOpkoYu2T6or9mo7qFMevUkPW4La8NPSc5WE1USbjc70+u8/TWrTm9TLbn4eH//
         Ezgjn45wNEpkqyl4NndYlyh+Oyl03nfm1jPmEoYmvW+yX+gLRQ6YAl30BS7sCsbg8W3V
         dKK1jUU9T/4Z9qOSip1DyolzBYLE62zGv5hG5ofvZjF6A3RuVF5djO7KTqdlky3RFfMG
         d+Fg==
X-Gm-Message-State: APjAAAXtqD4Bn1r7/m5L2hHYxoMJqxT/7frtJZU2B3uzGiFR0/ltaVEH
        i1Nl+Gixw2GlCAeOoODCDTuRBhrX4OA=
X-Google-Smtp-Source: APXvYqzYoYBY3/Kj72L5w4KgDpy2VP8xH1LuOCswnK9upAAR9uTNqUs1jzVw+gIT5M++TYdxbkHxYQ==
X-Received: by 2002:ac2:48af:: with SMTP id u15mr3441886lfg.75.1569364709288;
        Tue, 24 Sep 2019 15:38:29 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g3sm789485ljj.59.2019.09.24.15.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 15:38:26 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u3so2629430lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 15:38:26 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr3298645lfh.29.1569364706199;
 Tue, 24 Sep 2019 15:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190923223612.gJ-_DTlay%akpm@linux-foundation.org> <20190924074744.GA23050@dhcp22.suse.cz>
In-Reply-To: <20190924074744.GA23050@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Sep 2019 15:38:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTDTXMco-_LF2Wf5J7awz3BenB1JrkqJM3mPMr7y951Q@mail.gmail.com>
Message-ID: <CAHk-=wiTDTXMco-_LF2Wf5J7awz3BenB1JrkqJM3mPMr7y951Q@mail.gmail.com>
Subject: Re: [patch 066/134] mm/memory_hotplug.c: add a bounds check to check_hotplug_memory_range()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        alastair@d-silva.org, Qian Cai <cai@lca.pw>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>, ira.weiny@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, logang@deltatee.com,
        mm-commits@vger.kernel.org, osalvador@suse.com,
        pasha.tatashin@soleen.com, Wei Yang <richard.weiyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:47 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> Isn't this rushed a bit? I've had a review feedback just yesterday
> http://lkml.kernel.org/r/20190923122513.GO6016@dhcp22.suse.cz and had
> some concerns.

Ok dropped.

That means I need to drop "mm/memremap.c: add a bounds check in
devm_memremap_pages()" too, which depends on it.

           Linus
