Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA01C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27586205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3dKfMHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLCL0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:26:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46604 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCL0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:26:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id f5so2962095qkm.13;
        Tue, 03 Dec 2019 03:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNn5TDbf69hXamg6gs0Uhqk5YkGLvEavoffmPct4yOE=;
        b=E3dKfMHMUpS80HpjYCPawdIc0XZf/wwfwQNRjsYXHRz0xcED7mSpdDf07odwVlBN4b
         F/gyO5frvlt5ofJV0359blm+xLwJ1lGJHtZONliQ41H5on0QmgZRtkOK6edm8UHDZyqn
         ppkkKcMyJHmyCxPekRmlweSaKu2Hxfv7i+ShedaTP8BxmPz+cAIT9KB8igrmQgZiCCyl
         rE2iXsb0p1cJwwGGroAJTSH0A19C7ghQRezMf4mD+fDU0VGzIGYPK90OO8lAL1BHbhJB
         IC4iJRyb5hDrj/NaPVSdslC+QnKBlnVs8mzhpqevhmpg30oAWNhSq0Uc3Vd8AGBdAjmW
         uthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNn5TDbf69hXamg6gs0Uhqk5YkGLvEavoffmPct4yOE=;
        b=IwtuUXbZXBKlfBGmosK9nOMYdn5TppFI130iUvZ28Y1cc1CmS0NDHszr2w13VJljGl
         tpWvuKoFiWoxjKPCRPhGIUY44uLuBMnOYXsDtNbfpSg4A3s3o27Tkbwau7aceOhSqtUg
         iMkfgD12TLT9oRQy9+wvQBGjqg65xVl8I2Usn/plEVua8EVGrIKp94Yk+PQ1j1pAfooF
         JJoo8megzsQ7QuqzaSAoTQZ+eF+5xwKkxdFNs8k1XK4ZUAdZroaFpDiLMCDSIDc1uahw
         xtsXb0X4RVJMS+RtTnjA1ZFT0bJDuNNQBtn6tmBubwKUDEcKt2nYIMu3MTbXHHSsknk3
         somw==
X-Gm-Message-State: APjAAAUHq0V3KSzUEu8JtLx1G+AjY6GClDF10MIfSkoIpLfmAxvw95mH
        V2jbZirbfyWKga5vgvKWVmH9JYLGQDTLqmcPK48=
X-Google-Smtp-Source: APXvYqxdD4VR3xr+PfdSAWs9iKb4hbzHtiubcoqDjTPZPP1A5SAPbEiQoPb9h+OAAtqW08Cj2JokHdDn0o0zymsqRUM=
X-Received: by 2002:a37:6653:: with SMTP id a80mr4434002qkc.123.1575372362588;
 Tue, 03 Dec 2019 03:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20191201054219.13146-1-Jieun.Kim4758@gmail.com>
 <201912011539.mNLLB6ra%lkp@intel.com> <20191202173909.GA15687@redhat.com>
In-Reply-To: <20191202173909.GA15687@redhat.com>
From:   Jieun Kim <jieun.kim4758@gmail.com>
Date:   Tue, 3 Dec 2019 20:25:51 +0900
Message-ID: <CABjvjx27vwFgm8OeOY+mHtHOfsYSxabiAkQ5KDguVcStZ=He1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: md: dm-log.c: Remove unused variable 'sz'
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.
I'm sorry for the compile error. I realized that 'sz' is still used.
Next time, i will keep in mind to check out the compile result
correctly before submitting patches.

On Tue, Dec 3, 2019 at 2:39 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> As you can see below: your patches to remove the seemingly unused sz
> variables won't even compile.  The sz variable is used by the DMEMIT()
> macro.
>
> Nacked-by: Mike Snitzer <snitzer@redhat.com>
>
> On Sun, Dec 01 2019 at  2:46am -0500,
> kbuild test robot <lkp@intel.com> wrote:
>
> > Hi Jieun,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on dm/for-next]
> > [also build test ERROR on v5.4 next-20191129]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Jieun-Kim/drivers-md-dm-log-c-Remove-unused-variable-sz/20191201-134548
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
> > config: i386-defconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All error/warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/dm-dirty-log.h:16:0,
> >                     from drivers/md/dm-log.c:13:
> >    drivers/md/dm-log.c: In function 'core_status':
> > >> include/linux/device-mapper.h:551:22: error: 'sz' undeclared (first use in this function); did you mean 's8'?
> >     #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
> >                          ^
> > >> drivers/md/dm-log.c:788:3: note: in expansion of macro 'DMEMIT'
> >       DMEMIT("1 %s", log->type->name);
> >       ^~~~~~
> >    include/linux/device-mapper.h:551:22: note: each undeclared identifier is reported only once for each function it appears in
> >     #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
> >                          ^
> > >> drivers/md/dm-log.c:788:3: note: in expansion of macro 'DMEMIT'
> >       DMEMIT("1 %s", log->type->name);
> >       ^~~~~~
> > --
> >    In file included from include/linux/dm-dirty-log.h:16:0,
> >                     from drivers//md/dm-log.c:13:
> >    drivers//md/dm-log.c: In function 'core_status':
> > >> include/linux/device-mapper.h:551:22: error: 'sz' undeclared (first use in this function); did you mean 's8'?
> >     #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
> >                          ^
> >    drivers//md/dm-log.c:788:3: note: in expansion of macro 'DMEMIT'
> >       DMEMIT("1 %s", log->type->name);
> >       ^~~~~~
> >    include/linux/device-mapper.h:551:22: note: each undeclared identifier is reported only once for each function it appears in
> >     #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
> >                          ^
> >    drivers//md/dm-log.c:788:3: note: in expansion of macro 'DMEMIT'
> >       DMEMIT("1 %s", log->type->name);
> >       ^~~~~~
> >
> > vim +/DMEMIT +788 drivers/md/dm-log.c
> >
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  776
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  777  #define    DMEMIT_SYNC \
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  778     if (lc->sync != DEFAULTSYNC) \
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  779             DMEMIT("%ssync ", lc->sync == NOSYNC ? "no" : "")
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  780
> > 416cd17b198221 Heinz Mauelshagen  2008-04-24  781  static int core_status(struct dm_dirty_log *log, status_type_t status,
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  782                    char *result, unsigned int maxlen)
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  783  {
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  784     struct log_c *lc = log->context;
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  785
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  786     switch(status) {
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  787     case STATUSTYPE_INFO:
> > 315dcc226f066c Jonathan E Brassow 2007-05-09 @788             DMEMIT("1 %s", log->type->name);
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  789             break;
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  790
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  791     case STATUSTYPE_TABLE:
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  792             DMEMIT("%s %u %u ", log->type->name,
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  793                    lc->sync == DEFAULTSYNC ? 1 : 2, lc->region_size);
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  794             DMEMIT_SYNC;
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  795     }
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  796
> > 2a79ee10b97355 Jieun Kim          2019-12-01  797     return 0;
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  798  }
> > ^1da177e4c3f41 Linus Torvalds     2005-04-16  799
> >
> > :::::: The code at line 788 was first introduced by commit
> > :::::: 315dcc226f066c1d3cef79283dcde807fe0e32d1 dm log: report fault status
> >
> > :::::: TO: Jonathan E Brassow <jbrassow@redhat.com>
> > :::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>
> >
> > ---
> > 0-DAY kernel test infrastructure                 Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
>
>
