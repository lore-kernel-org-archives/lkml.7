Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7185DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A49D2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLBW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:56:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45648 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfLBW4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:56:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id 14so1344176oir.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 14:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dllmzilFshZS41Rqd+tPknCh99mINDcFfUz5Z0ooFc=;
        b=mDRKvsmfPtWZXf0ssUDOU5+X/yRvXnZg5oQjqrQqhUPVaJWMA22dyibjHBWAk8uCdQ
         PacQvZjk6yqjTEZWLDtnPtePZk3A4ROR2RRnP11Ny9SwnVhxzUOcvx517gdhBdT41paI
         wWRe1s8gAoYU2/9sDiZP2mJG+2ZElqM/nU7ooJ6QDD/5/nkl2G0K1+o8st8Z7uATOGDj
         LZ6wM6dV5KdRLIe+g+dbQWvPoEUm3B6M+tYrUCWnJFZpyS5goJqizEmtxJ2XD+UZYGtu
         DjOGYGWxaOxXa6xA8y0gWe55M136Pg0df6sot4TzSyVltkSj2rD2IX2LNB4pCQmZvPwT
         dCCw==
X-Gm-Message-State: APjAAAX6H+9tBwk8YGtv3KNA/ubc5TKZpzKaQ8pmTB6kTau+JGBYWYQ9
        PyFFOuLpkrDsfhk12xSSW5kMkiWA
X-Google-Smtp-Source: APXvYqwsskmgauv+Q0vPsOYaT6yTGHkhNSIYNd+V0rcxltvmMQfK/ztEu+Pax/fFbvyJe2KfI6Pfyg==
X-Received: by 2002:a05:6808:499:: with SMTP id z25mr1294697oid.62.1575327411717;
        Mon, 02 Dec 2019 14:56:51 -0800 (PST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id o4sm353929ota.57.2019.12.02.14.56.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 14:56:51 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id p8so1100404oth.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 14:56:50 -0800 (PST)
X-Received: by 2002:a9d:6745:: with SMTP id w5mr1041681otm.221.1575327410613;
 Mon, 02 Dec 2019 14:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
 <7beef282-1dd8-7c7a-4f6d-d0605d11eab5@kernel.org> <fb810251-f444-bd5d-54e3-774d2e1ccdb9@rasmusvillemoes.dk>
In-Reply-To: <fb810251-f444-bd5d-54e3-774d2e1ccdb9@rasmusvillemoes.dk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 2 Dec 2019 16:56:39 -0600
X-Gmail-Original-Message-ID: <CADRPPNSXS95DCpbnEG14tN7H4uxo7kFb8-azMU+MfPStyRcdpQ@mail.gmail.com>
Message-ID: <CADRPPNSXS95DCpbnEG14tN7H4uxo7kFb8-azMU+MfPStyRcdpQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/49] QUICC Engine support on ARM, ARM64, PPC64
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Miller <davem@davemloft.net>
Cc:     Timur Tabi <timur@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 2:14 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 01/12/2019 17.10, Timur Tabi wrote:
> > On 11/28/19 8:55 AM, Rasmus Villemoes wrote:
> >> There have been several attempts in the past few years to allow
> >> building the QUICC engine drivers for platforms other than PPC32. This
> >> is yet another attempt.
> >>
> >> v5 can be found
> >> here:https://lore.kernel.org/lkml/20191118112324.22725-1-linux@rasmusvillemoes.dk/
> >>
> >
> > If it helps:
> >
> > Entire series:
> > Acked-by: Timur Tabi <timur@kernel.org>
>
> Thanks. I'll leave it to Li Yang whether to apply that - they already
> all (except for the last-minute build fix) have your R-b.
>
> Li Yang, any chance you could pick up these patches so they have plenty
> of time in -next until 5.6?

Sure.  I will.  I'm waiting for the Ack from David on the networking side.

Regards,
Leo
