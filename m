Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843220661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCFSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:44:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45941 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfCFSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:44:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so14020479qtg.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ElWYEbUR+LJ8psNBo+UBE+XENynV58Cm2Tj5h8sRHuU=;
        b=cg3EfmGV4X7dFB6zE4X6843Y0tgep4lETsmXUwZ87Tnpv07DDrgjapk7kaFOE/UVEd
         1I/p/NEXPQ7UKb0+e7N7wYgRwAeK6v8wm9ZqjQpDna4YAcEF/LTDyizJJy+9BgWG9rfC
         zna1/tZckaZjVcUpJk5F/2B9Aiu6tjZkLOnebJhBU7NvKB3GKXWllF+XOiZVtMut0ooi
         IeEBxds8yF8k9CopQ+xEiCOtHlchlWuQL56bjWzoQxbJFWMT5aWiC+2ZkWQPnLPyg1+J
         1eBoaNGlJz39GpFmcFIkDcQrpDgQWuRWQsCfcf5C77k/642y4cBxPz9w7KbTgrM1QAy+
         IZ6A==
X-Gm-Message-State: APjAAAWJBkprHWgU/jldOS1T93f41jhkXlTZibKR1mbd2229YlhC8gwp
        nU1U9fb8BPr68kHu6E7NB00oOw==
X-Google-Smtp-Source: APXvYqx1S5gxMGG/ZIr9Mgd5jOASSHlQiWpFnNXemR1qMOJ1Cqpi1ovg9QSTLOYr1mZ1E01oTFaexg==
X-Received: by 2002:aed:3687:: with SMTP id f7mr6751880qtb.147.1551897842755;
        Wed, 06 Mar 2019 10:44:02 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id 55sm1539763qtq.25.2019.03.06.10.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 10:44:01 -0800 (PST)
Date:   Wed, 6 Mar 2019 13:43:54 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        alexander.duyck@gmail.com
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190306133826-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com>
 <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
> >> Here are the results:
> >>
> >> Procedure: 3 Guests of size 5GB is launched on a single NUMA node with
> >> total memory of 15GB and no swap. In each of the guest, memhog is run
> >> with 5GB. Post-execution of memhog, Host memory usage is monitored by
> >> using Free command.
> >>
> >> Without Hinting:
> >>                  Time of execution    Host used memory
> >> Guest 1:        45 seconds            5.4 GB
> >> Guest 2:        45 seconds            10 GB
> >> Guest 3:        1  minute               15 GB
> >>
> >> With Hinting:
> >>                 Time of execution     Host used memory
> >> Guest 1:        49 seconds            2.4 GB
> >> Guest 2:        40 seconds            4.3 GB
> >> Guest 3:        50 seconds            6.3 GB
> > OK so no improvement.
> If we are looking in terms of memory we are getting back from the guest,
> then there is an improvement. However, if we are looking at the
> improvement in terms of time of execution of memhog then yes there is none.

Yes but the way I see it you can't overcommit this unused memory
since guests can start using it at any time.  You timed it carefully
such that this does not happen, but what will cause this timing on real
guests?

So the real reason to want this is to avoid need for writeback on free
pages.

Right?


> >  OTOH Alex's patches cut time down to 5-7 seconds
> > which seems better. 
> I haven't investigated memhog as such so cannot comment on what exactly
> it does and why there was a time difference. I can take a look at it.
> > Want to try testing Alex's patches for comparison?
> Somehow I am not in a favor of doing a hypercall on every page (with
> huge TLB order/MAX_ORDER -1) as I think it will be costly.
> I can try using Alex's host side logic instead of virtio.
> Let me know what you think?
> >
> -- 
> Regards
> Nitesh
> 



