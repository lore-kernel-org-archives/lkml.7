Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B02CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E23521929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgXAqRKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407271AbfJYHjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:39:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406055AbfJYHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571989161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+zKTTNYokGo3jjaOtJP2IS26NDhOn6xEP3f396BOyI=;
        b=bgXAqRKDTjD5VbdBaOh3aYCKrtpa9jIIRmJYPu7aqCrc/Fno2CKyizGkSkHXg8N0wXs4nE
        79nztyPfPXo+ytdG2RVOcvd+hvy1ojVM9/XeVslTgGt7LZ4ZQASdooU5FQ4jKFyrtuCGAj
        4/huK6fDU1kA4lexQCnc6QC+MbQIT/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-DuC5qt3xO06PfITR1Pe6sA-1; Fri, 25 Oct 2019 03:39:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 290C547B;
        Fri, 25 Oct 2019 07:39:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id C8FE160BE0;
        Fri, 25 Oct 2019 07:39:13 +0000 (UTC)
Date:   Fri, 25 Oct 2019 09:39:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Hewenliang <hewenliang4@huawei.com>
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ilubashe@akamai.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, hushiyuan@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] perf tools: Call closedir to release the resource before
 we return
Message-ID: <20191025073913.GC31679@krava>
References: <20191025031605.23658-1-hewenliang4@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191025031605.23658-1-hewenliang4@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DuC5qt3xO06PfITR1Pe6sA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:16:05PM -0400, Hewenliang wrote:
> We should close the directory on pattern failure before the return
> of rm_rf_depth_pat.
>=20
> Fixes: cdb6b0235f170 ("perf tools: Add pattern name checking to rm_rf")
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/util.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 5eda6e19c947..1aadca8c43f3 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -154,8 +154,10 @@ static int rm_rf_depth_pat(const char *path, int dep=
th, const char **pat)
>  =09=09if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>  =09=09=09continue;
> =20
> -=09=09if (!match_pat(d->d_name, pat))
> +=09=09if (!match_pat(d->d_name, pat)) {
> +=09=09=09closedir(dir);
>  =09=09=09return -2;
> +=09=09}
> =20
>  =09=09scnprintf(namebuf, sizeof(namebuf), "%s/%s",
>  =09=09=09  path, d->d_name);
> --=20
> 2.19.1
>=20

