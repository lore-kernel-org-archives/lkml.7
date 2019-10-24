Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCF1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F7F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571939079;
	bh=OO63RqKkht3BLVyDlWq5U6uOSJRIpbb+WGgeqPArPpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HF9ykH4zseyNEFQsFHkcxYc7hkM+fwC80TaAGiNLIeyPYceiIzQHQXGYMTmPKfnlg
	 sMGcqls0XWW7+wfyYHZ4T/+66FuoV+pGnMmxhQvBH5OMSxx8FX0EP3+UjOOTSVRFh5
	 dJsBLt3sXCKlitWqYz4D4msTwBDp5xKn1sduVDPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392144AbfJXRoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:44:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41587 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJXRoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:44:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id c17so36098869qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y0zG26oxPMQJHKD7Mb6mmVZPWuqohBI8HCHAJ+PDX1w=;
        b=C50kV1wdlY3IFSWsf3R1J/0rmNlG8S/D4INw4MS4bXQhezmO1HghTBPUq0na+lXdyc
         VlnlgE9xhes3v5Ea1kXTm23DLrlLsvd2VyzzxhUoj9dB4JweiXpOZZrwlbuQqy571pZY
         yRyGinUVKGBoyTJm6lbfujHhvw5klIPv3nOHmkEf8R7AvMX2Si7SiOahmzeNhldkIzDz
         rygzXWysSTOzHFO12j082oPBv6vyVwhcBYA3Hz5BRmIKKZsJ6s8Wle+xoQg6VQrQq8zy
         +lODsW4YWcVXJQKkQPrIBRup+7kRkJ0U0bS1Q5LEXLBwkdrDxuRS//20+WULTwMBNGxA
         HFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y0zG26oxPMQJHKD7Mb6mmVZPWuqohBI8HCHAJ+PDX1w=;
        b=WNBcEB96415fWI2Eo6RXqia1RhpzTbtTjhNFpCGYXxO0VdfU3xj7KvXl+0sXWwFL8n
         VOgbB0oKDcaH0wCoHolrTAroSZe5C/VfbNlnm/wF7lYyla5IL7u2LfQDyhxUmX91+Rf3
         QI7SLu00/auq6WrEM8WuXMMjWSR6B4/wyM/9ZWj6qMsRBIY282aTttUBg0utXorO3kEH
         L0+D06GW/hu8+l99+sK7g/Ok1IDUvm5q+en0YLTUWFL3nGSadIRufr/+P7tJUd+8A+Fe
         WfHFm3/xoaY/hCGh53zqANYRAhyaSFMC7ZewGnPX0DPfY0CkFmMo7mN6sqympvoX+GeU
         yFqg==
X-Gm-Message-State: APjAAAUp+QZnGHDSkjIuU1/qQlCN6ifL4kf0zs7/cwZPj8O/jq5aWBgM
        1Y2MCL71clyvHnAyk5SgzFI=
X-Google-Smtp-Source: APXvYqyWr4EtLhA+is5CwIapWHxX16bKOxbWVYwKcqpmmunCD3QXeyKFdIHuwD/zNsiU8klPmk+hKg==
X-Received: by 2002:ac8:22b6:: with SMTP id f51mr5339688qta.210.1571939076995;
        Thu, 24 Oct 2019 10:44:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:b2e])
        by smtp.gmail.com with ESMTPSA id x38sm10740184qtc.64.2019.10.24.10.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:44:35 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:44:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
Message-ID: <20191024174433.GA3622521@devbig004.ftw2.facebook.com>
References: <20191016125019.157144-1-namhyung@kernel.org>
 <20191016125019.157144-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016125019.157144-2-namhyung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First of all, thanks a lot for working on this.

On Wed, Oct 16, 2019 at 09:50:18PM +0900, Namhyung Kim wrote:
> Current cgroup id is 32-bit and might be recycled while system is
> running.  To support unique id, add generation number (gen) to catch
> recycling and make 64 bit number.  This number will be used as kernfs
> id and inode number (and file handle).
> 
> Also introduced cgroup_idr struct to keep the idr and generation
> together.  The related functions are little bit modified as well and I
> made some change to cgroup_idr_alloc() to use cyclic allocator.
> 
> Later 64 bit system can have a simpler implementation with a single 64
> bit sequence number and a RB tree.  But it'll need to grab a spinlock
> during lookup.  I'm not entirely sure it's ok, so I left it as is.

Any chance I can persuade you into making this conversion?  idr is
exactly the wrong data structure to use for cyclic allocations.  We've
been doing it mostly for historical reasons but I really hope we can
move away from it.  These lookups aren't in super hot paths and doing
locked lookups should be fine.

>  /*
>   * A cgroup_root represents the root of a cgroup hierarchy, and may be
>   * associated with a kernfs_root to form an active hierarchy.  This is
> @@ -521,7 +529,7 @@ struct cgroup_root {
>  	unsigned int flags;
>  
>  	/* IDs for cgroups in this hierarchy */
> -	struct idr cgroup_idr;
> +	struct cgroup_idr cgroup_idr;

Given that there's cgroup->self css, can we get rid of the above?
Also, can we make css->id a 64bit value too?

Thanks.

-- 
tejun
