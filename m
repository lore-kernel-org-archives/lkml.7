Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75AC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCBA21976
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vVp/xUv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfGVDMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 23:12:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45647 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfGVDMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:12:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so25457646lfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 20:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BoTOo2Q0hAaQhRV9S4lq8HdMSQdYs79oTvCprCzExNE=;
        b=vVp/xUv+CtFzcPuAXowYe8wJhVlGxEwlkPGxO9uVGvr6WeSnEwgVsW6GAow0S9juzs
         ai84cJL7ajD0+curTRmYC7lrWpicyEyd7Y4L3et7J1JmbfOXBkO+2kB7bhI9RMs3KR0e
         h1+h/FM36KmpJoewzbcIMlKLQ/wjuoD/IAUUKgW1l55z3lLxy2Rh8FFQ46HuXy66nnmW
         xF3U+cRwtK3tCNe1xQBvm1pILf/LQDvGi3CE4wiN/M57evG0vHGSCeWaC9g9rHZa6b8N
         vV5llWLCjRZx40SqG5vZOJ6XqYBbGf5X364KyHxtQRFGiyPscfc+EPstVGNVxhGO7Tjp
         9MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BoTOo2Q0hAaQhRV9S4lq8HdMSQdYs79oTvCprCzExNE=;
        b=hEgJZkAb4a01IVnidDKOHlBGZOz1J7ckX/tu+aZna9XhwWWMXjMutDGP/sVEQ8JUO2
         tpIg9MblJ77YUxpnwMSgqU1gKs2XZGb0ugEL0e+/+Rr+u6HVaFc4NY7Mw1PQ6JvfNmEw
         9IXTsUBAVRs51GSWgae8q2lz90/ns7kXGLTrYHEegtsCSlPRxayWNIEjOi2fTygOSwh1
         LwnaPOsTH39gqt0CuGQBMp0fnkWt+DcV4k/pJ0o2VOlqyq7kTPsD4D2nDQzknDUXfFk3
         5cSC4YQathVl8AmvPZLX0zM2r1ydCIj9nUnCsY2COKNTDtGHyE1lScdKeSBcWNu6A6pU
         GlrA==
X-Gm-Message-State: APjAAAV15H0nBXYOUukDdx0p8sIgBawRq56x6ar31e4Juq5OrPiywvCn
        tAnU2mgrwLUFI9l3k0IjBUU=
X-Google-Smtp-Source: APXvYqxVa//VcmaIKYBFuFD504DvOuD2bhedQ6g47iO9335WFRXA8+Jy+FwxH+dmn5XOy5APicOWvg==
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr29910373lff.95.1563765166998;
        Sun, 21 Jul 2019 20:12:46 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id e13sm7350247ljg.102.2019.07.21.20.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jul 2019 20:12:45 -0700 (PDT)
Date:   Sun, 21 Jul 2019 20:07:04 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "soc@kernel.org" <soc@kernel.org>
Subject: Re: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
Message-ID: <20190722030704.jg23kwxksh7ge4vn@localhost>
References: <20190605194511.12127-1-leoyang.li@nxp.com>
 <20190617114948.7xxtpivve52c2jnb@localhost>
 <VE1PR04MB668773AB42154134CE18A6AB8FEB0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <VE1PR04MB668750E96558796A2E81DB678FF60@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB668750E96558796A2E81DB678FF60@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 06:48:17PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Leo Li
> > Sent: Monday, June 17, 2019 8:29 AM
> > To: Olof Johansson <olof@lixom.net>
> > Cc: arm@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; shawnguo@kernel.org
> > Subject: RE: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Olof Johansson <olof@lixom.net>
> > > Sent: Monday, June 17, 2019 6:50 AM
> > > To: Leo Li <leoyang.li@nxp.com>
> > > Cc: arm@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; shawnguo@kernel.org
> > > Subject: Re: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
> > >
> > > On Wed, Jun 05, 2019 at 02:45:11PM -0500, Li Yang wrote:
> > > > Hi arm-soc maintainers,
> > > >
> > > > This is a rebase of patches that missed 5.2 merge window together
> > > > with some new patches for QE.  Please help to review and merge it.
> > > > We would like this to be merged earlier because there are other
> > > > patches depending on patches in this pull request.  After this is
> > > > merged in arm-soc, we can ask other sub-system maintainers to pull
> > > > from this tag and apply additional patches.  Thanks.
> > >
> > > Li,
> > >
> > > You never followed up with a reply, or removed, the previous tag. So
> > > when we process the pull requests that come in, we've already merged it.
> > 
> > Sorry about that.  Will reply the previous pull request and remove the old tag
> > if update is needed next time.
> > 
> > >
> > > So, I've merged the previous version. Can you send an incremental pull
> > > request on top of that branch/tag instead of a rebase like this was, please?
> > 
> > Actually the new pull request is based on the old pull request this time.  I
> > sent the new one as V2 hoping that you can see this first and avoid merging
> > two times.  Since you have already merged the first one, you can merge the
> > second pull request as an incremental pull request directly.
> 
> Hi Olof,
> 
> I was on vacation for the past two weeks to follow up on this.  Hope this is not too late for this merge window.  Like I mentioned, the new tag is on top of the previous tag (you merged) so that it should be able to be merged incrementally.  The only thing is that the description of the new tag also included patches you merged with old tag.  Do you want me to regenerate the tag before you can merge it?


Hi,

I've now merged v2 into arm/drivers for the 5.4 merge window. If you need to
add more material on top for 5.4, feel free to use it as the base that you send
incremental pull requests on top of.

Next time, it's probably easier if you re-generate a new pull request
like I asked for -- I missed revisiting this since it seemed like a side
follow up and not new material to merge.


-Olof
