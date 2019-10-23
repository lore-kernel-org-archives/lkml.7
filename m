Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9B0CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2F21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaHKbEw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392217AbfJWO1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:27:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389061AbfJWO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571840836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PiooTmkkryaLrAgnX+C2Y55E3f5bnpoNVZbM91YApo=;
        b=eaHKbEw5z7xbNlnLNqGWbmlAwrIiJy8CFxzYZncL2PcZd+0D3jjSNYQ1+kuJOnZO+xkcSQ
        bFhQ0i04XSQIJ7K+C5XmpWw8/dx5omzHCWHMNKC5lFzsieoij1oha4egYJGdEZgE9szNbL
        4I/0bQH7c4byajuM5UqIt06K8c9LNKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-c9pvClMKPo-WcwcWH-UzIA-1; Wed, 23 Oct 2019 10:27:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 460C85E4;
        Wed, 23 Oct 2019 14:27:13 +0000 (UTC)
Received: from krava (ovpn-204-191.brq.redhat.com [10.40.204.191])
        by smtp.corp.redhat.com (Postfix) with SMTP id 16DC019C77;
        Wed, 23 Oct 2019 14:27:09 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:27:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191023142709.GR22919@krava>
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-4-yao.jin@linux.intel.com>
 <20191023113649.GO22919@krava>
 <32cbd687-9089-91ba-a2de-d9784cc37a20@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <32cbd687-9089-91ba-a2de-d9784cc37a20@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: c9pvClMKPo-WcwcWH-UzIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 09:09:34PM +0800, Jin, Yao wrote:
>=20
>=20
> On 10/23/2019 7:36 PM, Jiri Olsa wrote:
> > On Tue, Oct 22, 2019 at 04:07:08PM +0800, Jin Yao wrote:
> >=20
> > SNIP
> >=20
> > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.=
c
> > > index cdb436d6e11f..44aed40e9071 100644
> > > --- a/tools/perf/builtin-report.c
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -51,6 +51,7 @@
> > >   #include "util/util.h" // perf_tip()
> > >   #include "ui/ui.h"
> > >   #include "ui/progress.h"
> > > +#include "util/block-info.h"
> > >   #include <dlfcn.h>
> > >   #include <errno.h>
> > > @@ -96,10 +97,64 @@ struct report {
> > >   =09float=09=09=09min_percent;
> > >   =09u64=09=09=09nr_entries;
> > >   =09u64=09=09=09queue_size;
> > > +=09u64=09=09=09cycles_count;
> > > +=09u64=09=09=09block_cycles;
> > >   =09int=09=09=09socket_filter;
> > >   =09DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> > >   =09struct branch_type_stat=09brtype_stat;
> > >   =09bool=09=09=09symbol_ipc;
> > > +=09bool=09=09=09total_cycles;
> > > +=09struct block_hist=09block_hist;
> > > +};
> >=20
> > as I said please move all below into util/block_info.c
> >=20
> > thanks,
> > jirka
> >=20
>=20
> Hi Jiri,
>=20
> Above fields are not suitable to be moved to struct block_info because th=
ey
> are not per-block info. For example, total_cycles are the sum of sampled
> cycles for all blocks.
>=20
> Oh maybe you just suggest to create a new struct in util/block_info.c and
> move above info to the new struct? Is my understanding correct?

hum, I'm talking about the code below, starting with 'struct block_fmt' ...

jirka

