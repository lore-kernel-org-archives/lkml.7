Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923C1CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B992084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G08i3wkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405030AbfJWLgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:36:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390721AbfJWLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571830604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnA0V38ThXuaRHftJ1w07hrXcaIPmZZ1luFHNsfME6M=;
        b=G08i3wkleNSAQXcRWvMsh8BmMrOXJl+fmwF7RH8TkbQWa/qwkkq5gfdXFZQBGqcmJqBJqj
        GppoVI26++X45f1CamWrU8AqkKrHsuTBPD2fMUJAYi606q1MTyMhbk6HyR3WpEfhEtGAQZ
        o0yfdPye/DKSPO6j4bKGHOpV981piH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-0BfVulBjPt6WPNwk7TFjyQ-1; Wed, 23 Oct 2019 07:36:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D2F01800DCB;
        Wed, 23 Oct 2019 11:36:39 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 18C2F5D6C8;
        Wed, 23 Oct 2019 11:36:36 +0000 (UTC)
Date:   Wed, 23 Oct 2019 13:36:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191023113636.GM22919@krava>
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191022080710.6491-4-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0BfVulBjPt6WPNwk7TFjyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:07:08PM +0800, Jin Yao wrote:

SNIP

> +static void get_block_hists(struct hists *hists, struct block_hist *bh,
> +=09=09=09    struct report *rep)
> +{
> +=09struct rb_node *next =3D rb_first_cached(&hists->entries);
> +=09struct hist_entry *he;
> +
> +=09init_block_hist(bh, rep);
> +
> +=09while (next) {
> +=09=09he =3D rb_entry(next, struct hist_entry, rb_node);
> +=09=09block_info__process_sym(he, bh, &rep->block_cycles,
> +=09=09=09=09=09rep->cycles_count);
> +=09=09next =3D rb_next(&he->rb_node);
> +=09}
> +
> +=09hists__output_resort(&bh->block_hists, NULL);
> +}
> +
> +static int hists__fprintf_all_blocks(struct hists *hists, struct report =
*rep)
> +{
> +=09struct block_hist *bh =3D &rep->block_hist;
> +
> +=09get_block_hists(hists, bh, rep);
> +=09symbol_conf.report_individual_block =3D true;
> +=09hists__fprintf(&bh->block_hists, true, 0, 0, 0,
> +=09=09       stdout, true);
> +=09hists__delete_entries(&bh->block_hists);
> +=09return 0;
> +}
> +
>  static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>  =09=09=09=09=09 struct report *rep,
>  =09=09=09=09=09 const char *help)
> @@ -500,6 +820,12 @@ static int perf_evlist__tty_browse_hists(struct evli=
st *evlist,
>  =09=09=09continue;
> =20
>  =09=09hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
> +
> +=09=09if (rep->total_cycles) {
> +=09=09=09hists__fprintf_all_blocks(hists, rep);

it's still being computed in output function, the computation
should be outside.. like in report__output_resort or such

thanks,
jirka

