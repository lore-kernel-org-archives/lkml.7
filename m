Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63EAC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ED620851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCHDQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:16:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36781 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCHDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:16:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so19800892qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 19:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+aYmiB1WgFEgCfJKnHZaWgzaN6cLqOY1VulRCFSIq7o=;
        b=GzasrntSot/CtjdkPmtknteKUFn7y1tpmxmTwEKuuWuQhOK2H7TMywhJ/I3kufV5xJ
         TrZwtA8uBUP0XoivpiH2dStTwx973xKZjGOGuWPjsiouJ0gIy7TeDBaTY6NtHLrUIcUX
         2DzoDS+qDATvfdDcX5vHzWqfyIStQ1YY4L5KTRq16qnrcoO21HnwgmeZSYRTTlfs+Nb6
         WgtMLLeMqaFCv3NwFvwVQNinOL+sA8sTAXqRRIjXPfD/BiI4z/XXfagzK/vhY1IXVuAz
         LnNqw1b4OB43FIUGErK2a3I+wYobqv52L2quBUlE/oHHtGFN+NEct1tWnXtYONBDkqbT
         +Pdw==
X-Gm-Message-State: APjAAAU5fnmGq01cMOecbZPd/LWuxfVVH8K8zKkFhgJ/icG+G/N4TWon
        yVOsq/GSQrTxvkqccPXLnlt4lQ==
X-Google-Smtp-Source: APXvYqw6sRfZNl5pFoX22KuCtq3MTNly4SABQV/PC1XDvyoNf7RBNjxftnQqGuu1O6fUQh9dwZEKMA==
X-Received: by 2002:ac8:3f3b:: with SMTP id c56mr12702567qtk.81.1552014963812;
        Thu, 07 Mar 2019 19:16:03 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id i141sm3482629qke.7.2019.03.07.19.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 19:16:02 -0800 (PST)
Date:   Thu, 7 Mar 2019 22:16:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307221549-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191720.GF3835@redhat.com>
 <20190307211506-mutt-send-email-mst@kernel.org>
 <20190308025539.GA5562@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308025539.GA5562@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:55:39PM -0500, Jerome Glisse wrote:
> On Thu, Mar 07, 2019 at 09:21:03PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Mar 07, 2019 at 02:17:20PM -0500, Jerome Glisse wrote:
> > > > It's because of all these issues that I preferred just accessing
> > > > userspace memory and handling faults. Unfortunately there does not
> > > > appear to exist an API that whitelists a specific driver along the lines
> > > > of "I checked this code for speculative info leaks, don't add barriers
> > > > on data path please".
> > > 
> > > Maybe it would be better to explore adding such helper then remapping
> > > page into kernel address space ?
> > 
> > I explored it a bit (see e.g. thread around: "__get_user slower than
> > get_user") and I can tell you it's not trivial given the issue is around
> > security.  So in practice it does not seem fair to keep a significant
> > optimization out of kernel because *maybe* we can do it differently even
> > better :)
> 
> Maybe a slightly different approach between this patchset and other
> copy user API would work here. What you want really is something like
> a temporary mlock on a range of memory so that it is safe for the
> kernel to access range of userspace virtual address ie page are
> present and with proper permission hence there can be no page fault
> while you are accessing thing from kernel context.
> 
> So you can have like a range structure and mmu notifier. When you
> lock the range you block mmu notifier to allow your code to work on
> the userspace VA safely. Once you are done you unlock and let the
> mmu notifier go on. It is pretty much exactly this patchset except
> that you remove all the kernel vmap code. A nice thing about that
> is that you do not need to worry about calling set page dirty it
> will already be handle by the userspace VA pte. It also use less
> memory than when you have kernel vmap.
> 
> This idea might be defeated by security feature where the kernel is
> running in its own address space without the userspace address
> space present.

Like smap?

> Anyway just wanted to put the idea forward.
> 
> Cheers,
> Jérôme
