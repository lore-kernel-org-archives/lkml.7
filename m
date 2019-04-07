Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D8CC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4F920863
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="aTb8MU1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDGWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:20:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44996 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDGWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:20:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so9450313ljg.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kMbbmv59GueLpCb9KIjTCAIYKXDhICPmHjWjwmMrRAA=;
        b=aTb8MU1J65ZW0wtBaPF1j42vNAL3iSPOLfO+LGL/XkSrnvkkfXCFgAmTPi2kAdnM9C
         VBwUOwHaD+piEnYn0HsabAUXZE4Qh3sSyskB3EKFrXOE7beaNbVYdtHfVcCcC+Z8vPYS
         erk4sxy8mpef3+b+jPyEQjoMVyMiPrfxUWGJbN6tlxgxZlPIzPyz03IjMEQJxDzGTogk
         qqeLEpSJvFxkclbeY/2aIrH5bARFSJ6AIfQRu9rF733vc4aPDH9XsG23enZ5nrIXv/Aj
         x6+HGWKlabwDs38+nHDFnQBVPqY2TwVfc22K/K/oGbIA7mciwlIq8GrxP33QOkT71EOq
         PKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kMbbmv59GueLpCb9KIjTCAIYKXDhICPmHjWjwmMrRAA=;
        b=ZL+Jf7H1sjMTa1Ij6FpCtvdW67z7Z/6jyCp27iaueuyLPfczKEPEwWlMmvyQKTDO0T
         qUtbUjYmQbXwiYKsf8JjoIOpRIoGvP/hqWLFd49jQQ25FOQ0dEEKqy1ER3Al5x1oON6v
         ovKw7rzT/GheKNjbFst2/bzaGlGi3mQ/AdpoxdmBmTyJOIeeaU/VdQV1cUPc9OKeZ9KH
         rCRIMp54gdcmR5rgjzRh+SuVTIl3bOl284+y/qxMfd1JNe9K2lTQM4Exe3WIMPmPiwXJ
         iQmqYDrpeBUKiIOYaZrPhkJ9JDKHSYlBuqqdqU2bvVA+AAyAjg2q0vvq/UmDxnMqj2fw
         bF+Q==
X-Gm-Message-State: APjAAAWL4ygcwz0Cj6IndJlv3ArenVZeKWIw/assX2nTlqTsD254BFFa
        wJxyt38pAi/xe9rjsBBpWx9bWw==
X-Google-Smtp-Source: APXvYqza1rnH3Er3XkvoLeH4ePBq/WKSFOwegOEpiWcYFvDg6KXEMq7tFN4WSC1q8BBJixg/J+Q/+A==
X-Received: by 2002:a2e:7206:: with SMTP id n6mr13616409ljc.112.1554675639727;
        Sun, 07 Apr 2019 15:20:39 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k10sm6091867ljh.86.2019.04.07.15.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 15:20:38 -0700 (PDT)
Date:   Sun, 7 Apr 2019 15:13:29 -0700
From:   Olof Johansson <olof@lixom.net>
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: cpu: Fix JSON schema
Message-ID: <20190407221329.skbjjsjvqpnxwime@localhost>
References: <20190318100521.29109-1-maxime.ripard@bootlin.com>
 <CAL_JsqJ_LYycXazkdP2Q=e-jynKiX+z5En0bz0AWpDjsevwQTg@mail.gmail.com>
 <20190401091050.cwph7xlpv3pmkwnq@flea>
 <78bb248e-56b8-b825-e763-583f75148eb3@socionext.com>
 <20190401113546.d6p2mg2y47abhumz@flea>
 <b6cb709b-7b1a-6bab-6f93-bcb565be18fb@socionext.com>
 <b3ecf5c5-9b1a-eb8b-95c2-c30a94c8bdd8@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3ecf5c5-9b1a-eb8b-95c2-c30a94c8bdd8@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:42:02PM +0900, Sugaya, Taichi wrote:
> Hi,
> 
> On 2019/04/01 22:02, Sugaya, Taichi wrote:
> > Hi,
> > 
> > On 2019/04/01 20:35, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Mon, Apr 01, 2019 at 07:52:06PM +0900, Sugaya, Taichi wrote:
> > > > On 2019/04/01 18:10, Maxime Ripard wrote:
> > > > > Hi Sugaya, Arnd, Olof,
> > > > > 
> > > > > On Thu, Mar 28, 2019 at 02:35:54PM -0500, Rob Herring wrote:
> > > > > > +arm-soc
> > > > > > 
> > > > > > On Mon, Mar 18, 2019 at 5:05 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > 
> > > > > > > Commit fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for
> > > > > > > Milbeaut") added support for a new cpu enable-method, but did so using
> > > > > > > tabulations to ident. This is however invalid in the syntax, and resulted
> > > > > > > in a failure when trying to use that schemas for validation.
> > > > > > > 
> > > > > > > Use spaces instead of tabs to indent to fix this.
> > > > > > > 
> > > > > > > Fixes: fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for Milbeaut")
> > > > > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > > > > ---
> > > > > > >    Documentation/devicetree/bindings/arm/cpus.yaml | 2 +-
> > > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > 
> > > > > > This should be applied to arm-soc tree having the commit.
> > > > > 
> > > > > Could you pick up that patch?
> > > > 
> > > > I got it.
> > > > My mission is to resubmit your fix-patch added my singned-off tag and
> > > > Rob's reviewed tag...right?
> > > 
> > > If you are part of arm-soc and send your pull requests to Arnd and
> > > Olof, simply pick it up in the same branch than the initial patch was
> > > in. And when you apply that patch, you indeed need to add your
> > > Signed-off-by (note that most commands to commit have an option to do
> > > that automatically: -s and that includes git am) and the Rob's
> > > reviewed-by.
> > > 
> > > Then, send a new pull request to arm-soc.
> > > 
> > 
> > Okay, thanks for your suggestion.
> > I try to make pull request!
> > 
> 
> Sorry I realized that I couldn't make a private repository, so I'll send my Ack instead.
> 
> Acked-by: Sugaya Taichi <sugaya.taichi@socionext.com>

Applied to arm/fixes now. Thanks!


-Olof
