Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F8620640
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duvSWVpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfLBRjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:39:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32962 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727453AbfLBRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575308356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9SCc8Xb67Rv4f8yElCapS2tmzETNbHoXGURUx3SfYE=;
        b=duvSWVpWgC8eOqQWdG+Oe2LQU7yVei7F+GX9H64yHFaCM3sTE03unDgZum2RIMW1/EngOX
        sHdV615kpB+HCV56cszomf3AD7RtzFadPcH5LGTtjdzyV6H3f7qYi6ZTcOVFwaVfpeNgwU
        i9ifaMFG9hGrxGy1PRx+Lud2V+8rdNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-EaFkpV5kP-SoZ2jY9GHt0A-1; Mon, 02 Dec 2019 12:39:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40EE2800D54;
        Mon,  2 Dec 2019 17:39:14 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F14F35D9E5;
        Mon,  2 Dec 2019 17:39:10 +0000 (UTC)
Date:   Mon, 2 Dec 2019 12:39:10 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jieun Kim <jieun.kim4758@gmail.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: md: dm-log.c: Remove unused variable 'sz'
Message-ID: <20191202173909.GA15687@redhat.com>
References: <20191201054219.13146-1-Jieun.Kim4758@gmail.com>
 <201912011539.mNLLB6ra%lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <201912011539.mNLLB6ra%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: EaFkpV5kP-SoZ2jY9GHt0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you can see below: your patches to remove the seemingly unused sz
variables won't even compile.  The sz variable is used by the DMEMIT()
macro.

Nacked-by: Mike Snitzer <snitzer@redhat.com>

On Sun, Dec 01 2019 at  2:46am -0500,
kbuild test robot <lkp@intel.com> wrote:

> Hi Jieun,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on dm/for-next]
> [also build test ERROR on v5.4 next-20191129]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>=20
> url:    https://github.com/0day-ci/linux/commits/Jieun-Kim/drivers-md-dm-=
log-c-Remove-unused-variable-sz/20191201-134548
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/lin=
ux-dm.git for-next
> config: i386-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>    In file included from include/linux/dm-dirty-log.h:16:0,
>                     from drivers/md/dm-log.c:13:
>    drivers/md/dm-log.c: In function 'core_status':
> >> include/linux/device-mapper.h:551:22: error: 'sz' undeclared (first us=
e in this function); did you mean 's8'?
>     #define DMEMIT(x...) sz +=3D ((sz >=3D maxlen) ? \
>                          ^
> >> drivers/md/dm-log.c:788:3: note: in expansion of macro 'DMEMIT'
>       DMEMIT("1 %s", log->type->name);
>       ^~~~~~
>    include/linux/device-mapper.h:551:22: note: each undeclared identifier=
 is reported only once for each function it appears in
>     #define DMEMIT(x...) sz +=3D ((sz >=3D maxlen) ? \
>                          ^
> >> drivers/md/dm-log.c:788:3: note: in expansion of macro 'DMEMIT'
>       DMEMIT("1 %s", log->type->name);
>       ^~~~~~
> --
>    In file included from include/linux/dm-dirty-log.h:16:0,
>                     from drivers//md/dm-log.c:13:
>    drivers//md/dm-log.c: In function 'core_status':
> >> include/linux/device-mapper.h:551:22: error: 'sz' undeclared (first us=
e in this function); did you mean 's8'?
>     #define DMEMIT(x...) sz +=3D ((sz >=3D maxlen) ? \
>                          ^
>    drivers//md/dm-log.c:788:3: note: in expansion of macro 'DMEMIT'
>       DMEMIT("1 %s", log->type->name);
>       ^~~~~~
>    include/linux/device-mapper.h:551:22: note: each undeclared identifier=
 is reported only once for each function it appears in
>     #define DMEMIT(x...) sz +=3D ((sz >=3D maxlen) ? \
>                          ^
>    drivers//md/dm-log.c:788:3: note: in expansion of macro 'DMEMIT'
>       DMEMIT("1 %s", log->type->name);
>       ^~~~~~
>=20
> vim +/DMEMIT +788 drivers/md/dm-log.c
>=20
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  776 =20
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  777  #define=09DMEMIT_SYNC =
\
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  778  =09if (lc->sync !=3D D=
EFAULTSYNC) \
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  779  =09=09DMEMIT("%ssync "=
, lc->sync =3D=3D NOSYNC ? "no" : "")
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  780 =20
> 416cd17b198221 Heinz Mauelshagen  2008-04-24  781  static int core_status=
(struct dm_dirty_log *log, status_type_t status,
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  782  =09=09       char *res=
ult, unsigned int maxlen)
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  783  {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  784  =09struct log_c *lc =
=3D log->context;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  785 =20
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  786  =09switch(status) {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  787  =09case STATUSTYPE_INF=
O:
> 315dcc226f066c Jonathan E Brassow 2007-05-09 @788  =09=09DMEMIT("1 %s", l=
og->type->name);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  789  =09=09break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  790 =20
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  791  =09case STATUSTYPE_TAB=
LE:
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  792  =09=09DMEMIT("%s %u %u=
 ", log->type->name,
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  793  =09=09       lc->sync =
=3D=3D DEFAULTSYNC ? 1 : 2, lc->region_size);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  794  =09=09DMEMIT_SYNC;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  795  =09}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  796 =20
> 2a79ee10b97355 Jieun Kim          2019-12-01  797  =09return 0;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  798  }
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  799 =20
>=20
> :::::: The code at line 788 was first introduced by commit
> :::::: 315dcc226f066c1d3cef79283dcde807fe0e32d1 dm log: report fault stat=
us
>=20
> :::::: TO: Jonathan E Brassow <jbrassow@redhat.com>
> :::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>
>=20
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology C=
enter
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corpor=
ation


