Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C3D21E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+dfHsGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKKNa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:30:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23151 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbfKKNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573479025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rw8PLIg/foLU6kzuFUTYyEpMoeyK4DiIyn/Ev3WRh2g=;
        b=P+dfHsGCe4MKfSmYdcdoJbXl4P3MBcZ+Y/QC/TwSoz2O4x1US+yCJxD459xHAWMgyOjAU1
        xjJJGUxG3E2NCBJQc3O1mMXD09TMT219Y5eZh2VNHXDuWxVYec4XzaiqH8VPcvf3HGyRGo
        Ch4Lu2a6sAr4ciCia8e3CECk+jC7xDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-LmkZ2NoaNxyXl2S4CI_OUg-1; Mon, 11 Nov 2019 08:30:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB7D11005509;
        Mon, 11 Nov 2019 13:30:22 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id 942F718340;
        Mon, 11 Nov 2019 13:30:21 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:30:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 10/13] perf stat: Use affinity for opening events
Message-ID: <20191111133020.GA12923@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-11-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-11-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: LmkZ2NoaNxyXl2S4CI_OUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:16:43AM -0800, Andi Kleen wrote:

SNIP

> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1632,7 +1632,8 @@ void perf_evlist__force_leader(struct evlist *evlis=
t)
>  }
> =20
>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
> -=09=09=09=09=09=09 struct evsel *evsel)
> +=09=09=09=09=09=09 struct evsel *evsel,
> +=09=09=09=09=09=09bool close)
>  {
>  =09struct evsel *c2, *leader;
>  =09bool is_open =3D true;
> @@ -1649,10 +1650,11 @@ struct evsel *perf_evlist__reset_weak_group(struc=
t evlist *evsel_list,
>  =09=09if (c2 =3D=3D evsel)
>  =09=09=09is_open =3D false;
>  =09=09if (c2->leader =3D=3D leader) {
> -=09=09=09if (is_open)
> +=09=09=09if (is_open && close)
>  =09=09=09=09perf_evsel__close(&c2->core);
>  =09=09=09c2->leader =3D c2;
>  =09=09=09c2->core.nr_members =3D 0;
> +=09=09=09c2->reset_group =3D true;

so it's only set to true and stays.. please explain the logic
in comment.. together with errored=20

thanks,
jirka

