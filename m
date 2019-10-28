Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF31CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD9B205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DslLDOPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfJ1WBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:01:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726131AbfJ1WBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572300104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qSZVZ45yE1UDzYVH1u6vBUQnZQXBxbWtbkrQaBakGE=;
        b=DslLDOPz59uiP9gla5ap7bH1pxf/f+aYS+tAEDe/i/AtLOJpEBvw8b17J9MIydm8wU6gyi
        eMYGEMomuPZEuEiyZcaFjQjn1/xzAHf7iRfTWvxZBx7M+OKgiDY08fdyvrf4r6TZIY85o4
        nuopwOwc91MuzruobsnRGT1GJR7U1QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-z6TEDJpjOHqba2ScFGjJyQ-1; Mon, 28 Oct 2019 18:01:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85A545E4;
        Mon, 28 Oct 2019 22:01:39 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 194235D6C3;
        Mon, 28 Oct 2019 22:01:37 +0000 (UTC)
Date:   Mon, 28 Oct 2019 23:01:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 1/7] perf pmu: Use file system cache to optimize sysfs
 access
Message-ID: <20191028220137.GF28772@krava>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-2-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191025181417.10670-2-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: z6TEDJpjOHqba2ScFGjJyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:14:11AM -0700, Andi Kleen wrote:

SNIP

>  =09if (pmu_aliases_parse(path, head))
>  =09=09return -1;
> @@ -525,7 +524,6 @@ static int pmu_alias_terms(struct perf_pmu_alias *ali=
as,
>   */
>  static int pmu_type(const char *name, __u32 *type)
>  {
> -=09struct stat st;
>  =09char path[PATH_MAX];
>  =09FILE *file;
>  =09int ret =3D 0;
> @@ -537,7 +535,7 @@ static int pmu_type(const char *name, __u32 *type)
>  =09snprintf(path, PATH_MAX,
>  =09=09 "%s" EVENT_SOURCE_DEVICE_PATH "%s/type", sysfs, name);
> =20
> -=09if (stat(path, &st) < 0)
> +=09if (access(path, R_OK) < 0)

why not file_available call in here?

jirka

>  =09=09return -1;
> =20
>  =09file =3D fopen(path, "r");
> @@ -628,14 +626,11 @@ static struct perf_cpu_map *pmu_cpumask(const char =
*name)
>  static bool pmu_is_uncore(const char *name)
>  {
>  =09char path[PATH_MAX];
> -=09struct perf_cpu_map *cpus;
> -=09const char *sysfs =3D sysfs__mountpoint();
> +=09const char *sysfs;
> =20
> +=09sysfs =3D sysfs__mountpoint();
>  =09snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);

SNIP

