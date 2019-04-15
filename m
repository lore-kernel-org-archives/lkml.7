Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD296C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9035E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfDOUiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:38:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42946 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfDOUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:38:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so14972570oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBPgghKolr/TwY6VzN4rOO79Lc0HDTnrp0IaTUpf5BU=;
        b=DDSSx4vXgoUN1BZwNeLG64+s5bm4DwPRgFlnXNpX2XIDmGbKSbQvTGz1nJONdvw/tE
         xdf7kiUAjjsbQc7qvsYuJvw8w1soUUIK4zDSzzn7RJdvYrt86n/s7LEboWiOpKoKuqoo
         xYGfCKax8Wvff91EaIe2oAr1V6jLDyUOQPF6QxxETu6y289NO4TXCTyKhxNaf+qyC2p1
         UumSz44lXJzQBKCNqz5OHgU3dCCb1t1THAcGgVMfPg8tE8zQtmcmE0ViH1+cleDdF9Ek
         arGu5x0LLC5ZdlpAvzHpuyxUVbow+l3WgroTesnh14Fwy+8iIURC6iLxphGJj5xLxooV
         Xihw==
X-Gm-Message-State: APjAAAUyhtQp6Qc7f8nNztnUUSiiSg/d+K0ppRr+k5Ee2T6MoA4ze+M2
        iyVljeh22NofJczIr4VrCZovmt5a
X-Google-Smtp-Source: APXvYqxNPXx6b2TB5WZJjPXJBA5L993LWVXUtY0LOC0GLX6d7I/aHrPJybFL1gJN9GM18xsXL77VxQ==
X-Received: by 2002:aca:c782:: with SMTP id x124mr21397049oif.61.1555360730676;
        Mon, 15 Apr 2019 13:38:50 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id s26sm1025925otk.24.2019.04.15.13.38.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:38:50 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id c16so15680985otn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:38:50 -0700 (PDT)
X-Received: by 2002:a9d:186:: with SMTP id e6mr26614013ote.258.1555360730111;
 Mon, 15 Apr 2019 13:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <1554457764-7027-1-git-send-email-ioana.ciornei@nxp.com> <CADRPPNR0VqCZvyRvdTRAeNYWX5qgVTGrhDab5Y=mR9r9UJy-4w@mail.gmail.com>
In-Reply-To: <CADRPPNR0VqCZvyRvdTRAeNYWX5qgVTGrhDab5Y=mR9r9UJy-4w@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 15 Apr 2019 15:38:39 -0500
X-Gmail-Original-Message-ID: <CADRPPNSU74Uexegdvo4Vbe32UD-yUDzMAG=pEs+7MENgZYCfOQ@mail.gmail.com>
Message-ID: <CADRPPNSU74Uexegdvo4Vbe32UD-yUDzMAG=pEs+7MENgZYCfOQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: fsl: add DPAA2 console support
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 3:15 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Fri, Apr 5, 2019 at 4:51 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
> >
> > This patch adds DPAA2 MC and AIOP console log support.
> >
> > The platform driver probes on the "fsl,dpaa2-console" device tree node
> > which describes the base firmware address needed in order to infer the
> > start address of both firmware logs: MC and AIOP.
> > It then exports two misc char devices which can be used to dump
> > the needed logs.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
>
> Applied to soc-fsl for next.  Thanks.

Patch updated on next after fixing sparse warnings.

Regards,
Leo