> > > +struct block_fmt {
> > > +=09struct perf_hpp_fmt=09fmt;
> > > +=09int=09=09=09idx;
> > > +=09int=09=09=09width;
> > > +=09const char=09=09*header;
> > > +=09struct report=09=09*rep;
> > > +};
> > > +
> > > +enum {
> > > +=09PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
> > > +=09PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
> > > +=09PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
> > > +=09PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
> > > +=09PERF_HPP_REPORT__BLOCK_RANGE,
> > > +=09PERF_HPP_REPORT__BLOCK_DSO,
> > > +=09PERF_HPP_REPORT__BLOCK_MAX_INDEX
> > > +};
> > > +
> > > +static struct block_fmt block_fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX]=
;
> > > +
> > > +static struct block_header_column{
> > > +=09const char *name;
> > > +=09int width;
> > > +} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] =3D {
> > > +=09[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT] =3D {
> > > +=09=09.name =3D "Sampled Cycles%",
> > > +=09=09.width =3D 15,
> > > +=09},
> > > +=09[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] =3D {
> > > +=09=09.name =3D "Sampled Cycles",
> > > +=09=09.width =3D 14,
> > > +=09},
> > > +=09[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] =3D {
> > > +=09=09.name =3D "Avg Cycles%",
> > > +=09=09.width =3D 11,
> > > +=09},
> > > +=09[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] =3D {
> > > +=09=09.name =3D "Avg Cycles",
> > > +=09=09.width =3D 10,
> > > +=09},
> > > +=09[PERF_HPP_REPORT__BLOCK_RANGE] =3D {
> > > +=09=09.name =3D "[Program Block Range]",
> > > +=09=09.width =3D 70,
> > > +=09},
> > > +=09[PERF_HPP_REPORT__BLOCK_DSO] =3D {
> > > +=09=09.name =3D "Shared Object",
> > > +=09=09.width =3D 20,
> > > +=09}
> > >   };
> > >   static int report__config(const char *var, const char *value, void =
*cb)
> > > @@ -277,7 +332,8 @@ static int process_sample_event(struct perf_tool =
*tool,
> > >   =09=09if (!sample->branch_stack)
> > >   =09=09=09goto out_put;
> > > -=09=09iter.add_entry_cb =3D hist_iter__branch_callback;
> > > +=09=09if (!rep->total_cycles)
> > > +=09=09=09iter.add_entry_cb =3D hist_iter__branch_callback;
> > >   =09=09iter.ops =3D &hist_iter_branch;
> > >   =09} else if (rep->mem_mode) {
> > >   =09=09iter.ops =3D &hist_iter_mem;
> > > @@ -290,9 +346,10 @@ static int process_sample_event(struct perf_tool=
 *tool,
> > >   =09if (al.map !=3D NULL)
> > >   =09=09al.map->dso->hit =3D 1;
> > > -=09if (ui__has_annotation() || rep->symbol_ipc) {
> > > +=09if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles)=
 {
> > >   =09=09hist__account_cycles(sample->branch_stack, &al, sample,
> > > -=09=09=09=09     rep->nonany_branch_mode, NULL);
> > > +=09=09=09=09     rep->nonany_branch_mode,
> > > +=09=09=09=09     &rep->cycles_count);
> > >   =09}
> > >   =09ret =3D hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
> > > @@ -480,6 +537,269 @@ static size_t hists__fprintf_nr_sample_events(s=
truct hists *hists, struct report
> > >   =09return ret + fprintf(fp, "\n#\n");
> > >   }
> > > +static int block_column_header(struct perf_hpp_fmt *fmt __maybe_unus=
ed,
> > > +=09=09=09       struct perf_hpp *hpp __maybe_unused,
> > > +=09=09=09       struct hists *hists __maybe_unused,
> > > +=09=09=09       int line __maybe_unused,
> > > +=09=09=09       int *span __maybe_unused)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +
> > > +=09return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> > > +=09=09=09 block_fmt->header);
> > > +}
> > > +
> > > +static int block_column_width(struct perf_hpp_fmt *fmt __maybe_unuse=
d,
> > > +=09=09=09      struct perf_hpp *hpp __maybe_unused,
> > > +=09=09=09      struct hists *hists __maybe_unused)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +
> > > +=09return block_fmt->width;
> > > +}
> > > +
> > > +static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
> > > +=09=09=09=09=09struct perf_hpp *hpp,
> > > +=09=09=09=09=09struct hist_entry *he)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +=09struct report *rep =3D block_fmt->rep;
> > > +=09struct block_info *bi =3D he->block_info;
> > > +=09double ratio =3D 0.0;
> > > +=09char buf[16];
> > > +
> > > +=09if (rep->cycles_count)
> > > +=09=09ratio =3D (double)bi->cycles / (double)rep->cycles_count;
> > > +
> > > +=09sprintf(buf, "%.2f%%", 100.0 * ratio);
> > > +
> > > +=09return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, bu=
f);
> > > +}
> > > +
> > > +static int64_t block_total_cycles_pct_sort(struct perf_hpp_fmt *fmt,
> > > +=09=09=09=09=09   struct hist_entry *left,
> > > +=09=09=09=09=09   struct hist_entry *right)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +=09struct report *rep =3D block_fmt->rep;
> > > +=09struct block_info *bi_l =3D left->block_info;
> > > +=09struct block_info *bi_r =3D right->block_info;
> > > +=09double l, r;
> > > +
> > > +=09if (rep->cycles_count) {
> > > +=09=09l =3D ((double)bi_l->cycles / (double)rep->cycles_count) * 100=
0.0;
> > > +=09=09r =3D ((double)bi_r->cycles / (double)rep->cycles_count) * 100=
0.0;
> > > +=09=09return (int64_t)l - (int64_t)r;
> > > +=09}
> > > +
> > > +=09return 0;
> > > +}
> > > +
> > > +static void cycles_string(u64 cycles, char *buf, int size)
> > > +{
> > > +=09if (cycles >=3D 1000000)
> > > +=09=09scnprintf(buf, size, "%.1fM", (double)cycles / 1000000.0);
> > > +=09else if (cycles >=3D 1000)
> > > +=09=09scnprintf(buf, size, "%.1fK", (double)cycles / 1000.0);
> > > +=09else
> > > +=09=09scnprintf(buf, size, "%1d", cycles);
> > > +}
> > > +
> > > +static int block_cycles_lbr_entry(struct perf_hpp_fmt *fmt,
> > > +=09=09=09=09  struct perf_hpp *hpp, struct hist_entry *he)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +=09struct block_info *bi =3D he->block_info;
> > > +=09char cycles_buf[16];
> > > +
> > > +=09cycles_string(bi->cycles_aggr, cycles_buf, sizeof(cycles_buf));
> > > +
> > > +=09return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> > > +=09=09=09 cycles_buf);
> > > +}
> > > +
> > > +static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
> > > +=09=09=09=09  struct perf_hpp *hpp, struct hist_entry *he)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +=09struct report *rep =3D block_fmt->rep;
> > > +=09struct block_info *bi =3D he->block_info;
> > > +=09double ratio =3D 0.0;
> > > +=09u64 avg;
> > > +=09char buf[16];
> > > +
> > > +=09if (rep->block_cycles && bi->num_aggr) {
> > > +=09=09avg =3D bi->cycles_aggr / bi->num_aggr;
> > > +=09=09ratio =3D (double)avg / (double)rep->block_cycles;
> > > +=09}
> > > +
> > > +=09sprintf(buf, "%.2f%%", 100.0 * ratio);
> > > +
> > > +=09return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, bu=
f);
> > > +}
> > > +
> > > +static int block_avg_cycles_entry(struct perf_hpp_fmt *fmt,
> > > +=09=09=09=09  struct perf_hpp *hpp,
> > > +=09=09=09=09  struct hist_entry *he)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +=09struct block_info *bi =3D he->block_info;
> > > +=09char cycles_buf[16];
> > > +
> > > +=09cycles_string(bi->cycles_aggr / bi->num_aggr, cycles_buf,
> > > +=09=09      sizeof(cycles_buf));
> > > +
> > > +=09return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> > > +=09=09=09 cycles_buf);
> > > +}
> > > +
> > > +static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_h=
pp *hpp,
> > > +=09=09=09     struct hist_entry *he)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +=09struct block_info *bi =3D he->block_info;
> > > +=09char buf[128];
> > > +=09char *start_line, *end_line;
> > > +
> > > +=09symbol_conf.disable_add2line_warn =3D true;
> > > +
> > > +=09start_line =3D map__srcline(he->ms.map, bi->sym->start + bi->star=
t,
> > > +=09=09=09=09  he->ms.sym);
> > > +
> > > +=09end_line =3D map__srcline(he->ms.map, bi->sym->start + bi->end,
> > > +=09=09=09=09he->ms.sym);
> > > +
> > > +=09if ((start_line !=3D SRCLINE_UNKNOWN) && (end_line !=3D SRCLINE_U=
NKNOWN)) {
> > > +=09=09scnprintf(buf, sizeof(buf), "[%s -> %s]",
> > > +=09=09=09  start_line, end_line);
> > > +=09} else {
> > > +=09=09scnprintf(buf, sizeof(buf), "[%7lx -> %7lx]",
> > > +=09=09=09  bi->start, bi->end);
> > > +=09}
> > > +
> > > +=09free_srcline(start_line);
> > > +=09free_srcline(end_line);
> > > +
> > > +=09return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, bu=
f);
> > > +}
> > > +
> > > +static int block_dso_entry(struct perf_hpp_fmt *fmt, struct perf_hpp=
 *hpp,
> > > +=09=09=09   struct hist_entry *he)
> > > +{
> > > +=09struct block_fmt *block_fmt =3D container_of(fmt, struct block_fm=
t, fmt);
> > > +=09struct map *map =3D he->ms.map;
> > > +
> > > +=09if (map && map->dso) {
> > > +=09=09return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> > > +=09=09=09=09 map->dso->short_name);
> > > +=09}
> > > +
> > > +=09return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> > > +=09=09=09 "[unknown]");
> > > +}
> > > +
> > > +static void init_block_header(struct block_fmt *block_fmt)
> > > +{
> > > +=09struct perf_hpp_fmt *fmt =3D &block_fmt->fmt;
> > > +
> > > +=09BUG_ON(block_fmt->idx >=3D PERF_HPP_REPORT__BLOCK_MAX_INDEX);
> > > +
> > > +=09block_fmt->header =3D block_columns[block_fmt->idx].name;
> > > +=09block_fmt->width =3D block_columns[block_fmt->idx].width;
> > > +
> > > +=09fmt->header =3D block_column_header;
> > > +=09fmt->width =3D block_column_width;
> > > +}
> > > +
> > > +static void block_hpp_register(struct block_fmt *block_fmt, int idx,
> > > +=09=09=09       struct perf_hpp_list *hpp_list,
> > > +=09=09=09       struct report *rep)
> > > +{
> > > +=09struct perf_hpp_fmt *fmt =3D &block_fmt->fmt;
> > > +
> > > +=09block_fmt->rep =3D rep;
> > > +=09block_fmt->idx =3D idx;
> > > +=09INIT_LIST_HEAD(&fmt->list);
> > > +=09INIT_LIST_HEAD(&fmt->sort_list);
> > > +
> > > +=09switch (idx) {
> > > +=09case PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT:
> > > +=09=09fmt->entry =3D block_total_cycles_pct_entry;
> > > +=09=09fmt->cmp =3D block_info__cmp;
> > > +=09=09fmt->sort =3D block_total_cycles_pct_sort;
> > > +=09=09break;
> > > +=09case PERF_HPP_REPORT__BLOCK_LBR_CYCLES:
> > > +=09=09fmt->entry =3D block_cycles_lbr_entry;
> > > +=09=09break;
> > > +=09case PERF_HPP_REPORT__BLOCK_CYCLES_PCT:
> > > +=09=09fmt->entry =3D block_cycles_pct_entry;
> > > +=09=09break;
> > > +=09case PERF_HPP_REPORT__BLOCK_AVG_CYCLES:
> > > +=09=09fmt->entry =3D block_avg_cycles_entry;
> > > +=09=09break;
> > > +=09case PERF_HPP_REPORT__BLOCK_RANGE:
> > > +=09=09fmt->entry =3D block_range_entry;
> > > +=09=09break;
> > > +=09case PERF_HPP_REPORT__BLOCK_DSO:
> > > +=09=09fmt->entry =3D block_dso_entry;
> > > +=09=09break;
> > > +=09default:
> > > +=09=09return;
> > > +=09}
> > > +
> > > +=09init_block_header(block_fmt);
> > > +=09perf_hpp_list__column_register(hpp_list, fmt);
> > > +}
> > > +
> > > +static void register_block_columns(struct perf_hpp_list *hpp_list,
> > > +=09=09=09=09   struct report *rep)
> > > +{
> > > +=09for (int i =3D 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
> > > +=09=09block_hpp_register(&block_fmts[i], i, hpp_list, rep);
> > > +}
> > > +
> > > +static void init_block_hist(struct block_hist *bh, struct report *re=
p)
> > > +{
> > > +=09__hists__init(&bh->block_hists, &bh->block_list);
> > > +=09perf_hpp_list__init(&bh->block_list);
> > > +=09bh->block_list.nr_header_lines =3D 1;
> > > +
> > > +=09register_block_columns(&bh->block_list, rep);
> > > +
> > > +=09perf_hpp_list__register_sort_field(&bh->block_list,
> > > +=09=09&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
> > > +}
> > > +
> > > +static void get_block_hists(struct hists *hists, struct block_hist *=
bh,
> > > +=09=09=09    struct report *rep)
> > > +{
> > > +=09struct rb_node *next =3D rb_first_cached(&hists->entries);
> > > +=09struct hist_entry *he;
> > > +
> > > +=09init_block_hist(bh, rep);
> > > +
> > > +=09while (next) {
> > > +=09=09he =3D rb_entry(next, struct hist_entry, rb_node);
> > > +=09=09block_info__process_sym(he, bh, &rep->block_cycles,
> > > +=09=09=09=09=09rep->cycles_count);
> > > +=09=09next =3D rb_next(&he->rb_node);
> > > +=09}
> > > +
> > > +=09hists__output_resort(&bh->block_hists, NULL);
> > > +}
> > > +
> > > +static int hists__fprintf_all_blocks(struct hists *hists, struct rep=
ort *rep)
> > > +{
> > > +=09struct block_hist *bh =3D &rep->block_hist;
> > > +
> > > +=09get_block_hists(hists, bh, rep);
> > > +=09symbol_conf.report_individual_block =3D true;
> > > +=09hists__fprintf(&bh->block_hists, true, 0, 0, 0,
> > > +=09=09       stdout, true);
> > > +=09hists__delete_entries(&bh->block_hists);
> > > +=09return 0;
> > > +}
> > > +
> > >   static int perf_evlist__tty_browse_hists(struct evlist *evlist,
> > >   =09=09=09=09=09 struct report *rep,
> > >   =09=09=09=09=09 const char *help)
> > > @@ -500,6 +820,12 @@ static int perf_evlist__tty_browse_hists(struct =
evlist *evlist,
> > >   =09=09=09continue;
> > >   =09=09hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
> > > +
> > > +=09=09if (rep->total_cycles) {
> > > +=09=09=09hists__fprintf_all_blocks(hists, rep);
> > > +=09=09=09continue;
> > > +=09=09}
> > > +
> > >   =09=09hists__fprintf(hists, !quiet, 0, 0, rep->min_percent, stdout,
> > >   =09=09=09       !(symbol_conf.use_callchain ||
> > >   =09=09=09         symbol_conf.show_branchflag_count));
> > > @@ -1373,6 +1699,15 @@ int cmd_report(int argc, const char **argv)
> > >   =09=09goto error;
> > >   =09}
> > > +=09if (sort_order && strstr(sort_order, "total_cycles") &&
> > > +=09    (sort__mode =3D=3D SORT_MODE__BRANCH)) {
> > > +=09=09report.total_cycles =3D true;
> > > +=09=09if (!report.use_stdio) {
> > > +=09=09=09pr_err("Error: -s total_cycles can be only used together wi=
th --stdio\n");
> > > +=09=09=09goto error;
> > > +=09=09}
> > > +=09}
> > > +
> > >   =09if (strcmp(input_name, "-") !=3D 0)
> > >   =09=09setup_browser(true);
> > >   =09else
> > > @@ -1423,7 +1758,7 @@ int cmd_report(int argc, const char **argv)
> > >   =09 * so don't allocate extra space that won't be used in the stdio
> > >   =09 * implementation.
> > >   =09 */
> > > -=09if (ui__has_annotation() || report.symbol_ipc) {
> > > +=09if (ui__has_annotation() || report.symbol_ipc || report.total_cyc=
les) {
> > >   =09=09ret =3D symbol__annotation_init();
> > >   =09=09if (ret < 0)
> > >   =09=09=09goto error;
> > > diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
> > > index 5365606e9dad..655ef7708cd0 100644
> > > --- a/tools/perf/ui/stdio/hist.c
> > > +++ b/tools/perf/ui/stdio/hist.c
> > > @@ -558,6 +558,25 @@ static int hist_entry__block_fprintf(struct hist=
_entry *he,
> > >   =09return ret;
> > >   }
> > > +static int hist_entry__individual_block_fprintf(struct hist_entry *h=
e,
> > > +=09=09=09=09=09=09char *bf, size_t size,
> > > +=09=09=09=09=09=09FILE *fp)
> > > +{
> > > +=09int ret =3D 0;
> > > +
> > > +=09struct perf_hpp hpp =3D {
> > > +=09=09.buf=09=09=3D bf,
> > > +=09=09.size=09=09=3D size,
> > > +=09=09.skip=09=09=3D false,
> > > +=09};
> > > +
> > > +=09hist_entry__snprintf(he, &hpp);
> > > +=09if (!hpp.skip)
> > > +=09=09ret +=3D fprintf(fp, "%s\n", bf);
> > > +
> > > +=09return ret;
> > > +}
> > > +
> > >   static int hist_entry__fprintf(struct hist_entry *he, size_t size,
> > >   =09=09=09       char *bf, size_t bfsz, FILE *fp,
> > >   =09=09=09       bool ignore_callchains)
> > > @@ -580,6 +599,9 @@ static int hist_entry__fprintf(struct hist_entry =
*he, size_t size,
> > >   =09if (symbol_conf.report_block)
> > >   =09=09return hist_entry__block_fprintf(he, bf, size, fp);
> > > +=09if (symbol_conf.report_individual_block)
> > > +=09=09return hist_entry__individual_block_fprintf(he, bf, size, fp);
> > > +
> > >   =09hist_entry__snprintf(he, &hpp);
> > >   =09ret =3D fprintf(fp, "%s\n", bf);
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index 0e27d6830011..7cf137b0451b 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -758,6 +758,10 @@ struct hist_entry *hists__add_entry_block(struct=
 hists *hists,
> > >   =09struct hist_entry entry =3D {
> > >   =09=09.block_info =3D block_info,
> > >   =09=09.hists =3D hists,
> > > +=09=09.ms =3D {
> > > +=09=09=09.map =3D al->map,
> > > +=09=09=09.sym =3D al->sym,
> > > +=09=09},
> > >   =09}, *he =3D hists__findnew_entry(hists, &entry, al, false);
> > >   =09return he;
> > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > index 43d1d410854a..eb286700a8a9 100644
> > > --- a/tools/perf/util/sort.c
> > > +++ b/tools/perf/util/sort.c
> > > @@ -492,6 +492,10 @@ struct sort_entry sort_sym_ipc_null =3D {
> > >   =09.se_width_idx=09=3D HISTC_SYMBOL_IPC,
> > >   };
> > > +struct sort_entry sort_block_cycles =3D {
> > > +=09.se_cmp=09=09=3D sort__sym_cmp,
> > > +};
> > > +
> > >   /* --sort srcfile */
> > >   static char no_srcfile[1];
> > > @@ -1695,6 +1699,7 @@ static struct sort_dimension bstack_sort_dimens=
ions[] =3D {
> > >   =09DIM(SORT_SRCLINE_FROM, "srcline_from", sort_srcline_from),
> > >   =09DIM(SORT_SRCLINE_TO, "srcline_to", sort_srcline_to),
> > >   =09DIM(SORT_SYM_IPC, "ipc_lbr", sort_sym_ipc),
> > > +=09DIM(SORT_BLOCK_CYCLES, "total_cycles", sort_block_cycles),
> > >   };
> > >   #undef DIM
> > > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > > index 5aff9542d9b7..2ede6c70ad56 100644
> > > --- a/tools/perf/util/sort.h
> > > +++ b/tools/perf/util/sort.h
> > > @@ -239,6 +239,7 @@ enum sort_type {
> > >   =09SORT_SRCLINE_FROM,
> > >   =09SORT_SRCLINE_TO,
> > >   =09SORT_SYM_IPC,
> > > +=09SORT_BLOCK_CYCLES,
> > >   =09/* memory mode specific sort keys */
> > >   =09__SORT_MEMORY_MODE,
> > > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_c=
onf.h
> > > index e6880789864c..10f1ec3e0349 100644
> > > --- a/tools/perf/util/symbol_conf.h
> > > +++ b/tools/perf/util/symbol_conf.h
> > > @@ -40,6 +40,7 @@ struct symbol_conf {
> > >   =09=09=09raw_trace,
> > >   =09=09=09report_hierarchy,
> > >   =09=09=09report_block,
> > > +=09=09=09report_individual_block,
> > >   =09=09=09inline_name,
> > >   =09=09=09disable_add2line_warn;
> > >   =09const char=09*vmlinux_name,
> > > --=20
> > > 2.17.1
> > >=20
> >=20

