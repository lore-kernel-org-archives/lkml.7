Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2CCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D3020640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDIEb83p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405525AbfJWM7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:59:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36860 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405512AbfJWM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571835542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nPRYtamcp3tMOTTGsL4bR/kHLxIf3CFVe8L4w4NhPY=;
        b=IDIEb83pu2kNS6ztKcERFhrvQWb9dkJuQravuoxwPZWngsjSFaY02b1yC0Zzx2814c1/WT
        8QTiydQQgjroCmaQGml2qwqXF3AXg6fTjvWqz/EeBWWvaCZofF0s/uXnTCxYEB5Zo3my6u
        /JGCOzo4mim4qJi8Pe2c502eIp1j+hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-WWYVrJ2aN7yDIKQ5oh5RKQ-1; Wed, 23 Oct 2019 08:58:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71B80107AD31;
        Wed, 23 Oct 2019 12:58:57 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-17.phx2.redhat.com [10.3.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9967194BB;
        Wed, 23 Oct 2019 12:58:56 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 8B87B119; Wed, 23 Oct 2019 10:58:53 -0200 (BRST)
Date:   Wed, 23 Oct 2019 10:58:53 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, acme@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] perf kvm: Use evlist layer api when possible
Message-ID: <20191023125853.GA7814@redhat.com>
References: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
 <1571795693-23558-4-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
In-Reply-To: <1571795693-23558-4-git-send-email-ilubashe@akamai.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WWYVrJ2aN7yDIKQ5oh5RKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 22, 2019 at 09:54:53PM -0400, Igor Lubashev escreveu:
> No need for layer violations when a proper evlist api is available.

Thanks, applied.

- Arnaldo
=20
> Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> ---
>  tools/perf/builtin-kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 5217aa3596c7..340927c2b243 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1005,7 +1005,7 @@ static int kvm_events_live_report(struct perf_kvm_s=
tat *kvm)
>  =09=09}
> =20
>  =09=09if (!rc && !done)
> -=09=09=09err =3D fdarray__poll(fda, 100);
> +=09=09=09err =3D evlist__poll(kvm->evlist, 100);
>  =09}
> =20
>  =09evlist__disable(kvm->evlist);
> --=20
> 2.7.4

