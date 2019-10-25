Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F03CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA492084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572001589;
	bh=mk3jXEmUzesR1uKpUHpv6nCjEjMknVkj6SQJSeYWGjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l0Wal47aGNliivR/HIT8W2nODlluxXnAkJ0obnum6vPaNdQX/FetwH4Y/j2aYV1Mk
	 EdUVAn2ppIoQHyVhuMuMnDVP+v/eWfHCK4MU3mAoYHQAbuRFmG+TmyVYRHDYHLCmGa
	 G7bDShmKFG5nZG69eC35KHW5C6/xqUq8fL23eWvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394521AbfJYLG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:06:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38207 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393421AbfJYLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:06:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id o25so2598087qtr.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aAYJchrbdICiOouupZ3A2UdeXvhJ/5TzX3VjCK2DOiM=;
        b=oxpJk3tEnskZxe8iXIuVvPHl3cMuWRs4x09179QW10AzgrypuocXGoAbrt+D014hA1
         Uat5zpvrxGy3L82G7JaJtlBgjCmeRXaHhgOJD3ONf0PYclBoKI4JBBMqbiH3VolgsRuX
         3qlqdt4OcJtacnig67cUQlwvcOhVVAcWgPRkjmwBlgaRPatTQgcZw7/FhXiLMiypQSaQ
         E+V+OORTvGtHbONsMyjfZe79DqXPmhuXkjVutWyih4K9p9cgpvvDqbAo7goV32ogmk5r
         Sd9GBGvNwCl4qVepMy7wG+z2CNkLudarZqiEEJdh02drso6inseQak9NP6MRPJOxCe3H
         K6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aAYJchrbdICiOouupZ3A2UdeXvhJ/5TzX3VjCK2DOiM=;
        b=cbjIG7oMAxBeR1misgGnLtU79hpU64V+osSzifv+X1QI2TBdUHhN/EG/UWN4u/J5HO
         kUSmx2Fg1f3hl2TEBiccGsrAc8Ay4a20E4675eTCkUek1tPxS9BsLVl4l3Kth8vzs7eS
         aYsAafgJt3BDC+OSPoNC+sYenZp4K7aPzU51/QuCUX0EsH32KsotAxCK2m8FKLydNjf5
         /lGYuSdQdLlq89MkGYvOSpt2PLiHvRL4+1TqK885Rp1pYQ61ycB8K5GXNSBBWIrSZRiM
         1L/x9faCj1uyiGllAwLMewS9jXl0BNfyOEFZgoPOuTtApGbmXU63AuYPum0yx+jfm1E3
         5IZg==
X-Gm-Message-State: APjAAAV1xK+BJOQ2FGqr1U3WU0fKzc6cin/+61r2ayySVMffEkK6jj6p
        j1q5NTnhwo7XkiWNtGZ3s1Y=
X-Google-Smtp-Source: APXvYqwkYOtNgqNBsGOZ0X77v5ngzGtMWQBie9c47GqL28SaJZ30mFMzXisPFswYGKwPLUNbWnHCAA==
X-Received: by 2002:a0c:d985:: with SMTP id y5mr2554913qvj.208.1572001586755;
        Fri, 25 Oct 2019 04:06:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fd3c])
        by smtp.gmail.com with ESMTPSA id q44sm1557323qtk.16.2019.10.25.04.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 04:06:25 -0700 (PDT)
Date:   Fri, 25 Oct 2019 04:06:23 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
Message-ID: <20191025110623.GH3622521@devbig004.ftw2.facebook.com>
References: <20191016125019.157144-1-namhyung@kernel.org>
 <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com>
 <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 25, 2019 at 05:30:35PM +0900, Namhyung Kim wrote:
> > Any chance I can persuade you into making this conversion?  idr is
> > exactly the wrong data structure to use for cyclic allocations.  We've
> > been doing it mostly for historical reasons but I really hope we can
> > move away from it.  These lookups aren't in super hot paths and doing
> > locked lookups should be fine.
> 
> As you know, it entails change in kernfs id and its users.
> And I really want to finish the perf cgroup sampling work first.
> Can I work on this after the perf work is done?

Sure, but I think we should get the userland visible behaviors right.
Ignoring implementation details:

* cgroup vs. css IDs doesn't matter for now.  css IDs aren't visible
  to userland anyway and it could be that keeping using idr as-is or
  always using 64bit IDs is the better solution for them.

* On 32bit ino setups, 32bit ino + gen as cgroup and export fs IDs.

* On 64bit ino setups, 64bit unique ino (allocated whichever way) + 0
  gen as cgroup and export fs IDs.

Thanks.

-- 
tejun
