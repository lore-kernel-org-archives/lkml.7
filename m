Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D8CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E15205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsVR6Jy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfJUQHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:07:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52739 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726289AbfJUQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571674057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQPZRRCGMG7fJgu4hP+seA8pXPu83oas54mRg6x4AJ0=;
        b=gsVR6Jy4NxMWOjvjep4hNYbJRwVCDHmFPtq17hpGQtKRmS6M/PR51KLTunVHNftnlY9YOL
        A2ovt3kZwPPpC50gZ8JVpQrsnZYmah5ddorGBqAkHClzTkaF0z9yMDTOtRfHw78I5dl4JU
        4H0dha0sUfcifVEwwnCAIxie0KMxcRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-JbfJO3oRMX-KAL7iRsVTIg-1; Mon, 21 Oct 2019 12:07:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 716BB100550E;
        Mon, 21 Oct 2019 16:07:32 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 777F919481;
        Mon, 21 Oct 2019 16:07:30 +0000 (UTC)
Date:   Mon, 21 Oct 2019 18:07:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191021160729.GF32718@krava>
References: <20191015053350.13909-1-yao.jin@linux.intel.com>
 <20191015053350.13909-4-yao.jin@linux.intel.com>
 <20191015084102.GA10951@krava>
 <6882f3ae-0f8d-5a01-7fd5-5b9f9c93f9ac@linux.intel.com>
 <20191016101543.GC15580@krava>
 <456b8e97-dc50-449c-9999-0bddef0e9c4c@linux.intel.com>
 <20191016125325.GA10222@krava>
 <2a16a22e-5bdd-949b-480f-1c0956e13c14@linux.intel.com>
 <20191021140439.GE32718@krava>
MIME-Version: 1.0
In-Reply-To: <20191021140439.GE32718@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: JbfJO3oRMX-KAL7iRsVTIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:04:39PM +0200, Jiri Olsa wrote:
> On Mon, Oct 21, 2019 at 02:56:57PM +0800, Jin, Yao wrote:
>=20
> SNIP
>=20
> > > > Does it seem like what the c2c does?
> > >=20
> > > well c2c has its own data output with multiline column titles,
> > > hence it has its own separate dimension stuff, but your code
> > > output is within the standard perf report right? single column
> > > output.. why couldn't you use just sort_entry ?
> > >=20
> > > jirka
> > >=20
> >=20
> > Hi Jiri,
> >=20
> > I've being thinking how to use sort_entry but I have some troubles.
> >=20
> > In v2, I used "struct perf_hpp_fmt" to pass extra argument. For example=
,
> >=20
> > static int64_t block_cycles_cov_sort(struct perf_hpp_fmt *fmt,
> > =09=09=09=09     struct hist_entry *left,
> > =09=09=09=09     struct hist_entry *right)
> > {
> > =09struct block_fmt *block_fmt =3D container_of(fmt, ...);
> > =09struct report *rep =3D block_fmt->rep;
> > =09...
> > }
> >=20
> > But if I just use sort_entry, I can't pass extra argument (it's not a g=
ood
> > idea to add more fields in struct hist_entry).
> >=20
> > int64_t sort__xxx_sort(struct hist_entry *left,
> > =09=09       struct hist_entry *right)
> >=20
> > And for entry print it's similar, I can't pass extra argument in.
> >=20
> > In v2,
> > static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
> > =09=09=09=09  struct perf_hpp *hpp,
> > =09=09=09=09  struct hist_entry *he)
> > {
> > =09struct block_fmt *block_fmt =3D container_of(fmt,...);
> > =09struct report *rep =3D block_fmt->rep;
> > =09...
> > }
> >=20
> > But for se_snprintf, I can't pass extra argument in.
> >=20
> > hist_entry__xxx_snprintf(struct hist_entry *he, char *bf,
> > =09=09=09 size_t size, unsigned int width)
> >=20
> > That's why I feel headache for just using the sort_entry. :(
>=20
> you might be right, I just want to omit another field output framework ;-=
)=20
> I'm checking on this and will let you know if I find some way

ok, because it's based on branch data the sort entry would not be
convenient.. I'm sending some other comments for the patch

thanks,
jirka

