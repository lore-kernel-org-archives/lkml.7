Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92674206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIxGV8rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbfKGJ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:28:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726734AbfKGJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573118906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctwOveRd9v71yu12b6kOzByY3+zMzI0QhnxCZ7UW6kA=;
        b=WIxGV8rWS2HZQt45CYh/2uiTejqvDdg5fpzg/tRbPxZ9VP/b6lt7c7OBai2jqHULunRewB
        lvlThjRqNWgtjp4R3Z+k4KMNOcMmAONzM9VE8DKjSMfrn1J8N1ZOEn3xPEusULFCL9TOHw
        MUZ0RfiuivhctOWeF953uShJMPQcSuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-hfvt9XtANqW0ohL57JAbUQ-1; Thu, 07 Nov 2019 04:28:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FCBC107ACC3;
        Thu,  7 Nov 2019 09:28:21 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 203F6600CE;
        Thu,  7 Nov 2019 09:28:18 +0000 (UTC)
Date:   Thu, 7 Nov 2019 10:28:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v7 0/7] perf report: Support sorting all blocks by cycles
Message-ID: <20191107092818.GB14657@krava>
References: <20191107074719.26139-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191107074719.26139-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hfvt9XtANqW0ohL57JAbUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 03:47:12PM +0800, Jin Yao wrote:
> It would be useful to support sorting for all blocks by the
> sampled cycles percent per block. This is useful to concentrate
> on the globally hottest blocks.
>=20
> This patch series implements a new option "--total-cycles" which
> sorts all blocks by 'Sampled Cycles%'. The 'Sampled Cycles%' is
> block sampled cycles aggregation / total sampled cycles
>=20
> For example,
>=20
> perf record -b ./div
> perf report --total-cycles --stdio
>=20
>  # To display the perf.data header info, please use --header/--header-onl=
y options.
>  #
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 2M of event 'cycles'
>  # Event count (approx.): 2753248
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles              =
                                [Program Block Range]         Shared Object
>  # ...............  ..............  ...........  ..........  ............=
.....................................................  ....................
>  #
>             26.04%            2.8M        0.40%          18              =
                               [div.c:42 -> div.c:39]                   div
>             15.17%            1.2M        0.16%           7              =
                   [random_r.c:357 -> random_r.c:380]          libc-2.27.so
>              5.11%          402.0K        0.04%           2              =
                               [div.c:27 -> div.c:28]                   div
>              4.87%          381.6K        0.04%           2              =
                       [random.c:288 -> random.c:291]          libc-2.27.so
>              4.53%          381.0K        0.04%           2              =
                               [div.c:40 -> div.c:40]                   div
>              3.85%          300.9K        0.02%           1              =
                               [div.c:22 -> div.c:25]                   div
>              3.08%          241.1K        0.02%           1              =
                             [rand.c:26 -> rand.c:27]          libc-2.27.so
>              3.06%          240.0K        0.02%           1              =
                       [random.c:291 -> random.c:291]          libc-2.27.so
>              2.78%          215.7K        0.02%           1              =
                       [random.c:298 -> random.c:298]          libc-2.27.so
>              2.52%          198.3K        0.02%           1              =
                       [random.c:293 -> random.c:293]          libc-2.27.so
>              2.36%          184.8K        0.02%           1              =
                             [rand.c:28 -> rand.c:28]          libc-2.27.so
>              2.33%          180.5K        0.02%           1              =
                       [random.c:295 -> random.c:295]          libc-2.27.so
>              2.28%          176.7K        0.02%           1              =
                       [random.c:295 -> random.c:295]          libc-2.27.so
>              2.20%          168.8K        0.02%           1              =
                           [rand@plt+0 -> rand@plt+0]                   div
>              1.98%          158.2K        0.02%           1              =
                   [random_r.c:388 -> random_r.c:388]          libc-2.27.so
>              1.57%          123.3K        0.02%           1              =
                               [div.c:42 -> div.c:44]                   div
>              1.44%          116.0K        0.42%          19              =
                   [random_r.c:357 -> random_r.c:394]          libc-2.27.so
>  ......
>=20
> This patch series supports both stdio and tui. And also with the supporti=
ng
> of --percent-limit.
>=20
>  v7:
>  ---
>  Use use_browser in report__browse_block_hists and support
>  reporting for both stdio and tui modes.
> =20
>  Move block tui browser code from ui/browsers/hists.c
>  to block-info.c.

thanks for bearing with me ;-)

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

