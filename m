Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F116C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66078216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J53F5HYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfK1Iay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:30:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40178 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727184AbfK1Iay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574929852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BQ4hpQ90QGGq3VrE+u2bbLsUhoKFUFO1IpIp5wFLBw=;
        b=J53F5HYdHynv4YSBwUOgQ2urMD0jcfYoZvmn1vaHcwPvk2esm7Ggg1GbiTmXKgWvhV4L7F
        dSAOZMJZvNzEE+WBpVFm7iotPEvILUCLXbG+2v11jOwN2v30GBJkSOMswe99KRv+SBXGMf
        3rWbzzFGP6BLqiqaLJ5wI8DeekNuVIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-6vffqHqvPxauz9ZsuRwetg-1; Thu, 28 Nov 2019 03:30:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C39CD107ACC4;
        Thu, 28 Nov 2019 08:30:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id C89E8600C8;
        Thu, 28 Nov 2019 08:30:45 +0000 (UTC)
Date:   Thu, 28 Nov 2019 09:30:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, davidca@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7] perf: Sharing PMU counters across compatible events
Message-ID: <20191128083045.GB1209@krava>
References: <20191115235504.4034879-1-songliubraving@fb.com>
MIME-Version: 1.0
In-Reply-To: <20191115235504.4034879-1-songliubraving@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6vffqHqvPxauz9ZsuRwetg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 03:55:04PM -0800, Song Liu wrote:

SNIP

>  =09=09add_event_to_ctx(event, ctx);
>  =09}
> @@ -2745,21 +2998,26 @@ static void __perf_event_enable(struct perf_event=
 *event,
>  {
>  =09struct perf_event *leader =3D event->group_leader;
>  =09struct perf_event_context *task_ctx;
> +=09int was_active;
> +=09int event_type;
> =20
>  =09if (event->state >=3D PERF_EVENT_STATE_INACTIVE ||
>  =09    event->state <=3D PERF_EVENT_STATE_ERROR)
>  =09=09return;
> =20
> +=09event_type =3D perf_event_can_share(event) ? EVENT_ALL : EVENT_TIME;
> +=09was_active =3D ctx->is_active;
>  =09if (ctx->is_active)
> -=09=09ctx_sched_out(ctx, cpuctx, EVENT_TIME);
> +=09=09ctx_sched_out(ctx, cpuctx, event_type);

you're scheduling everything out in here, so cpuctx->task_ctx
will become NULL and trigger the check below

I dont think you need to do it here, ctx_resched will do that
for you later, this here is just to keep the time updated

jirka

> =20
>  =09perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
> +=09perf_event_setup_dup(event, ctx);
> =20
> -=09if (!ctx->is_active)
> +=09if (!was_active)
>  =09=09return;
> =20
>  =09if (!event_filter_match(event)) {
> -=09=09ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
> +=09=09ctx_sched_in(ctx, cpuctx, event_type, current);
>  =09=09return;
>  =09}
> =20
> @@ -2767,8 +3025,8 @@ static void __perf_event_enable(struct perf_event *=
event,
>  =09 * If the event is in a group and isn't the group leader,
>  =09 * then don't put it on unless the group is on.
>  =09 */
> -=09if (leader !=3D event && leader->state !=3D PERF_EVENT_STATE_ACTIVE) =
{
> -=09=09ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
> +=09if (leader !=3D event && leader->state <=3D PERF_EVENT_STATE_INACTIVE=
) {
> +=09=09ctx_sched_in(ctx, cpuctx, event_type, current);
>  =09=09return;
>  =09}
> =20
> @@ -2776,7 +3034,8 @@ static void __perf_event_enable(struct perf_event *=
event,
>  =09if (ctx->task)
>  =09=09WARN_ON_ONCE(task_ctx !=3D ctx);
> =20
> -=09ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +=09/* if perf_event_can_share() resched EVENT_ALL */
> +=09ctx_resched(cpuctx, task_ctx, get_event_type(event) | event_type);
>  }

SNIP

