Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E83C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CD12067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeiUrKut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfD0HVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:21:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41749 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0HVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:21:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id v23so4571939oif.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 00:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhLA4X+a5rMjmgHTPodvSWDw3ddBPwuLk4iywBiynBU=;
        b=QeiUrKut3FEsTH1x42QQzm0y57di//P8DpDlWt4OjnwnoYoIUIA41fPUsLUwGWHvKJ
         r37+tOup3+pTgUb453VWuJi6nw/QXyLU+si2A22zzUQsu/QXa4RzD83EJ93fjKBkubv1
         pybLEs3d95fpGBfrHkyVxB1hJiZqQr/fVNkCRT9hawKoLIXIbRWxWMMomDVTEX79haC3
         bSwwOn4LTCMjsnqtib6Lsnl+AZ4eN2e5sdppFaIsmK0l8eNYHCrZncoyu0uNo04d1caZ
         KSEs3/u8meolvncYTE914ZflfaFWuLhj0I0FFSPFnN70t8T9d9+feAK0HU6ZHgT2KGe1
         biMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhLA4X+a5rMjmgHTPodvSWDw3ddBPwuLk4iywBiynBU=;
        b=txTe/oY0FgVINaps0tv6BnuM4fsEsDuuQVFoNX1EGmiuWd1DtccOOh9o0W8PKiuQ29
         pkEUD35Dqx/4qVXuhfc910FtCC5T9sO4bSWZc/NJZZkebYgCatlaNKcRiRTaUAkf2xYA
         V+XvaUQjb7RuKabcJBkDZPH75QgvKNAkp5+0cYIEIkForVJVeKfhLOp+IdssXjd46fde
         DWxTHffP1pWtEAigZYtQCveHbrmHmsOoKikQYNjPgROOP8Z5uQIi1KkMWRZIjXsZWPnC
         Ky9HJZH6TuxmPKVUOrb+7t13pP3+JjEkC65RyJByZRf571mLdNj1EnsVD5PYCdz/7snG
         RDqQ==
X-Gm-Message-State: APjAAAVoyeLSTsxxsLTVaNSoh41eWKBJcpmb+PW5moiOVfmGgyuNbsNF
        Jdu8EnyEJI/QAqFyAqwplJ83V6D3V6ZSThHA15ANdXlW
X-Google-Smtp-Source: APXvYqwPwsTZHdPKhGJaSYtB9lz4zVOVaLWbbof/ytOS23yHhDq94/FTbQscRXXwAPLbgiQiE1OaRoYuvc9IH1t12b8=
X-Received: by 2002:aca:4202:: with SMTP id p2mr8930068oia.169.1556349665179;
 Sat, 27 Apr 2019 00:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <1556339208-7722-1-git-send-email-hofrat@osadl.org>
 <CAGngYiXBrNu7Jrk535=L89-mOSNx-6EfqL=1EwwG49Sf44R0Vg@mail.gmail.com> <20190427070021.GA2290@osadl.at>
In-Reply-To: <20190427070021.GA2290@osadl.at>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 27 Apr 2019 03:20:54 -0400
Message-ID: <CAGngYiX-s6dCc5focdXW5WYaiWiBF=dzacqFjSvXggvdxD3zAQ@mail.gmail.com>
Subject: Re: [PATCH RFC] staging: fieldbus: anybus-s: use proper type for wait_for_completion_timeout
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 3:01 AM Nicholas Mc Guire <der.herr@hofr.at> wrote:
> > > (some unrelated sparse warnings (cast to restricted __be16))
> >
> > That sounds interesting too. Could you provide more details?
>
> make C=1
> drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
> drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
> drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
> drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
> drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted

regmap_bulk_read(cd->regmap, REG_FIELDBUS_TYPE, &fieldbus_type,
        sizeof(fieldbus_type));
fieldbus_type = be16_to_cpu(fieldbus_type);

Probably because the parameter to be16_to_cpu() should be __be16.
Would you like to spin a separate patch for this too? Or shall I?

> I'll send the V2 later today then.

Thank you !
