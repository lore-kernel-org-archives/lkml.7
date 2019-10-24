Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84249CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BA821906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gvsu7dLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436914AbfJXKv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:51:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44393 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404139AbfJXKv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:51:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so22929124qkk.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Kn7zXHlDFisa5ha0EEX6R2nGbeEvvSUeVrzHt3lZZ5Y=;
        b=gvsu7dLgdrwVG34RluuIVlgzt15mmCgM2Jl+plvfxXHCBPSeBtw2cUlbUOS5l5OhKe
         dpLW/ohRQRoX7907vOa8nqZ/J+zm6O1uSZ0cmRQF69+36gRme4gjkD0KfvLIxw/vYcTw
         BD4Egl1/U4Pp+jvNtVFipaJ4sK8rDHbfoCC5yTHIZt5vm5D8djxYIRH/170wqYRj1556
         o9nk9M9/M6kSeu6SzpDlok2jdcLBUv5jZR/W+pq3d+AEFd6TKFYdSm8iVXSCR+m3gRH0
         npt7U8HYHUCKoVcFK6OkzDQFdS+wrmzdSJ+2rWDdKc8OyzrkN6ImH/LGzkcqrtYIAJCJ
         owUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Kn7zXHlDFisa5ha0EEX6R2nGbeEvvSUeVrzHt3lZZ5Y=;
        b=ebfjRj8ugctwjjdyDsNSdtrtwaVLL0Y2yoQIzGZ2h03AmYNi02atQ1ZvTF/Ab23yRV
         9MCKcAz7OTvU1fbg+1gktsJ6RxvpjMC98RLeIeVi0XiwWFQdYh7K69UlXd5UvBX2LgvK
         vAG64gcCE13Tq/TrNyHIIxybZ1+J9WkcRVmbEtwO7oUuL4DUO/aI7vBNgR6yDEfbxk7P
         rsaM+uurgzIUb77Xs3k8rAKAkMsplDsev5rXRO7AUxy+A/j6/NA9fW2+UQxdTnuDk9xP
         WREldrvSjAsAlUGGT+1WYwtY8WyV1lse6plhBvpeo3uWcIDvJoA3jKq2g/1OVCBRkHfK
         8voA==
X-Gm-Message-State: APjAAAXp5CCEgoWgOJb3RRUHTmMBNZLXYWoQGHI02rcvdOwwYi8+J/jq
        A9IHvUXrItVXHrHxmMrMY1GpwA==
X-Google-Smtp-Source: APXvYqzWgtKvFmwS91HOJ+59EsYqLoPDVaajXBMSSsHI13EtfayPCsKTm6FdChMHjdf2cN6OeVFgWg==
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr13122328qkj.53.1571914315702;
        Thu, 24 Oct 2019 03:51:55 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y29sm13170269qtc.8.2019.10.24.03.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 03:51:54 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading /proc/pagetypeinfo
Date:   Thu, 24 Oct 2019 06:51:54 -0400
Message-Id: <AE86BC94-F91E-454E-8A83-98918C93AD8F@lca.pw>
References: <20191024053445.GB42124@shbuild999.sh.intel.com>
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
In-Reply-To: <20191024053445.GB42124@shbuild999.sh.intel.com>
To:     Feng Tang <feng.tang@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 24, 2019, at 1:34 AM, Feng Tang <feng.tang@intel.com> wrote:
> 
> One example is, there was a platform with limited DRAM, so it preset
> some CMA memory for camera's big buffer allocation use, while it let 
> these memory to be shared by others when camera was not used. And
> after long time running, the cma region got fragmented and camera
> app started to fail due to the buffer allocation failure. And during
> debugging, we kept monitoring the buddy info for different migrate
> types.

For CMA-specific debugging, why CMA debugfs is not enough?
