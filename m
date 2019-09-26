Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997CC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD095222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zgig/tf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbfIZBXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:23:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42804 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfIZBXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:23:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so257427pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 18:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=22PGlG1vlAQyFCiQebzwvuuzTz1/kfVMRIZpfQyyRLo=;
        b=zgig/tf5Sz63yHXZf5ykSXhEvaJExJ8pTMIiFFPmAJSIeFQGcrAt4VlvMXucQ0d+Y2
         ISX1JfSdCrX9xp9kGJg9HeL7lEP1qZMzc0o0xVd/Fc18a1p5Ei2FkN2mdV615Wv+MlzQ
         dDJ/0b2kTmM+581Ld3pvAhGYzggVaLsuV19R3M6mwju9byc5+Der28Y5XEnd6TWCJ83M
         x0IcLhy4OSf9S8AMiTS8ZVW4ZfSiqC2B74p54qyvTAef4D6L3enZi+iOwj82niZ7IhFc
         fVen3QoId07DeV4lfNeiuf4t+68kb+cStWH/wc0bkgGI7n58v3vfQ6TU4Xh+eM9yecI0
         JOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=22PGlG1vlAQyFCiQebzwvuuzTz1/kfVMRIZpfQyyRLo=;
        b=DyXdAqM53MI3DMPxbRvAnDYiy+2RNTLstyG+rEk4LfyoeVGuQrVviOdlBgsSczm2Vr
         t476t463vnN171v1CUsg3tEybmGdGlYs20BcXfWZ99iinHGVR4E3FB1w2DrE51SiWvAK
         VOBny6s+gAVVEg76I8q7IbX06Yir6Lsif99J14RvUtuf5jSaaZOI6YhApQ5SuNRYaDRk
         WnXhJXM/sp6MXdhOFFCQ4oKf52i5VQYvpcBSgPHabfH/GWM6FsVMwhsc7fgBF6pjP9ac
         zUgUvvpMIzYzkXxEnpKsl3QaXTt6IF8k8SG4t5RcqLIqhzAgRrgGB8jKceXHyC/HNe+Y
         wd5Q==
X-Gm-Message-State: APjAAAWSqxzsquexHrPrsOPAOXjPk/RVRsHc+PN2lyYZ7KJTVnteRfES
        veV/zfR3H2QGQOM/62Q0DxXFew==
X-Google-Smtp-Source: APXvYqya/AneO2Xl0WxjU095xtUeWcGemRWOch75ciyEJ/c2Oz7gBUbQVVPb8WHw1/sCgztUiTVHzw==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr1077815plo.287.1569461030065;
        Wed, 25 Sep 2019 18:23:50 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id t3sm308272pje.7.2019.09.25.18.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 18:23:49 -0700 (PDT)
Date:   Wed, 25 Sep 2019 18:23:47 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        "David S. Miller" <davem@davemloft.net>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Fred Lotter <frederik.lotter@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: flower: prevent memory leak in
 nfp_flower_spawn_phy_reprs
Message-ID: <20190925182347.5a509f47@cakuba.netronome.com>
In-Reply-To: <20190925182405.31287-1-navid.emamdoost@gmail.com>
References: <20190925182405.31287-1-navid.emamdoost@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 13:24:02 -0500, Navid Emamdoost wrote:
> In nfp_flower_spawn_phy_reprs, in the for loop over eth_tbl if any of
> intermediate allocations or initializations fail memory is leaked.
> requiered releases are added.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Fixes: b94524529741 ("nfp: flower: add per repr private data for LAG offload")

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
