Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C4BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948D020840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCGR4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:56:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37235 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfCGR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:56:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so18137360qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GlubaI8/tdCsyayarj1cX94BX3ry6cE1EJgMPiinZzY=;
        b=UlTKcaJ5QgtZmCth27ZK3bh0qSONxqFoPnXXI2rnKm+ChhHJ5PRutwkWqhZG4bxXyd
         Z2HgQhiSMOtEPrFejjYkgDjHRHGOF/duQhAegwpQe9p23EOW9paV42QBU2vPFny8e2xr
         Dqww1q3KOq9MWG9H29vA/EjmyNDi8yi1Mu+SkmFUDuNHDTuNLzMH3UEQtjd7X9LaKjLN
         N9iILEso6Nw3tRHfktgYna61K/zH5HlVtqj0YKLMRlMwaJea9FAgNBlMgXQ0cA5/JwIR
         UzwH8CBXct8XAbX1gfnsDvkC7i/TD1TwNvk1QISk6S7UbCXZZFOmMZMFIXvXADvvb7C4
         YB+Q==
X-Gm-Message-State: APjAAAWbjGkSFg6iVqmlRkhqW3RFJqQumLIzzanMME+V077g4EGsWtDe
        IbLTojw0sr94acjEoFybNCoTrMg9eSE=
X-Google-Smtp-Source: APXvYqxFRpwD4FB6daKlGFu9HAvoSSE10i1RtuQ+4HSg9M3hIccAg7z5LEuuhNtsFaAZIgZcXp6wYQ==
X-Received: by 2002:ac8:354c:: with SMTP id z12mr10798499qtb.92.1551981409185;
        Thu, 07 Mar 2019 09:56:49 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id t38sm3698415qtc.12.2019.03.07.09.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 09:56:48 -0800 (PST)
Date:   Thu, 7 Mar 2019 12:56:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org, aarcange@redhat.com,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307124700-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307103503-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:47:22AM -0500, Michael S. Tsirkin wrote:
> On Wed, Mar 06, 2019 at 02:18:12AM -0500, Jason Wang wrote:
> > +static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
> > +	.invalidate_range = vhost_invalidate_range,
> > +};
> > +
> >  void vhost_dev_init(struct vhost_dev *dev,
> >  		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
> >  {
> 
> I also wonder here: when page is write protected then
> it does not look like .invalidate_range is invoked.
> 
> E.g. mm/ksm.c calls
> 
> mmu_notifier_invalidate_range_start and
> mmu_notifier_invalidate_range_end but not mmu_notifier_invalidate_range.
> 
> Similarly, rmap in page_mkclean_one will not call
> mmu_notifier_invalidate_range.
> 
> If I'm right vhost won't get notified when page is write-protected since you
> didn't install start/end notifiers. Note that end notifier can be called
> with page locked, so it's not as straight-forward as just adding a call.
> Writing into a write-protected page isn't a good idea.
> 
> Note that documentation says:
> 	it is fine to delay the mmu_notifier_invalidate_range
> 	call to mmu_notifier_invalidate_range_end() outside the page table lock.
> implying it's called just later.

OK I missed the fact that _end actually calls
mmu_notifier_invalidate_range internally. So that part is fine but the
fact that you are trying to take page lock under VQ mutex and take same
mutex within notifier probably means it's broken for ksm and rmap at
least since these call invalidate with lock taken.

And generally, Andrea told me offline one can not take mutex under
the notifier callback. I CC'd Andrea for why.

That's a separate issue from set_page_dirty when memory is file backed.

It's because of all these issues that I preferred just accessing
userspace memory and handling faults. Unfortunately there does not
appear to exist an API that whitelists a specific driver along the lines
of "I checked this code for speculative info leaks, don't add barriers
on data path please".


> -- 
> MST
