Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2714C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8758C20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCHDnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:43:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38776 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfCHDnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:43:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id z3so3263341qkf.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 19:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uekFqOVn98HGG4QuA6mGLQdwAoZwwLaY7YB1llaFMbo=;
        b=L7xVM5D57z3LI7fzGdGvUl+CB/q1kqvvkGZF1aG+rxLxYnTp+10x/lRuRrVi9Thbmp
         vYFyeRv6Hxrj+7ElQ5GV5mv6ByD6qJeU8KZMMA8bdRWUjkwN6GEWuK1t+kRei77EeN/x
         kAZIJf96YjzMsYv/CAkINssxdgyRc/dIEX1iLvZ/N/tKYyrCvMuVPiHn4XV3CfH3xXpS
         p04qIR525f9occiYebXOwR5H/N7xrTCiKAS5CIvhfLIFrPxpRCJ/vszGZea/jgZh4Kx1
         Bls51GkBu6/HcORtOH3O2u51BStkVlupz26hPx8yXiJu7x9YUhrNNotBNEy778V9zCGS
         VOhA==
X-Gm-Message-State: APjAAAWipIt4wE94NbYdkzySLhnN9D0neXZj218najts372tUoVeobFZ
        PTH34KNE5QXsiHEOgQ1QizGjM91dUe4=
X-Google-Smtp-Source: APXvYqxwiO037BlKr1Hx0fgpjyhdP/Z//1503mLf6eF76BmFvCFeRbxKmNyncYFT2IfZGY6+Y3h8Uw==
X-Received: by 2002:a05:620a:13ad:: with SMTP id m13mr12607514qki.59.1552016595261;
        Thu, 07 Mar 2019 19:43:15 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id c2sm4825237qtc.41.2019.03.07.19.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 19:43:14 -0800 (PST)
Date:   Thu, 7 Mar 2019 22:43:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307224143-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191720.GF3835@redhat.com>
 <20190307211506-mutt-send-email-mst@kernel.org>
 <20190308025539.GA5562@redhat.com>
 <20190307221549-mutt-send-email-mst@kernel.org>
 <20190308034053.GB5562@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308034053.GB5562@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:40:53PM -0500, Jerome Glisse wrote:
> On Thu, Mar 07, 2019 at 10:16:00PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Mar 07, 2019 at 09:55:39PM -0500, Jerome Glisse wrote:
> > > On Thu, Mar 07, 2019 at 09:21:03PM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Mar 07, 2019 at 02:17:20PM -0500, Jerome Glisse wrote:
> > > > > > It's because of all these issues that I preferred just accessing
> > > > > > userspace memory and handling faults. Unfortunately there does not
> > > > > > appear to exist an API that whitelists a specific driver along the lines
> > > > > > of "I checked this code for speculative info leaks, don't add barriers
> > > > > > on data path please".
> > > > > 
> > > > > Maybe it would be better to explore adding such helper then remapping
> > > > > page into kernel address space ?
> > > > 
> > > > I explored it a bit (see e.g. thread around: "__get_user slower than
> > > > get_user") and I can tell you it's not trivial given the issue is around
> > > > security.  So in practice it does not seem fair to keep a significant
> > > > optimization out of kernel because *maybe* we can do it differently even
> > > > better :)
> > > 
> > > Maybe a slightly different approach between this patchset and other
> > > copy user API would work here. What you want really is something like
> > > a temporary mlock on a range of memory so that it is safe for the
> > > kernel to access range of userspace virtual address ie page are
> > > present and with proper permission hence there can be no page fault
> > > while you are accessing thing from kernel context.
> > > 
> > > So you can have like a range structure and mmu notifier. When you
> > > lock the range you block mmu notifier to allow your code to work on
> > > the userspace VA safely. Once you are done you unlock and let the
> > > mmu notifier go on. It is pretty much exactly this patchset except
> > > that you remove all the kernel vmap code. A nice thing about that
> > > is that you do not need to worry about calling set page dirty it
> > > will already be handle by the userspace VA pte. It also use less
> > > memory than when you have kernel vmap.
> > > 
> > > This idea might be defeated by security feature where the kernel is
> > > running in its own address space without the userspace address
> > > space present.
> > 
> > Like smap?
> 
> Yes like smap but also other newer changes, with similar effect, since
> the spectre drama.
> 
> Cheers,
> Jérôme

Sorry do you mean meltdown and kpti?

-- 
MST
