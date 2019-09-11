Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEA8C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D1F2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfIKMJI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55037 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfIKMJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:09:07 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A61983F42
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 12:09:07 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id a22so6466849edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 05:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wiKMwbrFTWMlvoFQ+WcXmY6U5v89DRZRbjwpcrU0/0g=;
        b=JZ/zDj+tdiGbZXrS6UbxLj0csVlC0qVs0iTdapBIUH8V9IAxZoYhPSCAmt6d1HkpgO
         evg7kHmHl1qUFGnozyZ124UlPS6CuracHi9Er0pbIQQmG0ouzVkp/wx2E0nwkRf10fzr
         x47+J3Bogw72abTB6lWhdIh84MxByOc+ttiZwHzFSG/StgOUs6sH//ntjOIusMWaA0LU
         lp+SqQ8L7csNPdMmYnwQkSmQuFGfLBvbu9usydNlRYc8K4lAlzh6gaEFwluEMZ7/b83G
         8WCbYMnh9VXq/K7VzEaB3Qw6Oxfy0LTJdPVDBrBuFkTCieIwN0ET112nlwAMNKjIS/u+
         3rHA==
X-Gm-Message-State: APjAAAW0DiJF4ozb3dtXM16L1n5rKPQbYeJyk2gXlfMt0uI1NhdQdalr
        AqUd0ROfAnTfzm60yhOcQAp4nlPaCoL60xfYF5+jRh245LeE5KPy1zOe8ncnCCjWI6ydxYuu5HU
        0LoKrfFwSbD8uzRldSeLh5r/N
X-Received: by 2002:a50:baab:: with SMTP id x40mr10586842ede.60.1568203744134;
        Wed, 11 Sep 2019 05:09:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBwHHyUEXDcXl266h1mS0CBQ840+QtMXzXaW5MgM+DIbavLEYSLwUZNv6e85xX5gKfbNSrNw==
X-Received: by 2002:a50:baab:: with SMTP id x40mr10586809ede.60.1568203743936;
        Wed, 11 Sep 2019 05:09:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id o4sm4097666edq.84.2019.09.11.05.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 05:09:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0D6111804C6; Wed, 11 Sep 2019 13:09:02 +0100 (WEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
In-Reply-To: <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com>
References: <20190909223236.157099-1-samitolvanen@google.com> <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com> <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Sep 2019 13:09:01 +0100
Message-ID: <87impzt4pu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Töpel <bjorn.topel@intel.com> writes:

> On 2019-09-11 09:42, Yonghong Song wrote:
>> I am not an expert in XDP testing. Toke, Björn, could you give some
>> suggestions what to test for XDP performance here?
>
> I ran the "xdp_rxq_info" sample with and without Sami's patch:

Thanks for doing this!

> $ sudo ./xdp_rxq_info --dev enp134s0f0 --action XDP_DROP
>
> Before:
>
> Running XDP on dev:enp134s0f0 (ifindex:6) action:XDP_DROP options:no_touch
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      20      23923874    0
> XDP-RX CPU      total   23923874
>
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index   20:20  23923878    0
> rx_queue_index   20:sum 23923878
>
> After Sami's patch:
>
> Running XDP on dev:enp134s0f0 (ifindex:6) action:XDP_DROP options:no_touch
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      20      22998700    0
> XDP-RX CPU      total   22998700
>
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index   20:20  22998705    0
> rx_queue_index   20:sum 22998705
>
>
> So, roughly ~4% for this somewhat naive scenario.

Or (1/22998700 - 1/23923874) * 10**9 == 1.7 nanoseconds of overhead.

I guess that is not *too* bad; but it's still chipping away at
performance; anything we could do to lower the overhead?

-Toke
