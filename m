Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C54AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D958020700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfC1IFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:05:40 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40119 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1IFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:05:40 -0400
Received: by mail-vk1-f193.google.com with SMTP id l17so4311667vke.7;
        Thu, 28 Mar 2019 01:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1l+MpBVZScAXtCz01M3zXlY6CntX0jIq/2tr27fzXU=;
        b=CtDW1LHiW+xmiizsqtqhgaXfKYA4MPO21KytyFjyugsrVsxzCdk2m9uQc91xpKpEvt
         rfrZEo2STyHpv8DlLy+wXVcsEepwVvvn/qfvID/GWjumYxnEgCZgtGDhiGnuDDthEY7B
         flhq/ltNWbDksj37TaZhkDW2h8v4r/hJiXZYCkgS5fVIwbEedwcoAuvlQ+Tk2oS8G/fz
         +koN1dPRrEmJuenLXVIFI+UlmfAOo5XiV1DHenBjKn5vm3RcuB1xBuWFqRdsLvi3Pliy
         n3MUZG9P+G/jpAnDIQM8M8IYU+tyWi22C11VUyw+ulmd3A7dEY8K8l7b+YcwcpCthMTF
         qlfg==
X-Gm-Message-State: APjAAAUiF6HVYTePQGB4hwT8Ym5hm2qAgE4e/ESUWS3bTlWsQxL1JW1j
        qB3nHdo9bPVb/2D2ae1BSiJOKe3IvXexstu94v8=
X-Google-Smtp-Source: APXvYqzw2g+z2LssFIUYHXCRFbJFf4F5u9id0znF+qlaGD+WVKQiojvPk7TH+CF0MsH26vGNIX23zLy+STyV+VvcScQ=
X-Received: by 2002:a1f:b297:: with SMTP id b145mr2760855vkf.74.1553760339137;
 Thu, 28 Mar 2019 01:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
In-Reply-To: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Mar 2019 09:05:27 +0100
Message-ID: <CAMuHMdW8cRARXmGbCeuAzuY4XPyqmrKTKO_NrRiWudK-kQ4M9A@mail.gmail.com>
Subject: Re: [RESEND PATCH] thermal: rcar_gen3_thermal: Fix init value of
 IRQCTL register
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>, Jiri Slaby <jslaby@suse.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>,
        =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>,
        =?UTF-8?B?44Kr44Kq44O744O044Kh44Oz44O744OJ44Oz?= 
        <cv-dong@jinso.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:04 AM Nguyen An Hoan <na-hoan@jinso.co.jp> wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>
> Fix setting value for IRQCTL register. We are setting the last 6 bits
> of (IRQCTL) to be 1 (0x3f), this is only suitable for H3ES1.*, according
> to Hardware manual values 1 are "setting prohibited" for Gen3.
>
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
