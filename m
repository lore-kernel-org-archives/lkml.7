Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F036C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13236206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJsHtAOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKMXCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:02:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46840 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbfKMXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573686119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jhvq/7L4CZ926SBn146xoHM4iaITra2Z+/5GmzTdYcE=;
        b=DJsHtAOWRncdK0lLalXO/UBto7UO+3z4sEzZ5ewyuGJBoFWkkp5uEiZSy80sINhkJTdYsx
        QuSbrqbcAHOuU9a7DWPQeT5lXaTr1BiJYGq/BEYGTcXMx4GNXyS85Ln5pPfhrfTXdTfl4e
        wLNtzOsjrcvKXEriETWcpLIK0CEJuGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-NMLHO3wPOZCehLy3t-Rx9g-1; Wed, 13 Nov 2019 18:01:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AD73107ACC5;
        Wed, 13 Nov 2019 23:01:55 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CC531001B28;
        Wed, 13 Nov 2019 23:01:53 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 81BCB11E8; Wed, 13 Nov 2019 21:01:49 -0200 (BRST)
Date:   Wed, 13 Nov 2019 21:01:49 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hewenliang <hewenliang4@huawei.com>, tstoyanov@vmware.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH] tools lib traceevent: Fix memory leakage in
 copy_filter_type
Message-ID: <20191113230149.GA8999@redhat.com>
References: <20191025082312.62690-1-hewenliang4@huawei.com>
 <20191113144626.44ad5418@gandalf.local.home>
 <20191113203710.GC3078@redhat.com>
 <20191113154044.5b591bf8@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20191113154044.5b591bf8@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NMLHO3wPOZCehLy3t-Rx9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 13, 2019 at 03:40:44PM -0500, Steven Rostedt escreveu:
> On Wed, 13 Nov 2019 18:37:10 -0200
> Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
>=20
> > Em Wed, Nov 13, 2019 at 02:46:26PM -0500, Steven Rostedt escreveu:
> > > On Fri, 25 Oct 2019 04:23:12 -0400
> > > Hewenliang <hewenliang4@huawei.com> wrote:
> > >  =20
> > > > It is necessary to free the memory that we have allocated
> > > > when error occurs.
> > > >=20
> > > > Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_f=
ilter_type()")
> > > > Signed-off-by: Hewenliang <hewenliang4@huawei.com> =20
> > >=20
> > > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > >=20
> > > Arnaldo, =20
> >=20
> > sure
>=20
> I found an issue with it (if you didn't see the next email).
>=20
> Please don't take it.
=20

ok.

> Thanks!
>=20
> -- Steve
>=20
> > =20
> > > Can you take this?
> > >=20
> > > -- Steve
> >

