Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6AFC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7622020869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WbPReoDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfKFKhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:37:38 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:41815 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:37:38 -0500
Received: by mail-qk1-f178.google.com with SMTP id m125so24070635qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 02:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VtISKGrMtS0e/tHpQZgyHays11ru1iukGnwTiSIyUn4=;
        b=WbPReoDIcrxa3hH+P7qgQ0yILyFe+tpdLK26WLVriJP0fSkDhkveAZNT1byamSefAV
         VzxbSOsqF4ggKt2+OPmmOS6AdsHDDTsz0cGFHsmf0XnWCyYwj2h+pgdLhyfmWxe/Jt5D
         5H74WRvhkunEVJhuKvs4WeTiBnM5nGLrJTEllGWU4FOJuUshq8fJH3M1/898NN7u/jnK
         oNO2BNDNdR8NXmUqNuyyQE3FWBa5OCsbLur/iWU+kYhnIG/490fMtgg2P+dPOBhW9e6i
         XTnbqLdKxWigayV+g1pH9FEng5KLZEjMm3qs+N+eQabOJ65uYHb3ODeEkp7xMQS/JsDB
         4mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VtISKGrMtS0e/tHpQZgyHays11ru1iukGnwTiSIyUn4=;
        b=npmltCQ4hh8wmxZz+obWBkEDyUFEMSb6VJy8Dzvuzx/L2E9XW0UjVu8ApBd1VrRSO5
         V93K60lsGjLTARCQhEfGfGScbo37sL/vxKDFVFHi8xjS0DUdlJ4fbezTGvzbQxKJCP3f
         A+1M+ksiSKI7TELrevkUA8lDoZmMyGguaxUvHBhpypt93oNNd6GFSEYmVT8pMtM8L6+D
         hIX/Tr5NjB/ska+nI1o6X5f1tqphIfLTksorq78IKWE209xqTpEkgGlLLjT/vRF6+HJv
         WDUySmSPEWyLbi8k5jG+GxouFHtWr6DSseLp5eJ6kqnVgAhKExBocf+ifxoN8Qs2a/ny
         rN8g==
X-Gm-Message-State: APjAAAV2N/RaQDDIx5jBcqhbZGJ1clrkPtn9//y8A4PhDmweyk4Iw+2X
        qaHcId4mWGqBWN+YZJAglubWvNX/5q5ouQ==
X-Google-Smtp-Source: APXvYqxp1bwY6PptXeh5DlQjaKjg973D/BAqPRh3Dp1AXm9CE2Gfnk1Oq9ZavUdsLg+vXGO8V5WxXw==
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr1324176qkg.17.1573036656546;
        Wed, 06 Nov 2019 02:37:36 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y145sm3212494qkb.101.2019.11.06.02.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:37:35 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] perf/core: fix unlock balance in perf_init_event
Date:   Wed, 6 Nov 2019 05:37:34 -0500
Message-Id: <BFC92F0C-22D3-4543-9FAE-D53C7383CB3F@lca.pw>
References: <20191106092352.GU4131@hirez.programming.kicks-ass.net>
Cc:     mingo@redhat.com, andi@firstfloor.org, acme@kernel.org,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191106092352.GU4131@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 6, 2019, at 4:23 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> You wanted to write:
>=20
> Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
>=20
> instead, right? Fixed that for you.

I was not too sure about if the hashes are stable for commits only in the -t=
ip tree. If they remain the same even after merged into the mainline, and th=
en yes.=
