Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDEECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A1F214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RY8ZrSti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405085AbfJWLhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:37:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53034 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404834AbfJWLhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571830624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaQ7lBPeKaUYw7NAbnJaaN69roL1im/sbo/X7zk9/bE=;
        b=RY8ZrStiaynyyvWWx87Z/tD1PVDPWj/ABSxXhfSkpm8/wgOEmwYDslyvSt7Mx8xgmKhsKw
        eNV0QlM7FJZERmVkYgMssSKp4clQwA+olVO9+DgoNrGaycO2ME2GIteFWZSjzzQw6EhGQH
        FgXsa/W/xISo+vifRhrIwqXSgRcaLaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-Gbzul8nLMsm2W-LsGXrydg-1; Wed, 23 Oct 2019 07:37:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E589A1005500;
        Wed, 23 Oct 2019 11:36:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id B2C5D60BE1;
        Wed, 23 Oct 2019 11:36:56 +0000 (UTC)
Date:   Wed, 23 Oct 2019 13:36:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 5/5] perf report: Sort by sampled cycles percent per
 block for tui
Message-ID: <20191023113656.GP22919@krava>
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-6-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191022080710.6491-6-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Gbzul8nLMsm2W-LsGXrydg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:07:10PM +0800, Jin Yao wrote:
> Previous patch has implemented a new sort option "total_cycles".
> But there was only stdio mode supported.
>=20
> This patch supports the tui mode and support '--percent-limit'.
>=20
> For example,
>=20
>  perf record -b ./div
>  perf report -s total_cycles --percent-limit 1
>=20
>  # Samples: 2753248 of event 'cycles'
>  Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                =
                              [Program Block Range]         Shared Object
>           26.04%            2.8M        0.40%          18                =
                             [div.c:42 -> div.c:39]                   div
>           15.17%            1.2M        0.16%           7                =
                 [random_r.c:357 -> random_r.c:380]          libc-2.27.so
>            5.11%          402.0K        0.04%           2                =
                             [div.c:27 -> div.c:28]                   div
>            4.87%          381.6K        0.04%           2                =
                     [random.c:288 -> random.c:291]          libc-2.27.so
>            4.53%          381.0K        0.04%           2                =
                             [div.c:40 -> div.c:40]                   div
>            3.85%          300.9K        0.02%           1                =
                             [div.c:22 -> div.c:25]                   div
>            3.08%          241.1K        0.02%           1                =
                           [rand.c:26 -> rand.c:27]          libc-2.27.so
>            3.06%          240.0K        0.02%           1                =
                     [random.c:291 -> random.c:291]          libc-2.27.so
>            2.78%          215.7K        0.02%           1                =
                     [random.c:298 -> random.c:298]          libc-2.27.so
>            2.52%          198.3K        0.02%           1                =
                     [random.c:293 -> random.c:293]          libc-2.27.so
>            2.36%          184.8K        0.02%           1                =
                           [rand.c:28 -> rand.c:28]          libc-2.27.so
>            2.33%          180.5K        0.02%           1                =
                     [random.c:295 -> random.c:295]          libc-2.27.so
>            2.28%          176.7K        0.02%           1                =
                     [random.c:295 -> random.c:295]          libc-2.27.so
>            2.20%          168.8K        0.02%           1                =
                         [rand@plt+0 -> rand@plt+0]                   div
>            1.98%          158.2K        0.02%           1                =
                 [random_r.c:388 -> random_r.c:388]          libc-2.27.so
>            1.57%          123.3K        0.02%           1                =
                             [div.c:42 -> div.c:44]                   div
>            1.44%          116.0K        0.42%          19                =
                 [random_r.c:357 -> random_r.c:394]          libc-2.27.so
>=20
>  v3:
>  ---
>  Minor change since the function name is changed:
>  block_total_cycles_percent -> block_info__total_cycles_percent
>=20
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c    | 30 +++++++++++++---
>  tools/perf/ui/browsers/hists.c | 62 +++++++++++++++++++++++++++++++++-
>  tools/perf/ui/browsers/hists.h |  2 ++
>  tools/perf/util/hist.h         | 12 +++++++
>  4 files changed, 101 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dbae1812ce47..707512f177cb 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -800,6 +800,27 @@ static int hists__fprintf_all_blocks(struct hists *h=
ists, struct report *rep)
>  =09return 0;
>  }
> =20
> +static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
> +=09=09=09=09=09       struct report *rep)
> +{
> +=09struct block_hist *bh =3D &rep->block_hist;
> +=09struct evsel *pos;
> +=09int ret;
> +
> +=09evlist__for_each_entry(evlist, pos) {
> +=09=09struct hists *hists =3D evsel__hists(pos);
> +
> +=09=09get_block_hists(hists, bh, rep);

same here, this is display function, compute the data before

thanks,
jirka

> +=09=09symbol_conf.report_individual_block =3D true;
> +=09=09ret =3D block_hists_tui_browse(bh, pos, rep->min_percent);
> +=09=09hists__delete_entries(&bh->block_hists);
> +=09=09if (ret !=3D 0)
> +=09=09=09return ret;
> +=09}
> +
> +=09return ret;
> +}

SNIP

