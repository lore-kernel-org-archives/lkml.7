Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C7DC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D46220866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rQti2BTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgABEGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:06:17 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40970 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABEGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:06:16 -0500
Received: by mail-qv1-f67.google.com with SMTP id x1so14598562qvr.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=BSLpNtfQPeKHkyztJzyuvOsGtwsfKOKwHbhS0888HJk=;
        b=rQti2BTWhtJDh1/A7TK1bnxdbKtLaM2WTl93Wdm1Euwe6SMkIIQWKBDiT0mzEV9t1C
         oNgLdJ1XVkl8nBTWfLIKaVtrGFM8ctByU15LMYjz9lJ/+wE9bEXVBCLE3yuLSMf98WU+
         HjdFOUmrnNn0p4eCqAqBOPTrzjhyS4S+LcQTF6scSOW3a2P00OoOwgZhbB/P8k7w891F
         d980lBPqPLX9Yyj9L2wiLR4lVA4dPlI3AekDVXaVqffNtFMH38hdzQ4u5fNOImmKHYFc
         /LJUZ9Ard0GPnE0wgFLJLu2FeNrkunP27GgGaF6t4XkPAWgsP/1+idSeC2XOOW/WL0DU
         imAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=BSLpNtfQPeKHkyztJzyuvOsGtwsfKOKwHbhS0888HJk=;
        b=pduXtIxjgdWEpoVu68xoGr1BTiGJzPAiBa2t+w4vEVLeIa3hbp2OqUA6WWLsW3gFL+
         IuNd+FEvYlUHeF9WjaQa7kDxGJsAPNv7d8rxL93pQVii4CxucSo8fUljsEM2+lKCPRG1
         UF37D2IQ8k2G4XfjCgko4raO5XN8s4o5I20wfH4oibstr0Ln6zbQjg4amzfY8JEv7wWk
         vsmfrlZqBo1aNIKBMAcMey+5dGlAEVWErAYpIaykMmzZjB7Y2xoqdRMDwneseAXQCp1E
         likXiy/Uojwb4q+WDJGkF5wn7f566TEh/iOLwOZvzvPMPBmlhbvQyWdP3f6UKc46f2zr
         F3+w==
X-Gm-Message-State: APjAAAXDJNgnHAACGd4vqfwFA9YWpMCAIdtbfmRWNjh3fFtsNSev/dbC
        728SCsdz7CG+Q7Qo59iNwZ2EQc4daUQ=
X-Google-Smtp-Source: APXvYqx81rYTyqHJoH4eD2X2uQS6AAhqcWEyvRqp9i0mR+HDKv9IHYoJdoqjr3pWcBvecUuVqy7xcg==
X-Received: by 2002:a05:6214:c3:: with SMTP id f3mr60871816qvs.226.1577937975775;
        Wed, 01 Jan 2020 20:06:15 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o10sm16273095qtp.38.2020.01.01.20.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 20:06:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page-writeback.c: avoid potential division by zero
Date:   Wed, 1 Jan 2020 23:06:14 -0500
Message-Id: <D7A1EC0B-6A3C-4149-A249-2E2C99517183@lca.pw>
References: <62482b58-81e1-0295-1e28-e11261404831@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
In-Reply-To: <62482b58-81e1-0295-1e28-e11261404831@linux.alibaba.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 1, 2020, at 10:57 PM, Wen Yang <wenyang@linux.alibaba.com> wrote:
>=20
> This issue was introduced by commit 693108a8a667 (=E2=80=9Cwriteback: make=
 bdi->min/max_ratio handling cgroup writeback aware=E2=80=9D).

Okay, this needs a Fixes tag then, and Cc the relevant people, i.e., Tejun a=
nd Jens at least.

>=20
> Finally, we will summarize the above cases and plan to write a general coc=
cinelle rule to check for similar problems.
