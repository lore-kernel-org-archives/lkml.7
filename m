Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E06C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F32C20578
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZ0jIngn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKKUHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:07:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbfKKUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573502819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vh0lOxBTIyStTtSHCcKqLlpPPA7dotESbLsNyxBw55Y=;
        b=WZ0jIngnDrUnKMZNj5Do1au1v/XIanEXtSee0Il9OwopRJccRdZvtAj9kVZHshD3IDd8FB
        HYmrPlU1aQ99WQoMHZawFIbZj4TnjsMG88nP4wa3l1yLTkU43lafkDpMgrlgI63ZPjobnu
        Ladp0wqTmDPZY5KQovTnNKGrn7eHrDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-ylkYT010O8eIPpjcxLndVg-1; Mon, 11 Nov 2019 15:06:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 754BA18B9F80;
        Mon, 11 Nov 2019 20:06:57 +0000 (UTC)
Received: from krava (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4328846;
        Mon, 11 Nov 2019 20:06:56 +0000 (UTC)
Date:   Mon, 11 Nov 2019 21:06:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/13] perf stat: Use affinity for enabling/disabling
 events
Message-ID: <20191111200655.GB31193@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-14-andi@firstfloor.org>
 <20191111140415.GA26980@krava>
 <20191111165028.GC573472@tassilo.jf.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191111165028.GC573472@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ylkYT010O8eIPpjcxLndVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 08:50:28AM -0800, Andi Kleen wrote:
> On Mon, Nov 11, 2019 at 03:04:15PM +0100, Jiri Olsa wrote:
> > On Thu, Nov 07, 2019 at 10:16:46AM -0800, Andi Kleen wrote:
> >=20
> > SNIP
> >=20
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index 33080f79b977..571bb102b432 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -378,11 +378,28 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int=
 cpu)
> > >  void evlist__disable(struct evlist *evlist)
> > >  {
> > >  =09struct evsel *pos;
> > > +=09struct affinity affinity;
> > > +=09int cpu, i;
> >=20
> > should we have the fallback to current code in here (and below) as well=
?
> > also for reading/openning?
>=20
> The return only happens when you're out of memory, when nothing
> will work anyways.

then let's have some assert or BUG_ON on !all_cpus
and remove the fallback code from close path

jirka

>=20
> -Andi
>=20
> >=20
> > jirka
> >=20
> > > +
> > > +=09if (affinity__setup(&affinity) < 0)
> > > +=09=09return;
>=20

