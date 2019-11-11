Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DFFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751E020656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyWHP9qC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKKQcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:32:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbfKKQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573489935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqK12N2BhrocKRvl7cMiEaZz6qD/oH8PM0mBXIIjGWk=;
        b=KyWHP9qCwp+LoxxT6Ijj3Bz8QmuQYVIRaobpUtkGRZjI++E9mebk/5yyla3KnXTuswwqzP
        chJRCcxJesKS9aU5A94Xesenv2GvIVT1nw4DixIv0ZBoKbj0HRnXbPynVmrwMSbUma/zoE
        +j9GEqxGVuF/HiO5+JVPMqr66YMR3s4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-s9OhPxAAPJu1OgSJnyNOCw-1; Mon, 11 Nov 2019 11:32:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6391DDC59;
        Mon, 11 Nov 2019 16:32:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 524A06106C;
        Mon, 11 Nov 2019 16:32:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Nov 2019 17:32:13 +0100 (CET)
Date:   Mon, 11 Nov 2019 17:32:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v7 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191111163209.GB11389@redhat.com>
References: <20191111131704.656169-1-areber@redhat.com>
 <20191111152514.GA11389@redhat.com>
 <20191111154028.GF514519@dcbz.redhat.com>
 <20191111161458.fjodxyx566dar6ob@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20191111161458.fjodxyx566dar6ob@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: s9OhPxAAPJu1OgSJnyNOCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11, Christian Brauner wrote:
>
> On Mon, Nov 11, 2019 at 04:40:28PM +0100, Adrian Reber wrote:
> > > note also that this way we can easily allow set_tid[some_level] =3D=
=3D 0, we can
> > > simply do
> > >
> > > =09-=09if (xxx < 1 || xxx >=3D pid_max)
> > > =09+=09if (xxx < 0 || xxx >=3D pid_max)
> > >
> > > although I don't think this is really useful.
> >
> > Yes. I explicitly didn't allow 0 as a PID as I didn't thought it would
> > be useful (or maybe even valid).
>
> How do you express: I don't care about a specific pid in pidns level
> <n>,

Yes,

> Wouldn't that be potentially useful?

As I said above, I don't think this is really useful. Just I was thinking
out loud.

I suggested to cache set_tid[pos] rather than pos because this makes the
code simpler, not because this allows this allows to "naturally" handle
the case when set_tid[pos] =3D=3D 0. Sorry it it was not clear.

Oleg.

