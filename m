Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB377C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4F6214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCIzQeUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfHNKtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:49:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44172 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfHNKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:49:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id k22so3058202oiw.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3P5HD8zFs0OenSO+igXy3w9KtmPtkhkBINw7OrTEEo=;
        b=TCIzQeUwk2KLZtCaTvQK1OrgxfSroQuRzPuMFWXvWOElOPwgv2RKWoe64433uMxHNW
         bgreSS1YIUiNaMOzMSgX/uujzlDyjEKw/1v5hsx7E74JSV88PSJBF4FA56Ufnbkj9Ft6
         bu9hn4Omp9YVMId8YSQVEtcnn15506rdySM6A6SBnco9xZPZynfQSUGqFJ/F839Qspph
         UiQ8AR189rJsZsG2ieJ80VAhABMXDpMiDH2afzvYKQoyvwDpPcw8Sbg0BowqIAyFDKyR
         Z0fI06bVUcrodZon9YIB6NiSHg999sfjWqz6Giw3PR/SwY58iNzrR9W2rHQeMleBfhqr
         zSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3P5HD8zFs0OenSO+igXy3w9KtmPtkhkBINw7OrTEEo=;
        b=M2602gagONbyoLLOxAoMEfCUiZqJ9szZdKWYBhB67XHwxGLisVFgGhakiGF06QSZ59
         lKSlBu8Nr727WNmvfI3jRVyniiI80SLkO3kKYREqHMeJ2hdHB6n3XorPoQvNbTfUs8PH
         PZemu9rZfXsE35uicP2vrLPOipnYUlzRKcyZ/GGuZb+GEx5FcsSsuZmJTmd2FY/sk8lZ
         MnZiSxKQzIMrkuSxkynpnMH56EutJZZOZqJqOvSkVqHwot6HUH/lLJiaoCoKwlnPpKy0
         5rneC/eZEn08P9oFUQRPWsBUR2fp0uhqMXFoJJl5nKS1K72RjdTV9fVSuIOfKV6ovSzc
         /2aA==
X-Gm-Message-State: APjAAAWTfLS7q2aZdGUVZag0GL6Y30C/+0R44Qek8IRD44XQnfYufR+Q
        FCE0AM1Nr87WFavC/UARomyxP7RePcVKT7YSW+okOQ==
X-Google-Smtp-Source: APXvYqx47KLEn+2zqAfX9CwXnDqbWR0RTlkz32o6QvlqLcG9QA5bQMFDNDn0S23xNxRR/2fXsHnK9Rq1WC7fz5opueU=
X-Received: by 2002:a02:3941:: with SMTP id w1mr2690863jae.91.1565779777645;
 Wed, 14 Aug 2019 03:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190813110300.83025-1-darekm@google.com> <20190813110300.83025-8-darekm@google.com>
 <41c95313-fe39-b201-5238-24df7e72879a@xs4all.nl>
In-Reply-To: <41c95313-fe39-b201-5238-24df7e72879a@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Wed, 14 Aug 2019 12:49:26 +0200
Message-ID: <CALFZZQHw+MJo-ZRKpJqZtFi2CZfuu6rs8LJ5hsXLHBD+ASrcYQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] drm: dw-hdmi: use cec_notifier_conn_(un)register
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, Aug 13, 2019 at 1:38 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Russell's review caused me to take another look at this series, and it made
> wonder if cec_notifier_conn_unregister() shouldn't be called from bridge_detach?
>
I've sent out v7 of the series where unregistration is done from bridge detach.

Regards.
