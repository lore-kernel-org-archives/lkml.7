Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48681C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AECE217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew3RcOHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbfKFQeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:34:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42753 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727570AbfKFQeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573058043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+afJlc0mKg6PooMjy5Yb8uCcfB0SdJUAp19Nwsf16I=;
        b=ew3RcOHfVCO0NK03Q0i375U5KqBnT6UxL/0QA1YahmzS5IbxNcnoShNbgv4JOIxKMePfVb
        74udsLvpsct+hBQCrYyQFENjKa3z00UQcFZwg4UQNy1mJb6jo7Gx0QVAOvkFcdQ4EDPMwE
        H45KewP6WcNd+v8J3FDZq5Z66v/448g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-wnzQzyZcMZCYYJg4rjGw1A-1; Wed, 06 Nov 2019 11:34:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AC681800D53;
        Wed,  6 Nov 2019 16:33:59 +0000 (UTC)
Received: from krava (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id 40F2060BF4;
        Wed,  6 Nov 2019 16:33:57 +0000 (UTC)
Date:   Wed, 6 Nov 2019 17:33:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 6/9] perf stat: Factor out open error handling
Message-ID: <20191106163357.GM30214@krava>
References: <20191105002522.83803-1-andi@firstfloor.org>
 <20191105002522.83803-7-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191105002522.83803-7-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wnzQzyZcMZCYYJg4rjGw1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:25:19PM -0800, Andi Kleen wrote:

SNIP

>  =09=09=09=09goto try_again;
>  =09=09=09}
> =20
> -=09=09=09/*
> -=09=09=09 * PPC returns ENXIO for HW counters until 2.6.37
> -=09=09=09 * (behavior changed with commit b0a873e).
> -=09=09=09 */
> -=09=09=09if (errno =3D=3D EINVAL || errno =3D=3D ENOSYS ||
> -=09=09=09    errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP ||
> -=09=09=09    errno =3D=3D ENXIO) {
> -=09=09=09=09if (verbose > 0)
> -=09=09=09=09=09ui__warning("%s event is not supported by the kernel.\n",
> -=09=09=09=09=09=09    perf_evsel__name(counter));
> -=09=09=09=09counter->supported =3D false;
> -
> -=09=09=09=09if ((counter->leader !=3D counter) ||
> -=09=09=09=09    !(counter->leader->core.nr_members > 1))
> -=09=09=09=09=09continue;
> -=09=09=09} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg=
))) {
> -                                if (verbose > 0)
> -                                        ui__warning("%s\n", msg);
> -                                goto try_again;
> -=09=09=09} else if (target__has_per_thread(&target) &&
> -=09=09=09=09   evsel_list->core.threads &&
> -=09=09=09=09   evsel_list->core.threads->err_thread !=3D -1) {
> -=09=09=09=09/*
> -=09=09=09=09 * For global --per-thread case, skip current
> -=09=09=09=09 * error thread.
> -=09=09=09=09 */
> -=09=09=09=09if (!thread_map__remove(evsel_list->core.threads,
> -=09=09=09=09=09=09=09evsel_list->core.threads->err_thread)) {
> -=09=09=09=09=09evsel_list->core.threads->err_thread =3D -1;
> -=09=09=09=09=09goto try_again;
> -=09=09=09=09}
> +=09=09=09switch (stat_handle_error(counter)) {
> +=09=09=09case COUNTER_FATAL:
> +=09=09=09=09return -1;
> +=09=09=09case COUNTER_RETRY:
> +=09=09=09=09goto try_again;
> +=09=09=09case COUNTER_SKIP:
> +=09=09=09=09continue;
> +=09=09=09default:
> +=09=09=09=09break;
>  =09=09=09}

great, looks good, thanks

jirka

> -
> -=09=09=09perf_evsel__open_strerror(counter, &target,
> -=09=09=09=09=09=09  errno, msg, sizeof(msg));
> -=09=09=09ui__error("%s\n", msg);
> -
> -=09=09=09if (child_pid !=3D -1)
> -=09=09=09=09kill(child_pid, SIGTERM);
> -
> -=09=09=09return -1;
>  =09=09}
>  =09=09counter->supported =3D true;
> =20
> --=20
> 2.23.0
>=20

