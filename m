Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BC420652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551895645;
	bh=q3xzbBLf+GaNNMg98uOVgyJnxYjAv0qKOOCdYGWkWwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GmIS4W4Dgn7yTmhtbQrLkrVo6ZkUe7bzMASqBNHJNwKlmlYT29IA0NpBa1+KLlfDZ
	 W7UzjcyvFkMob7jefm37po1jcg5JJ0NeWsbDRe+YTvix5BLDcG0DzyGI0oLkFRjyEP
	 U2OHU9tsuri5uh0N9eagaAgtgowhsYj+Gfhu8sC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfCFSHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:07:23 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37682 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfCFSHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:07:23 -0500
Received: by mail-yw1-f67.google.com with SMTP id k14so10756398ywe.4;
        Wed, 06 Mar 2019 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MoZymIeYpEA3JH5PffWyHNM38vDeCAjiLx3pLK1x8l8=;
        b=KQk0ceeQM4K+MkwMcJQYLre2G1RYJpVpVisWfCktSy0qjCYEUhtEIR2nDix5IzCrJT
         ODz7xOVwQqmJs0FujdRPCbuSWqE8dksbzWMhWNb+5q4ovQnxvwtYn9epb7V34UImQ9WH
         0VAp8KH32TYjxtnpkrRkTQIf7m5Ns0kCt+Tld8ScKtCf5J1h8xmLDW9KMlfKTZJKX7Aq
         sUrPqjlqPntBpt3V93NJQMerD80bRlcmOkp7AS9perFdSsvb7p5eUtPOUNZ1yHnVrXYD
         rzWHcXVmEdJmxc0OKmDCADJh74Tjy4cMCo9fCa1K7loJubBHJ1SRDw4b0cXESh6wRa7o
         JIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MoZymIeYpEA3JH5PffWyHNM38vDeCAjiLx3pLK1x8l8=;
        b=uE7vXaYeDPU4DDirOwj5kG1oCz016Y9QmgKONU7lV5aTY9vgIpwYJ5Ag7bwTpgppwv
         5hVS5zUpa/1BZ2lxCJ8LJqUchXJsmVqBbXQy3ofoRq86kor3W+bg3zLmudxMFWrImh5U
         b2W1uoY0EaW1OenvO0Hn5mZNvvd17HhDedQI0z102kTdn3gGifCDqRrza8PZwmGOrQ2n
         89HRQAWvAD9QRvog5OaJSYB51/PXzHd9SgcAfDNLyNVlPcs+OyGVQPEBFR4UBDBmgfMW
         U99k1wtF5P+ccQg2vn1pS3lBIhimsgps7zOM2W5UGAaKAyDW3AIiVtiMRDjPdhpI+iWw
         Ky7w==
X-Gm-Message-State: APjAAAUL+jMaX7Ez00WgxK0Ar9l/7yhpWGunf878gqdSVfjTKJ228KHZ
        jxGSTJVnN/K1Ct8qTiAGFkk=
X-Google-Smtp-Source: APXvYqxMTxDAj3IpCJGqs+98ngN9UYv21Rop1bDeAi7I22zU0xOBO8iQUni1ghRl6c8gw2rxHZHGEQ==
X-Received: by 2002:a81:1cc1:: with SMTP id c184mr6838435ywc.360.1551895642287;
        Wed, 06 Mar 2019 10:07:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::2:a2f4])
        by smtp.gmail.com with ESMTPSA id v9sm811425ywe.59.2019.03.06.10.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 10:07:21 -0800 (PST)
Date:   Wed, 6 Mar 2019 10:07:19 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] sched/core: fix buffer overflow in cgroup2 property
 cpu.max
Message-ID: <20190306180719.GG50184@devbig004.ftw2.facebook.com>
References: <155189230232.2620.13120481613524200065.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155189230232.2620.13120481613524200065.stgit@buzz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 08:11:42PM +0300, Konstantin Khlebnikov wrote:
> Add limit into sscanf format string for on-stack buffer.
> 
> Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified hierarchy")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks and I look forward to the sscanf improvements.  That'd be
really nice to have.

-- 
tejun
