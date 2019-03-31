Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874CA20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="D2kttabG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfCaRta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:49:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33022 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbfCaRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:49:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so13733152wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9OU9Lj4qFWVXxFm6r/i0BpMX8i5DXMWXJH3S9m4beI=;
        b=D2kttabGkAex/H1jBPJhyIF/RAbwL0iKr6s/RbAgttbjKCLL6oWxhNWR0HDK4LTRsG
         PKV8imzQoePZrODeJEmUP+TJ48kVxt1Omt0b2DAndH1N5TL05VWOHgpIsWSNzno3aBgX
         uiU06G4ro7x7i/9TQlPSafIms44yZh0iOh5jLqk6Tt3XUWkOosxVBU3Zh8YtrC8IMoAK
         wMmcY6t4u5Iec4FL4dEgWKlviEKj8qEmfzZEPPu2tJdZmfgzyRJ8FO8ME77d69iNeJzt
         Mufg1UUEkpT1kXxPaCVJKl9eeXv0dGDx9Ef1uyjUb9mYE2ZvH2+Me1qrxFYUp9O6RVDy
         zzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9OU9Lj4qFWVXxFm6r/i0BpMX8i5DXMWXJH3S9m4beI=;
        b=scL5EZkzKB+w4eMrEEB2lJbDH6/A9F3qQ8ASQa5wd5ursCoCd/Ho3apWlU/werByy0
         oy4aV7tQATn/flKxM+rF6LdWp/3cNt2VQJVNi/O026hdjsCr8eII7dcWulv8ehqyO1eZ
         fJ78Ye5UhT2TpoVCc6COVlUq+8p8Bq5iJFgsrgJDEeXOF2jwL7+SJOwpPOfBR6zfV0If
         I/qWf/P/e5rzum2uSx3v7zKusYUMAWLhSFgU8BmsFw8N7AmM/yAde/yHipNbpP22PdjR
         Oh6qsmsMhOrJbaG2JifEt/3PJkEDAyCj7OKiF2hbsDcwCpoNulQ33jjwC85UpUqBj0SR
         Gglw==
X-Gm-Message-State: APjAAAWBdKXO7BQljqfUTQ47YUU7/H2EL/Xpq9FKnf1UslAsR0QQ2SG2
        8rOYO/JsoetohuCUI2pV7MVzAmDZ/VE9+kBmoLZXfQ==
X-Google-Smtp-Source: APXvYqyfksbycu2oBJaiv37LczOn24vf/sfHLvadxdp/iD0MhKPlSi2F1AchsxoTKBC1GycPkkOnNWRMnGsZD0JPB1M=
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr3741213wmf.97.1554054568117;
 Sun, 31 Mar 2019 10:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <822122908.274859.1553944071609@ox-groupware.bfs.de>
In-Reply-To: <822122908.274859.1553944071609@ox-groupware.bfs.de>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Sun, 31 Mar 2019 19:49:18 +0200
Message-ID: <CAMGffE=byzyhREomahYv9-VfiTYd2K3NoKPJc0p9K3f5fwUKPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: pm8001: clean up structurally dead code when
 PM8001_USE_MSIX is defined
To:     Walter Harms <wharms@bfs.de>
Cc:     Colin King <colin.king@canonical.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        lindar_liu <lindar_liu@usish.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:07 PM Walter Harms <wharms@bfs.de> wrote:
>
> the ifdef jungle does not make thinks more readable. I am aware that
> using neg is also not good but in this special case it seems helpful
> to have only one branch, like:
>
> static u32 pm80xx_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
> {
> #ifndef PM8001_USE_MSIX
>         u32 value;
>
>         value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>         if (!value)
>                 return 0;
> #endif
>         return 1;
>
>   }
>
> just my 2 cents,
>
> re,
>  wh

Both version looks good to me, I've acked Colin's version.

Thanks!

-- 
Jack Wang
Linux Kernel Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 30 57700-8042 | Fax: +49 30 57700-8598
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de


Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim Weiss

Member of United Internet

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
