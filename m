Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7332BC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4909820663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTm8ausO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfLLKiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:38:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbfLLKiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576147089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGdrhhHyRlkbfocg8i54ButT9u7PpOFWc5l6oudrYoY=;
        b=HTm8ausO0z/fCAFnUJ2o7oNaCen64eOavswJLHN/qHUr8/Br4Ici/U+qFQlFqRXtZoRgS6
        FqhakvJsxXohehzaHwugmo+gwu+tjf/FZdnE8VfUjP0zrZx+rW4uRVlSTeM72MdVGUjKO/
        wALxyW/7fiDtcltD3R5MJrV1ETWxnx0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-oeiUNHW0Ol2ZB93_zOtE4Q-1; Thu, 12 Dec 2019 05:38:08 -0500
X-MC-Unique: oeiUNHW0Ol2ZB93_zOtE4Q-1
Received: by mail-qt1-f198.google.com with SMTP id v25so1114417qtq.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGdrhhHyRlkbfocg8i54ButT9u7PpOFWc5l6oudrYoY=;
        b=W2793cWDYtRi2RzxrbFF02tpi454Aj4aDNUspEr5cbM+8XiAD8Q1k8Ocg9Rc4GDnkq
         H3gSlfM1UD/yBmewgdJM0p3MjEhSxXwduvd2p6uZnyu45wxxznPWBH0jV2KsugZ6tfBs
         EmfbSttkmfsWnYLGLvEa51yoYdY9EYle/M4pkCfi7OqLawt6i77/bSA5Vcmj+Z/i5c5r
         xTJaru39uBN2ymdEQaAkrXO8LWEQOQ7pe4u5rvZ05GwKHkQ/+mAoakdLjSsGtOA0N/Av
         PenJrAKS0n71inXDWdeMdlQAhnN+whepzsOL+PrrAHksHCr4bPuNdBEAtpi3A2TM8E+/
         HfPA==
X-Gm-Message-State: APjAAAWO/fPbAXiQb2DJonxpnBmKY8J0JNjQRkFehaQh4pV1RqrGGFf2
        Mq9Arcx1pfph+LfmWcTf0P5xnbiBv5SFoU+2mHRCRQ+wmOPVKCvZv3nafXcW5skAS/VZ2xvrzMT
        i+e08cwbR3xmDfCV1np5WsCq1
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr6826432qte.327.1576147087648;
        Thu, 12 Dec 2019 02:38:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqy533LAorMnek81fxEnELYfHSOMJtzaFsHpey7OtVFs0ONCSNjDRC58Vp1XiF2XTw+x7brejg==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr6826421qte.327.1576147087458;
        Thu, 12 Dec 2019 02:38:07 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id 53sm2085127qtu.40.2019.12.12.02.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:38:06 -0800 (PST)
Date:   Thu, 12 Dec 2019 05:38:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191212053403-mutt-send-email-mst@kernel.org>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191211063830-mutt-send-email-mst@kernel.org>
 <20191211205952.GA5091@xz-x1>
 <20191211172713-mutt-send-email-mst@kernel.org>
 <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
 <20191212023154-mutt-send-email-mst@kernel.org>
 <74edef57-c1c7-53cb-4b93-291d9f816688@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74edef57-c1c7-53cb-4b93-291d9f816688@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:12:04AM +0100, Paolo Bonzini wrote:
> On 12/12/19 08:36, Michael S. Tsirkin wrote:
> > On Thu, Dec 12, 2019 at 01:08:14AM +0100, Paolo Bonzini wrote:
> >>>> I'd say it won't be a big issue on locking 1/2M of host mem for a
> >>>> vm...
> >>>> Also note that if dirty ring is enabled, I plan to evaporate the
> >>>> dirty_bitmap in the next post. The old kvm->dirty_bitmap takes
> >>>> $GUEST_MEM/32K*2 mem.  E.g., for 64G guest it's 64G/32K*2=4M.  If with
> >>>> dirty ring of 8 vcpus, that could be 64K*8=0.5M, which could be even
> >>>> less memory used.
> >>>
> >>> Right - I think Avi described the bitmap in kernel memory as one of
> >>> design mistakes. Why repeat that with the new design?
> >>
> >> Do you have a source for that?
> > 
> > Nope, it was a private talk.
> > 
> >> At least the dirty bitmap has to be
> >> accessed from atomic context so it seems unlikely that it can be moved
> >> to user memory.
> > 
> > Why is that? We could surely do it from VCPU context?
> 
> Spinlock is taken.

Right, that's an implementation detail though isn't it?

> >> The dirty ring could use user memory indeed, but it would be much harder
> >> to set up (multiple ioctls for each ring?  what to do if userspace
> >> forgets one? etc.).
> > 
> > Why multiple ioctls? If you do like virtio packed ring you just need the
> > base and the size.
> 
> You have multiple rings, so multiple invocations of one ioctl.
> 
> Paolo

Oh. So when you said "multiple ioctls for each ring" - I guess you
meant: "multiple ioctls - one for each ring"?

And it's true, but then it allows supporting things like resize in a
clean way without any effort in the kernel. You get a new ring address -
you switch to that one.

-- 
MST

