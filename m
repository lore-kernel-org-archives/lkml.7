Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB05320872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PVO9AuwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfKTHv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:51:58 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36999 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKTHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:51:58 -0500
Received: by mail-il1-f194.google.com with SMTP id s5so2487911iln.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 23:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6RukAU4yfanIMPunVIfuS2B5y73IXuIqDOCI0UMmxkk=;
        b=PVO9AuwSNDQnHRLBSNzM0TSp1Zp1SdvCGoDnpyhmu7WVv0zg4E3qxBP4Ve8/VNVG/L
         BJmtp+MAp8ki3sJjxVhqCnYJUW3LpbQPAm1HaL9HR3wJXMRgD4/iSvOifSbhpC6diMhi
         r3+Oa7d3zgcFZ4mXlPNh7SlvSrOqWurTkEbpC2SQId3okyPF7qjTOnKhCUqT97c96TI1
         4qtDVgfX49hd739zROfni6i/j3qulUrIk78hpZ51UVpieMlW2GGzTtHCtxDkLrUluVHL
         xB0JPsoUmT/qRMPc9f7NUhpxDibstRYWiLpPC7tEkaOOLYe+0eAutu6AFiXn8s82sA/w
         N90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6RukAU4yfanIMPunVIfuS2B5y73IXuIqDOCI0UMmxkk=;
        b=Kc3R8wj+ofbxKYYZyI2O8PTELqRVskn596NEZdHJ6D/MDDVVazWLofkdr1qVnSmA0j
         eAy7LvqRUKvve+RMEMhewf/3iGAv4MSqGGdQfTwp6qOdbYNa3vOWTqdjEpOAbj6hM18c
         Tl3mmkAZWvGnvFEKz8V/P8PZ21C4zyYPU+vBkVcDzgSrB9vm6Az6FdMgTfqxtWNBLElH
         sfxdQMfpWf8WkvpiwkCCjgvmzWczuwQ8LxZA+1bpbmZIkHBM3MGqHGliRQbZdHzOhWhu
         LR5hyh3o49ZGNskB89rPnBJsTg12amm3VVnR5yA5DuJqlYhubodeTlBq/L/mXuZ13dHr
         GZJg==
X-Gm-Message-State: APjAAAUF7X8Tu5k0+5XxQ9Hx4fvI+yTkxrIv52QVX9YM5CuW/7xSy9DZ
        G5E9gsH1+9jgjmmxht2lRSFWhw==
X-Google-Smtp-Source: APXvYqxyj22gfdW5UAgMeF5MFaHfqP5hvYnwkk6L0UAliggkFBPMDJLq5pqDqo0MB5NpTRnfUdsUjw==
X-Received: by 2002:a92:7e18:: with SMTP id z24mr2049781ilc.276.1574236317557;
        Tue, 19 Nov 2019 23:51:57 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id f2sm4719623iog.30.2019.11.19.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 23:51:57 -0800 (PST)
Date:   Tue, 19 Nov 2019 23:51:56 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Behrens <behrensj@mit.edu>
Subject: Re: [PATCH v3 0/4] Add support for SBI v0.2 
In-Reply-To: <20191118224539.2171-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1911192344560.12489@viisi.sifive.com>
References: <20191118224539.2171-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Mon, 18 Nov 2019, Atish Patra wrote:

> The Supervisor Binary Interface(SBI) specification[1] now defines a
> base extension that provides extendability to add future extensions
> while maintaining backward compatibility with previous versions.
> The new version is defined as 0.2 and older version is marked as 0.1.
> 
> This series adds support v0.2 and a unified calling convention
> implementation between 0.1 and 0.2. It also adds minimal SBI functions
> from 0.2 as well to keep the series lean. 
> 
> [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> 
> The base support for SBI v0.2 is already available in OpenSBI v0.5.
> This series needs following additional patches in OpenSBI. 
> 
> http://lists.infradead.org/pipermail/opensbi/2019-November/000704.html
> 
> Tested on both BBL, OpenSBI with/without the above patch series. 

Just based on a quick look:

All of the patches in this series add warnings reported by 
'scripts/checkpatch.pl --strict'.  Could you please fix and repost?

Also: could you rebase these patches on top of the current RISC-V for-next 
branch?  There are some significant conflicts after Christoph's nommu 
work.

We'll wait to send these upstream until the SBI v0.2 spec is frozen, but 
in the meantime, it'll be good to get these into the experimental branch.

thanks,

- Paul
