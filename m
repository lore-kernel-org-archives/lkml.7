Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7D0217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866681;
	bh=VHy8EvzmBfDHc2PVoi7BpmHln7Id7Wj/dWKhpyavLXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sJYqADSvQQOeQElOK2zOmN8rqlrhD2224N9crwLckKkfBDRYR/+lZjQnWNgT2F94v
	 ygp5bPWE3eBG48DWSKJwqr251YVn3idmkLz0whrOLTvLpTHr8/Hp0o5brEn0mvzhrS
	 TYY91qDc2FgQZEP7yFyN5AOuD+Z5EpNRFqdibAtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfC2NiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbfC2Nh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:37:59 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E8692183F;
        Fri, 29 Mar 2019 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866678;
        bh=VHy8EvzmBfDHc2PVoi7BpmHln7Id7Wj/dWKhpyavLXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CArabNBdtYFjvXf9BXrtuZdZx6AW4e+3piOGbX5ByLYsuGL1sEbOiJnMPcyXSxMMx
         c0rP5bGgqWxW+4kqlSdMScge0ksK5YpSsWdD5Z84T5I4RpsjvQFkJN4t93vrQzkVlz
         iQt6icMA1orXhH45XGoOBEAJPH1leW3K74uzArvI=
Received: by mail-qk1-f182.google.com with SMTP id s81so1308859qke.13;
        Fri, 29 Mar 2019 06:37:58 -0700 (PDT)
X-Gm-Message-State: APjAAAW7EwoeiDhkLYyNUWt/bDTQQV+MD1dBr3IdYfLL5hMP/lcejuwZ
        /DruA78okbF7fEBsbH8Mz3yBH9NVtKqo4Hk5+g==
X-Google-Smtp-Source: APXvYqxZuBkGdT78a0trPhxj7QlVTaMQ9tiJMMDcoEGiwKFZSukFyjlJol6B1QVS+S4cDhsc2eWoTImkVDBeQWGuUnk=
X-Received: by 2002:a37:6748:: with SMTP id b69mr39230758qkc.79.1553866677736;
 Fri, 29 Mar 2019 06:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190327212155.80730-1-venture@google.com> <20190328165009.GA25705@bogus>
 <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com>
In-Reply-To: <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 Mar 2019 08:37:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSvzOQbJSgz7z2wZj9-z=bfhzF_C+662Gnf68TgAPFaA@mail.gmail.com>
Message-ID: <CAL_JsqJSvzOQbJSgz7z2wZj9-z=bfhzF_C+662Gnf68TgAPFaA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Patrick Venture <venture@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:03 PM Patrick Venture <venture@google.com> wrote:
>
> On Thu, Mar 28, 2019 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> > > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> > >
> > > Signed-off-by: Patrick Venture <venture@google.com>
> > > ---
> > > Changes for v8:
> > > - None
> > > Changes for v7:
> > > - Moved node under the syscon node it requires
> > > Changes for v6:
> > > - None
> > > Changes for v5:
> > > - None
> > > Changes for v4:
> > > - None
> > > Changes for v3:
> > > - None
> > > Changes for v2:
> > > - Added comment about syscon required parameter.
> > > ---
> > >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > >
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
>
> Adding tags in this case is adding a change version?  I was doing this
> to keep the two patches version-synced.  I thought that was required.
> There was a version change in the other patch in this set.

Adding tags is not considered a change. I gave a Reviewed-by in v7.
Subsequent versions should carry that tag if there's no change (or
only minor changes) in this patch. What happens in the other patches
is not really important. Maintainers are not going to go searching
thru the versions to find all the ack/review tags. And if I've already
reviewed this, I don't want to look at it again.

Rob
