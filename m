Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E51FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4432073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EREwrdwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfKOOzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:55:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727786AbfKOOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573829746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vyWkFPpuPA83lu+9TJYuXo3BcNIHjBOZjcUx9JW1TRk=;
        b=EREwrdwlgLxLVW7GxRgYfUs48h6hSO0Gl3saYtbxa2UMuz4CNP1jw4DpAbzoBNHcK1jgex
        Fa7fD83fDOEHzK+kAHTNbFBav/x4KeLpPSm0DfDxe5PBoqh/izcaDAVdgdKe+qTEP2CXt1
        J3jbZo4QQz98KGcR3C+wG/AWnHXGR3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-1Pdznkz1MuWdgeIogsr6bQ-1; Fri, 15 Nov 2019 09:55:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E36EE64A92;
        Fri, 15 Nov 2019 14:55:43 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id C4B516918E;
        Fri, 15 Nov 2019 14:55:42 +0000 (UTC)
Date:   Fri, 15 Nov 2019 15:55:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 10/12] perf stat: Use affinity for reading
Message-ID: <20191115145542.GD4255@krava>
References: <20191112005941.649137-1-andi@firstfloor.org>
 <20191112005941.649137-11-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191112005941.649137-11-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1Pdznkz1MuWdgeIogsr6bQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:59:39PM -0800, Andi Kleen wrote:

SNIP

> =20
>  =09return 0;
> @@ -325,15 +318,35 @@ static int read_counter(struct evsel *counter, stru=
ct timespec *rs)
>  static void read_counters(struct timespec *rs)
>  {
>  =09struct evsel *counter;
> -=09int ret;
> +=09struct affinity affinity;
> +=09int i, ncpus, cpu;
> +
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return;
> +
> +=09ncpus =3D evsel_list->core.all_cpus->nr;
> +=09if (!(target__has_cpu(&target) && !target__has_per_thread(&target)))
> +=09=09ncpus =3D 1;

hum, could we propagate the negation inside amke this more readable?

  if (!target__has_cpu(&target) || target__has_per_thread(&target))

jirka

> +=09evlist__for_each_cpu (evsel_list, i, cpu) {
> +=09=09if (i >=3D ncpus)
> +=09=09=09break;
> +=09=09affinity__set(&affinity, cpu);
> +
> +=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09if (evsel__cpu_iter_skip(counter, cpu))
> +=09=09=09=09continue;
> +=09=09=09if (!counter->err)
> +=09=09=09=09counter->err =3D read_counter(counter, rs, counter->cpu_iter=
 - 1);
> +=09=09}
> +=09}
> +=09affinity__cleanup(&affinity);

SNIP

