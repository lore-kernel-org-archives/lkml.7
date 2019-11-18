Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8855C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACFB20722
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hC0pYwsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKRPYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:24:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34246 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfKRPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574090682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLGi9fY1vNkBVsN98gcHesJsA6BDlVXAshm64cOSSz4=;
        b=hC0pYwsvDkCiqXlusZlLNS3pgZtv88W536o1JO+a3TkC5L3pQXVk5cPjN9Y7mmYdLj4Pq1
        Mt2FSyPPAG+fi6QpRf9BOml9t2DwbjlHwUCSsJ0GwtAUl49+Uf/+KBV+ESLsFTdJd/aopG
        GeIhc6QlyjvIz1WNx/IsyymH8By06Iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-lEWPb9egMsaMiMSNAklbLg-1; Mon, 18 Nov 2019 10:24:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1643718B6409;
        Mon, 18 Nov 2019 15:24:38 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-10.phx2.redhat.com [10.3.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F57350229;
        Mon, 18 Nov 2019 15:24:36 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 87A4411E7; Mon, 18 Nov 2019 13:24:33 -0200 (BRST)
Date:   Mon, 18 Nov 2019 13:24:33 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hewenliang <hewenliang4@huawei.com>, tstoyanov@vmware.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH v2] tools lib traceevent: Fix memory leakage in
 copy_filter_type
Message-ID: <20191118152433.GA3667@redhat.com>
References: <20191025082312.62690-1-hewenliang4@huawei.com>
 <20191118092844.7292ad26@oasis.local.home>
MIME-Version: 1.0
In-Reply-To: <20191118092844.7292ad26@oasis.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: lEWPb9egMsaMiMSNAklbLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 09:28:44AM -0500, Steven Rostedt escreveu:
>=20
> Arnaldo,
>=20
> Can you take this patch?

Sure, taking this as an Acked-by you
=20
> Thanks!
>=20
> -- Steve
>=20
>=20
> On Fri, 25 Oct 2019 04:23:12 -0400
> Hewenliang <hewenliang4@huawei.com> wrote:
>=20
> > It is necessary to free the memory that we have allocated
> > when error occurs.
> >=20
> > Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_filte=
r_type()")
> > Signed-off-by: Hewenliang <hewenliang4@huawei.com>
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

