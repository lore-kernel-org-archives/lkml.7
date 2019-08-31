Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86268C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B2D21852
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfHaRn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 13:43:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfHaRn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 13:43:26 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89A113D94D
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 17:43:25 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id v16so10883884qtp.14
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 10:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cIHszIcXROJYsUB5SpC1UHCVwuIkppX7qGEFDj/5xo0=;
        b=d3ZyVziITqVb84J3cOdIszQYkOMo3U1fj5Ha/Q754PZUILl5J1L8yHSTjDEGUILf4M
         ZR2vP2dA9qsBnlrc4XKVPth/ly8PgAA9SmojGJ3dRJHGzlqJo1ll6jewZUNkcKoJbFU/
         2/w0OMHQhLcXsInfWazmLL3Pb1I+0Ip51JBSCPlGHa+jexQFji3SpsH4l52cJwKKmS1x
         ZRP8c+CRgvIt1sQ6/KDtWW8Vl92mwiQYLIPRtKyqyyKdh/RCqMsgz9Awk2Y8IrQzTy4p
         +ndvRfAKs7m2ybjQ26hnGT8590zQAB08mvefZnYClYMZD5txs9EpFCgmaGxePO6fnzfU
         siag==
X-Gm-Message-State: APjAAAXGaV0VLNsqhs9HH6wyuh1j4K6s8gJS+VjDGcUxmOFmzpcKmF0t
        ZKEWqbf9qu+/0ZHkdQdU8xFJrei40gFhbsAE1DtnVnpKg5ptwhnf3Oh0wQGSGKmBOlysO80Eeoj
        ICjxwHx1BnzU9Rv49Vpca6pEJ
X-Received: by 2002:a37:8204:: with SMTP id e4mr13824074qkd.281.1567273404563;
        Sat, 31 Aug 2019 10:43:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyUVTZQ/NdVzrtHwlgWa3CZUvMoYBF799HKr9TzniFNFWi/Tj1PilrvJQdHknPVch1OD89j7A==
X-Received: by 2002:a37:8204:: with SMTP id e4mr13824060qkd.281.1567273404418;
        Sat, 31 Aug 2019 10:43:24 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id g19sm2433415qtb.2.2019.08.31.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 10:43:23 -0700 (PDT)
Date:   Sat, 31 Aug 2019 13:43:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matej Genci <matej.genci@nutanix.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
Message-ID: <20190831134218-mutt-send-email-mst@kernel.org>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
 <20190830095928-mutt-send-email-mst@kernel.org>
 <41b8eb4b-0d3b-f103-9ec4-332a903612ee@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b8eb4b-0d3b-f103-9ec4-332a903612ee@nutanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 05:58:23PM +0000, Matej Genci wrote:
> On 8/30/2019 3:02 PM, Michael S. Tsirkin wrote:
> > On Tue, Aug 27, 2019 at 03:20:57PM +0000, Matej Genci wrote:
> >> Compilers such as g++ 7.3 complain about assigning void* variable to
> >> a non-void* variable (like struct pointers) and pointer arithmetics
> >> on void*.
> >>
> >> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> >> ---
> >>   include/uapi/linux/virtio_ring.h | 9 +++++----
> >>   1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> >> index 4c4e24c291a5..2c339b9e2923 100644
> >> --- a/include/uapi/linux/virtio_ring.h
> >> +++ b/include/uapi/linux/virtio_ring.h
> >> @@ -168,10 +168,11 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
> >>   			      unsigned long align)
> >>   {
> >>   	vr->num = num;
> >> -	vr->desc = p;
> >> -	vr->avail = p + num*sizeof(struct vring_desc);
> >> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> >> -		+ align-1) & ~(align - 1));
> >> +	vr->desc = (struct vring_desc *)p;
> >> +	vr->avail = (struct vring_avail *)((uintptr_t)p
> >> +		+ num*sizeof(struct vring_desc));
> >> +	vr->used = (struct vring_used *)(((uintptr_t)&vr->avail->ring[num]
> >> +		+ sizeof(__virtio16) + align-1) & ~(align - 1));
> >>   }
> >>   
> >>   static inline unsigned vring_size(unsigned int num, unsigned long align)
> > 
> > I'm not really interested in building with g++, sorry.
> > Centainly not if it makes code less robust by forcing
> > casts where they weren't previously necessary.
> 
> Can you elaborate on how these casts make the code less robust?

If we ever change the variable types build will still pass
because of the cast.

> They aren't necessary in C but I think being explicit can improve
> readability as argued in
> https://softwareengineering.stackexchange.com/a/275714
> 
> > 
> > However, vring_init and vring_size are legacy APIs anyway,
> > so I'd be happy to add ifndefs that will allow userspace
> > simply hide these functions if it does not need them.
> > 
> 
> I feel like my patch is a harmless way of allowing this header
> to be used in C++ projects, but I'm happy to drop it in lieu of
> the guards if you feel strongly about it.
> 
> Thanks.
> Matej

Yea let's not even start.

> > 
> >> -- 
> >> 2.22.0
> >>
> 
