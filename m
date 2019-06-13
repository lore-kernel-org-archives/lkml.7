Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B079FC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2AA20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="o9ysYyAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbfFMPFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:05:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43380 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbfFMOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:12:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so9464701qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDhqdSFdNrJkUzLZKLANjMrDzCWc+1BFxgZR9EoSJWc=;
        b=o9ysYyAYYAkKDCEjOpEcA8dHcyUIgiishqyzWE+RGyB0CPD0qX9BMV8V2Ph7rpuhQ2
         K8NR9n3H2e8PDC40efcl/XPNsZvrJzaA26yNoknpyzgEflgHS0LCRUJZDIxSiwaskZOx
         wVtjRQyVJFXdvVLENdH2e5X3E+kNGZusxml91Hhgrxkdi0137ew7YVLbQca3LK9zF88/
         ajD2LpyQ70yJdzGRaInaMTvnMegeomU9tWJ7wrO/cd9dwWrkG3s41kbgxjMsoVvaBYhS
         JdQZnPb7pa+AfGg8+n8JdN/2O+vKRsl7thrK0YyHBoE/x0JUOpZD1nFq32wrn+4+Pmlh
         8wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDhqdSFdNrJkUzLZKLANjMrDzCWc+1BFxgZR9EoSJWc=;
        b=THrHL3inc6BlTBo4HqxaSULG0Cl0yQjRlx6/tK9GQdnw/wusq4XQfQoGdhQ8Ndk2IC
         3RgJglqibhlDvwOqe0NLbGXUMXzD+IFKdND0DlXHFzrJlRG5fQcQIU/XQhtiRgZtyEj1
         /UZ9w2keg1OUVy8fTNUTNP0c7kdKEKcPGmqQk8t6kZl1ichZXo30jwdzPCwliqnmDiT/
         nEM92X4QlovPyyhoMG8txr5kZVv/GkdMYpL18tUR1JXP0sqVUcRUQ39uwSCImzZXw9+c
         DoZ8CmdDWB81Cw+xT24lUAQAGyNplmotAsb2Uf64fqNC5MidG7rJwkH8xk9Qt3DICDaQ
         8Uyg==
X-Gm-Message-State: APjAAAWsUtGn1/ok9ek4ixTPdZVmV/uRmo0JPXbxAWoa6sExiqX0rG69
        j+lZdQaa6mtr00mYx7uCVDv0pw==
X-Google-Smtp-Source: APXvYqxb/kePzso30q0J3LDebGmnh0NZA/pxwsejwKpoIHkaoRXf9QORb3+scacfUjYllSbAb0hUTg==
X-Received: by 2002:ac8:18f0:: with SMTP id o45mr74804877qtk.273.1560435156338;
        Thu, 13 Jun 2019 07:12:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id k15sm1394975qtg.22.2019.06.13.07.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:12:35 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:12:34 -0400
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
Subject: Re: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Message-ID: <20190613141232.nud7gqz622ewcyzp@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-10-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-10-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:15PM +0900, Naohiro Aota wrote:
> When in HMZONED mode, make sure that device super blocks are located in
> randomly writable zones of zoned block devices. That is, do not write super
> blocks in sequential write required zones of host-managed zoned block
> devices as update would not be possible.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/disk-io.c     | 11 +++++++++++
>  fs/btrfs/disk-io.h     |  1 +
>  fs/btrfs/extent-tree.c |  4 ++++
>  fs/btrfs/scrub.c       |  2 ++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7c1404c76768..ddbb02906042 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3466,6 +3466,13 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
>  	return latest;
>  }
>  
> +int btrfs_check_super_location(struct btrfs_device *device, u64 pos)
> +{
> +	/* any address is good on a regular (zone_size == 0) device */
> +	/* non-SEQUENTIAL WRITE REQUIRED zones are capable on a zoned device */

This is not how you do multi-line comments in the kernel.  Thanks,

Josef
