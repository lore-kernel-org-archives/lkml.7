Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE73CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BC52064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCdN4hXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404269AbfJWJ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:59:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22616 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390982AbfJWJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571824756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H97WqW0j/xwCI0yXKzrYyNUvs3kYqavnSJQt/g2Ejhk=;
        b=MCdN4hXfBjdu/qOzV2xYoDbfT7S1bjKm6dOg9hOFFoVH7fZoviD/PFjl9y9XeuTiYWaFuv
        JQN5wPONuEg2PsmJ3IDOkbr+VEIQqL9MM2PzpR6rQBWk6g3vx6zrFHOGCScWDOaEJHLRII
        7SX0UA60uargRzBtW69ieNs9S5hMkqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-NVp_limcMRycUX3lsogTWA-1; Wed, 23 Oct 2019 05:59:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D644C476;
        Wed, 23 Oct 2019 09:59:13 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 33879589B;
        Wed, 23 Oct 2019 09:59:11 +0000 (UTC)
Date:   Wed, 23 Oct 2019 11:59:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 4/9] perf affinity: Add infrastructure to save/restore
 affinity
Message-ID: <20191023095911.GJ22919@krava>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-5-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191020175202.32456-5-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NVp_limcMRycUX3lsogTWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 10:51:57AM -0700, Andi Kleen wrote:

SNIP

> +}
> diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
> new file mode 100644
> index 000000000000..e56148607e33
> --- /dev/null
> +++ b/tools/perf/util/affinity.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef AFFINITY_H
> +#define AFFINITY_H 1
> +
> +struct affinity {
> +=09unsigned char *orig_cpus;
> +=09unsigned char *sched_cpus;

why not use cpu_set_t directly?

jirka

