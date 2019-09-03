Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE95CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56BA2339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfICPAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICPAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:00:37 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FB44CF20
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 15:00:37 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id v143so5095597qka.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KXBcRiCzE5toFQPvirypSePgXTAp9EkT2QplSpuPdPg=;
        b=PoiSoSYx42sfEUsRfSK/oHEXjOWK7EWK16/110o1kOO3dHubyxEY4GrXl6ejNoWbQm
         DVqx6X5ljND4tHR9lY/v1lAyujYup8P7+U23TznbicxAvThzrDiy8eMDQusoTyo+89mS
         YmtqWn7BB6dIlagPA0foT2NYSieZdBeKwbGduoGLpRu0Ohpz0YZ3m5hbSIPKG0nw72VS
         tfmpcypFlVt+LH/ZTfWmw0jc+uuxCsCb7tSuNSVOjaT+kcgMlAQyEyUoi/hLgscP1QtR
         dcCtKV3uJrEQ254KoYnOQ331yHCPLOpam6CxL3nQlpQamEe9GZ1zQZAPZQz1eYSBRpuS
         EsSA==
X-Gm-Message-State: APjAAAVUvM4Xgm/GS4H/DQ3Br74/kLACE1JZ3jtC0wyHor8cDz9u9BbH
        1WhAeZxQNazcK5/UeMnjJWH3fCwRpcid3TTHSvJaZ5aC6EoZh6tIgPy/KnKWjc0C1zVM4PcZJtm
        g1fx+EU4kYAU4oNOpUlzDaOWj
X-Received: by 2002:a37:470a:: with SMTP id u10mr5544450qka.17.1567522836438;
        Tue, 03 Sep 2019 08:00:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwX7TspzFyxuwob+EMNdf8BABzLUIs6GRYTTNyphxRKypQ3g5QNYvArrCH/9RyhQNDnFU1d+Q==
X-Received: by 2002:a37:470a:: with SMTP id u10mr5544426qka.17.1567522836228;
        Tue, 03 Sep 2019 08:00:36 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id p186sm8738374qkc.65.2019.09.03.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 08:00:35 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:00:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matej Genci <matej.genci@nutanix.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
Message-ID: <20190903105954-mutt-send-email-mst@kernel.org>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
 <20190830095928-mutt-send-email-mst@kernel.org>
 <41b8eb4b-0d3b-f103-9ec4-332a903612ee@nutanix.com>
 <20190831134218-mutt-send-email-mst@kernel.org>
 <6454e12b-470b-cce6-5570-3fb92cbc916d@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6454e12b-470b-cce6-5570-3fb92cbc916d@nutanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 09:56:42AM +0000, Matej Genci wrote:
> On 8/31/2019 6:43 PM, Michael S. Tsirkin wrote:
> > On Fri, Aug 30, 2019 at 05:58:23PM +0000, Matej Genci wrote:
> >> On 8/30/2019 3:02 PM, Michael S. Tsirkin wrote:
> >>> On Tue, Aug 27, 2019 at 03:20:57PM +0000, Matej Genci wrote:
> >>>> Compilers such as g++ 7.3 complain about assigning void* variable to
> >>>> a non-void* variable (like struct pointers) and pointer arithmetics
> >>>> on void*.
> >>>>
> >>>> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> >>>> ---
> >>>>    include/uapi/linux/virtio_ring.h | 9 +++++----
> >>>>    1 file changed, 5 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> >>>> index 4c4e24c291a5..2c339b9e2923 100644
> >>>> --- a/include/uapi/linux/virtio_ring.h
> >>>> +++ b/include/uapi/linux/virtio_ring.h
> >>>> @@ -168,10 +168,11 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
> >>>>    			      unsigned long align)
> >>>>    {
> >>>>    	vr->num = num;
> >>>> -	vr->desc = p;
> >>>> -	vr->avail = p + num*sizeof(struct vring_desc);
> >>>> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> >>>> -		+ align-1) & ~(align - 1));
> >>>> +	vr->desc = (struct vring_desc *)p;
> >>>> +	vr->avail = (struct vring_avail *)((uintptr_t)p
> >>>> +		+ num*sizeof(struct vring_desc));
> >>>> +	vr->used = (struct vring_used *)(((uintptr_t)&vr->avail->ring[num]
> >>>> +		+ sizeof(__virtio16) + align-1) & ~(align - 1));
> >>>>    }
> >>>>    
> >>>>    static inline unsigned vring_size(unsigned int num, unsigned long align)
> >>>
> >>> I'm not really interested in building with g++, sorry.
> >>> Centainly not if it makes code less robust by forcing
> >>> casts where they weren't previously necessary.
> >>
> >> Can you elaborate on how these casts make the code less robust?
> > 
> > If we ever change the variable types build will still pass
> > because of the cast.
> > 
> 
> Wouldn't that be the case in the original as well?
> You're assigning void*, which is implicitly cast to everything.


Right. And if we change that void * to something else,
build will fail. Not so with a cast.

> >> They aren't necessary in C but I think being explicit can improve
> >> readability as argued in
> >> https://urldefense.proofpoint.com/v2/url?u=https-3A__softwareengineering.stackexchange.com_a_275714&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=dbPDDn52JgZndd-WPvGcL5PLZTrms-72TItYJx-If5I&m=sw6xxC2EOF9g3XtUKuI6OvT5xhYF7XcWBqyQvGb-UMw&s=QWoZHF4XlOzPesnnbfsf1_KORrzkXb6yfd6yQGCwepc&e=
> >>
> >>>
> >>> However, vring_init and vring_size are legacy APIs anyway,
> >>> so I'd be happy to add ifndefs that will allow userspace
> >>> simply hide these functions if it does not need them.
> >>>
> >>
> >> I feel like my patch is a harmless way of allowing this header
> >> to be used in C++ projects, but I'm happy to drop it in lieu of
> >> the guards if you feel strongly about it.
> >>
> >> Thanks.
> >> Matej
> > 
> > Yea let's not even start.
> > 
> 
> Sure. I can re-send the patch with guards. But for my own sake,
> can you elaborate on the above?
> 
> >>>
> >>>> -- 
> >>>> 2.22.0
> >>>>
> >>
> 
