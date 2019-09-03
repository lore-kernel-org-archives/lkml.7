Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB07C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C65421897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxm8P2Ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfICVgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:36:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40184 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfICVgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:36:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id u29so14089568lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5c3lERoSBFKARRSEJjybtuQrS47BHT/FjEnyYEyNFQ4=;
        b=dxm8P2Ly/msbsWBeFRBcnitifyB3atAXYLi82sF0F0mHuVQSC6s5gkHpC87cEgYLt4
         f34KoYIhlfFxD3mXnngj8ImCRMTbWdei5YasUPMWWS/n/+jq9Wbn1kLrr0qrh7NXmfvN
         wSZjXyWYR130Jp31Zoq+YIYqVKcSCdgw1hc6bpSSOXSbjAbb7PDBY8f62BlbEa6UjUmY
         SuBoCbno0obv6HEu6lgdwrhqw237KiEFBG88Fmux0Tqbkn5Y/awAvyTtHXaneQJe9Bsy
         lxQMgKiSOohBTdUaheExu2nfYZMLqWEuzMqgOMlYr93Wxf/F0niZ4qroBYnH8aRfBgXA
         Kg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5c3lERoSBFKARRSEJjybtuQrS47BHT/FjEnyYEyNFQ4=;
        b=B6Bt+jhhC5e6puF1WhMuGH2f6FMZ+alCGSPUnyU1VvWf/srS0c8ci2k+0U2FH36rgL
         9WAqWZ8nfDTeGjbRvA66e2lpo3u6Az5EL6+CDw5ndPDkPsKLobj9zZls+4YFRPmzHSHG
         jgOjg3DHZp46VHQh27Oi8DlRq42pZ2dDSQ1Ca3hERNCdvqghxtPQHBIyGNe3ySBrLKrh
         yvZZJbn33KVAaKTzetk1pXQFaVlQ0qhWFw9+GxJLUEBp7O3hdxp3HmnR8gzdNu5WyXLL
         LihVeDLZ8qhlT3p1oAgBgoVdaAcUgIis7b0pxdM4rUilGKWneVLENKYSFUv4lC5BP7SO
         5jlg==
X-Gm-Message-State: APjAAAWwyCythKKqnlHoE4Bo8fpWCNINJn6c/iUp/YOjfTVOpvdqYeUh
        dgQyEOzSaF5Y3E8BWCUvHRK/oantMPaCneP0EHg=
X-Google-Smtp-Source: APXvYqy2qhVjfLBh6LUVY+Z+vrZrMk+8/5OQwcJmo6NhFVQ3s89dwyA3XcD5DyAwHt4sP/Hll/Nzd4MOCtCsqEAmtqg=
X-Received: by 2002:ac2:530e:: with SMTP id c14mr11866722lfh.165.1567546571837;
 Tue, 03 Sep 2019 14:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190903204645.25487-1-lyude@redhat.com> <20190903204645.25487-7-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-7-lyude@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 4 Sep 2019 07:35:59 +1000
Message-ID: <CAPM=9tx1vQMEsw4VjDVCbDYFUiaeHNCfP09aiSxnPnucQuB1JQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/27] drm/dp_mst: Combine redundant cases in drm_dp_encode_sideband_req()
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Juston Li <juston.li@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <hwentlan@amd.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 06:48, Lyude Paul <lyude@redhat.com> wrote:
>
> Noticed this while working on adding a drm_dp_decode_sideband_req().
> DP_POWER_DOWN_PHY/DP_POWER_UP_PHY both use the same struct, so we can
> just combine their cases.

both use the same struct as enum path resources?

Since otherwise the patch doesn't make sense.

With that fixed:
Reviewed-by: Dave Airlie <airlied@redhat.com>
