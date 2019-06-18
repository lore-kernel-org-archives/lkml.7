Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FB9C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF0F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="00lZ/ldt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfFRNhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:37:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38282 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFRNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:37:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so8538984qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dKOAWFz5cXu8yUBPgcqckTt7kzukUrCB+Jl5SHrTW/k=;
        b=00lZ/ldtQ7gltLCIq7U75Iv73vSu301v/xHpCBaT5vvpKcPv2SDXSgfLlBGOPRRWub
         qJrBYqT6uhnkX0PRQo81O6pR/V0eFDI/IHKYxz2rotg3mt/d+njmBWV+EdfR2Bcdf2rF
         Y0WSjknSo1RvsX503Pjc3Op3vtZ8qaUpcxEBZ2ngQBMvfF1OjXKxCfLjDT7UL6lslNI1
         rlWTY2BePS7vkN7kok7590f0815mpJnT+5ETdG8yQrqWpA2QdBfz4qdZXzIBvvUPZBSc
         FpYf+0ETtM5FPRq2ywZskhpUCmljarKMhBq3No5fGFNGoOC4BdeT/ZTebKNnKg9OFPF5
         MQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dKOAWFz5cXu8yUBPgcqckTt7kzukUrCB+Jl5SHrTW/k=;
        b=Xf+QmyJi0ujoIj/GYBV0ys9Gl8BWw37uRN2utQHw7blC0imo5tZV4EDUWRnCdOHggC
         yk3ZA5xlvYRnREnFlEMe5/rm/Qe8pJMylhvUEQsxktei3YIl5Be7ZlQ6d+qyqZN69lzf
         a3NG0EpgKGproDqDHEX744Dj0IqoWQZ9/9brgyczfBruIZTZTjEe17gsoNZMiIUhmglg
         Qa34ofjtSCm34A800u2AnVV6tDlUBntPDBaQKcxQ7OswW/3FtCxHZxtWgDGYCCjQHpLZ
         3K3fAYGdCEqKhRt6Py40gMl3mZ/tV7VqxFni7NdFRMTGS4IWoPdOZ9OBBhuNI3t/dJVE
         RbZg==
X-Gm-Message-State: APjAAAUy28G8WCLjyx8VseKUSx5gWAw1kMoI7UgavybfG2wbR2NKJZQA
        /twhA63srOJMSAfukeTe+hNO4A==
X-Google-Smtp-Source: APXvYqzVyjVs8hr/sNGnjr3BH1IqN+B2Whl7guFMeOiZwUrMlsDfMj6dxQgZjs2p9QiPAf8W3AMOFQ==
X-Received: by 2002:a37:b3c2:: with SMTP id c185mr94722667qkf.44.1560865065211;
        Tue, 18 Jun 2019 06:37:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a0ec])
        by smtp.gmail.com with ESMTPSA id m5sm8188809qke.25.2019.06.18.06.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 06:37:44 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:37:43 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 07/19] btrfs: do sequential extent allocation in HMZONED
 mode
Message-ID: <20190618133741.62tcifdq5hth4xuj@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-8-naohiro.aota@wdc.com>
 <20190613140722.lt6mvxnddnjg5lvx@MacBook-Pro-91.local>
 <SN6PR04MB5231A70D08002CA9181D9E468CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB5231A70D08002CA9181D9E468CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 08:28:07AM +0000, Naohiro Aota wrote:
> On 2019/06/13 23:07, Josef Bacik wrote:
> > On Fri, Jun 07, 2019 at 10:10:13PM +0900, Naohiro Aota wrote:
> >> @@ -9616,7 +9701,8 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
> >>   	}
> >>   
> >>   	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
> >> -		    cache->bytes_super - btrfs_block_group_used(&cache->item);
> >> +		    cache->bytes_super - cache->unusable -
> >> +		    btrfs_block_group_used(&cache->item);
> >>   	sinfo_used = btrfs_space_info_used(sinfo, true);
> >>   
> >>   	if (sinfo_used + num_bytes + min_allocable_bytes <=
> >> @@ -9766,6 +9852,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
> >>   	if (!--cache->ro) {
> >>   		num_bytes = cache->key.offset - cache->reserved -
> >>   			    cache->pinned - cache->bytes_super -
> >> +			    cache->unusable -
> >>   			    btrfs_block_group_used(&cache->item);
> > 
> > You've done this in a few places, but not all the places, most notably
> > btrfs_space_info_used() which is used in the space reservation code a lot.
> 
> I added "unsable" to struct btrfs_block_group_cache, but added
> nothing to struct btrfs_space_info. Once extent is allocated and
> freed in an ALLOC_SEQ Block Group, such extent is never resued
> until we remove the BG. I'm accounting the size of such region
> in "cache->unusable" and in "space_info->bytes_readonly". So,
> btrfs_space_info_used() does not need the modify.
> 
> I admit it's confusing here. I can add "bytes_zone_unusable" to
> struct btrfs_space_info, if it's better.
> 

Ah you're right, sorry I just read it as space_info.  Yes please add
bytes_zone_unusable, I'd like to be as verbose as possible about where our space
actually is.  I know if I go to debug something and see a huge amount in
read_only I'll be confused.  Thanks,

Josef
