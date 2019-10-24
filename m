Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F678CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 04:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07AA20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 04:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JTeq6/j9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406720AbfJXEeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 00:34:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43917 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJXEeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 00:34:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id t20so35884689qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=K52zhMqxC6yVYBZkde9mx251XL6jpmIx/bNnXAEuuVc=;
        b=JTeq6/j9aKIMQfD8FP44xb0xiEDiaX/r/Asr+PmNFQStjb+noF8IPswVgPsUlH23Pf
         20D259GfcqlKRe9KicirfQEIPpND7r9A02x6drUUTMlPDUfW94z4lFnsxmeru6nUWLl9
         aLrQ5U97lNnGanbnE/KEMAkA8cj2opSkN6YEbpYe5kdPcxwNWo10+9puwHk0uLRVqMGQ
         Wv2sHbfOtu7nJD/LmmD7C9Os61ee6qVv7loUQ1NWSlYiZsrFsEoGi/wI9jOsNa0BiYQ6
         x/wEUWqiseSgrbUibTSwX6xs7R4jxbarZFp8OHM9WevMt2bknEctfgxUf1Rkb4nNUSfm
         kMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=K52zhMqxC6yVYBZkde9mx251XL6jpmIx/bNnXAEuuVc=;
        b=MQDfs8WXe58bdNj7Ea+rZgtLypIJCUOROMUhrwQZD9YNo36Txk5ynNrc6Q4T6aFHUj
         9IpUdj8MIz2pNGFEoT3okIZFe06x60y6ZwoNqsU6R4Koo7ODuUhE+oiMS/OUr2nme8iG
         D8ypmjHPm8LcmvYHeHBUMLrWYT77VbKAMWKmJumKCTyLed3VS3R8cf0pP489QBEfef1U
         BKe9TbAmW3BkIQYtHLO3pJvcv8mDrE75uwslQI6NByz9lLZmADXG8Yvjpcq4i4XBRBE0
         jtsYGf0oyN/J2KINQqFHQxviveU2ETwSHzooBXASb4qrmvjJ1WBE3VjvVKzrb2mRVdWq
         CzcQ==
X-Gm-Message-State: APjAAAUJNX/+3CDdYoWsnkUWcWLHPyFA0pTI2Robp3etwR6+D7MbkF+z
        kau6eB4JkSOWLJSaEiMXBLNgOA==
X-Google-Smtp-Source: APXvYqyA5SwfEszriIyG6grRFtST4lt9blokF465jTDQhWJWxl+UIPmqkcc/xPIboZHr8ZYeXI0v7Q==
X-Received: by 2002:ac8:45d0:: with SMTP id e16mr2144235qto.8.1571891683443;
        Wed, 23 Oct 2019 21:34:43 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q8sm8754411qta.31.2019.10.23.21.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 21:34:42 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading /proc/pagetypeinfo
Date:   Thu, 24 Oct 2019 00:34:41 -0400
Message-Id: <15BA6C88-21C1-4BF3-BB10-2A207AEBB401@lca.pw>
References: <20191024033313.GA42124@shbuild999.sh.intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
In-Reply-To: <20191024033313.GA42124@shbuild999.sh.intel.com>
To:     Feng Tang <feng.tang@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2019, at 11:33 PM, Feng Tang <feng.tang@intel.com> wrote:
>=20
> We have been using the /proc/pagetypeinfo for debugging, mainly for
> client platforms like phones/tablets. We met problems like very slow
> system response or OOM things, and many of them could be related with
> memory pressure or fragmentation issues, where monitoring /proc/pagetypein=
fo
> will be very useful for debugging.

This description of use case is rather vague. Which part of the information i=
n that file is critical to debug an OOM or slow system that is not readily a=
vailable in places like /proc/zoneinfo, /proc/buddyinfo, sysrq-m, or OOM tra=
ce etc?=
