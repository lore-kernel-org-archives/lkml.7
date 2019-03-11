Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D944C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F9720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1iejg/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfCKSOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:14:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33156 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:14:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id i8so6257538wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=74d95NB2egqcS4EygZF1+Okd+h8WQNRS+P0xWWmMnqY=;
        b=E1iejg/sC8cwAv8jZNAd8QcVGEmHf/6TJwRnwJHJ7ldAOg8wqhctujDIu95+p6yI4b
         B4o1Liw06GuGH5NkinJWnxdXfb6mL+NFW2iuGQzaEcVN2BQ7t9LyufoLfOZsP+ePkP0q
         DI5QjnR3iZbWdykp6BPismcE1r9CvGmtw0T+Ho7uUraLAXLv4+QdPIFJUIDT4Cyl14FE
         hKpI0NEAjZdvHyECReydBSFMI3OfV79i5zVaBFTsnbWjWOpn3wo8l7tXXck/UG8rsdmS
         V6bA6X9UOS8UBt635M0Oz9V9jLJhE00bLkLEJXj4GkMNiJz4YNekDPn/EBVB7aD0jFYn
         nFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=74d95NB2egqcS4EygZF1+Okd+h8WQNRS+P0xWWmMnqY=;
        b=sP7syTXAGx7LBy/grX0U5eXGCYgJKn77ZF2HZAx3nTj8zgPoiq4CVoX7jiOBCZx2tK
         VCUqmf/VnzSLHmhLCOjHFEljjtUaepnS+Et50Qm9GbbKiE5IRyePwzq6XfSn4c9yquKA
         3ydtPod3/w2XpY+DHMgSmCfNk9JvTGzcr7tDmm+/lnzPjE9aeAEhl8hbZ7n1ZZZeaIOX
         GFP6n4K+hS7Zr5LlBG9/QxGKFve9wo4SGU8N+yCifNY52O6Obzt6uF2Q3ofpWIPZeqMx
         7dqNukPcGmkllgwziJvaY3TquYq55ptjnqcWuibySdtCNjdXm5jR8eUcTuD1jBZhKmds
         5/hg==
X-Gm-Message-State: APjAAAXhnsVxTfkDvKDiktXnEWowkI/iFS/RTIy1tFJJEm4NWGuGIQbt
        4RtzIHtZrORqlWhV389SuqLDHztxz3z4jxUokgFaNw==
X-Google-Smtp-Source: APXvYqxx19cewvdG8bGNQloTk27P7fXMeuBlecDGQA5cmm+Rlo/ymRcjyFuQhtFfeeV8V4Wcn9KRAVulr8GRYc0SPOU=
X-Received: by 2002:a5d:664a:: with SMTP id f10mr2002960wrw.95.1552328068816;
 Mon, 11 Mar 2019 11:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c8cd:0:0:0:0:0 with HTTP; Mon, 11 Mar 2019 11:14:27
 -0700 (PDT)
In-Reply-To: <20190308183718.21409-1-jbx6244@gmail.com>
References: <20190308183718.21409-1-jbx6244@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Date:   Mon, 11 Mar 2019 19:14:27 +0100
Message-ID: <CA+z=w3W+OYgxwejgfbNLJzFP28seh5ij62imuCDAY9XP_V39fQ@mail.gmail.com>
Subject: Re: [PATCH] drm: rockchip: add shutdown function to poweroff VOP and
 HDMI TX
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just found out that this was patched and reverted before.(lol)
The revert was 3 months ago for RK3399 boards, but other processors
like RK3066 are left without shutdown now.

What's the status for a fix?
Keep using the old patch for now?


drm/rockchip: shutdown drm subsystem on shutdown
https://patchwork.kernel.org/patch/10556151/

[for-4.20] Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"
https://patchwork.kernel.org/patch/10714725/

2019-03-08 19:37 GMT+01:00, Johan Jonker <jbx6244@gmail.com>:
> When a MK808 TV-stick with RK3066 processor
> is given a poweroff command, the monitor doesn't turn blank,
> but freezes. The VOP and HDMI share the same power domain,
> so that means that both there clocks were never turned off.
> Fix the disable of the VOP and HDMI TX by adding an extra
> shutdown function that will unbind both drivers.
