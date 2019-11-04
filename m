Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966DDCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB3C21D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2/UIBBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfKDOEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:04:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729182AbfKDOEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572876285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nZHz0KBZcWv78FvObOGGcw3FAYSb0Qb8cjadirDsAc=;
        b=A2/UIBBVoOPk3qOkv8nDV7enh+a1VjzabiRPx2aTpn7kgyumXZImEPrb9DMQW2v1WH7lXN
        V9yjoyrKAIr0DtaB6xNDbQC1Lny8MTcoITFgVRwe1nCVxRZ8qmyHdKAY10qcjVNmeXWx1b
        qTmFhvkltqjGwVudlJC3hhFPYbXbMig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-TnAo12xYMJqzlSbGRiybrQ-1; Mon, 04 Nov 2019 09:04:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33710800C73;
        Mon,  4 Nov 2019 14:04:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3F49860E1C;
        Mon,  4 Nov 2019 14:04:39 +0000 (UTC)
Date:   Mon, 4 Nov 2019 15:04:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 5/7] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191104140438.GI8251@krava>
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
 <20191030060430.23558-6-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191030060430.23558-6-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TnAo12xYMJqzlSbGRiybrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:04:28PM +0800, Jin Yao wrote:

SNIP

> +static int hists__fprintf_all_blocks(struct block_hist *bh)
> +{
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
>  {
>  =09struct evsel *pos;
> +=09int i =3D 0;
> =20
>  =09if (!quiet) {
>  =09=09fprintf(stdout, "#\n# Total Lost Samples: %" PRIu64 "\n#\n",
> @@ -494,12 +509,20 @@ static int perf_evlist__tty_browse_hists(struct evl=
ist *evlist,
>  =09evlist__for_each_entry(evlist, pos) {
>  =09=09struct hists *hists =3D evsel__hists(pos);
>  =09=09const char *evname =3D perf_evsel__name(pos);
> +=09=09struct block_hist *block_hist;
> =20
>  =09=09if (symbol_conf.event_group &&
>  =09=09    !perf_evsel__is_group_leader(pos))
>  =09=09=09continue;
> =20
>  =09=09hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
> +
> +=09=09if (rep->total_cycles_mode) {
> +=09=09=09block_hist =3D &rep->block_reports[i++].hist;
> +=09=09=09hists__fprintf_all_blocks(block_hist);
> +=09=09=09continue;
> +=09=09}

hum, you don't need evsel in here, please make separate function like
perf_evlist__tty_browse_block_hists, where you will iterate directly
block_reports[i++]

IMO the best would be to have report__browse_block_hists in block-info.c
and handle all display modes from there

that's probably the last thing that would be moved to block-info.c
other than that I think the patchset is ok

thanks,
jirka

