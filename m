Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB7AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64252214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfCLG7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfCLG73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 574233082AEE;
        Tue, 12 Mar 2019 06:59:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-175.ams2.redhat.com [10.36.117.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB091600C5;
        Tue, 12 Mar 2019 06:59:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B0CD711AA4; Tue, 12 Mar 2019 07:59:27 +0100 (CET)
Date:   Tue, 12 Mar 2019 07:59:27 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atomic-helper: Validate pointer before dereference
Message-ID: <20190312065927.fnroygpyso4rumob@sirius.home.kraxel.org>
References: <20190311210120.fdixvenmqjoxuoqt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311210120.fdixvenmqjoxuoqt@smtp.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 12 Mar 2019 06:59:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> -			if (funcs->atomic_enable)
> -				funcs->atomic_enable(crtc, old_crtc_state);
> -			else
> -				funcs->commit(crtc);
> +			if (funcs) {
> +				if (funcs->atomic_enable)
> +					funcs->atomic_enable(crtc,
> +							     old_crtc_state);
> +				else if (funcs->atomic_enable)

"if (funcs->commit)" I guess?

> +					funcs->commit(crtc);
> +			}

cheers,
  Gerd

