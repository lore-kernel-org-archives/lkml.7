Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A7CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8E620856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572442176;
	bh=igiX650YpjR8H3mGZ/ALPmIk+Lrkf/kUdT1CdvytKdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tWPQB/Q4hLTKAgUih4d+CidJWGwMJLJ4JnM25OUYrtxu6uv5n1grbJBFM0PXp547y
	 H0aSTvpRhHSYq2IRFKtP6/maVpVMGEgiiX+JlkqkhyHaLrFeFh22ZqE/GaWCKdjaSV
	 ueIpoV+6EIzyNj6bZl95gGdkLQUYiqPjnK5aS18s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfJ3N3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:29:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44702 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJ3N3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:29:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id n48so2055016ota.11;
        Wed, 30 Oct 2019 06:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2PIp3nuujjbVDTCQlERuQPPmNS4hMz6vAUUQvwn05Tc=;
        b=HCru8Ej2p19n/vaYXq0Vuji5lWKCNrkqKpiBpfQ+0eQJ+UNkYiN0kCMRhYPXBsOV44
         LF/HfHmdCwHFLkHSf7OOPvHN/VX4g4IZZiYiMF2uzcFGq5nP3uXWjiI+YGfZ6NvFWtp1
         guA8AYHYihnaXhbuMKuXiaPl+8z3Ow9GIvBEYedo/sW4wvId3dtqiOIFh7fvZBz0pdMm
         isdPwWD/Llz39wfX9KKX/mtomWoNi9jTyjJEZOcYVn3E9c4pG2lMsbxzuI+6yjosh5+r
         lFis5fL7IGMSKLgNQD23g/gYx3nfIBz17JkvCA+hed/FDO6Tz4a8qowpwswTS9Q7goay
         ZEWQ==
X-Gm-Message-State: APjAAAXe2PLU20K+ZKZ1dJm9uCZVqUrr+Zp57UAxBnKPHnXWlaD2ionr
        BpO2iz0YQLnW7q3x/tAJ6g==
X-Google-Smtp-Source: APXvYqxZ/cduY/57uFpVQbDA+dzUHNgNL7l4CUKcqiu/GlyrSfqJ4CfvFx7pOS+ityjeM2CS6IH5vA==
X-Received: by 2002:a05:6830:1e65:: with SMTP id m5mr13647806otr.41.1572442173786;
        Wed, 30 Oct 2019 06:29:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u1sm9804oie.37.2019.10.30.06.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 06:29:33 -0700 (PDT)
Date:   Wed, 30 Oct 2019 08:29:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Rob Herring <rob.e.herring@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC][PATCH 1/3] dt-bindings: dma-buf: heaps: Describe CMA
 regions to be added to dmabuf heaps interface.
Message-ID: <20191030132932.GA7292@bogus>
References: <20191025225009.50305-1-john.stultz@linaro.org>
 <20191025225009.50305-2-john.stultz@linaro.org>
 <CAC=3eda3sCMjCQbFX2Y0-6iVt-YRR7P_Y1ksJOsLw9CmJJRxbA@mail.gmail.com>
 <CALAqxLXG8LrWAQevEyj7BJ00CiAkodfgFMdCbuMRucO5w5yhKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXG8LrWAQevEyj7BJ00CiAkodfgFMdCbuMRucO5w5yhKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 04:55:35PM -0700, John Stultz wrote:
> On Fri, Oct 25, 2019 at 4:32 PM Rob Herring <rob.e.herring@gmail.com> wrote:
> >
> > On Fri, Oct 25, 2019 at 5:51 PM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > This binding specifies which CMA regions should be added to the
> > > dmabuf heaps interface.
> >
> > Is this an ION DT binding in disguise? I thought I killed that. ;)
> 
> Maybe? I may not have been paying attention back then.  :)
> 
> > > +Example:
> > > +This example has a camera CMA node in reserved memory, which is then
> > > +referenced by the dmabuf-heap-cma node.
> > > +
> > > +
> > > +       reserved-memory {
> > > +               #address-cells = <2>;
> > > +               #size-cells = <2>;
> > > +               ranges;
> > > +               ...
> > > +               cma_camera: cma-camera {
> > > +                       compatible = "shared-dma-pool";
> > > +                       reg = <0x0 0x24C00000 0x0 0x4000000>;
> > > +                       reusable;
> > > +               };
> > > +               ...
> > > +       };
> > > +
> > > +       cma_heap {
> > > +               compatible = "dmabuf-heap-cma";
> > > +               memory-region = <&cma_camera>;
> >
> > Why the indirection here? Can't you just add a flag property to
> > reserved-memory nodes like we do to flag CMA nodes?
> 
> Happy to try. Do you mean like with the "reuasable" tag?  Or more like
> the "linux,cma-default" tag?

Probably like "linux,cma-default" as it is a hint for who to manage it 
rather than a characteristic of the region.
 
> Do you have a preference for the flag name here?

Not really.


> > As I suspected, it's because in patch 2 you're just abusing DT to
> > instantiate platform devices. We already support binding drivers to
> > reserved-memory nodes directly.
> 
> Sorry, one of those "when all you know how to do is hammer, everything
> looks like a nail" issues.
> Is there a specific example for binding drivers to reserved-memory
> nodes I can try to follow?

ramoops and I think there's a QCom driver.

Rob
