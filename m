Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F86C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E345020675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCHCVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:21:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38914 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHCVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:21:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so19649405qtk.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 18:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2TXa20qb/Eg4W3WSZnBQT88vOwNyfmVbxryiRAAOMZ0=;
        b=SZnfZ+oACUO1kPtp+qimlj3MqLgUsSWosrl62RA3F133MVaDOsm2aXzHrFCblzEzvb
         VkZ7U17kk16L9EHIe1mCOBBEr8TtWEUNftRodabyNQzLPDhgXg3m4ckmDvyRgqymE+mY
         ZuDcsSTfVlOHGAL67SvYlY2GUo+ccVz0saT0UKXexMCvfdCpyzmJzv3brq2uqpoGZJQe
         hl/4rUtCGtL4RdQdqNBfy1OTle1EK0LeLPjG5IxZ7unJMD1Pt3XhTM5FQC5id+PgA8a9
         Ms5CWlFT2hzB8xP/KWLsgrgaALkdneie9tbYcidLj06VciAsRBoL/3DjqlPEoJmHqohQ
         71Kw==
X-Gm-Message-State: APjAAAWEjBoCMYp6FpSbj1pE2m5udzrYzRULiGD0FU4coOwIZIJYhHRe
        yJptWMixqOBl8sr4vXP8+DgddA==
X-Google-Smtp-Source: APXvYqzwmvqaJpBh6BkGPYK/AtjzjCuM+5N/KdCuho9+qlSH99IkjHAdDdmV+TJ2vuAvSfuxMvgJPA==
X-Received: by 2002:a0c:a8d4:: with SMTP id h20mr13474604qvc.46.1552011666383;
        Thu, 07 Mar 2019 18:21:06 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id q57sm3931129qtj.79.2019.03.07.18.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 18:21:05 -0800 (PST)
Date:   Thu, 7 Mar 2019 21:21:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307211506-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191720.GF3835@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307191720.GF3835@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 02:17:20PM -0500, Jerome Glisse wrote:
> > It's because of all these issues that I preferred just accessing
> > userspace memory and handling faults. Unfortunately there does not
> > appear to exist an API that whitelists a specific driver along the lines
> > of "I checked this code for speculative info leaks, don't add barriers
> > on data path please".
> 
> Maybe it would be better to explore adding such helper then remapping
> page into kernel address space ?

I explored it a bit (see e.g. thread around: "__get_user slower than
get_user") and I can tell you it's not trivial given the issue is around
security.  So in practice it does not seem fair to keep a significant
optimization out of kernel because *maybe* we can do it differently even
better :)

-- 
MST
