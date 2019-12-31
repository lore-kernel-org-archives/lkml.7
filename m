Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4553AC2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 07:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B01B20718
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577779118;
	bh=fl8RoGLJ0Bkf3yCH1QLnzjV3P/tl6iQW6a0+tUPE/Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iASniwah96YH60J7QP5pZEpWUXW/Vk1tpmoS3YiNDc3nUfKMjf4WT9XLewbvRE4e/
	 Qq4EHWUfme04Z4EE72yciVvR55XbTt96P7j+C4cKLm2cT49K99FafTJCyW0DCuxdgC
	 7WenEVzaYV3Ail2VO33RKDoy1LKViKjIe/SFzQr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLaH6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 02:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfLaH6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 02:58:37 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A91206D9;
        Tue, 31 Dec 2019 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577779116;
        bh=fl8RoGLJ0Bkf3yCH1QLnzjV3P/tl6iQW6a0+tUPE/Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NrjhCO77dz/ZYeJPLhPRQi/8p/IolRtyGUUXMnbC3Ue1/q1iQ3X311qRgzcRO0qAK
         p0AntSL+ok3jBooT/+g2eQn1mpETDdJjC3pitQRlWXJ+7Y1YE3SV6D3KC1Sj8Df6Ax
         MSF9REoZjsKqmxuE+nzuAMwCGNVlzmle234SV1eg=
Date:   Tue, 31 Dec 2019 09:00:02 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20191231080002.efq3yeomzktepegk@hendrix.lan>
References: <20191222204507.32413-1-sravanhome@gmail.com>
 <20191222204507.32413-3-sravanhome@gmail.com>
 <20191223105028.amtzf62yjdpdsfrt@hendrix.home>
 <ec7d8937-724e-946c-0569-da685223d21d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec7d8937-724e-946c-0569-da685223d21d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 11:23:36PM +0100, saravanan sekar wrote:
> > > +  mps,inc-off-time:
> > > +     description: |
> > > +        mutually exclusive to mps,fixed-off-time an array of 8, linearly increase
> > > +        output delay during power off sequence based on factor of time slot/interval
> > > +        for each regulator.
> > > +     allOf:
> > > +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> > > +       - minimum: 0
> > > +       - maximum: 15
> > > +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
> > You should check the size of the array too, but if it's a property of
> > the regulators, why not have it in the regulators node?
>
> the node regulators & sub-node of regulators are parsed (initdata) by
> regulator framework during regulator registration,
> so it would be redundant parsing all the node if mentioned under each
> regulator node and this is optional. If you still not
> convinced I will change.

It's not really redundant, since the regulator framework will ignore
whatever custom property you would put there, and your driver would
ignore any generic property in those nodes.

> > > +  regulators:
> > > +    type: object
> > > +    description:
> > > +      list of regulators provided by this controller, must be named
> > > +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
> > > +      The valid names for regulators are
> > > +      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5
> > For the third times now, the names should be validated using
> > propertyNames.
>
> Not sure did I understand your question correctly.
> all the node name under regulators node are parsed by regulator
> framework & validated against
> name in regulator descriptors.

Yes, and the point of the bindings in YAML is to make sure all the
constraints we might have can be catched at compilation / validation
time.

The names of the nodes are a constraint, and propertyNames allows you
to express it.

Maxime
