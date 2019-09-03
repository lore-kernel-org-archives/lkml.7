Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B2023431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfICOMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICOMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:12:22 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C18888306
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 14:12:22 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id 91so19072770qtf.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B2BfNzrm+hR7i1mNls3IhAz7GlKTxZk9pYPgMdNVli0=;
        b=OAkBlASR7HAFosydcHoXUyWHAF9WLnornvUM9Pe+gBRWqFnD7V/j8SLltC8v+6lI3A
         lRWqpFoN/Gmz04eLbQRO5dFqmzb4fTgqF6ghbotFPt04rLGND9zyiiDvp1ecdpdqDRSw
         L7HASAmdB4ty3moNmg68TKd2xVptZjkGRGMDVbsH//4ranZBsCd9V9AbAj6sLIogtN5e
         uSIhJbYbsM1YXrT6+Iv3eB3K8osed7nbtgQbvsET7ZIPz9J/n++LikOre7ndnenXL4VY
         vPQn5HIQMXnAc3EJyrWCQog2AVLQRLpraH8u4PfyLAgz8juGhndJrGxVVNM++zPJz2Zu
         1XFg==
X-Gm-Message-State: APjAAAUopbkDdycRzH/nDpaJmJHpPKvLFqcd/IJKYXzkhrmSSZ6Wkie1
        fOIEaRJcdlI7dJ6Oh2qQMq3UQEFWSatKN4KGhMPjY5WA/FKOm+QcMlIRouZjiBxSuwDems6/fmY
        mObyuF/sCddTQIgt36MdqBwkP
X-Received: by 2002:ac8:19c7:: with SMTP id s7mr23669445qtk.392.1567519941737;
        Tue, 03 Sep 2019 07:12:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZD7QC/GbljRGHZ9kQkhQ8TANJQbERaI507U8NcnTvw54YKl5HRSRH5iHvxe2JtdirsGcbnA==
X-Received: by 2002:ac8:19c7:: with SMTP id s7mr23669437qtk.392.1567519941605;
        Tue, 03 Sep 2019 07:12:21 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id b123sm8764984qkf.85.2019.09.03.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:12:20 -0700 (PDT)
Date:   Tue, 3 Sep 2019 10:12:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190903101001-mutt-send-email-mst@kernel.org>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
 <20190903041507-mutt-send-email-mst@kernel.org>
 <20190903140752.GA10983@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903140752.GA10983@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:07:52AM -0400, Vivek Goyal wrote:
> On Tue, Sep 03, 2019 at 04:31:38AM -0400, Michael S. Tsirkin wrote:
> 
> [..]
> > +	/* TODO lock */
> > give me pause.
> > 
> > Cleanup generally seems broken to me - what pauses the FS
> 
> I am looking into device removal aspect of it now. Thinking of adding
> a reference count to virtiofs device and possibly also a bit flag to
> indicate if device is still alive. That way, we should be able to cleanup
> device more gracefully.

Generally, the way to cleanup things is to first disconnect device from
linux so linux won't send new requests, wait for old ones to finish.




> > 
> > What about the rest of TODOs in that file?
> 
> I will also take a closer look at TODOs now. Better device cleanup path
> might get rid of some of them. Some of them might not be valid anymore.
> 
> > 
> > use of usleep is hacky - can't we do better e.g. with a
> > completion?
> 
> Agreed.
> 
> Thanks
> Vivek
