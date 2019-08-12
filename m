Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D71A206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfHLVJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:09:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35048 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHLVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:09:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id g17so13440373otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwrLPzNK2MFvq1QESV7imkM7uK+b56kHOC4f2KRqdjM=;
        b=jHSqEYTD5S5MJUIvO+zYgRVZqOHU4ElM+oqETh4cyI5/xNeVfC5RpP4CsVD+SJBnUd
         ANqZDCmWRx69FJ/HYSj0nAWUwVdo4sSuof3aJOZGuqMyTu/PQiwgwtBbv7NciIwF0yoa
         /QjOFQtJhzwcof5A3nkdmbetYb65CN7wV2zM7ApIwohgvlPh9Pz3TyYAIyOyD0j5o/ph
         A6wIN540pkGWJuI0OGWtJ4jSwdfYMX2902q9SKkib96ToGi56kWMQ63056pIXYrye3uT
         J+WnJcdXJX7Bn/ee6ZdDeIlAJaT06SIP7SQANuS68zsnHOz97vHPfhLEQ9BcNz/dRt09
         H7tA==
X-Gm-Message-State: APjAAAXhYIT7Yp65zYroADRyXvTbaA5xl6rN7JgZhsobrjZ9sq4KEduU
        o6oCisqx9b4KlC7Qpg6Qe2b3a42g8i3+PvQoL5Q=
X-Google-Smtp-Source: APXvYqzeAd1kl6RrmEP6tY+jjNbDeBOauI6sZEnoWILRlbR16znAHNv5D2NzQAiN+UBllL9M9JxhgxCzd7Monf/o2xo=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr32651042otn.297.1565644163741;
 Mon, 12 Aug 2019 14:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190812102049.27836-1-geert@linux-m68k.org> <a74dd048-8501-a973-5b03-eefbc83d7f79@infradead.org>
In-Reply-To: <a74dd048-8501-a973-5b03-eefbc83d7f79@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Aug 2019 23:09:12 +0200
Message-ID: <CAMuHMdVAKwTWeeT4H6NrzvRc2Fgav0owAqGjRtZawOLOf=HVAA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.3-rc4
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Aug 12, 2019 at 10:34 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 8/12/19 3:20 AM, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.3-rc4[1] compared to v5.2[2].
> >
> > Summarized:
> >   - build errors: +5/-1
> >   - build warnings: +137/-136
> >
> > JFYI, when comparing v5.3-rc4[1] to v5.3-rc3[3], the summaries are:
> >   - build errors: +0/-4
> >   - build warnings: +105/-69
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d45331b00ddb179e291766617259261c112db872/ (all 242 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0ecfebd2b52404ae0c54a878c872bb93363ada36/ (all 242 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e21a712a9685488f5ce80495b37b9fdbe96c230d/ (all 242 configs)
>
>
> > *** WARNINGS ***
> >
> > 137 warning regressions:
>
> >   + warning: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS:  => N/A

WARNING: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS:
8 warnings in 2 logs
        v5.3-rc4/um-x86_64/um-allyesconfig v5.3-rc4/um-x86_64/um-allmodconfig

> It would be Really Good if there was some automated way to know which
> of the 242 configs this is from (instead of you having to grep and reply to
> email or someone/me having to download up to 242 log files).

I used to upload the summary containing that info to kernel.org. Then they
made kup mandatory, and during the last 7 years, I still haven't looked into
mastering kup. Ugh...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
