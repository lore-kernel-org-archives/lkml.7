Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABD9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BB5206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfGaThl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:37:41 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38436 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGaThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:37:41 -0400
Received: by mail-ua1-f68.google.com with SMTP id j2so625052uaq.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 12:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+bKc7B4JzgT9DtuNjUTDcn35OMgA2VDnh+9KjBEbSOU=;
        b=H29iwchNwHtctZrbJJZv0GjX42hNl/qrUMljDpkCGmNZ5nnZm7THfjws+hP5/kFaMp
         kFATcROlXRPGa0ZN0Z3df/gT7MjFGAp/tljrc1/of40mwzZrwzSbztzDECAek4qmPjWX
         +L/OK5gLa1kQDcN6LIUWMF4BLOUOecuCayW7jKKbyMfGBLnhzR6RG2tiLPIccqF/huUi
         Oqaun0X1L5jsrYxJJ8WmGl2FyP896ulu99iTHlOgmWq7N6rMXpJyIp+Kv3rnuxr+TH3W
         8FbLDoD7LKedlxKfiA3sVS+NHczNJc9Tlpr8nES423NKvHK7LpRfTnzJqcYtyPKuNQdS
         Kh1g==
X-Gm-Message-State: APjAAAULb3qneOsNrAzfuAsaIAuK+TFt9bjiqQg9E3Kb83WXl/zvbugc
        JQMhfXPJs8B3Q/DkNRIKK4iVsA==
X-Google-Smtp-Source: APXvYqw/uC7Sg0RgYeqV/6ZnjT1WzyZlwnkKUfrWxPSyTzC349Dq5/eLPf4Pq8CVGYdLBk+RnFtD3Q==
X-Received: by 2002:ab0:175:: with SMTP id 108mr75476010uak.136.1564601860284;
        Wed, 31 Jul 2019 12:37:40 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id a23sm8006371vkl.52.2019.07.31.12.37.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 12:37:39 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:37:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 4/9] vhost: reset invalidate_count in
 vhost_set_vring_num_addr()
Message-ID: <20190731153640-mutt-send-email-mst@kernel.org>
References: <20190731084655.7024-1-jasowang@redhat.com>
 <20190731084655.7024-5-jasowang@redhat.com>
 <20190731124124.GD3946@ziepe.ca>
 <31ef9ed4-d74a-3454-a57d-fa843a3a802b@redhat.com>
 <20190731193252.GH3946@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190731193252.GH3946@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:32:52PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 31, 2019 at 09:29:28PM +0800, Jason Wang wrote:
> > 
> > On 2019/7/31 下午8:41, Jason Gunthorpe wrote:
> > > On Wed, Jul 31, 2019 at 04:46:50AM -0400, Jason Wang wrote:
> > > > The vhost_set_vring_num_addr() could be called in the middle of
> > > > invalidate_range_start() and invalidate_range_end(). If we don't reset
> > > > invalidate_count after the un-registering of MMU notifier, the
> > > > invalidate_cont will run out of sync (e.g never reach zero). This will
> > > > in fact disable the fast accessor path. Fixing by reset the count to
> > > > zero.
> > > > 
> > > > Reported-by: Michael S. Tsirkin <mst@redhat.com>
> > > Did Michael report this as well?
> > 
> > 
> > Correct me if I was wrong. I think it's point 4 described in
> > https://lkml.org/lkml/2019/7/21/25.
> 
> I'm not sure what that is talking about
> 
> But this fixes what I described:
> 
> https://lkml.org/lkml/2019/7/22/554
> 
> Jason

These are two reasons for a possible counter imbalance.
Unsurprisingly they are both fixed if you reset the counter to 0.

-- 
MST
