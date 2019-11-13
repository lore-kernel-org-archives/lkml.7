Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DFAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414E7206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJrWl+1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfKMUhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:37:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35914 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726162AbfKMUhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573677441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR6D3pONuhiH0qc0/Iv2UQgY08BbLP2x6Vmi8FX4RW4=;
        b=EJrWl+1Zm/PWNbuJutqHKjQ/DwP4OdOGZxhsPz0rduPSiiyuOPVrwiQB09XRVXelVwC6y9
        cdx5Gtwjn5y6aYAllZ/nP0C9RSwZBcCcksvrf2VJifYURvzmx4ZJd0sSbip1+j0L81LHmV
        wsxeHGHilKsZevo3qim2zHuK2iMXmVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-haOFguBlM-Cqz5GiKmuc7A-1; Wed, 13 Nov 2019 15:37:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3BB18B9FC1;
        Wed, 13 Nov 2019 20:37:17 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-40.phx2.redhat.com [10.3.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 197365F78C;
        Wed, 13 Nov 2019 20:37:16 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 712E7119; Wed, 13 Nov 2019 18:37:10 -0200 (BRST)
Date:   Wed, 13 Nov 2019 18:37:10 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hewenliang <hewenliang4@huawei.com>, tstoyanov@vmware.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH] tools lib traceevent: Fix memory leakage in
 copy_filter_type
Message-ID: <20191113203710.GC3078@redhat.com>
References: <20191025082312.62690-1-hewenliang4@huawei.com>
 <20191113144626.44ad5418@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20191113144626.44ad5418@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: haOFguBlM-Cqz5GiKmuc7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 13, 2019 at 02:46:26PM -0500, Steven Rostedt escreveu:
> On Fri, 25 Oct 2019 04:23:12 -0400
> Hewenliang <hewenliang4@huawei.com> wrote:
>=20
> > It is necessary to free the memory that we have allocated
> > when error occurs.
> >=20
> > Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_filte=
r_type()")
> > Signed-off-by: Hewenliang <hewenliang4@huawei.com>
>=20
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>=20
> Arnaldo,

sure
=20
> Can you take this?
>=20
> -- Steve
>=20
> > ---
> >  tools/lib/traceevent/parse-filter.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent=
/parse-filter.c
> > index 552592d153fb..fbaa790d10d8 100644
> > --- a/tools/lib/traceevent/parse-filter.c
> > +++ b/tools/lib/traceevent/parse-filter.c
> > @@ -1473,8 +1473,10 @@ static int copy_filter_type(struct tep_event_fil=
ter *filter,
> >  =09if (strcmp(str, "TRUE") =3D=3D 0 || strcmp(str, "FALSE") =3D=3D 0) =
{
> >  =09=09/* Add trivial event */
> >  =09=09arg =3D allocate_arg();
> > -=09=09if (arg =3D=3D NULL)
> > +=09=09if (arg =3D=3D NULL) {
> > +=09=09=09free(str);
> >  =09=09=09return -1;
> > +=09=09}
> > =20
> >  =09=09arg->type =3D TEP_FILTER_ARG_BOOLEAN;
> >  =09=09if (strcmp(str, "TRUE") =3D=3D 0)
> > @@ -1483,8 +1485,11 @@ static int copy_filter_type(struct tep_event_fil=
ter *filter,
> >  =09=09=09arg->boolean.value =3D 0;
> > =20
> >  =09=09filter_type =3D add_filter_type(filter, event->id);
> > -=09=09if (filter_type =3D=3D NULL)
> > +=09=09if (filter_type =3D=3D NULL) {
> > +=09=09=09free(str);
> > +=09=09=09free(arg);
> >  =09=09=09return -1;
> > +=09=09}
> > =20
> >  =09=09filter_type->filter =3D arg;
> > =20

