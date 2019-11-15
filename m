Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72FE20730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbYoedFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfKOOzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:55:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727496AbfKOOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573829735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKmFBRNcgdSwymqjHC99Gi+RzBFDF0TzRLorY8ip2rc=;
        b=IbYoedFUrJTeWsQdsEZRh7O2H7Oh4dRfw+oC3EyTX0XfRAmvr1gX0bM9ug9vhjkx3z0snR
        2nOkR8MS4W02p/bdIYZBvmvO5d7SgAjR2luY6LBQtvend4IWjy1y01IDTH97ZZ8lRY15ay
        JKlzfWRscegeRoQAoZLc57JBSwSlUJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-6WaB5xypPbuZUXNLAVO_yQ-1; Fri, 15 Nov 2019 09:55:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67BC0107ACE5;
        Fri, 15 Nov 2019 14:55:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4BA705ED54;
        Fri, 15 Nov 2019 14:55:28 +0000 (UTC)
Date:   Fri, 15 Nov 2019 15:55:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 10/12] perf stat: Use affinity for reading
Message-ID: <20191115145528.GB4255@krava>
References: <20191112005941.649137-1-andi@firstfloor.org>
 <20191112005941.649137-11-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191112005941.649137-11-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 6WaB5xypPbuZUXNLAVO_yQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:59:39PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
>=20
> Restructure event reading to use affinity to minimize the number
> of IPIs needed.
>=20
> Before on a large test case with 94 CPUs:
>=20
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>   3.16    0.106079           4     22082           read
>=20
> After:
>=20
>   3.43    0.081295           3     22082           read
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>=20
> ---
>=20
> v2: Use new iterator macros
> v3: Use new iterator macros
> v4: Change iterator macros even more
> v5: Preserve counter->err in all cases
> ---
>  tools/perf/builtin-stat.c | 95 ++++++++++++++++++++++-----------------
>  tools/perf/util/evsel.h   |  1 +
>  2 files changed, 55 insertions(+), 41 deletions(-)
>=20
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 039aefb07777..7784f5a93944 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -266,15 +266,10 @@ static int read_single_counter(struct evsel *counte=
r, int cpu,
>   * Read out the results of a single counter:
>   * do not aggregate counts across CPUs in system-wide mode
>   */
> -static int read_counter(struct evsel *counter, struct timespec *rs)
> +static int read_counter(struct evsel *counter, struct timespec *rs, int =
cpu)

please rename this to read_counter_cpu

thanks,
jirka

