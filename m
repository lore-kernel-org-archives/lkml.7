Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06372C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DE22084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RElZAQT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfDJGem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:34:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36573 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfDJGem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:34:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id o74so938899ota.3;
        Tue, 09 Apr 2019 23:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTrLyLlaDKBqAijWQkRUpLg7AhqK/JuOtTbkg1ntkuY=;
        b=RElZAQT619E57z3EGNolDzfrnhppg7ibohJ/8iv+e8ef3CcmgeNsP1fLvWwhPilQfa
         jXhG+Etor+UqVP5CAXF2bMyMpKAh/uFWQm5neAEvcnM9KL+X0w1FLZmvugLNuYNistA+
         zTftTCx0TEG/j7jwpnQ7osnhwWN1tneFLCT0V9+t1OuPFF5PO+RvsnOgvR0KY4o+zafn
         OhxyQ95x4scmkzsnuSaZCxauIvvc/UG2cIA/TFmhm81HmMfQHHFYs8nWh5FQLmcuTX9A
         pYfZz22uLkn+F7Lb2KmgyQi9eCWFEayCqp+TFzMXE4ynfMJuyX2O/syKhTJH/6i/mcjd
         WCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTrLyLlaDKBqAijWQkRUpLg7AhqK/JuOtTbkg1ntkuY=;
        b=h/kUE3PH+sO3vjZkdwfkvqkGw11Qsf2vh8gDGbsY0KjJ4FQcGo1TJN8+JmyG4dfaox
         1dfsOxF9zVmShbOV3nA5rz/gRitnsSVZfFhe4tmdMntZa+WUp/u/ZechLMNeeF53X84L
         K2p9NcVvMH6v/PMSVBeneNblLNRPswzT4p494rwwYQDKwM7aoAHzNdhkk4W26617cdN0
         klps3xdIV5AZaAeQkHGhom1H0xO7q/A62JkyF3pUh/4zOvSYEydKPS0j/eMgvYca4sAW
         LU65ushv0vsJVrNnyPD5F8SsPyPhRE90LtoR9/MV0L1wWBSzRxVLhmYr5HZtfMhHgnmA
         7sHQ==
X-Gm-Message-State: APjAAAXJCTKNDcoxsPaWvYemogFqK2NN5Xw2nalSOX0ghJwIKvkUQujF
        awDUeaWBmXMWJA9btP97WbJMM/8qJX8s0nYR83Q=
X-Google-Smtp-Source: APXvYqzwV6iyh3gH08iBXRqwNLpmPd4f1ucjhCsr02qviYmpVwWpj47FQTZwt0xxx0oXaMGcXN0vGljfDPqbIOcfjRA=
X-Received: by 2002:a05:6830:1654:: with SMTP id h20mr27331654otr.149.1554878081537;
 Tue, 09 Apr 2019 23:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190408130212.0a41f2a8@canb.auug.org.au> <20190408091458.00004e48@huawei.com>
 <20190408100121.GH9224@smile.fi.intel.com> <20190408111439.000049bc@huawei.com>
 <20190408103437.GK9224@smile.fi.intel.com> <20190408130151.0000278a@huawei.com>
 <20190409153942.GW9224@smile.fi.intel.com>
In-Reply-To: <20190409153942.GW9224@smile.fi.intel.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 10 Apr 2019 09:34:29 +0300
Message-ID: <CA+U=Dsrum6cop7OJrwP6EiEggkkBhfigy4oB8Fw1KREyHcjHZw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 6:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 08, 2019 at 01:01:51PM +0100, Jonathan Cameron wrote:
> > On Mon, 8 Apr 2019 13:34:37 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Apr 08, 2019 at 11:14:39AM +0100, Jonathan Cameron wrote:
> > > > On Mon, 8 Apr 2019 13:01:21 +0300
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Mon, Apr 08, 2019 at 09:14:58AM +0100, Jonathan Cameron wrote:
> > > > > > On Mon, 8 Apr 2019 13:02:12 +1000
> > > > > > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > > > > > That is the correct resolution.
> > > > >
> > > > > I think it still misses the following fix:
> > >
> > > > Is that actually a problem given it's copied over from buffer->scan_mask just after allocation?
> > > > The two masks are the same length so I don't think we have a problem with this one.
> > > > Am I missing something?
> > >
> > > Hmm... I didn't get why the commit 20ea39ef9f2f fixes anything.
> > >
> > Good point.  I'm don't think it ever did.
> >
> > Alex, any thoughts?
>

Hey,

This seems to have been in the context of our tree.
We have this patch:
https://github.com/analogdevicesinc/linux/commit/81d00795b1537

That removes bitmap_copy() .
See here:
https://github.com/analogdevicesinc/linux/commit/81d00795b1537#diff-0a87744ce945d2c1c89ea19f21fb35bbL397

This change is not upstreamed yet.
I guess I am slowly going nuts with trying to sync multiple trees [
our master, upstream IIO & some internal temp-branches ].

To give a bit of background: we've noticed this weird behavior while
testing a AD7193 chip with the AD7192 driver and some weird things
were happening.
At the time, this patch seemed easy to send upstream, so I sent it.

Sorry for the noise.

I guess the conclusion is, that in the context of the mainline IIO
tree, commit 20ea39ef9f2f is not needed.

Thanks
Alex

> I have a thought that it might be possible that somewhere code is still broken,
> i.e. accessing bitmap behind the size (for example, iterating by unsigned long
> without bitmap size being aligned to size of unsigned long).
>
> If this is a case, the mentioned patch has a symptomatic healing and not fixing
> a root cause.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
