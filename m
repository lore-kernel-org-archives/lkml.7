Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC15FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58BD20652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCGPr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:47:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39148 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:47:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id x6so9285350qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BhTxD3ySC1uQNcQaurRgNi8lE2OWakmfxk2tvcIPUn4=;
        b=th6erMheCIAZzyC/spHeuzkgRa7ceHNK9SK61G8jGdtATsuY0yuPRvC0UevFw+NpD1
         Oexr8I4g9kWu7f6jLytOZ2ii+gM8Tt1i3MQ/0h87YKOR6r58DhKHLhmI5/qnFJJxKoSp
         oBjbTEFNRub2SAshJUWL7BBz7ROKHhS2SCHipPkHHf9coHe7fayXXNkJNrRTizEnakm1
         yMNcYgijpfR8njdNXVQc14NUZI5JV6cWJ0oGqr5MWy8J7sPQP8OUIZe7R9F1t3IjEr86
         sOgpu/5aNfl6/7OE1m1vmT1m+JwYnAq/TxKHu5A6mxRLxYnEHqurYY/4aOimi6UHDAVe
         P+zg==
X-Gm-Message-State: APjAAAVMch4Fsa0SebKX1G3BzBXlD0zT8S5xD8dBPW9Nk39qmJUOA572
        zMvrQR9xPbrBWfw++9dsmXiWMw==
X-Google-Smtp-Source: APXvYqwmzGcW5lj5Q8CC2/neDVhy2nmaELi4a1GVCRW653iKSH/SbNxUxxC4uElvkGE3ZhcVB5QJ0g==
X-Received: by 2002:a05:620a:148a:: with SMTP id w10mr10023352qkj.172.1551973646133;
        Thu, 07 Mar 2019 07:47:26 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id s49sm3115748qtk.7.2019.03.07.07.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 07:47:25 -0800 (PST)
Date:   Thu, 7 Mar 2019 10:47:22 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307103503-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551856692-3384-6-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 02:18:12AM -0500, Jason Wang wrote:
> +static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
> +	.invalidate_range = vhost_invalidate_range,
> +};
> +
>  void vhost_dev_init(struct vhost_dev *dev,
>  		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
>  {

I also wonder here: when page is write protected then
it does not look like .invalidate_range is invoked.

E.g. mm/ksm.c calls

mmu_notifier_invalidate_range_start and
mmu_notifier_invalidate_range_end but not mmu_notifier_invalidate_range.

Similarly, rmap in page_mkclean_one will not call
mmu_notifier_invalidate_range.

If I'm right vhost won't get notified when page is write-protected since you
didn't install start/end notifiers. Note that end notifier can be called
with page locked, so it's not as straight-forward as just adding a call.
Writing into a write-protected page isn't a good idea.

Note that documentation says:
	it is fine to delay the mmu_notifier_invalidate_range
	call to mmu_notifier_invalidate_range_end() outside the page table lock.
implying it's called just later.

-- 
MST
