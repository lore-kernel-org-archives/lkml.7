Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE66C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210BD20663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="R4VeKMX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfLQOQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:16:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36602 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfLQOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:16:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so7340700qkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ZkdzLix0g7TLx3w5KL71e42yAFa7G9Wu3yCJiO5zBhs=;
        b=R4VeKMX5z+UpczXH2iwhnXxVtV/oF7T7YQHHVdhLWz3zDT3WeJr7l93DvuR8yvVTv1
         b8K8T6PxnmokRbgIrYOjdgQoidBrClvkj/ONfMxQ5qwk5O8VdAzKcNBZJRcqHTxrR9fv
         6oZkLQMCNFUQ5RqfDFqqCiEYcPxcbVXU0GWa+V3TiQSvhU1WYhVdc+Wyyy3uWM0/S5EK
         hEiB9TnfsOs25eWmyhQX7mf8iQrlU2obMGSU/PBQ/Kdp7Cpq5otTFcelPh4cIsg5+vi1
         l7/uWYHT18DpZM2q2zh8DATf6vrIqr3vrPVB6SD6pC+LUQX8NwBm0Pev0kzsqmMQ18g+
         1smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ZkdzLix0g7TLx3w5KL71e42yAFa7G9Wu3yCJiO5zBhs=;
        b=gWEy2EjwfUwdzNLM1n233erSAp/e3JrByZbD/gWVh9CTrFJQZEb5Ek4Bw4sDJzfXqS
         +GcPuQCpUUvQ99xCDfkKrZE93YZg3x4mIV7k+cmJmu7/qWbWLMU0A1FlTFRTWof8j9jR
         sSKUndiUll+CiOZropcBlGMPRHPZPeLGsHHRApZADQq+0+BbXniMOVV0sIHqagsPHq8C
         9g1vowWnenAzD/WQ/msUfM4p4DQv6jXQjzMOUJ4a3BzAY7WDWi94wWHnbP6eyZUoWNKJ
         IJkOORKmJiUYnUiKoqwTSUj5Rk2oOwwREKIoUFlQ+2qd/ds3fc3/MFnYU7trgVLxQ+ta
         qtqQ==
X-Gm-Message-State: APjAAAVviZO99BgEkq9Qc7HrmWCz4fv0lbv8M23odL3tDdvj9YssW0cQ
        VAUgesfdi5zpTo206I5GCpsVzw==
X-Google-Smtp-Source: APXvYqyIaW9SH9dIo0nTwluwbMjOkaOIBAywH/CZvwYvSZJusUJQDeyKQIEbOh3B2HI/AZvYCG2apQ==
X-Received: by 2002:a37:a807:: with SMTP id r7mr5369874qke.346.1576592197757;
        Tue, 17 Dec 2019 06:16:37 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v2sm7089372qkj.29.2019.12.17.06.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 06:16:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under CONFIG_MMU
Date:   Tue, 17 Dec 2019 09:16:36 -0500
Message-Id: <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
References: <20191217135440.GB58496@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217135440.GB58496@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2019, at 8:54 AM, Chris Down <chris@chrisdown.name> wrote:
>=20
> Let's just add __maybe_unused, since it seems like what we want in this sc=
enario -- it avoids new users having to enter preprocessor madness, while al=
so not polluting the build output.

__maybe_unused should only be used in the last resort as it mark the compile=
r to catch the real issues in the future. In this case, it might be better j=
ust ignore it as only non-realistic compiling test would use !CONFIG_MMU in t=
his case.=
