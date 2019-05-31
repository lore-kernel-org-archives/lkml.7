Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96376C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C712675B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEaKG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:06:59 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:50287 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaKG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:06:57 -0400
Received: from [2a01:e35:39f2:1220:9dd7:c176:119b:4c9d] (helo=opteyam2)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1hWeR2-000GJh-Nm; Fri, 31 May 2019 12:06:52 +0200
Message-ID: <2fd5d462449f24b04adad2bbdf0e272647e62247.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Date:   Fri, 31 May 2019 12:06:52 +0200
In-Reply-To: <20190531064313.193437-7-minchan@kernel.org>
References: <20190531064313.193437-1-minchan@kernel.org>
         <20190531064313.193437-7-minchan@kernel.org>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:9dd7:c176:119b:4c9d
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [RFCv2 6/6] mm: extend process_madvise syscall to support
 vector arrary
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le vendredi 31 mai 2019 à 15:43 +0900, Minchan Kim a écrit :
> 
> diff --git a/include/uapi/asm-generic/mman-common.h
> b/include/uapi/asm-generic/mman-common.h
> index 92e347a89ddc..220c2b5eb961 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -75,4 +75,15 @@
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>  				 PKEY_DISABLE_WRITE)
>  
> +struct pr_madvise_param {
> +	int size;		/* the size of this structure */
> +	int cookie;		/* reserved to support atomicity */
> +	int nr_elem;		/* count of below arrary fields */

Those should be unsigned.

There's an implicit hole here on ABI with 64bits aligned pointers

> +	int __user *hints;	/* hints for each range */
> +	/* to store result of each operation */
> +	const struct iovec __user *results;
> +	/* input address ranges */
> +	const struct iovec __user *ranges;

Using pointer type in uAPI structure require a 'compat' version of the
syscall need to be provided.

If using iovec too.

> +};
> +
>  #endif /* __ASM_GENERIC_MMAN_COMMON_H */

Regards.

-- 
Yann Droneaud
OPTEYA


