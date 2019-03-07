Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852DF20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551918319;
	bh=DxxJi/UnfBJx/V5irnr9NcpGGM1muIvgW4/4PgPC9VA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N4bswA3epEmptw7wpLZ9trE8ANHeTbf8dH4/49zWEiXOWw5pVQYiaR4MSmy3IA159
	 U90GTHOMlR3CkumJodXTlEVFvrlxxeZAlVbz2o+EdOW0dqPE09+Mp/qR4DHEvZcEA+
	 CqFlFX6Z0cnNdBkAkRUSNjDwvo0Q6pGh5zWUzDaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCGAZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:25:17 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40663 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCGAZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:25:17 -0500
Received: by mail-lj1-f181.google.com with SMTP id w6so12582795ljd.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVqygTjaZysAF5htR2hsk4Vzx9iUfkDalVCMullUfAY=;
        b=c23H9I/FKAg5W9/71gf3PWUEMcejNuvsCVCp2joqP2fhbSdq4O5N0NXRa/rAVj0glq
         vjblmsg/iQjqDqOLWKVn49/U3SJxT6nmcaBbG8/Zm9qrTA0w1r0YcMiCoD0FgKQgfapJ
         +2bZOePTK4ezi62L+8f2tM12YUf4qA5DuvnKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVqygTjaZysAF5htR2hsk4Vzx9iUfkDalVCMullUfAY=;
        b=omW6wq4LcxiZ3rEboo+8CiTdj58NBMbYG2b1N2ksuWVFeWIDTOB0zDtp7epoCyj1tK
         wYmLrKJgfusxjtmxgx77QfjmJQUWEssQBPyBaEKgeDRw9cyTroHZ0Mxu34fyO6bqpXzm
         UEzORpU4Lw0B2uSla8mnnfZeANY5PRyKk0wLn5OguQE//agGxn48cbgoKnmD1d/KAvK5
         /6oXD+azRyajOV7GwqLCzbq+PDwXUTzmWBUF5Lk49l5Z5KfhIMLrgU0KuJdIxSmOQKXk
         0U7Z4T2qX8guXRlnUPLE95gS/4rR9651mjo3JtWv5Qff+Yy9QQZkAMLIgMJM3Jm5QLE2
         XC9g==
X-Gm-Message-State: APjAAAVi35dZnHLDsw9yt+SzhU9s9ptvMWVVC0+iFMfUlBIzylhYIViS
        /OuLXILvg11FHJiJD5lq9e9RDr2aQZo=
X-Google-Smtp-Source: APXvYqyVpPF6F34wICP70TIRKx5DpwTbbmG0UNbZ6pAjeuEo9NxKgnnMQKYIsL9TD/6RT+IDuX0OUA==
X-Received: by 2002:a2e:711b:: with SMTP id m27mr3944097ljc.141.1551918314154;
        Wed, 06 Mar 2019 16:25:14 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e13sm562523lfg.78.2019.03.06.16.25.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:25:13 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 199so12603505ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:25:12 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr4042122lji.135.1551918312419;
 Wed, 06 Mar 2019 16:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20190306103350.GA10570@kroah.com> <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
 <d596d6db449d4747b3eebf4cb42f6657ad42f989.camel@perches.com> <CAHk-=wi5D-fZBjiqo30XgmXJPpmLxTJvJKEDqHCAFiZo9QWC_w@mail.gmail.com>
In-Reply-To: <CAHk-=wi5D-fZBjiqo30XgmXJPpmLxTJvJKEDqHCAFiZo9QWC_w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 16:24:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3QTQyrsU5i8V=Bgi4B-29Sgyt9rVnhdLrFZuTPftWKw@mail.gmail.com>
Message-ID: <CAHk-=wh3QTQyrsU5i8V=Bgi4B-29Sgyt9rVnhdLrFZuTPftWKw@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.1-rc1
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 4:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> > btw; what compiler version?
>
>   gcc version 8.2.1 20181215 (Red Hat 8.2.1-6) (GCC)

Oh, and also did a dnf upgrade, and the same thing happens with

   gcc version 8.3.1 20190223 (Red Hat 8.3.1-2) (GCC)

too.

           Linus
