Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EAFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8424C222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLizEG5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503952AbfJYMCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:02:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2502539AbfJYMCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572004923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IBg/RemnUO6FrGBf0EaqOcr2gXDDQq0ETHC+883fOmI=;
        b=QLizEG5HiQ1UD/o52bIlhmIdM6K3ICA2+5sbykhC27eRB2cuFb7VLUBk5adiYaemE/fFhm
        5HMJdb1+ioPyWEI8M2wpNWanNKvIpMppmS2T2jEe1ZkiICZPC8jZxJIP37yiCJE7o2ntpP
        mCNTIU8ANm0dl+r4LPkwDLlqUqFdZdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-9JO_5gNoPreq6XvpTBvKag-1; Fri, 25 Oct 2019 08:01:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC4EA800D41;
        Fri, 25 Oct 2019 12:01:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8A7DC5D9CA;
        Fri, 25 Oct 2019 12:01:55 +0000 (UTC)
Date:   Fri, 25 Oct 2019 14:01:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] perf c2c: Fix memory leak in c2c_he_zalloc()
Message-ID: <20191025120154.GA25352@krava>
References: <9d5f26f8-9429-bcb6-d491-cb789f761ea2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <9d5f26f8-9429-bcb6-d491-cb789f761ea2@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 9JO_5gNoPreq6XvpTBvKag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 05:42:47PM +0800, Yunfeng Ye wrote:
> A memory leak in c2c_he_zalloc() is found by visual inspection.
>=20
> Fix this by adding memory free on the error paths in c2c_he_zalloc().
>=20
> Fixes: 7f834c2e84bb ("perf c2c report: Display node for cacheline address=
")
> Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-c2c.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e69f44941aad..ad7d38a9dcbe 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -138,21 +138,29 @@ static void *c2c_he_zalloc(size_t size)
>=20
>  =09c2c_he->cpuset =3D bitmap_alloc(c2c.cpus_cnt);
>  =09if (!c2c_he->cpuset)
> -=09=09return NULL;
> +=09=09goto free_c2c_he;
>=20
>  =09c2c_he->nodeset =3D bitmap_alloc(c2c.nodes_cnt);
>  =09if (!c2c_he->nodeset)
> -=09=09return NULL;
> +=09=09goto free_cpuset;
>=20
>  =09c2c_he->node_stats =3D zalloc(c2c.nodes_cnt * sizeof(*c2c_he->node_st=
ats));
>  =09if (!c2c_he->node_stats)
> -=09=09return NULL;
> +=09=09goto free_nodeset;
>=20
>  =09init_stats(&c2c_he->cstats.lcl_hitm);
>  =09init_stats(&c2c_he->cstats.rmt_hitm);
>  =09init_stats(&c2c_he->cstats.load);
>=20
>  =09return &c2c_he->he;
> +
> +free_nodeset:
> +=09free(c2c_he->nodeset);
> +free_cpuset:
> +=09free(c2c_he->cpuset);
> +free_c2c_he:
> +=09free(c2c_he);
> +=09return NULL;
>  }
>=20
>  static void c2c_he_free(void *he)
> --=20
> 2.7.4
>=20

