Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3D0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCA520718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARM5VetO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfKVNUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:20:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726548AbfKVNUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574428842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcpMO7N5Av7TXp8MXIEndacd5hJ7I/V4hiUn3Vf4UDs=;
        b=ARM5VetOd1nxc6Pf/whHhMs5KQ0vJM8pVXX7kv9LBbbZBHbCIMxz1CJ3YLK1TdWVe8dsIX
        Qces3D76rE3A2kPxmbUZJj653Dq/pz/3nKpyAooBU7Im5JHhLqhf/HCg7oxR2YtsEYRFkR
        l3xE0vjeZlwlPwz2DxcF8lJ21XM/ZZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-9I8s34nrO3iYDcaehz-16A-1; Fri, 22 Nov 2019 08:20:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD97D800054;
        Fri, 22 Nov 2019 13:20:39 +0000 (UTC)
Received: from krava (unknown [10.40.205.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8491028DFD;
        Fri, 22 Nov 2019 13:20:37 +0000 (UTC)
Date:   Fri, 22 Nov 2019 14:20:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] perf mmap: declare type for cpu mask of arbitrary
 length
Message-ID: <20191122131513.GE17308@krava>
References: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
 <0c716b33-a91e-2972-637f-e7c3a187fa77@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <0c716b33-a91e-2972-637f-e7c3a187fa77@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9I8s34nrO3iYDcaehz-16A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:37:48PM +0300, Alexey Budankov wrote:
>=20
> Declare a dedicated struct map_cpu_mask type for cpu masks of=20
> arbitrary length. Mask is available thru bits pointer and the=20
> mask length is kept in nbits field. mmap_cpu_mask_bytes() macro=20
> returns mask storage size in bytes.
>=20
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/mmap.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index bee4e83f7109..a218a0eb1466 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -15,6 +15,15 @@
>  #include "event.h"
> =20
>  struct aiocb;
> +
> +struct mmap_cpu_mask {
> +=09unsigned long *bits;
> +=09size_t nbits;
> +};
> +
> +#define mmap_cpu_mask_bytes(m) \

we try to have all macros upper case

> +=09(BITS_TO_LONGS(((struct mmap_cpu_mask *)m)->nbits) * sizeof(unsigned =
long))

we have BITS_TO_BYTES

thanks,
jirka

> +
>  /**
>   * struct mmap - perf's ring buffer mmap details
>   *
> --=20
> 2.20.1
>=20

