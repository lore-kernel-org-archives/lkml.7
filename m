Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B4C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC322077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575487602;
	bh=ktCkSMc3xOFusPlzOBLfyD+iztBQ46wxjl+lXy3N1Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y9MKATQUcQGoepvl0jBKrMB4jFY4xsKDlscYbng4J3/bNHZCc1fytA2RoFWJVDUUK
	 aYVejNEmk/96h8qYO3qn12kNNmZxdIJmz/FY9B52rE3Di3PcESOwTCYe8haPCCf24w
	 aazLJxsG6+KJd7wdNIzGJhl3lNeb39bbQk3PRrHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfLDT0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:26:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35783 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfLDT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:26:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id k196so360121oib.2;
        Wed, 04 Dec 2019 11:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEYmt+88G565IC6LTTQd0m6TuuMzboUhXwXWSfb6lpw=;
        b=Ds/6mX4b/TCRm55MXxF1S/v3hcAl6FGwQXgkCwnJTUrvQdxKHLhCs2fScgbXL07+QO
         qSUADZWJLlZwujUv7/qKjDoAV3w1XB63eB3peNqCvB7sqOEGGBJJuOpV3KwoerQH9pML
         OuJI7BsdV4kHJ6DS8MmByYt0eWd5e4uE++OQvrcBpsNl1m8+O5GYSeqlZn7fhJ6MCo20
         QrBSb4gERhlCiEKlEwu3Az4qZdi+QNqSKnBCuLtaUQx+7+1MTc8rPWOWjrOQjjeHt11S
         CX+B1DqqaA7PmbnudA8kpIbW+fETdTdYOj9GTrhV7DQikx6oNXJKwf6xG+LIM+lJj4xI
         lUQg==
X-Gm-Message-State: APjAAAXkLK99oA4lGiLVQh7Jtc05hT5KlRp3EaZWnSnavevCV+2ygFhY
        jIIylvtAEkOmEHqjf5kkmQ==
X-Google-Smtp-Source: APXvYqz/iitGqmzi/IbQOgpS92w6HiwU32hDyJqwif2rbQwBLEuTPwfH9acMxZSOQ/FyuvEcqo7jGw==
X-Received: by 2002:aca:7583:: with SMTP id q125mr4218753oic.100.1575487600190;
        Wed, 04 Dec 2019 11:26:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i25sm2499520oto.72.2019.12.04.11.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:26:39 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:26:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kevin.tang@unisoc.com, baolin.wang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: syscon: Add syscon-names to refer to
 syscon easily
Message-ID: <20191204192639.GA15786@bogus>
References: <20191120154148.22067-1-orson.zhai@unisoc.com>
 <20191120154148.22067-2-orson.zhai@unisoc.com>
 <20191204163830.GA25135@bogus>
 <CAK8P3a3_r6z6Qk133=4gUzJ0rYmMH7sDDqpEF8ZVXS_bc3OtkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_r6z6Qk133=4gUzJ0rYmMH7sDDqpEF8ZVXS_bc3OtkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 06:00:17PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 4, 2019 at 5:38 PM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Nov 20, 2019 at 11:41:47PM +0800, Orson Zhai wrote:
> > > Make life easier when syscon consumer want to access multiple syscon
> > > nodes with dozens of items.
> > > Add syscon-names and relative properties to help to manage different
> > > cases when accessing more than one syscon node even with arguments.
> > >
> > > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > > ---
> > >  .../devicetree/bindings/mfd/syscon.txt        | 43 +++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> > > index 25d9e9c2fd53..4c7bdb74bb0a 100644
> > > --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> > > @@ -30,3 +30,46 @@ hwlock1: hwspinlock@40500000 {
> > >         reg = <0x40500000 0x1000>;
> > >         #hwlock-cells = <1>;
> > >  };
> > > +
> > > +
> > > +
> > > +==Syscon Name==
> > > +
> > > +Syscon name is a helper to be used in consumer nodes who refer to system
> > > +controller node. It provides a way to refer to syscon node by names with
> > > +phandle args in syscon consumer node. It will help people who have a lot
> > > +of syscon references to be managed. It is not a must feature and has no
> > > +effect to syscon node itself at all.
> > > +
> > > +Required properties:
> > > +- syscons: List of phandles and any number of arguments if needed. Arguments
> > > +  is specific to differnet vendors and its usage should be described at each
> > > +  vendor's bindings. For example: In Unisoc SoCs, the 1st arg will be treated
> > > +  as register address offset and the 2nd is bit mask.
> > > +
> > > +- syscon-names:        List of syscon node name strings sorted in the same order as
> > > +  what it represents in property syscons.
> > > +
> > > +Optional property:
> > > +- #.*-cells: Represents the number of arguments in single phandle in syscons
> > > +  list. ".*" is vendor specific. If this property is not set, default value
> > > +  will be 0.
> >
> > This breaks the normal pattern of how '#.*-cells' works. While Arnd
> > suggests removing it, I don't think that works well either with having a
> > generic 'syscons' property. That means every syscon in a system has to
> > have the same number of cells.
> >
> > I don't really want to see syscon binding expanded. Really, I'd like
> > 'syscon' to go away. It's nothing more than a flag to create a regmap.
> 
> Not expanding the syscon binding is the point about not having a #*-cells:
> In the examples that Orson listed, the cell count would always be
> specific to the user of the syscon regmap, and not interpreted by the
> syscon itself.
> 
> > I think it is better to keep the property names specific to exactly what
> > the functionality is for each syscon phandle rather than a generic
> > binding.
> >
> > What are the eamples of where you want to use this?
> 
> I think generally speaking this would be useful for random registers that
> logically belong to one device but are grouped with other unrelated
> registers in a syscon, and that are in a different register offset for
> each chip that has them. Using named properties instead of a list
> of phandle/arg tuples with names is clearly a simpler alternative
> and more like we do it today, but I can also see some API simplification
> with Orson's patch without the binding getting out of hand.

I understand when a phandle to a syscon is used. That's nothing new. 
What's special about Unisoc SoC that needs something new/different? 
I saw there's a large number of syscons, but I don't understand what's 
in them. 

If the API is this:

struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,                                                    
                                       const char *name,
                                       int arg_count, __u32 *out_args)

How is 'name' being an entry in syscon-names simpler than just being the 
property name? The implementation for the latter would certainly be 
simpler.

It also makes the property unparseable without knowledge outside of the 
DT (i.e. in the driver). I suppose if the number of cells for each entry 
is fixed, we could count the number of syscon-names entries to figure 
out the stride. But then if one entry needs a lot of cells, then they 
all have to have padding cells.

Rob
