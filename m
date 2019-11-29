Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80013C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E0221736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ark2WRET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfK2NlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:41:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbfK2NlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575034865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3X8Mo2LacIErqf895aJZHB4pRGhzQ2jkuaJinfm0VE=;
        b=ark2WRET03tj05EtuGbZ6g1M9NUvaZgvfL4O0ZxteUqFKVBdcuD9T/lE3xUV5GdAI9JN7v
        BBNczNoUIAZPs4DuPODtmLu8claf6T87t+ttEnvha206fk043hoRlZkRNfrak3xy22ZPbk
        v0eeoIeslNq8aXQcfO5LDWZhNpeibL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-u8blKExWNIOKM8tb8tiPpw-1; Fri, 29 Nov 2019 08:41:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9D51DB23;
        Fri, 29 Nov 2019 13:40:58 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id B44FA60BF1;
        Fri, 29 Nov 2019 13:40:56 +0000 (UTC)
Date:   Fri, 29 Nov 2019 14:40:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Message-ID: <20191129134056.GE14169@krava>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191112183757.28660-5-acme@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: u8blKExWNIOKM8tb8tiPpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:37:46PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> From there we can get al->mg->machine, so replace that field with the
> more useful 'struct map_groups' that for now we're obtaining from
> al->map->groups, and that is one thing getting into the way of maps
> being fully shareable.
>=20
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-4qdducrm32tgrjupcp0kjh1e@git.kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/callchain.c                          |  6 +++---
>  tools/perf/util/db-export.c                          | 12 ++++++------
>  tools/perf/util/event.c                              |  6 +++---
>  .../perf/util/scripting-engines/trace-event-python.c |  2 +-
>  tools/perf/util/symbol.h                             |  2 +-
>  5 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 9a9b56ed3f0a..89faa644b0bc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, s=
truct callchain_cursor_node *
>  =09=09=09goto out;
>  =09}
> =20
> -=09if (al->map->groups =3D=3D &al->machine->kmaps) {
> -=09=09if (machine__is_host(al->machine)) {
> +=09if (al->mg =3D=3D &al->mg->machine->kmaps) {

heya, I'm getting segfault because of this change

perf record --call-graph dwarf ./ex

=09(gdb) r report --stdio
=09Program received signal SIGSEGV, Segmentation fault.
=09fill_callchain_info (al=3D0x7fffffffa1b0, node=3D0xcd2bd0, hide_unresolv=
ed=3Dfalse) at util/callchain.c:1122
=091122            if (al->maps =3D=3D &al->maps->machine->kmaps) {
=09(gdb) p al->maps
=09$1 =3D (struct maps *) 0x0

I wish all those map changes would go through some review,
I have no idea how the code works now ;-)

thanks,
jirka

