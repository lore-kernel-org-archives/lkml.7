Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5152184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCTPRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:17:37 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55741 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCTPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:17:36 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7683D6000B;
        Wed, 20 Mar 2019 15:17:33 +0000 (UTC)
Message-ID: <8d6f1e9191638e243616ac7832b1b650a80d85ad.camel@bootlin.com>
Subject: Re: [PATCH 3/3] drm/vc4: Don't liberate the binner BO at runtime
 suspend
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>
Date:   Wed, 20 Mar 2019 16:17:32 +0100
In-Reply-To: <87o96alk7k.fsf@anholt.net>
References: <20190315162538.4120-1-paul.kocialkowski@bootlin.com>
         <20190315162538.4120-3-paul.kocialkowski@bootlin.com>
         <87o96alk7k.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le samedi 16 mars 2019 à 11:58 -0700, Eric Anholt a écrit :
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > The binner BO is a pre-requisite to GPU operations, so we must ensure
> > that it is always allocated when the GPU is in use.
> > 
> > Because the buffer is allocated from the same pool as other GPU buffers,
> > we might run into a situation where we are out of memory at runtime
> > resume. This causes the binner BO allocation to fail and results in all
> > subsequent operations to fail, resulting in a major hang in userspace.
> > 
> > Now that we allocate the buffer at firstopen and liberate it at
> > lastclose, we can just keep it alive during runtime suspend.
> 
> I think this needs to be squashed into the previous patch, as otherwise
> coming from suspended, a firstopen -> resume -> render will leak a copy
> of the bin BO.

Woops, you're definitely right: vc4_allocate_bin_bo won't check whether
we already have allocated it or not. I'll send a new version with both
patches squashed.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

