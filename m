Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B66420637
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UE/6TT7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKUQJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:09:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33872 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:09:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id l202so3698347oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXcgcbvs+2MnPA/4X38cmSpaLsc4tBMazAvEwqgqGLo=;
        b=UE/6TT7HfPuj8S5WgeIZ69I021cjsb4qGDZt3qc9fk1IB5APVoH66ut51jVBes4iSW
         Aef0fLKZocovV80FGW/O+Gv57tCW1pRhplxGliybAKG42xLiMrtbqrEIgCZ6c+KmfCnf
         dgvaBxYJ35Q4ov8s6LeUCSJ9dYGNH8PcnuIi4h6Cd61vCgrzzcoQi7EHEGMv6fGYmXFq
         ZiKVURucVh43UjBdWpw4DNKYA1CKXYHftPdvH2B0cR4G3F+T+udGHGGCvHw31xJf3qSy
         xTb97wVqCQKA608tb1v79CHsPYi02hOh3NrGphXwbN+jVtzlRPeKPQCB+mCUZPdYStwN
         m24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXcgcbvs+2MnPA/4X38cmSpaLsc4tBMazAvEwqgqGLo=;
        b=OTJ2OEA6Ugt074iXNanHgvX9EnTkXZQ4WLUqsuA7Vbpd+rRcpZniq7RUUw9p98qa7g
         eTqQn6DBYMJYyAZqEs3bSeAByXY/BHJVspm6KRTQ6isSR6NGAFpZQ/O7BJyl5d1DUAnj
         E6UhO9wyjISg/2SaLAX+zfRNjG7EIA9D4U5xxWa5Az3xGYBYyVxVrRuGtrPxmq6yYGRB
         Lv0JtEXN/Vz8BSED/ZEgdBWmcQ7wITEZCWqRcdUqrPts6bdEHUnrk6SEQJ434Hj59c09
         Suzdj1EKtbdLaAVGQmQFWyHj4XvCLTioITDEGfOxQbxOVlI6ry6GLOrPDEqXc+GAg1eY
         UBjg==
X-Gm-Message-State: APjAAAVI2bIiklHmKyeNoLNcoKSY/diKeC6qugBV4tdBd36PZDxI2m5m
        l0Cpo8JcIEwK3JMYGS7SZz41S+21B5Kjp5b7oT36VA==
X-Google-Smtp-Source: APXvYqwkBEKt2Ayxyhbxss+ahZZeyKGZ4wQSytQ1j5jmWgdtz59MSNkUesIZGAabUlJVAxO+Bd8N8I04KKrwKi4VgcA=
X-Received: by 2002:aca:3c1:: with SMTP id 184mr7837409oid.70.1574352553381;
 Thu, 21 Nov 2019 08:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
 <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com> <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
In-Reply-To: <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Nov 2019 08:09:02 -0800
Message-ID: <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:00 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> > > >
> > > > >  Remove logic to create child bio in the async flush function which
> > > > >  causes child bio to get executed after parent bio 'pmem_make_request'
> > > > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> > > > >  data write request.
> > > > >
> > > > >  Instead we are performing flush from the parent bio to maintain the
> > > > >  correct order. Also, returning from function 'pmem_make_request' if
> > > > >  REQ_PREFLUSH returns an error.
> > > > >
> > > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > >
> > > > There's a slight change in behavior for the error path in the
> > > > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> > > > converted to -EIO.  Now, they are reported as-is.  I think this is
> > > > actually an improvement.
> > > >
> > > > I'll also note that the current behavior can result in data corruption,
> > > > so this should be tagged for stable.
> > >
> > > I added that and was about to push this out, but what about the fact
> > > that now the guest will synchronously wait for flushing to occur. The
> > > goal of the child bio was to allow that to be an I/O wait with
> > > overlapping I/O, or at least not blocking the submission thread. Does
> > > the block layer synchronously wait for PREFLUSH requests? If not I
> > > think a synchronous wait is going to be a significant performance
> > > regression. Are there any numbers to accompany this change?
> >
> > Why not just swap the parent child relationship in the PREFLUSH case?
>
> I we are already inside parent bio "make_request" function and we create child
> bio. How we exactly will swap the parent/child relationship for PREFLUSH case?
>
> Child bio is queued after parent bio completes.

Sorry, I didn't quite mean with bio_split, but issuing another request
in front of the real bio. See md_flush_request() for inspiration.
