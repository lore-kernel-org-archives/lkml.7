Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C25CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5E5214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rt4oy7hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405059AbfJWLhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:37:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23474 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404831AbfJWLhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571830628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJ2863pRcd+MmfAL9jLi7X0U7M+hTUINeHaoCP6kV/M=;
        b=Rt4oy7hy0VM6mjVaTTS+Ozql6GVK3JzuzBxgjVIs2kputgtGlI0x8YR3DizrrwIrzsGOKw
        6Cxpp7zjPAJ+75A2bLjf4u3Kk9In4jidgIHbpDXzdFkTmrSyZifqkId7nPLSKrVxtuqbpe
        MUBFiYmwE0W62XGlTdQoHpDMkwRJ33w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-kDrHZGwpPtmNH7OYzfeZwQ-1; Wed, 23 Oct 2019 07:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E96CE107AD31;
        Wed, 23 Oct 2019 11:37:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0530C5D6D0;
        Wed, 23 Oct 2019 11:37:03 +0000 (UTC)
Date:   Wed, 23 Oct 2019 13:37:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/5] perf util: Cleanup and refactor block info
 functions
Message-ID: <20191023113703.GQ22919@krava>
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191022080710.6491-2-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: kDrHZGwpPtmNH7OYzfeZwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:07:06PM +0800, Jin Yao wrote:

SNIP

> =20
> -static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
> -{
> -=09/* Skip the calculation of column length in output_resort */
> -=09he->filtered =3D true;
> -=09return 0;
> -}

please move this change into separate patch and explain in changelog
why this is necessary

thanks,
jirka

> -
>  static void hists__precompute(struct hists *hists)
>  {
>  =09struct rb_root_cached *root;
> @@ -792,8 +695,11 @@ static void hists__precompute(struct hists *hists)
>  =09=09he   =3D rb_entry(next, struct hist_entry, rb_node_in);
>  =09=09next =3D rb_next(&he->rb_node_in);
> =20
> -=09=09if (compute =3D=3D COMPUTE_CYCLES)
> -=09=09=09process_block_per_sym(he);
> +=09=09if (compute =3D=3D COMPUTE_CYCLES) {
> +=09=09=09bh =3D container_of(he, struct block_hist, he);
> +=09=09=09init_block_hist(bh);
> +=09=09=09block_info__process_sym(he, bh, NULL, 0);
> +=09=09}
> =20
>  =09=09data__for_each_file_new(i, d) {
>  =09=09=09pair =3D get_pair_data(he, d);
> @@ -812,16 +718,18 @@ static void hists__precompute(struct hists *hists)
>  =09=09=09=09compute_wdiff(he, pair);
>  =09=09=09=09break;
>  =09=09=09case COMPUTE_CYCLES:
> -=09=09=09=09process_block_per_sym(pair);
> -=09=09=09=09bh =3D container_of(he, struct block_hist, he);
>  =09=09=09=09pair_bh =3D container_of(pair, struct block_hist,
>  =09=09=09=09=09=09       he);
> +=09=09=09=09init_block_hist(pair_bh);
> +=09=09=09=09block_info__process_sym(pair, pair_bh, NULL, 0);
> +
> +=09=09=09=09bh =3D container_of(he, struct block_hist, he);
> =20
>  =09=09=09=09if (bh->valid && pair_bh->valid) {
>  =09=09=09=09=09block_hists_match(&bh->block_hists,
>  =09=09=09=09=09=09=09  &pair_bh->block_hists);
> -=09=09=09=09=09hists__output_resort_cb(&pair_bh->block_hists,
> -=09=09=09=09=09=09=09=09NULL, filter_cb);
> +=09=09=09=09=09hists__output_resort(&pair_bh->block_hists,
> +=09=09=09=09=09=09=09     NULL);
>  =09=09=09=09}
>  =09=09=09=09break;
>  =09=09=09default:

SNIP

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 679a1d75090c..a7fa061987e4 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -18,6 +18,7 @@
>  #include "srcline.h"
>  #include "symbol.h"
>  #include "thread.h"
> +#include "block-info.h"
>  #include "ui/progress.h"
>  #include <errno.h>
>  #include <math.h>
> @@ -80,6 +81,8 @@ void hists__calc_col_len(struct hists *hists, struct hi=
st_entry *h)
>  =09int symlen;
>  =09u16 len;
> =20
> +=09if (h->block_info)
> +=09=09return;
>  =09/*
>  =09 * +4 accounts for '[x] ' priv level info
>  =09 * +2 accounts for 0x prefix on raw addresses

SNIP

