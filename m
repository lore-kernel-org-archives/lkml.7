Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D091D2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCKN7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:59:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41873 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfCKN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:59:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id o129so799589qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=77FPPr8GBQjFVtWgXmaq2v1wGWOsJ9spQIX6jZegB34=;
        b=K0sG2LQbOK5WNG1odJscdB3Jgnj48UvhOVglmD+yLH63coOI/Jtt8F83xHQlTAg9ts
         Hbhky2L6pClqBO0QUGh0qBOiPm91LwApEdV9vY3DAXSq8/ILhisZ8PgsO07nwO1Yewq1
         jd4SD7dYHKLQn4BqVlXbq7+dmFdU5PpHbtF+LvO4fSXCwH+tfuGFyUKVgj3kkTm8HZvS
         FhFYks+nWBw+OLiWbvBLEN360TCgbVAKsSrhKhYKdqYtFfXI7M7jGxW45DpVHTMSC67R
         SgnYcpGrlAy9LEGurn6SULr+TymzdePPFwfkSOOrR9gbi3c82nmZYWTWn1MABG/T1vz8
         oItQ==
X-Gm-Message-State: APjAAAUHN/LQhCBEvgrJTg76URUvPdVur2Tir4BL855XAWwNg/sbp5C9
        HldWfqbp3uGbhhdLg62qsmnJMiRjN4A=
X-Google-Smtp-Source: APXvYqw9YjGDnhJ+1jlpw7LNXGz4dlHhYvGe+8BN/PnyfIJlcNuYvvhADur74p7uAUvRCtKs8Sg6Ow==
X-Received: by 2002:a37:464f:: with SMTP id t76mr7443872qka.353.1552312772629;
        Mon, 11 Mar 2019 06:59:32 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id r24sm3623959qte.60.2019.03.11.06.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 06:59:31 -0700 (PDT)
Date:   Mon, 11 Mar 2019 09:59:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
Message-ID: <20190311095405-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <20190308141220.GA21082@infradead.org>
 <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 03:13:17PM +0800, Jason Wang wrote:
> 
> On 2019/3/8 下午10:12, Christoph Hellwig wrote:
> > On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
> > > This series tries to access virtqueue metadata through kernel virtual
> > > address instead of copy_user() friends since they had too much
> > > overheads like checks, spec barriers or even hardware feature
> > > toggling. This is done through setup kernel address through vmap() and
> > > resigter MMU notifier for invalidation.
> > > 
> > > Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
> > > obvious improvement.
> > How is this going to work for CPUs with virtually tagged caches?
> 
> 
> Anything different that you worry?

If caches have virtual tags then kernel and userspace view of memory
might not be automatically in sync if they access memory
through different virtual addresses. You need to do things like
flush_cache_page, probably multiple times.

> I can have a test but do you know any
> archs that use virtual tag cache?

sparc I believe.

> Thanks



