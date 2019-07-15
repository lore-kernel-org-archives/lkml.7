Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6707BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE432064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/68ct6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfGOKkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:40:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50672 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbfGOKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:40:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so14651232wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OLhOlGy/Zpqk6ycbhGl95GCnRY0eR5mykg/94zkQXyM=;
        b=U/68ct6QI4cClrqDBJmUuHunt/bg7Eh4NWXxIK1SZh1Pct9mlDieZnhhyXUDkdTiMo
         xwZ5DZv4rGnkwvCZoErPIwjqKBjEa3vYL/k+jmjni4t3FKK/w/DCKUF2Z6+4wnekTco5
         ICKzJxf7I3hOwcglNlrZw2CpBPvJqF+tjL568qKQr1flPxkdLSCMP7jSDYqgWL6Kl8ds
         ZMulunacwg1naNMsspmMzqHf29PGhqan6ls1G2ZHgbqylCBYXA9TzSsXs/5Khwouv/tF
         74+NRsRAotsQ+tGtwEAIeMu0WM8lCJB+ksyGYuUsUxZEjbBVvGNy+Axn64dS1Xqi9hG+
         7DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLhOlGy/Zpqk6ycbhGl95GCnRY0eR5mykg/94zkQXyM=;
        b=XCKieUM9A2yBO3gQ9HOXhYPE7MJ3b3h4l8SGUD3jvhlX2Tyf5dhj71UDb6dCqM/ofF
         GyUCncjAkst9J2PNs+IdXN+bijgqzpo5pt9nUmD3am6deR7e53Enh9KhCBZNN7E/HUDL
         78Ti3kSR37nJRy6ZyvqQ4qNQ04O4qo8Wbi/56u58GF5V8qv8guyP3uoj+CHtXHu8P9Qy
         SsAKP62s2XEWUE0Lmb2Tf61dg/Bu1WHeOkVgymaTD/dE5TlStYiX+HKhO/T/cprVfVEK
         e2rsVVYXEpiF3AJmtZLGMvxLmP4wSnDgDu5ovNCKL/jpDzJ3auBwKLgW8Vr32PoDa52H
         nmCw==
X-Gm-Message-State: APjAAAW5+pevnzfm+csc7sTmDcSeL19xePgX6fWun6dBSa8WahiP5zQs
        ZBuUhCrTpb5skEVZEggPavY=
X-Google-Smtp-Source: APXvYqyCvN1z7i6TYAqjic41kTp/MqB/5K7wVhGC9Qeaiv1CVUiAEgMVsPPOsOESqC9Cne4zkSc5Bw==
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr25059180wme.67.1563187222360;
        Mon, 15 Jul 2019 03:40:22 -0700 (PDT)
Received: from arch-x1c3 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
        by smtp.gmail.com with ESMTPSA id 5sm16132908wmg.42.2019.07.15.03.40.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 03:40:21 -0700 (PDT)
Date:   Mon, 15 Jul 2019 11:40:20 +0100
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 05/24] drm/amdgpu: remove memset after kzalloc
Message-ID: <20190715104020.GB20839@arch-x1c3>
References: <20190715031731.6421-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715031731.6421-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/07/15, Fuqian Huang wrote:
> kzalloc has already zeroed the memory during the allocation.
> So memset is unneeded.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v3:
>   - Fix subject prefix: gpu/drm -> drm/amdgpu
> 
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil

