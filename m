Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB12DC3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD5A2464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgADPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:17:08 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:38612 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgADPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:17:08 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A784A805F7;
        Sat,  4 Jan 2020 16:17:03 +0100 (CET)
Date:   Sat, 4 Jan 2020 16:17:02 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 0/6] dt-bindings: display: Update few panel bindings with
 YAML
Message-ID: <20200104151702.GC17768@ravnborg.org>
References: <20200101112444.16250-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101112444.16250-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=TC1aGOGHLOKMx2fu2ooA:9 a=CjuIK1q_8ugA:10 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.
On Wed, Jan 01, 2020 at 04:54:38PM +0530, Jagan Teki wrote:
> These panel bindings are owned by me, so updated all of them into
> YAML DT schema.
> 
> Any inputs?
Thanks for doing the conversion.

dt_binding_check was not happy:
Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.example.dt.yaml: panel: 'backlight', 'port' do not match any of the regexes: 'pinctrl-[0-9]+'
  DTC     Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml
Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml: panel: 'backlight', 'port' do not match any of the regexes: 'pinctrl-[0-9]+'
Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml: panel: compatible: Additional items are not allowed ('simple-panel' was unexpected)
Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml: panel: compatible: ['friendlyarm,hd702e', 'simple-panel'] is too long
  DTC     Documentation/devicetree/bindings/display/panel/sitronix,st7701.example.dt.yaml
Error: Documentation/devicetree/bindings/display/panel/sitronix,st7701.example.dts:22.42-43 syntax error
FATAL ERROR: Unable to parse input tree

Please fix and check the bindings using dt_binding_check before
resubmit.

I had to install libyaml-dev (as least I recall this was the name)
before dt_binding_check worked OK for me.

	Sam
