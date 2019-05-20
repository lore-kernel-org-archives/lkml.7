Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C160EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97403216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbfETNJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:09:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36277 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbfETNJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:09:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id a17so16199743qth.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dFuLtne3guYuFwbHKpK48q543MOC/my0Y0MNbyUjuPE=;
        b=ZY3myx134WpV0MDj+yzXlLAHHLDYBFPL59Jv1/uvsy0DijGI+qvjoAJ0dFEYf2GL6m
         qFgNJeIHHYF3ziiu6bvOstuOOpEMzWwgvQ76IELgiHPEwtJD78/JfBih66kGLrISbIJ6
         Zl5YSShRtu+/vfgpTk3JbN0hIlCbfndUkRk35985a6qkPgiNIYMCg/T/bUTvJqkEasGT
         5tTj7+sEHnqxNpjamRsP0g5cZdeDEmKx8N3eb/77SIhm09iYmy823GiY9/vhwE06ktK5
         jHzLuF2aNARvf21ou2bcOozALzr1eGOnj3gQIZTfriqysqN4mjgCJ5hMYLleeSCKJw/V
         jVPA==
X-Gm-Message-State: APjAAAXNzFD7YxuxZzGruSYd3a6/1o0M4sJeFBAs1c8dsH1A/I5VUSm8
        gw3dSre28Ne5qh30hfCsrfOnuQ==
X-Google-Smtp-Source: APXvYqxFmd0nNrX047VR0mRGjhNHl6yQJCi/WzEdlp1N5DlMzFNrD0wqdFlb4sI+QUnVeRVV7+bGMQ==
X-Received: by 2002:a0c:af51:: with SMTP id j17mr38357606qvc.34.1558357741216;
        Mon, 20 May 2019 06:09:01 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id n190sm7929770qkb.83.2019.05.20.06.08.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 06:08:59 -0700 (PDT)
