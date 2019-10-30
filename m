Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BFACA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B538C208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpnQkQ6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfJ3SQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:16:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55516 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726184AbfJ3SQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572459359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bVsDGgUyFf/Lc4r2nBI3fmbyc9xGnSjSyn4XFOkRPo4=;
        b=FpnQkQ6KJq1/5Pt21q6TUvIOX453IscYJAMXMaaUMt23azYkZ6iaLrM5vRK07JVD1pCsaS
        3XcQNANlG4KxakkIBoz+yhc0M2i5+Xg9x4CoG70GmadVpb+sO6DDjNYedAYoBNmfcn7yUH
        tQPlHBnbbE1T/UwfVLj/KrSQcs7t7cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-3tKoewCdPPKL05J5zOAY_w-1; Wed, 30 Oct 2019 14:15:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13F461005500;
        Wed, 30 Oct 2019 18:15:55 +0000 (UTC)
Received: from krava (ovpn-204-82.brq.redhat.com [10.40.204.82])
        by smtp.corp.redhat.com (Postfix) with SMTP id 658C75D6D6;
        Wed, 30 Oct 2019 18:15:53 +0000 (UTC)
Date:   Wed, 30 Oct 2019 19:15:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 3/7] perf evsel: Add iterator to iterate over events
 ordered by CPU
Message-ID: <20191030181552.GM20826@krava>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-4-andi@firstfloor.org>
 <20191030100606.GG20826@krava>
 <20191030155108.taqo2kbuaro3idhe@two.firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191030155108.taqo2kbuaro3idhe@two.firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3tKoewCdPPKL05J5zOAY_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 08:51:08AM -0700, Andi Kleen wrote:
> On Wed, Oct 30, 2019 at 11:06:06AM +0100, Jiri Olsa wrote:
> > > +struct perf_cpu_map *evlist__cpu_iter_start(struct evlist *evlist)
> > > +{
> > > +=09struct perf_cpu_map *cpus;
> > > +=09struct evsel *pos;
> > > +
> > > +=09/*
> > > +=09 * evlist->cpus is not necessarily a superset of all the
> > > +=09 * event's cpus, so compute our own super set. This
> > > +=09 * assume that there is a super set
> > > +=09 */
> > > +=09cpus =3D evlist->core.cpus;
> > > +=09evlist__for_each_entry(evlist, pos) {
> > > +=09=09pos->cpu_index =3D 0;
> > > +=09=09if (pos->core.cpus->nr > cpus->nr)
> > > +=09=09=09cpus =3D pos->core.cpus;
> > > +=09}
> > > +=09return cpus;
> >=20
> > I might not understand the reason for cpu_index, but=20
>=20
> This is just so that we can iterate each event's map
> independently.
>=20
> > imagine something like below should be enough, no?
>=20
> Well it's more complicated because evlist->all_cpus doesn't exist.

yes, I suggest to create it

> The exists evlist->cpus cannot be used (I tried that)
> I also don't think we have an existing function to merge
> two maps, so that would need to be added to create it.
> Just using ->cpu_index is a much simpler change.

I dont think that would be lot of code
and it would simplify this one

jirka

