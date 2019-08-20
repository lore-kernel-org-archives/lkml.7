Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C5BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86875214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZwsAQPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfHTQGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:06:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfHTQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:06:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so3518042pgn.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YRs056YLcytSz/lcO+02IvGDxxc6td9XPBdc4gsyYAA=;
        b=IZwsAQPMaGfjir+i5wyMopDfSahsdLLbIG4M5qW3lPXUt8ZvDZ12aXqjHRdxxcJVJo
         3xTqpA4xV5p8ffOQ5vGphhzOyMAFFXXhYAibizmbrSDbNoIKaUHrm1oL6fomE55poTIB
         f9UvaFnq09P/l9L/ekZZE+aUvjkKM/fuN7qkDmwv0hzXvs/PonBQKr/Bqg6fnWKSizOP
         mESE5AH4jEiQn98hxJ8m4eBXwWApQRsTlyQW8NRhWCBcVv1NBZuYrrXJxMUhrLs7C266
         OhlKJrqxjeqLBN8ifArRe1bNaYfywbN23eq/xHnkNeWv2vQ4DsXjtZWp/ppyTLPJ7hLZ
         7YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YRs056YLcytSz/lcO+02IvGDxxc6td9XPBdc4gsyYAA=;
        b=MSt1K/sRijy4nRt3O954+Gh1XIJx/eUa/lQDt5zuKt1oGUqdXYTzh76HTs9g31f3N3
         7+IIJO8QUB3wIsZSW72dbCo6/8H2U90R/Z673MS4mQOxuMX4kRRK9CCFbeWJiG/f3utV
         6gzdgsrH/6LNlhinwcLwqsfASuqSkTS3uBRIpP7YxFmTwJhWj98D+cbOmDiRFdaCIvNv
         HbKqezUUKVDk3zoGxmFk8uOD7ESXAeFvaL/zHrEOFZ9F3VzO00AKMUNy0X7DMnACmBfX
         Tf01niSGol7YvAH/cxDLxiFTlnF8Ij7D26d5fiyC+jU2hWPM7WPeifYOw6k7lWD9kOmh
         v6kQ==
X-Gm-Message-State: APjAAAU9oyvo+0shPgnOT0M0w2hkKfSHiKSIRA8PzB17QVmvCz/FHGpO
        a8SpXMguL51Y0GztxLgvi9fq
X-Google-Smtp-Source: APXvYqwHifgRXXVR3SKFbiTSLt/P72Jdqu1N9xCJpAmYOMEfgiMIhGYa3U4Js8e4uNnZMrXcZFrRaA==
X-Received: by 2002:a17:90a:8591:: with SMTP id m17mr769569pjn.100.1566317208487;
        Tue, 20 Aug 2019 09:06:48 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:0:ec1e:e8be:e0af:4cab:a3be])
        by smtp.gmail.com with ESMTPSA id e2sm20786541pff.49.2019.08.20.09.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 09:06:47 -0700 (PDT)
Date:   Tue, 20 Aug 2019 21:36:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
Message-ID: <20190820160641.GA9262@Mani-XPS-13-9360>
References: <20190517153223.7650-1-robh@kernel.org>
 <20190613224435.GA32572@bogus>
 <20190614170450.GA29654@Mani-XPS-13-9360>
 <5946467c-7674-de2b-a657-627cf3be42df@suse.de>
 <CAL_JsqJoQDkqZO_4XdaQymVW0cJDXVmAPh3uieRkBjoUXeWE1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJoQDkqZO_4XdaQymVW0cJDXVmAPh3uieRkBjoUXeWE1w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:33:47PM -0600, Rob Herring wrote:
> On Fri, Jun 14, 2019 at 11:07 AM Andreas Färber <afaerber@suse.de> wrote:
> >
> > Am 14.06.19 um 19:04 schrieb Manivannan Sadhasivam:
> > > On Thu, Jun 13, 2019 at 04:44:35PM -0600, Rob Herring wrote:
> > >> On Fri, May 17, 2019 at 10:32:23AM -0500, Rob Herring wrote:
> > >>> Convert Actions Semi SoC bindings to DT schema format using json-schema.
> > >>>
> > >>> Cc: "Andreas Färber" <afaerber@suse.de>
> > >>> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >>> Cc: Mark Rutland <mark.rutland@arm.com>
> > >>> Cc: linux-arm-kernel@lists.infradead.org
> > >>> Cc: devicetree@vger.kernel.org
> > >>> Signed-off-by: Rob Herring <robh@kernel.org>
> > >>> ---
> > >>> v3:
> > >>> - update MAINTAINERS
> > >>>
> > >>>  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
> > >>>  .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
> > >>>  MAINTAINERS                                   |  2 +-
> > >>>  3 files changed, 39 insertions(+), 57 deletions(-)
> > >>>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
> > >>>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
> > >>
> > >> Ping. Please apply or modify this how you'd prefer. I'm not going to
> > >> keep respinning this.
> > >>
> > >
> > > Sorry for that Rob.
> >
> > Well, it was simply not clear whether we were supposed to or not. :)
> 
> I thought 'To' you and a single patch should be clear enough.
> 
> > > Andreas, are you going to take this patch? Else I'll pick it up (If you
> > > want me to do the PR for next cycle)
> >
> > I had checked that all previous changes to the .txt file were by myself,
> > so I would prefer if we not license it under GPLv2-only but under the
> > same dual-license (MIT/GPLv2+) as the DTs. That modification would need
> > Rob's approval then.
> 
> That's fine and dual license is preferred. Can you adjust that when
> applying. Note that the preference for schema is (GPL-2.0 OR
> BSD-2-Clause), but MIT/GPLv2+ is fine by me.

Andreas, are you going to take this patch? Else, we can ask Rob to take
this through his tree as we don't have any queued patches for v5.4 yet.

Thanks,
Mani

> 
> Rob
