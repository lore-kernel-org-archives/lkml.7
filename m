Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBDFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F3F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1lusMgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfJUNwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:52:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728076AbfJUNwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571665936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2nzQ90tRgNCuNOaHKs/Hv9c/5zHLPy8GB8ApqV4qS0=;
        b=g1lusMgzepDUsPnF5ZMttzkMI5tVAJtfRuALcpFFgWaxWoGHOcZhBdBHd4lqL1sglSrGu7
        l+AapKpk0tpb3vdkatzm92zjNRHxcNmNEjMzT7wCLxtXzdbzrunfXqgBaUGGAbX0+8wXWJ
        KhvruNU6GScbyB8cn4porFckG8DVzpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-YG0MBNVgNG2KPTmgh_7I7Q-1; Mon, 21 Oct 2019 09:52:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57FF5476;
        Mon, 21 Oct 2019 13:52:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 779D06012D;
        Mon, 21 Oct 2019 13:52:11 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:52:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] perf tools: Support single perf.data file directory
Message-ID: <20191021135210.GA32718@krava>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-5-adrian.hunter@intel.com>
 <20191007112027.GD6919@krava>
 <2340d60c-e8a6-2333-06ce-77076c912a1c@intel.com>
 <a2853fa8-a2e8-8e17-132c-0d47b8129eff@intel.com>
 <20191021134611.GB10039@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191021134611.GB10039@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: YG0MBNVgNG2KPTmgh_7I7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:46:11AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 21, 2019 at 03:42:39PM +0300, Adrian Hunter escreveu:
> > On 7/10/19 3:06 PM, Adrian Hunter wrote:
> > > On 7/10/19 2:20 PM, Jiri Olsa wrote:
> > >> On Fri, Oct 04, 2019 at 11:31:20AM +0300, Adrian Hunter wrote:
> > >>
> > >> SNIP
> > >>
> > >>>  =09u8 pad[8] =3D {0};
> > >>> =20
> > >>> -=09if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
> > >>> +=09if (!perf_data__is_pipe(data) && perf_data__is_single_file(data=
)) {
> > >>>  =09=09off_t file_offset;
> > >>>  =09=09int fd =3D perf_data__fd(data);
> > >>>  =09=09int err;
> > >>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > >>> index df173f0bf654..964ea101dba6 100644
> > >>> --- a/tools/perf/util/data.c
> > >>> +++ b/tools/perf/util/data.c
> > >>> @@ -76,6 +76,13 @@ int perf_data__open_dir(struct perf_data *data)
> > >>>  =09DIR *dir;
> > >>>  =09int nr =3D 0;
> > >>> =20
> > >>> +=09/*
> > >>> +=09 * Directory containing a single regular perf data file which i=
s already
> > >>> +=09 * open, means there is nothing more to do here.
> > >>> +=09 */
> > >>> +=09if (perf_data__is_single_file(data))
> > >>> +=09=09return 0;
> > >>> +
> > >>
> > >> cool, I like this approach much more than the previous flag
> > >=20
> > > Yes it is much nicer.  Thanks for your direction on that.
> > >=20
> > >>
> > >> any change you (if there's repost) or Arnaldo
> > >> could squeeze in indent change below?
> > >=20
> > > Sent a patch, to be applied before these.
> > >=20
> >=20
> > That is:
> >=20
> > "[PATCH] perf session: Fix indent in perf_session__new()"
> >=20
> > Any comments on this patch set Arnaldo?
>=20
> I'll take a look at it later, I think Jiri is ok with it already?

yes, it's just indent fix

jirka

