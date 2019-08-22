Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2133EC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9797233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="COEUpB7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfHVJfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:35:31 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:45969 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbfHVJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:35:29 -0400
Received: by mail-qk1-f173.google.com with SMTP id m2so4477014qki.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NO22HbaMZJynJgD6+PgDdcz0IJRAkX2Q/TUAe3LAdCw=;
        b=COEUpB7lH+sa1Wm04QhSBmeEb8LEjrit6+KDHW0QV3SkhpdO+Ce09Rz+f5uPxJLN+u
         PvMmv4NQgj4yXMULkRZbPjXReODK5MwhM0rU94n4s3sxouvbYUUhCxBwPE8eRv4ZupU3
         KQx7RAWff5qZ1RW5IQeQjBsJA5gjRhDWjOiSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO22HbaMZJynJgD6+PgDdcz0IJRAkX2Q/TUAe3LAdCw=;
        b=l/nTicUwX+qAaf9sfoPdU3R58X27S8/sG/0LuiKzlYkHAI4qjkmQvdqyB/1HhAv1Pl
         ozhzIcnglTSix/mxmqAyI54TpQDx5WZXbexeXb6DBqUMj1EqlTKOM7UGuTmfqe3ZSBu/
         78VSWDByr+6IO8xmyp5zdVV4OdZp7qXnlSvVUCmctvF/DuMHuGkODlLZC4UcSUOrWdnA
         JW/u2ZX/VfddNri0TT+mrP3lWy9aAOmZnnNB0MxJO1SEZlKQhga8/Gx7uBzTokRZUy5E
         8IuH3KlkwJFpcunF6PogNIIEmHX1FuWofaNOdbSDY80QIf7rccNLAsI703hLQHmIm1Pg
         wgcw==
X-Gm-Message-State: APjAAAVxBtfd3NRUzBTwib1rzWmcZcVmjM4QuL6iQJ4qCNMptFrTcS7H
        F8fg6LmCs71qDnCUZPFSQX9yIMlfGSjWvxRGKKjNIQ==
X-Google-Smtp-Source: APXvYqyJ0CJid6ew+jYjIZdViygDbZ1nSFTHSvRIEbJVqYXbQji9bHodn6KVX4KP8QmHSXLnWIh+hxt/IGhXvLaxdp0=
X-Received: by 2002:a37:47cb:: with SMTP id u194mr33199821qka.342.1566466528133;
 Thu, 22 Aug 2019 02:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190822055737.142384-1-hsinyi@chromium.org> <1566462278.26641.1.camel@mtksdaap41>
In-Reply-To: <1566462278.26641.1.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 22 Aug 2019 17:35:02 +0800
Message-ID: <CAJMQK-hr5m_YETnObsgw8M5etm+9xL_KY=54V6==fSbY191F_g@mail.gmail.com>
Subject: Re: [PATCH RESEND] i2c: mediatek: disable zero-length transfers for mt8183
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Jun Gao <jun.gao@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qii Wang <qii.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 5:24 PM Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>
> Why do you need to change this part?
>
> Joe.C
>
You're right. We don't need to change this. I'll revert this back.
