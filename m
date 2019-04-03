Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B77C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB02206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfDCPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:52:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39311 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:52:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id c189so10458982qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IFbEaZvNrzXqdsFVxntTHzvbKfbVDaen34px36fcNTU=;
        b=T9Xxf9fSr8XNfw7Xm09RPfRqK5xq8gv/ldmSS96/J3uguu9geWRtrhFLO+KrWa+rRa
         oLjeYB6WD43LL3LXh9knzidNrpfRSZ0Udj5s5FkoMZ1VCIr5/I+oawhC4IybzZOh+N1e
         jI5nkXPx3nlz0K61d9lSoJwPGkirdwEDQ4ebJOTdQ8Y4t+bSgTH7wRxWkfTQ4O0XWJVz
         nDLhLEph2Xj03rpskbTpkxS4INKisnMwd2Bjozwok1/VW0v8GeT5Nik+nZ4jXFg3GQld
         TQPOuxEbW6aLcpoWXYu7158tYoGBdWo1CwgQO+JzyO5PVd4kjhUvJBlGWz2lfgN22FBM
         /7pQ==
X-Gm-Message-State: APjAAAVKiXbvxxF+LEa4JR375cxmkNtEz7kIXUyGeO4QbjtOkteGO0ao
        B2FT5mS9pWrZhCW83r1RHJ1Gdw==
X-Google-Smtp-Source: APXvYqzjlw+C4YsSyZo0xegWH2Ejd5eS0sNyS9InzJ2sSWpBcV4y+L4y+V0jrIAKriqF2sRS9MiMSg==
X-Received: by 2002:ae9:c310:: with SMTP id n16mr720495qkg.8.1554306754849;
        Wed, 03 Apr 2019 08:52:34 -0700 (PDT)
Received: from dhcp-10-20-1-165.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id w18sm13148268qta.2.2019.04.03.08.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:52:33 -0700 (PDT)
Message-ID: <eba84e1ed570908acdf65a2683b77718ff585e99.camel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
From:   Adam Jackson <ajax@redhat.com>
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Date:   Wed, 03 Apr 2019 11:52:31 -0400
In-Reply-To: <CAPj87rOE2K9nxV2p+KrMTDnijdKpmNP8BGSUJyK9YtFueJpkqw@mail.gmail.com>
References: <20190403072318.31507-1-kraxel@redhat.com>
         <85ba308177f4e9ddee336d5110cb6df7a447cebf.camel@redhat.com>
         <CAPj87rOE2K9nxV2p+KrMTDnijdKpmNP8BGSUJyK9YtFueJpkqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 16:15 +0100, Daniel Stone wrote:

> There's already a list of supported formats for each DRM plane, which
> you can get via drmModeGetPlane (being careful to enable universal
> planes so you can discover the primary plane). The same information is
> present in the 'IN_FORMATS' property, which is more difficult to parse
> but also tells you about modifiers.
> 
> modesetting already pulls all this out (at least in the atomic path)
> so we can reason about acceptable modifiers.

D'oh, I knew that. The problem then is modesetting isn't pulling that
info out early enough in PreInit. I'll consider that another case of
xorg/xserver#9 then.

- ajax

