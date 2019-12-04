Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413A5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E2C20656
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM7hfePS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfLDMH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:07:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33144 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727445AbfLDMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575461247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QX3Jr8BVT6bq8JjJGdnB3TP6g5ApuFdu1TbuAgwMefo=;
        b=DM7hfePS0FOI9fJgEq2XzTdR5WnhDldXTZJyBnIWE/TICKKDDabM0o91aPee5aCt5SG5ml
        MNw2Dmm2WzaXtHxJaNPc5ARUG9sFH0THwaYaGP91DXaU2S5qz8YJbYFBleZHWKs7TOXTmv
        pNld36fGeIwiBL1SeTlM00bbVvElOdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-cLa41l0vPe24b7d6QDvc6A-1; Wed, 04 Dec 2019 07:07:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD5A107ACC4;
        Wed,  4 Dec 2019 12:07:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 558685D6AE;
        Wed,  4 Dec 2019 12:07:10 +0000 (UTC)
Date:   Wed, 4 Dec 2019 13:07:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, kan.liang@intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf report: Few fixes
Message-ID: <20191204120707.GC20746@krava>
References: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: cLa41l0vPe24b7d6QDvc6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 06:52:10PM +0530, Ravi Bangoria wrote:
> v1: https://lore.kernel.org/r/20191112054946.5869-1-ravi.bangoria@linux.i=
bm.com
>=20
> v1 fixed a segfault when -F phys_daddr is used in perf report without
> --mem-mode. Arnaldo suggested to bail out the option completely in
> such case instead of showing 0 values.
>=20
> Ravi Bangoria (3):
>   perf hists: Replace pr_err with ui__error
>   perf report: Make -F more strict like -s
>   perf report: Error out for mem mode fields if mem info is not
>     available
>=20
>  tools/perf/builtin-report.c |  8 ++++++++
>  tools/perf/util/sort.c      | 16 +++++++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)

looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

