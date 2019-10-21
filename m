Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D08CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9FA205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8YV2Kds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfJUQIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:08:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22973 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729905AbfJUQIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571674099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0gyiV8kZl+ih7o/Bmi/12GeJIpHG3xO7HZjuWluFnE=;
        b=U8YV2KdsNjpBdsIf80iC/HLAi3xvdWakx9zIh6/TEyK490Ats3axlcJnnOyaqQxYzz5s5X
        26XIqjlW07B8ZIIL0tjtvE40vyuUDSm0I6qbsBSVCj71SQ+QfqMt6HwybMPsWp+4ZbKs2R
        vNJrD26P/G/PIVbd+I6xxuZdt9Mh22E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-znxQob-HNQaoTryP0UMXWQ-1; Mon, 21 Oct 2019 12:08:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DAF580183E;
        Mon, 21 Oct 2019 16:08:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 984995C207;
        Mon, 21 Oct 2019 16:08:12 +0000 (UTC)
Date:   Mon, 21 Oct 2019 18:08:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/5] perf util: Create new block.h/block.c for block
 related functions
Message-ID: <20191021160811.GI32718@krava>
References: <20191015053350.13909-1-yao.jin@linux.intel.com>
 <20191015053350.13909-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191015053350.13909-2-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: znxQob-HNQaoTryP0UMXWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:33:46PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 39814b1806a6..3121c0055950 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -1,4 +1,5 @@
>  perf-y +=3D annotate.o
> +perf-y +=3D block.o
>  perf-y +=3D block-range.o
>  perf-y +=3D build-id.o
>  perf-y +=3D cacheline.o
> diff --git a/tools/perf/util/block.c b/tools/perf/util/block.c
> new file mode 100644
> index 000000000000..e5e6f941f040
> --- /dev/null
> +++ b/tools/perf/util/block.c

please use block_info.c, block.c is misleading wrt what
we are doing here..

jirka

