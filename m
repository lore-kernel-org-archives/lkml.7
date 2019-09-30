Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F138FC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8DF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rQYI2urg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbfI3XtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:49:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37701 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfI3XtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 19:49:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id l3so19348608qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=FCAEYzwQHp/oK53c+OOeDcXUXegqNanjk+gs1PbOM0c=;
        b=rQYI2urgnS9QZIhepXn30zrdLl8ujftYDHTVOSnahx36b7E86fxoUgjxMH8D1uWwNq
         95mOz9imHaOzBymQFaPMIHTm0R+9pm3PqkytCXft0B9zx53T6JEkTpSbgMySdJnj0yuQ
         pWygoreFNumE8Ylq76eRimWgIIbm/m5pmXcgE0Rtk+kdCE+VGo+W9MWYUxnCEIRuvkpB
         OAylwMKTk9T+cynvsZUfLCmC5V/QXg/pm1x8h1CI11GIl+5QVup/XVUPYnq5UQKR2DDk
         SE2YbZ+6nlHm+yBMCtoN8aY8VNFGkUav8HsBjxhStdLqg1Gu/pPSMTyqjdUDBXr3wanv
         +qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FCAEYzwQHp/oK53c+OOeDcXUXegqNanjk+gs1PbOM0c=;
        b=TwtT+SvStsBiCcY1n7hr2sEOEMIAnC/Ay1XxHICqt8uVYLmTMpkdieV8Z0U96AFJmw
         UnwdVwZLfBUP47c4K1Ies0PryUHeWlmpUUag7mHDbOtoHdV6wMtFw+4p6PIa+Fd2eSsh
         kpWLf2wgZPkDUDaLvADjl285DJPHSwurV/wL1aUpPOKjG390a86L1Cq0DE3/++m7+TIb
         ZadZwzJ3QDj/hWtZvDgZsLYhyOimW6GIbixuIRO3Eo1bL4esAA6fX7Lz39suuL+7z1S2
         CZMpih+VxIiG0uhKSgPpefVil9Pc6cyowRGvhrQCuUSe8ePsPN0GrICSb1GLIBAS51te
         vKuQ==
X-Gm-Message-State: APjAAAUOUVXVBlh2n8T1ko2sGZYdTwzjkyRMdvHYydjvVtuZx0I22564
        A9NJMUV3zDnXZvhnRV1rRJDxVQ==
X-Google-Smtp-Source: APXvYqxoJjy4y4RTrdyui1wzZOryEZJsAQIbS3Csd1QSHfDRJJXV7WRxh/RrV57jgJjBo5KQAHF4jw==
X-Received: by 2002:ac8:74c4:: with SMTP id j4mr12159055qtr.360.1569887360676;
        Mon, 30 Sep 2019 16:49:20 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j17sm10884571qta.0.2019.09.30.16.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 16:49:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/3] mm, page_owner: decouple freeing stack trace from debug_pagealloc
Date:   Mon, 30 Sep 2019 19:49:18 -0400
Message-Id: <731C4866-DF28-4C96-8EEE-5F22359501FE@lca.pw>
References: <eccee04f-a56e-6f6f-01c6-e94d94bba4c5@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
In-Reply-To: <eccee04f-a56e-6f6f-01c6-e94d94bba4c5@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 30, 2019, at 5:43 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> Well, my use case is shipping production kernels with CONFIG_PAGE_OWNER
> and CONFIG_DEBUG_PAGEALLOC enabled, and instructing users to boot-time
> enable only for troubleshooting a crash or memory leak, without a need
> to install a debug kernel. Things like static keys and page_ext
> allocations makes this possible without CPU and memory overhead when not
> boot-time enabled. I don't know too much about KASAN internals, but I
> assume it's not possible to use it that way on production kernels yet?

In that case, why can=E2=80=99t users just simply enable page_owner=3Don and=
 debug_pagealloc=3Don for troubleshooting? The later makes the kernel slower=
, but I am not sure if it is worth optimization by adding a new parameter. T=
here have already been quite a few MM-related kernel parameters that could t=
idy up a bit in the future.=
