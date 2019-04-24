Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B42C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A4D208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfDXVPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:15:41 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:44884 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfDXVPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:15:40 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 58059804B1;
        Wed, 24 Apr 2019 23:15:37 +0200 (CEST)
Date:   Wed, 24 Apr 2019 23:15:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [PATCH 24/25] drm: kirin: Pass driver data to crtc init and
 plane init
Message-ID: <20190424211536.GB27952@ravnborg.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-25-git-send-email-john.stultz@linaro.org>
 <20190424170910.GC21067@ravnborg.org>
 <CALAqxLWmrabPxnpN7T_9KCLNrpzj0dnzbNs8vLhz+GBGyRxp_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWmrabPxnpN7T_9KCLNrpzj0dnzbNs8vLhz+GBGyRxp_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=_3D3e047poz2VFtbk70A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

> 
> > I missed where ade_driver_data came from.
> > This looks an extra patch to intoduce driver_data,
> > that maybe should be merged with an earlier version?
> 
> I'm not sure I'm following you here. Can you clarify a bit more?

So I looked at this a bit more - and got the bigger picture in place
again.

driver_data is assigned using the lookup done at probe() time.
For now this is just assigned to ade_driver_data as this is the
only option.
So an indirection via driver_date or calling ade_driver_data
direct is the same.
And you have several patches where you migrate to use driver_data
rather than calling ade_driver_data direct.
It confused me that the patch introducing the lookup at probe()
came before all call sites were migrated to use driver_data.
But I get it now so it is fine.

Maybe a few words in the commit log like:

This patch refactor to call functions via driver_data,
rather than hardcoding them via ade_driver_data.
This is doen so we later can assing another stucture to
driver_data to support other chips.

PS. I did not complain about your spelling mistakes in the
changelog. I have a similar (or worse) keyboard from a spelling
point of view.

	Sam
