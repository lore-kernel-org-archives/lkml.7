Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9174AC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649692067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578559800;
	bh=F3Raaz39tonTz+2eBDZq34zZ313j9Y+C4nI9KcvzHBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SQgycw0cmbcdzCt3bdUoAM1eh+Co9glkYw0Zi1KlL98HWkbhe/nvR7oEuC6fVnkay
	 Ls2f1dfkgYRfNMFeZWMAvawvG92IkEvgr0UiVHo6gTVGBGiR4HuhNC1u4m+1UgE7sI
	 KSabU2vVrqUoZpaZQJ8hpsPc5Iaa4inkt7m41v0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgAIIt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:49:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35452 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgAIIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:49:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1876033wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 00:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HkmT/H0ZhfS407bD4aO1lzA4ZzACMKMDaTVuBlwXUwY=;
        b=i+tZkfsRd6n4MPXMiX0FhgEX3RVA/p7vBeZrccxLkz5/vBJXX6kSRRzKu0QJe1Zn8A
         63OdOB+lC1Yp/0vSkwfUx3mjipt8KZDrBXClaIMa8Mp3hsgC9w5rNph7abA54jhhXIa8
         MK+aaFE6PNAKlJD3cEOlkZsHXbmkmPPhHIbsBlXsZI3WMvl1GpaPBTzpW9vaoetluyKp
         nQYCjOhok38qdxMagm9ZWLtHUH0qgwYLTADPJaboe+50+gXU8jl+InVI71Jp5vLAUVQf
         t5LZgdBDpSOwGdvLd8naQf9l9IjpwPfDZ0H4VQ2w+Ee3eUa/Pw3EceByJYGyaAGcX47u
         JBIA==
X-Gm-Message-State: APjAAAVQK0Do11Q7BPOcI0ynIUStGgA9vCpIWyfVm5rVudgc/HimVA/O
        edqihxb6HaPgdKHtmqtfmlc=
X-Google-Smtp-Source: APXvYqw0aY48Yfv1vThwdEkfwH0Fqeh8X5myKMWsTmTCpivL/2veh03vVB5fRl0y5PDjBfiq0Idn2w==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr3643069wmc.78.1578559797116;
        Thu, 09 Jan 2020 00:49:57 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u18sm6793493wrt.26.2020.01.09.00.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:49:56 -0800 (PST)
Date:   Thu, 9 Jan 2020 09:49:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>, nathanl@linux.ibm.com,
        ricklind@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200109084955.GI4951@dhcp22.suse.cz>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
 <20200107214801.GN32178@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107214801.GN32178@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-01-20 22:48:04, Michal Hocko wrote:
> [Cc Andrew]
> 
> On Tue 17-12-19 13:32:38, Scott Cheloha wrote:
> > Searching for a particular memory block by id is slow because each block
> > device is kept in an unsorted linked list on the subsystem bus.
> 
> Noting that this is O(N^2) would be useful.
> 
> > Lookup is much faster if we cache the blocks in a radix tree.
> 
> While this is really easy and straightforward, is there any reason why
> subsys_find_device_by_id has to use such a slow lookup? I suspect nobody
> simply needed a more optimized data structure for that purpose yet.
> Would it be too hard to use radix tree for all lookups rather than
> adding a shadow copy for memblocks?

Greg, Rafael, this seems to be your domain. Do you have any opinion on
this?
-- 
Michal Hocko
SUSE Labs
