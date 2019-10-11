Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB39C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A28721D82
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570809088;
	bh=SM20gL8UFJmurgt+rjdFQn95j4Z+zNSNXhK250EJoPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lErSjt8ZF6TWqK+0ewTpD1Wib8SIvp4KuCoH2nl1psRMHaaYEAzSbHXaqgkSAWsPy
	 zHxAf3KwQeeaU0TkmFDJw+cm3epTsPC12SYvjyYiDMUIyG6o6qeaJ61x7r1WmnKsnr
	 WPtsCJmKyWyGKROiqRng+3/ARhc2uSnyEdwmSEfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfJKPv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:51:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34045 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfJKPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:51:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id m19so8384187otp.1;
        Fri, 11 Oct 2019 08:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/QLZGzKlqPXEYz4XBHb6fc2z++j0NNAuKvWxwrnWJg=;
        b=ec9NzZUpmc0uLkvW1tOSgjCPKMLt9xvqzSaW1wdr6BXn1pXtR5/MfGNBTCiIb/Awjq
         F/4vQAqh3GMKlZGW7TGvI09CAj7uGcMwHuMUKREdqY88KZa2GTBgWc2NVsYOsVhsRl/W
         UaD+F/y5Luf70XKJjZUz5Q5cAJyG5iK0ZOkL5U8aFbDpCLlaX0rZiLZny1h99JK2SbSu
         xsOrXdl82GZL8v4JQIsFY4arKf0ElW+4c42JGtnc8eyjlW3jdTJtqk2Okn+EG/xe+YR4
         Iqwr6HHancxMvJGCttYL2MdyZLqmVtcqc12DBljO7k0smR3zqFMyFlRpkvYQzhF4acRW
         LVAw==
X-Gm-Message-State: APjAAAUsW6M5ba/q6+yZ6jMQC7MZNKT1tNCtXAkOIUFIx7l3KWqL3g5e
        ymM5DxACq0NwOPLPnbzIeA==
X-Google-Smtp-Source: APXvYqzMiRb5PqzKa+7EMBkhL+RYTJ4w67wtnTkU2oNcHr3BX8SzjO7iCTP7LdvIaXqRtBxNK69+Rg==
X-Received: by 2002:a9d:7844:: with SMTP id c4mr9137267otm.273.1570809085207;
        Fri, 11 Oct 2019 08:51:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm2625595oiz.3.2019.10.11.08.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:51:24 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:51:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu Chen <chenyu56@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RFC][PATCH v2 4/5] dt-bindings: usb: dwc3: of-simple: add
 compatible for HiSi
Message-ID: <20191011155123.GA14272@bogus>
References: <20191007175553.66940-1-john.stultz@linaro.org>
 <20191007175553.66940-5-john.stultz@linaro.org>
 <CAL_JsqJLY2n7hfneNptAGswVZtGm3vJbSR6W2wUG+ZTzMN8wZA@mail.gmail.com>
 <CALAqxLWB7Vd-H70LLLSW0Fv=_4-saQ9CE2k3-L_43E+F8mLj2w@mail.gmail.com>
 <CAL_JsqJ9uUtqTDEkLi86-BCvW+wM6Pgz_K+JuTsuOqHfFOHStA@mail.gmail.com>
 <CALAqxLVpPvHf2RpwjHh5v9cnQm9CLtj0HHaqVH=EFQJk-GhaPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLVpPvHf2RpwjHh5v9cnQm9CLtj0HHaqVH=EFQJk-GhaPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:00:24PM -0700, John Stultz wrote:
> On Mon, Oct 7, 2019 at 2:11 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Oct 7, 2019 at 2:07 PM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > On Mon, Oct 7, 2019 at 11:38 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 7, 2019 at 12:56 PM John Stultz <john.stultz@linaro.org> wrote:
> > > > >
> > > > > Add necessary compatible flag for HiSi's DWC3 so
> > > > > dwc3-of-simple will probe.
> > > > >
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Felipe Balbi <balbi@kernel.org>
> > > > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: Yu Chen <chenyu56@huawei.com>
> > > > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > > > Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > Cc: linux-usb@vger.kernel.org
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > > > ---
> > > > > v2: Tweaked clock names as clk_usb3phy_ref didn't seem right.
> > > > > ---
> > > > >  .../devicetree/bindings/usb/hisi,dwc3.txt     | 52 +++++++++++++++++++
> > > > >  1 file changed, 52 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > > >
> > > > Can you make this a schema.
> > >
> > > Sorry, I'm not sure exactly what you're asking. I'm guessing from
> > > grepping around you want the bindings in yaml instead (I see a few
> > > examples)?
> >
> > Yes.
> >
> > > Is there some pointer to documentation? The
> > > Documentation/devicetree/bindings/writing-bindings.txt file doesn't
> > > seem to say much on it.
> >
> > You mean Documentation/devicetree/writing-schemas.rst? There's that
> > and Documentation/devicetree/bindings/example-schema.yaml which has a
> > bunch of annotations on what each part means.
> 
> Ah! Sorry for missing that. Thanks for the pointer, though I may get
> away with dropping this one.
> 
> > > > If it's only clocks and resets for the wrapper node, just make this
> > > > all one node.
> > >
> > > Just to make sure I'm following, you're suggesting I put all the
> > > clocks/resets in the dwc3 node (renamed to usb for the node name) and
> > > not add the wrapper?
> >
> > Yes.
> >
> > > I'll have to see if that's possible. The generic dwc3 binding wants 3
> > > clocks, but I only have two in the code I've worked with (similarly it
> > > seems to only want two resets, not 4) so I'll have to see if I can
> > > figure out how to adapt that.
> >
> > Possible since commit fe8abf332b8f ("usb: dwc3: support clocks and
> > resets for DWC3 core").
> 
> Ok. It *seems* like I can get it working with the existing binding
> then. There's a little funkiness with the core expecting three clocks
> while I only have two (currently I'm duplicating the "bus_early" clk
> for "suspend". Is there a preferred way to do this sort of hack?), and
> I'm a little worried that only the first reset is being used (instead
> of the 4 specified), but it seems to work so far.

I would assume that you simply don't know how the 'suspend' clock is 
connected rather than you don't have one. But that's maybe not a 
problem you can fix.

I would make dwc3 use devm_clk_bulk_get_all and allow for less than 3 
clocks. And do a similar change for resets.


> I still suspect the dwc3-of-simple.c method might be better since it
> can handle arbitrary sets of clks and resets instead of the fixed 3 &
> 1 in the dwc3.txt binding.
> But if I can get away without having to add an extra binding here, I'd
> be happier.

Me too.

Rob
