Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42331C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EC121906
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlPnPXt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfKSO7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:59:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727066AbfKSO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574175540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y94Zvgx3YXa8+T8zM3e1aaL1uR5flwkg7GrHxHXTlhg=;
        b=MlPnPXt7JEvpuNShxqul27YnAKR4lCKaBtEc4sVAqAgk6sV8Y6x1VzuryPBEKOlcgBIxqL
        3a0ZKqpUt9wSm9LjpXCN6dAbSFhuSAzcT3SWBJ4oP7oT8ZVznVpxb7MXCnEPwWOEFXjY2k
        5vb3h49EgeyZyB2ybZh6MEMZAX9fPbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-bKDfKisfOMSV_utgoqRCsg-1; Tue, 19 Nov 2019 09:58:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 641AE107ACC4;
        Tue, 19 Nov 2019 14:58:56 +0000 (UTC)
Received: from x230.aquini.net (dhcp-17-70.bos.redhat.com [10.18.17.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F041C1DA;
        Tue, 19 Nov 2019 14:58:55 +0000 (UTC)
Date:   Tue, 19 Nov 2019 09:58:54 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kconfig: make Transparent Hugepage Support sysfs
 defaults to match the documentation
Message-ID: <20191119145853.GA1869@x230.aquini.net>
References: <20191119030102.27559-1-aquini@redhat.com>
 <20191119104741.rtjc7awl4k57boyu@box>
MIME-Version: 1.0
In-Reply-To: <20191119104741.rtjc7awl4k57boyu@box>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bKDfKisfOMSV_utgoqRCsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 01:47:41PM +0300, Kirill A. Shutemov wrote:
> On Mon, Nov 18, 2019 at 10:01:02PM -0500, Rafael Aquini wrote:
> > Documentation/admin-guide/mm/transhuge.rst (originally in Documentation=
/vm/transhuge.txt)
> > states that TRANSPARENT_HUGEPAGE_MADVISE is the default option for THP =
config:
> >=20
> > "
> > madvise
> >         will enter direct reclaim like ``always`` but only for regions
> >         that are have used madvise(MADV_HUGEPAGE). This is the default
> >         behaviour.
> > "
> >=20
> > This patch changes mm/Kconfig to reflect that fact, accordingly.
>=20
> No. You've read it incorrectly.
>
Fair enough.

I'll reform the log message then, and repost.
=20
> The documentation describes default behaviour wrt defragmentaton ("defrag=
"
> file), not page fault ("enabled" file). We don't have any Kconfig option
> to set default behaviour for "defrag".
>=20
> > Besides keeping consistency between documentation and the code behavior=
,
> > other reasons to perform this minor adjustment are noted at:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1772133
> >=20
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> >  mm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index a5dae9a7eb51..c12a559aa1e5 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -385,7 +385,7 @@ config TRANSPARENT_HUGEPAGE
> >  choice
> >  =09prompt "Transparent Hugepage Support sysfs defaults"
> >  =09depends on TRANSPARENT_HUGEPAGE
> > -=09default TRANSPARENT_HUGEPAGE_ALWAYS
> > +=09default TRANSPARENT_HUGEPAGE_MADVISE
> >  =09help
> >  =09  Selects the sysfs defaults for Transparent Hugepage Support.
> > =20
> > --=20
> > 2.17.2
> >=20
> >=20
>=20
> --=20
>  Kirill A. Shutemov
>=20

