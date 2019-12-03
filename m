Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F083C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0A620684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCZj9NxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLCKWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:22:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbfLCKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575368563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJnlkqQuX45vF9FHqxHeZsY8ZPt9Nh2gdIeo4L+JajI=;
        b=YCZj9NxZkFV66Dzclkbq23qIf2brrRn6k6rvfiJKMp6OQGfh0WEdS3hcxs6hyad2E28nkf
        bz68QGxQvZ2NimAm2WFUBWUGaSfLde4NSUKnxPhZjC9QKZ3wnUel1YPTB2rU6DVd5Wlum4
        7IeZvky3YEDWoVitHjByBEvobzyvGEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-HN7Q1R1HNFiQSSXPogrzGA-1; Tue, 03 Dec 2019 05:22:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA1991005502;
        Tue,  3 Dec 2019 10:22:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 223FD5C557;
        Tue,  3 Dec 2019 10:22:34 +0000 (UTC)
Date:   Tue, 3 Dec 2019 11:22:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: perf is unable to read dward from go programs
Message-ID: <20191203102234.GE17468@krava>
References: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
 <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
 <20191129134929.GA26903@krava>
 <20191129151436.GB26963@kernel.org>
 <CABWYdi19LmOHC0Ect-8vNXz0uF2tNC1XmDQfMn0fmYOt2yJH9w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABWYdi19LmOHC0Ect-8vNXz0uF2tNC1XmDQfMn0fmYOt2yJH9w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: HN7Q1R1HNFiQSSXPogrzGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 11:49:55AM -0800, Ivan Babrou wrote:
> I've tried building with libdw with mixed results:
>=20
> 1. I can see stacks from some Go programs that were invisible before (yay=
!)
>=20
> 2. Warnings like below still appear in great numbers for a system-wide
> flamegraph:
>=20
> BFD: Dwarf Error: found dwarf version '18345', this reader only
> handles version 2, 3 and 4 information.
>=20
> I'm not sure how to pinpoint this to a particular binary and would
> appreciate some help with this.

I'd need some way of reproducing this, could you please
paste me command lines you used?

>=20
> 3. It takes minutes to produce a flamegraph of a running system
> whereas before it only took seconds. See this flamegraph of "perf
> script" itself:
>=20
> * https://gist.github.com/bobrik/a9c46cffe9daa5840abd137443d8bab0#file-fl=
amegraph-perf-svg
>=20
> Seems like there is no caching and debug info is getting reparsed
> continuously for every stack. It's possible that it was not an issue
> before, because we spent no time decompressing dwarf.

possibly, if we have some clear reproducer we can hand it
to the libdw guy that helped us develop this

>=20
> 4. Pretty much all luajit frames stacks that were marked as unknown
> before are now gone.
>=20
> See before and after here: https://imgur.com/a/1LNfqAk
>=20
> Before:
>=20
> nginx-cache 94572 446642.722028:   10101010 cpu-clock:
>             5607d8d56718 ngx_http_lua_shdict_lookup+0x48 (inlined)
>             5607d8d5a09d ngx_http_lua_ffi_shdict_incr+0xcd
> (/usr/local/nginx-cache/sbin/nginx-cache)
>             560802fe58e4 [unknown] (/tmp/perf-94572.map)
>=20
> After:
>=20
> nginx-cache 94572 446543.008703:   10101010 cpu-clock:
>             5607d8d56718 ngx_http_lua_shdict_lookup+0x48 (inlined)
>             5607d8d59da7 ngx_http_lua_ffi_shdict_get+0x197
> (/usr/local/nginx-cache/sbin/nginx-cache)
>=20
> The key is /tmp/perf-*.map frame at the bottom. I don't know if it's
> expected, but we grew dependent on knowing this.
>=20
> 5. Special [[stack]], [[heap]] and [anon] frames are also gone, and
> you can see the following during "perf script" run:
>=20
> open("[stack]", O_RDONLY)               =3D -1 ENOENT (No such file or di=
rectory)
> open("[heap]", O_RDONLY)                =3D -1 ENOENT (No such file or di=
rectory)
> open("//anon", O_RDONLY)                =3D -1 ENOENT (No such file or di=
rectory)

strange, let's start with the reproducer and I'll check
on this if I see it

thanks,
jirka

