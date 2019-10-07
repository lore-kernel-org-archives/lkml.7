Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D73C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1424B206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m4QDHaY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfJGQot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:44:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34943 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfJGQos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:44:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so9771637lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGS436HRux8Qi7+bTLo6awpzRjQ2y9zvJJmtOyjTy/k=;
        b=m4QDHaY9wDH4anvI3npqUIjOWHwZwVW9tFDgDtWfAkgb2tRUbHrib/Hfh3GsBfV6xI
         8XGs3WyeKiX7I+C5+2+8Cimoy7SwINY2CQjJNAbQT7A/B+otoNHjyn8YoRdPxdCBvgTy
         Rc1Zgal0G06EAMaNutfcGukP1UXn6JsZRqi8a9ScvO3UL7xH/8gF/CznKXx0cY0ZFwyF
         C6tkrvLh+Oqk5Rxl97h1DU/XhFIBKYDe6ef+HKAwzSeDBnmi7goNkdvGrFFaSCzPFs1P
         bP6Xhq+Yi05Kx9v4P6tQgq+McVUpcC+AN7y7WY0Vt/4IvEleG80GW86mPcOeZNvYBRMJ
         Hq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGS436HRux8Qi7+bTLo6awpzRjQ2y9zvJJmtOyjTy/k=;
        b=fyX28NCaaDAzUbCOCCsIDiplaBcuKGiXm7URRP/0MijPcFKbQOOz5KnFCwRTZVEmK4
         3Aii97Ylkxwr4fwK478orEXxyTMXBklSYZHf2XLNDF9A+sX5hTW8HfFFIWUPi5AC/q0Z
         owIdpobio8KqyahQDEXAVd0DfMRXRcfIDy6iFkVA+KJ64mzmYpkSlCj0LBndCglqPH9r
         iWJ+Uxr/3d3lOjlWwG/DEBLSeNlKF7Ih1QYjfZ+SQDGtqSCZOyjpf1rlJH/WfLYb5xap
         pi9cBuF1xyXTVsx68J49cedIBTpx6KN4keE/Vq72UUmsEjpcSIFF2CVvp+uWBVoicas0
         aIBw==
X-Gm-Message-State: APjAAAWt5R5V28WXbzMFS5j8Gm8eM200ZF8GZ41MNezXmFzTUd0cRAiX
        WRPuLm/FWyFby1LP5HFUVfv9WFMA5/+OZSK285v+zw==
X-Google-Smtp-Source: APXvYqyD8xebRWeDAhv/SXKGNKe39rkLCr9IKa58cOL5jGUyw5j1ilBYyphmOtOiQeF6Sb9unlTDSdpPR5KU2T4pSbc=
X-Received: by 2002:a19:8a0b:: with SMTP id m11mr17305439lfd.4.1570466685517;
 Mon, 07 Oct 2019 09:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com> <20191007061324.GB17978@infradead.org>
In-Reply-To: <20191007061324.GB17978@infradead.org>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 7 Oct 2019 09:44:33 -0700
Message-ID: <CABEDWGyovfKuXsNpfhsSCJ0sryg3EpAsaqRTHxBGC9LFM+=dww@mail.gmail.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>, christophe.leroy@c-s.fr,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 11:13 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Sep 30, 2019 at 04:22:35PM -0700, Alan Mikhak wrote:
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >
> > Modify sg_miter_stop() to validate the page pointer
> > before calling PageSlab(). This check prevents a crash
> > that will occur if PageSlab() gets called with a page
> > pointer that is not backed by page struct.
> >
> > A virtual address obtained from ioremap() for a physical
> > address in PCI address space can be assigned to a
> > scatterlist segment using the public scatterlist API
> > as in the following example:
>
> As Jason pointed out that is not a valid use of scatterlist.  What
> are you trying to do here at a higher level?

I am developing a PCI endpoint framework function driver to bring-up
an NVMe device over PCIe. The NVMe endpoint function driver connects
to an x86_64 or other root-complex host over PCIe. Internally, the
NVMe endpoint function driver connects to the unmodified Linux NVMe
target driver running on the embedded CPU. The Linux NVMe target
operates an NVMe namespace as determined for the application.
Currently, the Linux NVMe target code operates a file-based namespace
which is backed by the loop device. However, the application can be
expanded to operate on non-volatile storage such as flash or
battery-backed RAM. Currently, I am able to mount such an NVMe
namespace from the x86_64 Debian Linux host across PCIe using the
Disks App and perform Partition Benchmarking. I am also able to save
and load files, such as trace files for debugging the NVMe endpoint
with KernelShark, on the NVMe namespace partition nvme0n1p1.

My goal is to not modify the Linux NVMe target code at all. The NVMe
endpoint function driver currently does the work that is required. It
maps NVMe PRPs and PRP Lists from the host, formats a scatterlist that
NVMe target driver can consume, and executes the NVMe command with the
scatterlist on the NVMe target controller on behalf of the host. The
NVMe target controller can therefore read and write directly to host
buffers using the scatterlist as it does if the scatterlist had
arrived over the NVMe fabric.

In my current platform, there are no page struct backing for the PCIe
memory address space. Nevertheless, I am able to feed the virtual
addresses I obtain from ioremap() to the scatterlist as shown in my
example earlier. The scatterlist code has no problem traversing the
scatterlist that is formed from such addresses that were obtained from
ioremap(). The only place the scatterlist code prevents such usage is
in sg_miter_stop() when it calls PageSlab() to decide if it should
flush the page. I added a check to see if the page is valid and not
call PageSlab() if it is not a page struct backed page. That is all I
had to do to be able to pass scatterlists to the NVMe target.

Given that the PCIe memory address space is large, the cost of adding
page structs for that region is substantial enough for me to ask that
it be considered here to modify scatterlist code to support such
memory pointers that were obtained from ioremap(). If not acceptable,
the solution would be to pay to price and add page structs for the
PCIe memory address space.

Regards,
Alan
