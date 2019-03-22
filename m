Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E03C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89CD218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCVI4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:56:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:35747 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfCVI4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:56:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 01:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="asc'?scan'208";a="129196070"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 22 Mar 2019 01:56:14 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC] Allowing modules to control tracing subsystem
Date:   Fri, 22 Mar 2019 10:56:10 +0200
Message-ID: <87h8bvffth.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi guys,

I've been thinking about turning my f-trace.c USB function [1] into an
implementation of the USB Debug Class [2]. In order to support all
requests, I would need means to control parts of the tracing subsystem,
for example enabling and disabling tracing, flushing the trace buffer,
changing trace buffer size, choose which trace events to enable, etc.

Some of those functions (e.g. print_trace_line()) are available for
things like trace_kdb.c [3], but they're not available for modules;
i.e. they're not exported symbols.

This will involve a rather large change to tracing subsystem however we
could rely on such infrastructure for remote debugging of e.g. IVIs,
phones, etc.

The USB Debug Class already predicts the presence of JTAG access and
Hardware tracing modules to be exported over USB. It also allows for
GDB-type access. Adding our linux kernel tracing would make it into a
complete tracing solution.

In order to fully support this we would need, not only to expose some
internal trace functions for modules, but I suppose the trace format
would have to be slightly better defined so that it be decoded remotely
give access to vmlinux.

What do you guys think about this? Would this be something that folks
would be interested in? Currently we can only export ftrace data, not
trace events or anything else. Ideally we would export raw trace buffer
entries to be decoded at a later moment.

cheers

[1] https://marc.info/?i=3D20190321094748.7031-1-felipe.balbi@linux.intel.c=
om
[2] https://www.usb.org/sites/default/files/documents/usb_debug_class_rev_1=
_0_final_0.pdf
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/trace/trace_kdb.c#n20

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyUoyoACgkQzL64meEa
mQbbRg/7BMCGnkVhR0Fm71yJeRWftXIuTTvOV6tCFIqoK+PrQ4Ev98tVZ7mcHpRI
dYQFh+9CLDIlOu/e91E+nCQEeE7yJ5UnDTz7DmpcDRdJ/nzvP1Jglfzcul8oxABe
LdP5nweW/zDzSXn5DuYvL38Js+mYcWtODx3dg+RGNUXkLRkxdgSAoxpWVCZERrso
xFYMpK+qLztqB6LOn1rJh/EctEZlsJyDDix7jaoOkEyKsakkGJHG9uU9mDzl3WTM
IVhIGoJ32RI18qugTZ89lZIrjEbr6I/Mlns24bgOJU+x3LO7/uqPY87gQZSqibSB
sub9forJRPs7iUxmjNAqfR51XxyQ9yu4HRXSFnWuBvOvVhq33xfRqgwSs4njtBQc
ZLj7EMJ+UOnVop8//uDxkEeppnRjLXD3Yo3K1eW1uJC/wjKqL8riWifEhbEHCyVX
4AqZE5ssoE18RCduoXGf2N3/BKVqTbEo2JVaYeXLuCwK0AXsH63w0Qsa/LLT90kd
GKmOowgC6fbW02Gmg0dheMwJhbYErUpZZ2eRxoDt29mI4qD3122Hb6R2rR9h8LgN
T1uApLwOdwg7XfiMQwux6M7F+4wGseEUYOb1o8H4cOg7DeC6TCsV1xElOwDiUvVJ
tIoptUEB+xa1grtVnbJxw3u43iRqG9jmvt5S92GeC5vi3Lq8TDs=
=WTws
-----END PGP SIGNATURE-----
--=-=-=--
