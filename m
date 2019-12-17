Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D449C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D2D21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PywzVWBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfLQPe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:34:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40552 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfLQPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:34:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so7778725qkg.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=WIcgHN30dR2crDNHrX3sAimvrkTmgj4IY/+nrOsfb9k=;
        b=PywzVWBsXibwF9hDhJCdPW2VL32SQKqTUSKd6D+9UIqoIV7pmnlbaOJ+qTm0m1E0uT
         zFgW0p2F9QnGu1M/DylWPZyV5hnHz7D+ap0nWhNkLi86F7Q3MwF5Kbll87NdUFwBqgWX
         wXv0O7g9neyrEpeGc6JNk9zpV1O7hOjyaDdTtePzsVisZH/y5QHKU890sIAYZJ9TXJsz
         Zr/T/HpH6iUXsgmwVIILdLkrupJGp6j8eHGk2ibc3KSXeDV67Lr2jTB05m6geLtaJcXr
         UuumkHs7gyxZeREiJ/AOjM8DSejbrBZvtPQRT3oVIWlugpNoxcFSHGMhQCfMKr4QF7mE
         GdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=WIcgHN30dR2crDNHrX3sAimvrkTmgj4IY/+nrOsfb9k=;
        b=F/6OWpK93zXoCr/7zJPY35Q/WTbyT081E5egfkyUx9nyujdaNcbFgNDGLlPBOD26Z7
         XGlfZqHrBxMmc69ne6ibnxXezMPxW5UQespprlDo2YQ84FWXIe/YpI4xuf7zu2NpolcC
         BdhKvVC6lDsEhORVLoU8ZbQANaCx5HxIbjaZsLAciIe91PQPvlCLCsEwkDBSvIj2fHb8
         Zvl3cdQ0/5qbC4lXs8W1BBHtIl/pkz8k3IMu5mCwc3iBHRTVzj+/cZP1o4DFPePCvNzv
         lL1HYw6/6pi8AHg1WKY5gwbznuc3JcT2A+Ptk1yhkqikqz32KdyxXDOQue/ZTNkjNCHh
         FKeA==
X-Gm-Message-State: APjAAAVHZWes8L5AED+qSr5KvSztClG3RrSJYWz9bq4fuC+iPKKC6kA9
        GbGIujHbA4MAhjxDuuqxej4pqQ==
X-Google-Smtp-Source: APXvYqwvEuSRz1JrJXykeUpICkmJqlku5cTmZZfJ3EItoZnLotOClF6h+hnfPLEg0+oc3Xm2j+KD4A==
X-Received: by 2002:ae9:e206:: with SMTP id c6mr5684828qkc.105.1576596896651;
        Tue, 17 Dec 2019 07:34:56 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a66sm7220772qkb.27.2019.12.17.07.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:34:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under CONFIG_MMU
Date:   Tue, 17 Dec 2019 10:34:55 -0500
Message-Id: <CE79F821-F17D-489D-81A9-CD87AEA9C0ED@lca.pw>
References: <20191217152814.GB136178@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217152814.GB136178@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2019, at 10:28 AM, Chris Down <chris@chrisdown.name> wrote:
>=20
> Maybe Qian is right and we should just ignore such patches, but I think th=
at comes with its own risks that we will alienate perfectly well intentioned=
 new contributors to mm without them having any idea why we did that.

Yes, that is a good point, but in reality is that there are many subsystems h=
ave already done the same. We even have some famous introduction document fo=
r kernel development put in the way that if =E2=80=9Cthe maintainers (or Lin=
us) ignored your patches after the resend, they probably don=E2=80=99t like i=
t.=E2=80=9D=
