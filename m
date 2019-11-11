Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C05A222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKcH+yJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfKKNai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:30:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727187AbfKKNag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573479035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4BMidOVZKEVpsHN/f9l10/p1xHO+IaREHg0739sCgY=;
        b=dKcH+yJsbeKcoNH1S5rSjCLz2kfEsiepa30AW+UEwQVn1Y52AbaCFMjcG35iqqyKKXnq5e
        Mr0EFsnBDHvtE+oJ5B88CMle14DajZ0GGuvqVEc3fkT/LA2uLkXooDue/CG8QLX2E1rLpB
        a5xJwf8hRZXujE9sjukTGbgcIzb+rn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-2FwtZx-4OjK73mhAVfgmdA-1; Mon, 11 Nov 2019 08:30:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C425801E50;
        Mon, 11 Nov 2019 13:30:29 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B60D61075;
        Mon, 11 Nov 2019 13:30:27 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:30:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 10/13] perf stat: Use affinity for opening events
Message-ID: <20191111133027.GB12923@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-11-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-11-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2FwtZx-4OjK73mhAVfgmdA-1
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

> +=09=09=09=09 * Don't close here because we're in the wrong affinity.
> +=09=09=09=09 */
> +=09=09=09=09if ((errno =3D=3D EINVAL || errno =3D=3D EBADF) &&
> +=09=09=09=09    counter->leader !=3D counter &&
> +=09=09=09=09    counter->weak_group) {
> +=09=09=09=09=09perf_evlist__reset_weak_group(evsel_list, counter, false)=
;
> +=09=09=09=09=09assert(counter->reset_group);
> +=09=09=09=09=09second_pass =3D true;
> +=09=09=09=09=09continue;
> +=09=09=09=09}
> +
> +=09=09=09=09switch (stat_handle_error(counter)) {
> +=09=09=09=09case COUNTER_FATAL:
> +=09=09=09=09=09return -1;
> +=09=09=09=09case COUNTER_RETRY:
> +=09=09=09=09=09goto try_again;
> +=09=09=09=09case COUNTER_SKIP:
> +=09=09=09=09=09continue;
> +=09=09=09=09default:
> +=09=09=09=09=09break;
> +=09=09=09=09}
> +
>  =09=09=09}
> +=09=09=09counter->supported =3D true;
> +=09=09}
> +=09}
> =20
> -=09=09=09switch (stat_handle_error(counter)) {
> -=09=09=09case COUNTER_FATAL:
> -=09=09=09=09return -1;
> -=09=09=09case COUNTER_RETRY:
> -=09=09=09=09goto try_again;
> -=09=09=09case COUNTER_SKIP:
> -=09=09=09=09continue;
> -=09=09=09default:
> -=09=09=09=09break;
> +=09if (second_pass) {
> +=09=09/*
> +=09=09 * Now redo all the weak group after closing them,
> +=09=09 * and also close errored counters.
> +=09=09 */
> +
> +=09=09evlist__cpu_iter_start(evsel_list);
> +=09=09evlist__for_each_cpu (evsel_list, i, cpu) {

no need for evlist__cpu_iter_start call in here?

jirka

> +=09=09=09affinity__set(&affinity, cpu);
> +=09=09=09/* First close errored or weak retry */
> +=09=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09=09if (!counter->reset_group && !counter->errored)
> +=09=09=09=09=09continue;
> +=09=09=09=09if (evsel__cpu_iter_skip_no_inc(counter, cpu))
> +=09=09=09=09=09continue;
> +=09=09=09=09perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
>  =09=09=09}
> +=09=09=09/* Now reopen weak */
> +=09=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09=09if (!counter->reset_group && !counter->errored)

SNIP

