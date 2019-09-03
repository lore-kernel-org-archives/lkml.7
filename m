Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1C0C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 04:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB60721881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 04:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfICEj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 00:39:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfICEjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 00:39:25 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8851480F7C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 04:39:25 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id e2so17664068qtm.19
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 21:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QsFw6JbKR151rBeG65E8RZKx+pqxeiIfjKh1LzJnxMs=;
        b=mVXM4sqtNZNmG8VFrljv2+Mnd7lMsi2qSSVUF3yRn3JIoxLGPciuWphWCM8yYCitMg
         0NGLAe6bK0rYEjEwrYPBFcJL5t8jnzkCLbR2eAoD/tu/mAkP+s1APfVCfa9Su8a+dphM
         YWx4s+qpkS5VMj9t6lYcpBqiTTYBfC+p15xNpeufM0dVfKNjrezVqF9dZNNiPAupgey+
         cB4prhXlWu4u8d6VuJdYQwJ8LfED3LT2BtzALdN/uamAn69XRc+GitBHNqANXNSui3yl
         2qtzQ9si3l/ky8/+rc1p+da19dUjRTQBZZkAQp5P83zfxnGSpj7OeOMYOm/VH8YkwtTl
         9wqQ==
X-Gm-Message-State: APjAAAVXo6WjDF2wgzHRkGUpnWUgJRIwoGWjAGBqmemqoNpfn2AWh3fv
        MftlhwgwDpxYTrkhJbpBZYyI97kgB3jb75efaEgLLbkG7930fY7IiINyS9EcsU4z1PoCg8Pd4fG
        EYSpDk2Q8EbyOIGWI2i6fKO0F
X-Received: by 2002:a37:7f41:: with SMTP id a62mr5242887qkd.21.1567485564947;
        Mon, 02 Sep 2019 21:39:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwsb0LztYbIXObHR39awO6zBUHMeK0bLZrIDZ9QdvCXGsCAgbVutbSJHHLuwhraV6VG7qqbwA==
X-Received: by 2002:a37:7f41:: with SMTP id a62mr5242876qkd.21.1567485564780;
        Mon, 02 Sep 2019 21:39:24 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id z72sm8508456qka.115.2019.09.02.21.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 21:39:24 -0700 (PDT)
Date:   Tue, 3 Sep 2019 00:39:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Message-ID: <20190903003823-mutt-send-email-mst@kernel.org>
References: <20190729165056.r32uzj6om3o6vfvp@steredhat>
 <20190729143622-mutt-send-email-mst@kernel.org>
 <20190730093539.dcksure3vrykir3g@steredhat>
 <20190730163807-mutt-send-email-mst@kernel.org>
 <20190801104754.lb3ju5xjfmnxioii@steredhat>
 <20190801091106-mutt-send-email-mst@kernel.org>
 <20190801133616.sik5drn6ecesukbb@steredhat>
 <20190901025815-mutt-send-email-mst@kernel.org>
 <20190901061707-mutt-send-email-mst@kernel.org>
 <20190902095723.6vuvp73fdunmiogo@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902095723.6vuvp73fdunmiogo@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:57:23AM +0200, Stefano Garzarella wrote:
> > 
> > Assuming we miss nothing and buffers < 4K are broken,
> > I think we need to add this to the spec, possibly with
> > a feature bit to relax the requirement that all buffers
> > are at least 4k in size.
> > 
> 
> Okay, should I send a proposal to virtio-dev@lists.oasis-open.org?

How about we also fix the bug for now?

-- 
MST
