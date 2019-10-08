Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D879CC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83D720673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaok6n+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfJHNbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:31:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44696 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:31:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so13972165otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlqTGKDatQ39JBp5MaCG8YiZeVo+Zi+HgwYgtcFJ7bM=;
        b=jaok6n+ftbtguoOgZOkoaVWuKNg/hT1AF+vvxUa8L6VaZYoJW9uTxf5UoaDdOCrqAy
         2twyG3ioLpAMv2NcmNn/qtjEoCt56r4R5NQZOcPbs6TH7Yfd3jcGYOq1T3rMj19Sf3jS
         CFwJDPFawl0ALy9+pHKRyZ0nbcXQZO4eaHgqn/EFiCMcrIEH7GJB16rAcH+R3rbkIwqL
         ZWadGRgNBVuWoCkowErXK473HPRGN72dATrIFSsUsR9OeVFDdlB5ayBOP3aL/dwianX5
         cRCO17gZhajg/Fgz0jJzmXz0S9vaCdKTvb9kyYB3DBha6o7de0BRT8TzF3SJT+2ynR/R
         woDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlqTGKDatQ39JBp5MaCG8YiZeVo+Zi+HgwYgtcFJ7bM=;
        b=MBxyUi+7wwP2lRs7M37uZr9Z+n0+LNq4Q5zBIgb/i2sbKqatjyo2WRTN+stjsbQ1Le
         Dsltdnq5Y7zlkLgiHubdt3M5drqEPOzoflUZD415jPojp4nhIkW21aKTQngVClRaA6+H
         Skzp/wPOMoZnMtbx8CZhfJTwL5Y6522CL8HzOc9qkm2kdljRV1AWWXZSDDT+qnll5iJL
         opv4XzZ+Hd4Njtiv7zEyCneclWKTFmWa71soXOUuRlswQali4lqogCesvMH8zsi175fq
         L7x+Dzn3f4rB1SBcenlAux/GTYurcaVTVmGVQl4VLFCMzwSabSx2HEWgm80ZiKUG3ucz
         ZFZw==
X-Gm-Message-State: APjAAAXmVu/RKrvUlVJXz8U/VDW1a6qKhk9CqTO2XFoMg2mRF+zK5Z64
        WLtgkikBa1a/AmX/ssDzllhYDo83EQBJe7wzJuY=
X-Google-Smtp-Source: APXvYqyig+ODteQZhBcuNLfnk8kQqZ1n49hWxgEP5iwlYTj+3wEOKyrlEHtnCkOS6uAJzNS1YDXiOcAVtIC9MQpRPnk=
X-Received: by 2002:a9d:7498:: with SMTP id t24mr26700822otk.0.1570541503407;
 Tue, 08 Oct 2019 06:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <1570515056-23589-1-git-send-email-hariprasad.kelam@gmail.com>
In-Reply-To: <1570515056-23589-1-git-send-email-hariprasad.kelam@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 8 Oct 2019 09:31:32 -0400
Message-ID: <CAGngYiX0zoAQB=SEoXfoMm9u_JzHu3eLErj4zmTYtSAoDwkp6Q@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: make use of devm_platform_ioremap_resource
To:     hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 2:11 AM hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>
> fix below issues reported by coccicheck
> drivers/staging//fieldbus/anybuss/arcx-anybus.c:135:1-5: WARNING: Use
> devm_platform_ioremap_resource for base
> drivers/staging//fieldbus/anybuss/arcx-anybus.c:248:1-14: WARNING: Use
> devm_platform_ioremap_resource for cd -> cpld_base
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/fieldbus/anybuss/arcx-anybus.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
Tested-by: Sven Van Asbroeck <TheSven73@gmail.com>
