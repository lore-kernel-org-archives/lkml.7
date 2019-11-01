Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E20CA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907F02080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/eksA1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfKAIeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:34:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24712 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730257AbfKAIeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572597275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4K5f+OjWDQ3lv6MdWJuVPcknw9YtYo2q38ocb7a62o=;
        b=Q/eksA1/owJaPg4nvfOSMQ+ecR8fs8QoH8FhiBF5RvyZ5f82l4ruOlFLn1dFsfM26dwEgK
        dv/6sQJOH04nUVuH1qxf/gtF0awuJBrfmTLaxMxIIwPINvtOOXaFtPDE7jIP8kRlCuzDcN
        gJ2NNdPU7WXSXegMFBQeN30SouY/Ca4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-ATosDpZlPHiQGlWjGQd1tQ-1; Fri, 01 Nov 2019 04:34:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30E5C800D49;
        Fri,  1 Nov 2019 08:34:31 +0000 (UTC)
Received: from krava (ovpn-204-176.brq.redhat.com [10.40.204.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id A8CFA5D9CA;
        Fri,  1 Nov 2019 08:34:27 +0000 (UTC)
Date:   Fri, 1 Nov 2019 09:34:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 7/7] perf report: Sort by sampled cycles percent per
 block for tui
Message-ID: <20191101083426.GC2172@krava>
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
 <20191030060430.23558-8-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191030060430.23558-8-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ATosDpZlPHiQGlWjGQd1tQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:04:30PM +0800, Jin Yao wrote:

SNIP

> +
>  static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>  =09=09=09=09=09 struct report *rep,
>  =09=09=09=09=09 const char *help)
> @@ -605,6 +624,11 @@ static int report__browse_hists(struct report *rep)
> =20
>  =09switch (use_browser) {
>  =09case 1:
> +=09=09if (rep->total_cycles_mode) {
> +=09=09=09ret =3D perf_evlist__tui_block_hists_browse(evlist, rep);
> +=09=09=09break;
> +=09=09}

does this have sense only for cycles event? what if I do:
  # perf record -b -e cycles,cache-misses

jirka

> +
>  =09=09ret =3D perf_evlist__tui_browse_hists(evlist, help, NULL,
>  =09=09=09=09=09=09    rep->min_percent,
>  =09=09=09=09=09=09    &session->header.env,
> @@ -1408,12 +1432,8 @@ int cmd_report(int argc, const char **argv)
>  =09if (report.total_cycles_mode) {
>  =09=09if (sort__mode !=3D SORT_MODE__BRANCH)
>  =09=09=09report.total_cycles_mode =3D false;
> -=09=09else if (!report.use_stdio) {
> -=09=09=09pr_err("Error: --total-cycles can be only used together with --=
stdio\n");
> -=09=09=09goto error;
> -=09=09} else {
> +=09=09else
>  =09=09=09sort_order =3D "sym";
> -=09=09}
>  =09}
> =20
>  =09if (strcmp(input_name, "-") !=3D 0)

SNIP

