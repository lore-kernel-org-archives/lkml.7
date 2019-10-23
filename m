Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC42CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64962064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSl/bwcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbfJWJrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:47:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27283 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403961AbfJWJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571824053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jJ0Mx1TSKoNbNHDjSEIStJvRuQEnjO2FdmEZzltyLU=;
        b=XSl/bwcP9ppGNVeQP9Cn6UGrWQkKtxJrhgKYbEoUWdXww3GOw00uJqHLYLxYUqMn9TwiBv
        8+RsHzQXHk258RfpD03idDy+u38oWXw5vifLv0qHqpxmmYMjChRlOBdZ2hevH5wkJUug6T
        dahNWWpldm1WQ/xp0SqHTfn/sq2IXUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-dsbJ0kJ6OASfiJ4hDzfrFA-1; Wed, 23 Oct 2019 05:47:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82C40476;
        Wed, 23 Oct 2019 09:47:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id E362619C70;
        Wed, 23 Oct 2019 09:47:25 +0000 (UTC)
Date:   Wed, 23 Oct 2019 11:47:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 3/9] perf pmu: Use file system cache to optimize sysfs
 access
Message-ID: <20191023094724.GI22919@krava>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-4-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191020175202.32456-4-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dsbJ0kJ6OASfiJ4hDzfrFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 10:51:56AM -0700, Andi Kleen wrote:

SNIP

> @@ -92,8 +93,12 @@ static int pmu_format(const char *name, struct list_he=
ad *format)
>  =09snprintf(path, PATH_MAX,
>  =09=09 "%s" EVENT_SOURCE_DEVICE_PATH "%s/format", sysfs, name);
> =20
> -=09if (stat(path, &st) < 0)
> +=09if (lookup_fncache(path, &res) && !res)
> +=09=09return 0;
> +
> +=09if (!res && access(path, R_OK) < 0)
>  =09=09return 0;=09/* no error if format does not exist */
> +=09update_fncache(path, true);
> =20
>  =09if (perf_pmu__format_parse(path, format))
>  =09=09return -1;
> @@ -470,9 +475,9 @@ static int pmu_aliases_parse(char *dir, struct list_h=
ead *head)
>   */
>  static int pmu_aliases(const char *name, struct list_head *head)
>  {
> -=09struct stat st;
>  =09char path[PATH_MAX];
>  =09const char *sysfs =3D sysfs__mountpoint();
> +=09bool res =3D false;
> =20
>  =09if (!sysfs)
>  =09=09return -1;
> @@ -480,8 +485,11 @@ static int pmu_aliases(const char *name, struct list=
_head *head)
>  =09snprintf(path, PATH_MAX,
>  =09=09 "%s/bus/event_source/devices/%s/events", sysfs, name);
> =20
> -=09if (stat(path, &st) < 0)
> -=09=09return 0;=09 /* no error if 'events' does not exist */
> +=09if (lookup_fncache(path, &res) && !res)
> +=09=09return 0;
> +=09if (!res && access(path, R_OK) < 0)
> +=09=09return 0;
> +=09update_fncache(path, true);

I was thinking that maybe you dont need to have the fncache::res,
but then I realized we have 2 kind of information in here:
  - we processed this file
  - is present file present

so I think you should update the result on each update_fncache call,
not only when it's succesful


also, could you please make single function API for this?
sonething like:

  is_the_file_there(path)

that would encapsulate those calls

thanks,
jirka

