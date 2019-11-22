Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E842C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BCC2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyTag3rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKVTdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:33:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23128 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbfKVTdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574451233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKcl9yS0cJKCotCijHKAQf+0jmhdSMlOqNVO8Y8+/lY=;
        b=QyTag3rYreG71+gqwwq+GUHzqgoA2rHxpsw2xjlr0bTmuEPKI1nG10hxED3FSdE0Axdtv5
        FnUP5l2jhwjHfT6aFkS14h5qQYF1czn2fvm0ViSHwUC5RkgCsCFzpRKCJ9tSkB2qjEAXTC
        Xx6/56ya+ZHIgCttwA7jgIK98OnyK10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-mTi7oQhHPG2hcSE2I_a2Ug-1; Fri, 22 Nov 2019 14:33:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 251AB8018A2;
        Fri, 22 Nov 2019 19:33:47 +0000 (UTC)
Received: from krava (ovpn-204-245.brq.redhat.com [10.40.204.245])
        by smtp.corp.redhat.com (Postfix) with SMTP id E5B215F773;
        Fri, 22 Nov 2019 19:33:44 +0000 (UTC)
Date:   Fri, 22 Nov 2019 20:33:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, davidca@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7] perf: Sharing PMU counters across compatible events
Message-ID: <20191122193343.GB2157@krava>
References: <20191115235504.4034879-1-songliubraving@fb.com>
MIME-Version: 1.0
In-Reply-To: <20191115235504.4034879-1-songliubraving@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mTi7oQhHPG2hcSE2I_a2Ug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 03:55:04PM -0800, Song Liu wrote:
> This patch tries to enable PMU sharing. When multiple perf_events are
> counting the same metric, they can share the hardware PMU counter. We
> call these events as "compatible events".
>=20
> The PMU sharing are limited to events within the same perf_event_context
> (ctx). When a event is installed or enabled, search the ctx for compatibl=
e
> events. This is implemented in perf_event_setup_dup(). One of these
> compatible events are picked as the master (stored in event->dup_master).
> Similarly, when the event is removed or disabled, perf_event_remove_dup()
> is used to clean up sharing.
>=20
> A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
> This state is used when the slave event is ACTIVE, but the master event
> is not.
>=20
> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
>=20
> ---
> Changes in v7:
> Major rewrite to avoid allocating extra master event.

hi,
what is this based on? I can't apply it on tip/master:

=09Applying: perf: Sharing PMU counters across compatible events
=09error: patch failed: include/linux/perf_event.h:722
=09error: include/linux/perf_event.h: patch does not apply
=09Patch failed at 0001 perf: Sharing PMU counters across compatible events
=09hint: Use 'git am --show-current-patch' to see the failed patch
=09When you have resolved this problem, run "git am --continue".
=09If you prefer to skip this patch, run "git am --skip" instead.
=09To restore the original branch and stop patching, run "git am --abort".

also I'm getting this when trying to see/apply plain text patch:

=09[jolsa@dell-r440-01 linux-perf]$ git am --show-current-patch | tail
=09 =3D09=3D09for_each_sibling_event(sibling, group_leader) {
=09 =3D09=3D09=3D09perf_remove_from_context(sibling, 0);
=09 =3D09=3D09=3D09put_ctx(gctx);
=09+=3D09=3D09=3D09WARN_ON_ONCE(sibling->dup_master);
=09 =3D09=3D09}
=09=3D20
=09 =3D09=3D09/*
=09--=3D20
=092.17.1


jirka

