Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6625C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF6206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfH0Lfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:35:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40756 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfH0Lfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:35:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id c34so18328063otb.7;
        Tue, 27 Aug 2019 04:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgUvI1wVdSFC0r3GWCGOcOGlAvlCeJNAArDfqz2GV1k=;
        b=I4CagTJE3EVAtgKPf4ZGNm7QYXmp9VRtYN9P9x1/vDXIyAmKWjUbO38pHY7gIcaTz3
         w7VeUXdcRTJJ388fFsHOL5Kcly7okrSnay+NHdAyh3Uu1em0r+TdAAhRxsWRtSrfquq3
         /62/mSm868An5rLFb82p2aR09wQaOlOUpj0vklQumbGEs2f5f5ppt1szmaTkSm+OJMte
         Ih4blBgTy6pslu/8hp/aK2FGrFMeLJ8C7ruYtfYW+aQ5SLbh70xOUP26yq7GwrVdyy3x
         1vjoWuitnnO98xnnijKo9LiWBo3FAsWhvyJrhhn9WRSHqT2uc003MUHgELdlgh6TBF10
         iXSA==
X-Gm-Message-State: APjAAAVdwAg53aMRlJXVW/SCJhWd2lUrd5QIs9p+oIG5RkT7xxngnVV+
        nClbXubZQbbpIQ2h72BFpHE/iXcixBg05K5Zg8xPFQ==
X-Google-Smtp-Source: APXvYqzuGRUVrGBTfkJoYYJQgr8dVEdnTZQskFtZVIjmdFjAZjxzC+aNUz5mk5WeR+CUiF+4cLB91dqn+MuGu6EAMv4=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr19650606otn.297.1566905730406;
 Tue, 27 Aug 2019 04:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190827110854.12574-1-peda@axentia.se> <20190827110854.12574-4-peda@axentia.se>
In-Reply-To: <20190827110854.12574-4-peda@axentia.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 13:35:19 +0200
Message-ID: <CAMuHMdVkqX7x_D5nf01s-kE=o+y5OLM-5fd3q=2RDKGTcpCfHg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fbdev: fbmem: avoid exporting fb_center_logo
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Aug 27, 2019 at 1:09 PM Peter Rosin <peda@axentia.se> wrote:
> The variable is only ever used from fbcon.c which is linked into the
> same module. Therefore, the export is not needed.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

But note that the same is true for fb_class, so perhaps it can be added
(or better, removed ;-)?

Once drivers/staging/olpc_dcon/olpc_dcon.c stops abusing registered_fb[]
and num_registered_fb, those can go, too.

Does anyone remembe why au1200fb calls fb_prepare_logo() and fb_show_logo()
itself?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
