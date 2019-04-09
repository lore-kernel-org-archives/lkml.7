Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4014C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69658208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Jgo77ysd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDIOtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:49:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42706 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:49:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id 103so15776624otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k18vVFTc+hq7WxyjyyY6YPjDwfffABYGdRiJn2pWXkA=;
        b=Jgo77ysdABrsaTRjIOT4m1WX7sd5vCQoSB0IvxSSxjkBx5SSkMCVcYRu31lVFo++J/
         qeN/swtfSsbbUtk6/Mfg65URcmgy6WN/PonezV4buI7RlC5k4UssuwFRoVGKkSBHr0NZ
         ZxKANLnCf4TmqK9je9dP3w7NyWJEp2CYvmvAipxPX7D8VtteU943JskqA6G7zNP4gtY4
         rktE27jcfl4IJ05xwRioHCOfRVfZ6CT+1UgIeiaWGjOehMrX/GPKcIfaMNA7ya89ptNk
         efIb3nMvbvj/6xWyrmqvWNYdhQlXl7i03tMBK6puOtBiHLNhruokv0aCYHV5baradbuA
         65Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k18vVFTc+hq7WxyjyyY6YPjDwfffABYGdRiJn2pWXkA=;
        b=b6ME6I1kaaL1U4UFPqCn7n8yVeHKFSCUihZU6OV8RUH6gEFgIyn2tXLJ/hZVRCkDDd
         ktYtyJ4UZmXyaCAW7fjM85kJfdjOGnKu926w0ZJmwidl21ukkqfquPI1XK8HS+bpsAbS
         ZLmmiI1Fv2z1np8IReTe6dAdv/dkPiz432US+lWkPSgLEdG0a8R8u3Nh2ZRK7s9ye9e6
         Bn4d30gdjprZZn9RogsEyMj2+0nnCfDMG6MCDd8vUk//sx+d72NbbD/bOU/Qukhj/SuH
         Vp2NHkiQU6qr2jwAgXniJN+kcMT1vNXUvJ0E3a9JA5rRvjCv5Qfi0q8QOmlg680yvNC+
         lppw==
X-Gm-Message-State: APjAAAUpPeoaAeVjuOhWh6oy68EEBWQaXkK6tYpkvABvq8po/B4A+jn7
        XTsM+bKaLhPsxIeU4Fja/9u7fQ1kQUmtBt0i+krA1Q==
X-Google-Smtp-Source: APXvYqzg2IjJpUJv7Oc9XxacrOBeMKvYZMxzbtRcNRaccyHw1L7vBYcvCvlbRGK54j//hFmYexJmqA8Zwi+Vc4sFHeU=
X-Received: by 2002:a9d:6a88:: with SMTP id l8mr24365746otq.260.1554821370037;
 Tue, 09 Apr 2019 07:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440492988.3190322.4475460421334178449.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190409121318.GA16955@infradead.org>
In-Reply-To: <20190409121318.GA16955@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Apr 2019 07:49:18 -0700
Message-ID: <CAPcyv4h3M7fGtdWt_dUVGkp1A2VZjR98wg0xAzipVccYZuChqg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] acpi/hmat: Register special purpose memory as a device
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 5:13 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 04, 2019 at 12:08:49PM -0700, Dan Williams wrote:
> > Memory that has been tagged EFI_SPECIAL_PURPOSE, and has performance
> > properties described by the ACPI HMAT is expected to have an application
> > specific consumer.
> >
> > Those consumers may want 100% of the memory capacity to be reserved from
> > any usage by the kernel. By default, with this enabling, a platform
> > device is created to represent this differentiated resource.
>
> This sounds more than weird.  Since when did we let the firmware decide
> who can use the memory?

There's 2 related motivations for playing along with this "special
purpose" attribute. Before this bit we've seen gross hacks in platform
firmware trying to game OS behavior by lying about numa distances in
the ACPI SLIT. For example "near" high bandwidth memory being set at a
large distance to prevent the kernel from allocating from it by
default as much as possible. Secondly, allow niche applications
guarantees about being able to claim all of a given designated
resource.

The above comes with the option to override this default reservation
and just turn it back over to the page allocator i.e. ignore the
platform firmware hint.

The alternative is arranging for "special purpose" memory to be given
to the page allocator by default with the hope that it can be reserved
/ claimed early so the administrator can prevent unwanted allocations.
It just seemed overall easier to "default reserve with the option to
hot-add" instead of "default online with option / hope of hot-remove
or early allocation".
