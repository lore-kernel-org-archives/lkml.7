Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D60C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD2C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCKOY4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:24:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43536 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfCKOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:24:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id s26so2778118qkm.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mktf9NbwTHJzytT6rfosuWYysmBIsHkTibLJvruU36o=;
        b=VtsI5JOQGDqawh3Nd/F2maJ8yM0UnAoWyBobSGMYF0tT60vcYQ2S82uOrNb4OdIFLp
         j4KC+KAyMkY4nx/XUoSsTSHQh3yZZKNwus+4sFMOpKoiR6J6iFtVqN+wNXdv6XP6bvDG
         i4ri8pqXbrOsim8F7Z3O2i/W8DJ1hhXD+RIMC61UhLyeE0Eus2tV5BoWBlU3qNetJNpU
         FQaSqNzCMnzy+mRC/NGxd0CZXqF6RN4OabKAjwiY3gwmL08oXJ2gRFC8cp6v9cqAq9qx
         LGdw/ffobfAu93JCNFtGDq0nmaO0hn1BNQKTawysJmA682UunLVlu1QAjaNyUNQX0+X0
         VD4g==
X-Gm-Message-State: APjAAAVyfzXsVcM7tbSvPr/8W7B5iYAOojllUpqmSWSa9tF1O/OdJrXS
        1l42+qDGtfANpibCs2hGukwc+V4onQ3XcjnYWjRR3Q==
X-Google-Smtp-Source: APXvYqxh/pw0RG3E66KyVw8a1DD6DP3U4kZPxmIcWlU1sNrWRJIeG9QOmBsEXU+VTv9P0J8WW1V0xFwNJQZbchB+L6s=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr24802251qki.291.1552314294804;
 Mon, 11 Mar 2019 07:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190307155323.2949975-1-arnd@arndb.de> <d69abbf5-faf6-d169-2a0c-f440e17ef011@st.com>
In-Reply-To: <d69abbf5-faf6-d169-2a0c-f440e17ef011@st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 15:24:37 +0100
Message-ID: <CAK8P3a2Y-H9v6dFNUPLOFEVJka8+w+5X9VuQETXn539K90fHQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: fix CONFIG_FB dependency
To:     Yannick FERTRE <yannick.fertre@st.com>
Cc:     Philippe CORNU <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 4:50 PM Yannick FERTRE <yannick.fertre@st.com> wrote:
>
> Reviewed-by: Yannick Fertré <yannick.fertre@st.com>

Thanks,

> Arnd,
> could you merge the patch?
> I think that Benjamin could also merge it.

I think this should go through the drm tree, so someone with
access to that should merge it, not me.

     Arnd