Date:   Mon, 20 May 2019 09:08:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190520090602-mutt-send-email-mst@kernel.org>
References: <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
 <20190320171027-mutt-send-email-mst@kernel.org>
 <87tvfvbwpb.fsf@morokweng.localdomain>
 <20190323165456-mutt-send-email-mst@kernel.org>
 <87a7go71hz.fsf@morokweng.localdomain>
 <20190419190258-mutt-send-email-mst@kernel.org>
 <875zr228zf.fsf@morokweng.localdomain>
 <20190424210813-mutt-send-email-mst@kernel.org>
 <871s1o1ft0.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s1o1ft0.fsf@morokweng.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:56:43PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Wed, Apr 24, 2019 at 10:01:56PM -0300, Thiago Jung Bauermann wrote:
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> >> >>
> >> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >> >>
> >> >> > On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
> >> >> >>
> >> >> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >> >> >>
> >> >> >> > On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
> >> >> >> >> >From what I understand of the ACCESS_PLATFORM definition, the host will
> >> >> >> >> only ever try to access memory addresses that are supplied to it by the
> >> >> >> >> guest, so all of the secure guest memory that the host cares about is
> >> >> >> >> accessible:
> >> >> >> >>
> >> >> >> >>     If this feature bit is set to 0, then the device has same access to
> >> >> >> >>     memory addresses supplied to it as the driver has. In particular,
> >> >> >> >>     the device will always use physical addresses matching addresses
> >> >> >> >>     used by the driver (typically meaning physical addresses used by the
> >> >> >> >>     CPU) and not translated further, and can access any address supplied
> >> >> >> >>     to it by the driver. When clear, this overrides any
> >> >> >> >>     platform-specific description of whether device access is limited or
> >> >> >> >>     translated in any way, e.g. whether an IOMMU may be present.
> >> >> >> >>
> >> >> >> >> All of the above is true for POWER guests, whether they are secure
> >> >> >> >> guests or not.
> >> >> >> >>
> >> >> >> >> Or are you saying that a virtio device may want to access memory
> >> >> >> >> addresses that weren't supplied to it by the driver?
> >> >> >> >
> >> >> >> > Your logic would apply to IOMMUs as well.  For your mode, there are
> >> >> >> > specific encrypted memory regions that driver has access to but device
> >> >> >> > does not. that seems to violate the constraint.
> >> >> >>
> >> >> >> Right, if there's a pre-configured 1:1 mapping in the IOMMU such that
> >> >> >> the device can ignore the IOMMU for all practical purposes I would
> >> >> >> indeed say that the logic would apply to IOMMUs as well. :-)
> >> >> >>
> >> >> >> I guess I'm still struggling with the purpose of signalling to the
> >> >> >> driver that the host may not have access to memory addresses that it
> >> >> >> will never try to access.
> >> >> >
> >> >> > For example, one of the benefits is to signal to host that driver does
> >> >> > not expect ability to access all memory. If it does, host can
> >> >> > fail initialization gracefully.
> >> >>
> >> >> But why would the ability to access all memory be necessary or even
> >> >> useful? When would the host access memory that the driver didn't tell it
> >> >> to access?
> >> >
> >> > When I say all memory I mean even memory not allowed by the IOMMU.
> >>
> >> Yes, but why? How is that memory relevant?
> >
> > It's relevant when driver is not trusted to only supply correct
> > addresses. The feature was originally designed to support userspace
> > drivers within guests.
> 
> Ah, thanks for clarifying. I don't think that's a problem in our case.
> If the guest provides an incorrect address, the hardware simply won't
> allow the host to access it.
> 
> >> >> >> > Another idea is maybe something like virtio-iommu?
> >> >> >>
> >> >> >> You mean, have legacy guests use virtio-iommu to request an IOMMU
> >> >> >> bypass? If so, it's an interesting idea for new guests but it doesn't
> >> >> >> help with guests that are out today in the field, which don't have A
> >> >> >> virtio-iommu driver.
> >> >> >
> >> >> > I presume legacy guests don't use encrypted memory so why do we
> >> >> > worry about them at all?
> >> >>
> >> >> They don't use encrypted memory, but a host machine will run a mix of
> >> >> secure and legacy guests. And since the hypervisor doesn't know whether
> >> >> a guest will be secure or not at the time it is launched, legacy guests
> >> >> will have to be launched with the same configuration as secure guests.
> >> >
> >> > OK and so I think the issue is that hosts generally fail if they set
> >> > ACCESS_PLATFORM and guests do not negotiate it.
> >> > So you can not just set ACCESS_PLATFORM for everyone.
> >> > Is that the issue here?
> >>
> >> Yes, that is one half of the issue. The other is that even if hosts
> >> didn't fail, existing legacy guests wouldn't "take the initiative" of
> >> not negotiating ACCESS_PLATFORM to get the improved performance. They'd
> >> have to be modified to do that.
> >
> > So there's a non-encrypted guest, hypervisor wants to set
> > ACCESS_PLATFORM to allow encrypted guests but that will slow down legacy
> > guests since their vIOMMU emulation is very slow.
> 
> Yes.
> 
> > So enabling support for encryption slows down non-encrypted guests. Not
> > great but not the end of the world, considering even older guests that
> > don't support ACCESS_PLATFORM are completely broken and you do not seem
> > to be too worried by that.
> 
> Well, I guess that would be the third half of the issue. :-)
> 
> > For future non-encrypted guests, bypassing the emulated IOMMU for when
> > that emulated IOMMU is very slow might be solvable in some other way,
> > e.g. with virtio-iommu. Which reminds me, could you look at
> > virtio-iommu as a solution for some of the issues?
> > Review of that patchset from that POV would be appreciated.
> 
> Yes, I will have a look. As you mentioned already, virtio-iommu doesn't
> define a way to request iommu bypass for a device so that would have to
> be added.

I think it does have a way for guest to request bypass:
there's a feature bit which - if set - specifies that a device
that is in no domain bypasses the iommu.

> Though to be honest in practice I don't think such a feature in
> virtio-iommu would make things easier for us, at least in the short
> term. It would take the same effort to define a powerpc-specific
> hypercall to accomplish the same thing (easier, in fact since we
> wouldn't have to implement the rest of virtio-iommu). In fact, there
> already is such hypercall, but it is only defined for VIO devices
> (RTAS_IBM_SET_TCE_BYPASS in QEMU). We would have to make it work on
> virtio devices as well.

Now I'm a bit lost. Could you pls describe quickly what does it do?

> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
