Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5A1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE30208CC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8gqoaTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKSLGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:06:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbfKSLGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574161609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0N7/xxwg0d/r7DXcAG6jQ+ZB31mI3EeeQskppGYrvA=;
        b=i8gqoaTs/j+NbawGIJPcwCGTemHiytP+VKKCEuH3wspCG/hmSSjItQPVVIMjK6DIEPv0xH
        q4hAFnSL327z5CWuyWYYrXijTR8DVGSfXlaQMTfiB12/lcvNg6Jw2sv6ZpSRFLgZwr23Xh
        WV7WMblmkjkTQCu8GL0sUQUTKqj0Trc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-D0PsgCwEMhG0UUweei_-mg-1; Tue, 19 Nov 2019 06:06:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A734F477;
        Tue, 19 Nov 2019 11:06:44 +0000 (UTC)
Received: from krava (unknown [10.40.205.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id D97DF60BE0;
        Tue, 19 Nov 2019 11:06:41 +0000 (UTC)
Date:   Tue, 19 Nov 2019 12:06:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCHv2 0/2] perf tools: Share struct map after clone
Message-ID: <20191119110641.GC21165@krava>
References: <20191016082226.10325-1-jolsa@kernel.org>
 <20191023075517.GA22919@krava>
 <20191029205855.GA20826@krava>
 <20191118121400.GA14046@krava>
 <20191118214851.GA17315@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191118214851.GA17315@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: D0PsgCwEMhG0UUweei_-mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 06:48:51PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 18, 2019 at 01:14:00PM +0100, Jiri Olsa escreveu:
> > On Tue, Oct 29, 2019 at 09:58:55PM +0100, Jiri Olsa wrote:
> > > > >=20
> > > > > Also available in here:
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > > > >   perf/map_shared
>=20
> > > > I rebased to latest perf/core and pushed the branch out
>=20
> > > rebased and pushed out
> =20
> > heya,
> > I lost track of this.. what's the status, are you going with your
> > version, or is this one still in? I don't see any of them in latest
> > code..
>=20
> So, I'm still working on and off on this, current status is at:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=3Dp=
erf/map_share
>=20
> Its just one patch more than perf/core, the one that does the sharing.
>=20
> The thing is, as I'm going over all the fields in 'struct map', it seems
> that we'll end up with just one cacheline per instance, as there are
> things there that are not strictly related to a map, but to a map_group
> (unmap_ip/map_ip), or to a dso (maj, min, ino, ino_generation), and some
> need less than what is allocated to them.
>=20
> Current status is:
>=20
> [root@quaco ~]# pahole -C map ~acme/bin/perf
> struct map {
> =09union {
> =09=09struct rb_node rb_node __attribute__((__aligned__(8))); /*     0   =
 24 */
> =09=09struct list_head node;                   /*     0    16 */
> =09} __attribute__((__aligned__(8)));                                    =
           /*     0    24 */
> =09u64                        start;                /*    24     8 */
> =09u64                        end;                  /*    32     8 */
> =09_Bool                      erange_warned:1;      /*    40: 0  1 */
> =09_Bool                      priv:1;               /*    40: 1  1 */
>=20
> =09/* XXX 6 bits hole, try to pack */
> =09/* XXX 3 bytes hole, try to pack */
>=20
> =09u32                        prot;                 /*    44     4 */
> =09u64                        pgoff;                /*    48     8 */
> =09u64                        reloc;                /*    56     8 */
> =09/* --- cacheline 1 boundary (64 bytes) --- */
> =09u64                        (*map_ip)(struct map *, u64); /*    64     =
8 */
> =09u64                        (*unmap_ip)(struct map *, u64); /*    72   =
  8 */
> =09struct dso *               dso;                  /*    80     8 */
> =09refcount_t                 refcnt;               /*    88     4 */
> =09u32                        flags;                /*    92     4 */
>=20
> =09/* size: 96, cachelines: 2, members: 13 */
> =09/* sum members: 92, holes: 1, sum holes: 3 */
> =09/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits *=
/
> =09/* forced alignments: 1 */
> =09/* last cacheline: 32 bytes */
> } __attribute__((__aligned__(8)));
> [root@quaco ~]#
>=20
> This is with the tentative move of maj/min/ino/ino_generation to 'struct
> dso', but that needs more work to match the sort order that touches it
> "dcacheline", i.e. a map that comes with the same backing DSO but
> different values for those fields is not the same DSO, right?
>=20
> Right now with moving the maj/min/etc to dso, in the map_share patch we
> get the structure used to keep shared entries in the rb_tree at 40
> bytes, under one cacheline, while the full 'struct map' is 32 bytes more
> than one cacheline, so still good for sharing:
>=20
> [acme@quaco perf]$ pahole -C map_node ~/bin/perf
> struct map_node {
> =09union {
> =09=09struct rb_node rb_node __attribute__((__aligned__(8))); /*     0   =
 24 */
> =09=09struct list_head node;                   /*     0    16 */
> =09} __attribute__((__aligned__(8)));               /*     0    24 */
> =09refcount_t                 refcnt;               /*    24     4 */
> =09_Bool                      is_node:1;            /*    28: 0  1 */
>=20
> =09/* XXX 7 bits hole, try to pack */
> =09/* XXX 3 bytes hole, try to pack */
>=20
> =09struct map *               map;                  /*    32     8 */
>=20
> =09/* size: 40, cachelines: 1, members: 4 */
> =09/* sum members: 36, holes: 1, sum holes: 3 */
> =09/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 7 bits *=
/
> =09/* forced alignments: 1 */
> =09/* last cacheline: 40 bytes */
> } __attribute__((__aligned__(8)));
> [acme@quaco perf]$ pahole -C map ~/bin/perf
> struct map {
> =09union {
> =09=09struct rb_node rb_node __attribute__((__aligned__(8))); /*     0   =
 24 */
> =09=09struct list_head node;                   /*     0    16 */
> =09} __attribute__((__aligned__(8)));               /*     0    24 */
> =09refcount_t                 refcnt;               /*    24     4 */
> =09_Bool                      is_node:1;            /*    28: 0  1 */
> =09_Bool                      erange_warned:1;      /*    28: 1  1 */
> =09_Bool                      priv:1;               /*    28: 2  1 */
>=20
> =09/* XXX 5 bits hole, try to pack */
> =09/* XXX 3 bytes hole, try to pack */
>=20
> =09u64                        start;                /*    32     8 */
> =09u64                        end;                  /*    40     8 */
> =09u64                        pgoff;                /*    48     8 */
> =09u64                        reloc;                /*    56     8 */
> =09/* --- cacheline 1 boundary (64 bytes) --- */
> =09u64                        (*map_ip)(struct map *, u64); /*    64     =
8 */
> =09u64                        (*unmap_ip)(struct map *, u64); /*    72   =
  8 */
> =09struct dso *               dso;                  /*    80     8 */
> =09u32                        flags;                /*    88     4 */
> =09u32                        prot;                 /*    92     4 */
>=20
> =09/* size: 96, cachelines: 2, members: 14 */
> =09/* sum members: 92, holes: 1, sum holes: 3 */
> =09/* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 5 bits *=
/
> =09/* forced alignments: 1 */
> =09/* last cacheline: 32 bytes */
> } __attribute__((__aligned__(8)));
> [acme@quaco perf]$
>=20
> So give me some more time, please :-)

sure ;-) I just did not want to loose track of this

thanks,
jirka

