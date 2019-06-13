Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B259EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE7E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="M/EoFGxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfFMPG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:06:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37498 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732416AbfFMOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:09:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so22718249qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oUME5bpW/Pr2SfzIJPfU0VV06cSnG0RxvavtUh+MNiE=;
        b=M/EoFGxSABgyBztItve42zjdupYcYzfD66qeOAPLBjvpSgzRq3HwHibHyK/bfTYVEp
         Snv4WKDHMWhtXFgzfNRIFTonBDpjlZsLLMc7vcnU9wP5LDnc/CIYINLuC6ppOlhzSzY5
         ZWucyBOfomZUhxoFgVEij2q2INcKhyqsuO0F4hRvO7iu5rONPKPMTHOya75MQbomTah8
         wugG9whK6bvLQvDOPZ19ijqEfPhbK5NevTijutOMONhj6LXCDCikjy8e+z5pAil5qWGh
         rbacUCGTqim+/+M2vPQhdgQMs5lJtjkZ2RiSQhQb59i7UDGC3ZBzpBNJdPhIml4PbxZi
         n6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUME5bpW/Pr2SfzIJPfU0VV06cSnG0RxvavtUh+MNiE=;
        b=NAIP6bIOSH+DVEz3E1Wtjvie8vKsUpvk5pueXVJGkgYDLCABwR1z6q3hfyGP+8FMbW
         FyyzBjkDb8S2lql9FLJWh/SypV+cDGmuz+qXDiGr8Zo6jQZQ2P2GsL0dzzpawTSVCD+D
         Bd5NFs4OALgcFcyU9fn7X18m+aCt0rvvyddglY0mvp89vlDo8gk/fQIdntmRFTFlgm2P
         p9yJsPZ7stkS7CGLSzJMxKPazD0o4VBecTD37dLdhE7RnL35ecoFn5sDL5DGBHRWfNuQ
         P+8Zy0HjqYO54Q+Fme5WlwH6YoeKNatPdtZ/bqeNyOKdlOpcRMcaFGDo+bReTsK/MW1w
         Akew==
X-Gm-Message-State: APjAAAUYRWvEQA2jl5klY+E1H6fDsEDDd2I+7GPYJlxdxEy4CGtqwwWJ
        8eglt79miBODtMr+AwUv6tZceA==
X-Google-Smtp-Source: APXvYqx4PKvJqRb73kg+itLzxBEy7G8qizukwpBTzsJCknKQ1saPW7YkHzuQiHXLfj0I/50gl4TQCA==
X-Received: by 2002:a0c:b036:: with SMTP id k51mr3868142qvc.103.1560434964503;
        Thu, 13 Jun 2019 07:09:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id m44sm1865189qtm.54.2019.06.13.07.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:09:23 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:09:22 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 08/19] btrfs: make unmirroed BGs readonly only if we have
 at least one writable BG
Message-ID: <20190613140921.a2kmty5p6lzqztej@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-9-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-9-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:14PM +0900, Naohiro Aota wrote:
> If the btrfs volume has mirrored block groups, it unconditionally makes
> un-mirrored block groups read only. When we have mirrored block groups, but
> don't have writable block groups, this will drop all writable block groups.
> So, check if we have at least one writable mirrored block group before
> setting un-mirrored block groups read only.
> 

I don't understand why you want this.  Thanks,

Josef
