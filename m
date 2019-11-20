Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A750C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A93A2088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd2ziWcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKTTSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:18:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23701 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727738AbfKTTSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574277501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWQ0snqOKErAvm9iOwBriYePO5G6kgp/7GlG1L6NwAM=;
        b=bd2ziWcHMCaTycH4JILx9Y/qst/rxWZ5Da4ExcbefsA6iFlroArrTJm/jH0WtxU9cnrQem
        jH30RW1U60BkOKOQTKHFFkXCEbSGoTc4EZ9dAt1klNgR/IZCwNE9r9SQg8iI1d2PDwQmXA
        WEzIxUyOYmunnXu8JudBWqiCnQi1NnM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-woKUUW_YMlqllekpkE1tqg-1; Wed, 20 Nov 2019 14:18:20 -0500
Received: by mail-qt1-f198.google.com with SMTP id c8so519482qte.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=0ZPeDSwJuPWYCh0VtDJP/WF4gGFB+fn/XJDG0N6k/Og=;
        b=iPVZ5FWequucSKQYlI8Y8M8rgeC61DtQW5xv7kabERDXCyQfQVUD72gbcLD7Eom0r/
         Mk88P7lKFk6vE2rS2wMcORFpoFqvrRDNdxLDX+utM5IOufM1XqSav+G1+bFdFlX8/AEW
         fVZ+4Gypl4Ycvp0zqGTXdiiL1nJOPlk+IJzlJoD2BKV5aOA+1wPROxa84QF4NxHnvHVZ
         JInBcrk5y599CZOYH7RjqFvh1T34LH22tlrSvSql1kFMPOe+yDhLTixAN0861vE7Cw2C
         acecWyy5IPwKMq9Gf7Hb/cnWp4uh2jc7ed1BtSq4bFLOu/3VSS1YYSwIaH7C3ERV9A+9
         8rwA==
X-Gm-Message-State: APjAAAWTElOZgFvpZf3MBS02m5T2eND9XHq55WSDd61YBbKP7TdEUTNM
        0Sju2eF+/yMIjNbzyr3EekFB0MslUF4ROxdRhZWI2HQ+bPQuzQZuzraS6XdaX6sBZmTbtcMymDb
        baKY3ztpUsnE9xY1DYMIQf7m9
X-Received: by 2002:ac8:1908:: with SMTP id t8mr4314396qtj.18.1574277499305;
        Wed, 20 Nov 2019 11:18:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3z6BLPgSb887SPg+WQy5XrCTAlqdgetdC6l5TXKFFF3p7RCVtBvZ/2U95u26DiAwzmgkpgg==
X-Received: by 2002:ac8:1908:: with SMTP id t8mr4314362qtj.18.1574277498977;
        Wed, 20 Nov 2019 11:18:18 -0800 (PST)
Received: from dhcp-10-20-1-46.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id w15sm15088193qtk.43.2019.11.20.11.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 11:18:18 -0800 (PST)
Message-ID: <a0e277e23dc540c66d075305a0a9c6903e81de48.camel@redhat.com>
Subject: Re: [PATCH][next] drm/dp_mst: fix multiple frees of tx->bytes
From:   Lyude Paul <lyude@redhat.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Nov 2019 14:18:17 -0500
In-Reply-To: <0e6b2b68-2898-213d-3a37-c23d32a97133@canonical.com>
References: <20191120173509.347490-1-colin.king@canonical.com>
         <f6c44c85a63c89e548cafa55d89caccd7e868268.camel@redhat.com>
         <0e6b2b68-2898-213d-3a37-c23d32a97133@canonical.com>
Organization: Red Hat
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-MC-Unique: woKUUW_YMlqllekpkE1tqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-20 at 19:11 +0000, Colin Ian King wrote:
> On 20/11/2019 18:59, Lyude Paul wrote:
> > Heh, surprised I missed this one!
> >=20
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> >=20
> > Do you need me to push this to drm-misc, or do you have commit rights
> > already
>=20
> I have no commit rights.

Gotcha:

Enumerating objects: 11, done.
Counting objects: 100% (11/11), done.
Delta compression using up to 4 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 885 bytes | 442.00 KiB/s, done.
Total 6 (delta 5), reused 0 (delta 0)
To ssh://git.freedesktop.org/git/drm/drm-misc
   8896e40c05cc..2c8bc91488fc  drm-misc-next -> drm-misc-next
Pushing drm-misc-fixes to for-linux-next-fixes... Everything up-to-date
Done.
Pushing drm-misc-next-fixes to for-linux-next... Everything up-to-date
Done.
Updating rerere cache... Done.
Reloading nightly.conf... Done.
Fetching drm-amd... Done.
Fetching drm-intel... Done.
Fetching sound-upstream (local remote sound)... Done.
Fetching drm... Done.
Fetching drm-misc... Done.
Fetching linux-upstream (local remote origin)... Done.
Fetching drm-tip... Done.
Merging drm/drm-fixes... Reset. Done.
Merging drm-misc/drm-misc-fixes... Fast-forward. Done.
Merging drm-intel/drm-intel-fixes... Fast-forward. Done.
Merging drm-amd/drm-amd-fixes... Fast-forward. Done.
Merging drm/drm-next... Done.
Merging drm-misc/drm-misc-next-fixes... Done.
Merging drm-intel/drm-intel-next-fixes... Done.
Merging drm-amd/drm-amd-next-fixes... Fast-forward. Done.
Merging drm-misc/drm-misc-next... Done.
Merging drm-intel/drm-intel-next-queued... Done.
Merging drm-intel/drm-intel-next... Fast-forward. Done.
Merging drm-amd/drm-amd-next... Fast-forward. Done.
Merging sound-upstream/for-linus (local remote sound)... Fast-forward. Done=
.
Merging sound-upstream/for-next (local remote sound)... Done.
Merging drm-intel/topic/core-for-CI... Done.
Adding integration manifest drm-tip: 2019y-11m-20d-19h-16m-39s UTC... Done.
Pushing drm-tip... Done.
Finalizing rerere cache... Nothing changed. Pushing rerere cache... Done.

Thanks for the patch!
>=20
>=20
> > On Wed, 2019-11-20 at 17:35 +0000, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > >=20
> > > Currently tx->bytes is being freed r->num_transactions number of
> > > times because tx is not being set correctly. Fix this by setting
> > > tx to &r->transactions[i] so that the correct objects are being
> > > freed on each loop iteration.
> > >=20
> > > Addresses-Coverity: ("Double free")
> > > Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
> > > selftests")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/gpu/drm/drm_dp_mst_topology.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > index ae5809a1f19a..2754e7e075e7 100644
> > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > @@ -517,8 +517,10 @@ drm_dp_decode_sideband_req(const struct
> > > drm_dp_sideband_msg_tx *raw,
> > >  =09=09=09}
> > > =20
> > >  =09=09=09if (failed) {
> > > -=09=09=09=09for (i =3D 0; i < r->num_transactions; i++)
> > > +=09=09=09=09for (i =3D 0; i < r->num_transactions; i++) {
> > > +=09=09=09=09=09tx =3D &r->transactions[i];
> > >  =09=09=09=09=09kfree(tx->bytes);
> > > +=09=09=09=09}
> > >  =09=09=09=09return -ENOMEM;
> > >  =09=09=09}
> > > =20
--=20
Cheers,
=09Lyude Paul

