Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EAFC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751FB206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfHZKsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:48:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfHZKsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:48:09 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF2B0882F2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 10:48:08 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id c14so9784837plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 03:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0dLSzyN/rqUp1HY2dWLbKR3HKdVZWjjqhT8wBvMX/lY=;
        b=JaJBz6OUhjDZUI78/dQ4FZY/KMLI8JJLqMPWotbHNS5nhj3tZLiaoSKWqTfv931yey
         inHCofz+tuN9lk2f6+T1VvgsvTMEtfdrgS0SJUEt2wtWWzvq/eGcDs/7nTF7pnsz9zOl
         8/OX+DoVjFS7GqTBvDg0qR2/VcdLzZBEeJR9aWWSGrfGHENk/vB71bYZA3d05yZgt7Bn
         pnqUvg0jPj5DFq5c3S8xm1EK9rLnJgT9lNxlaPQUt9oQSQHykgXd9D6GHB2TezLNld5w
         LGTORFB0DJxM1CypMbhi3/1aUS3M4aWfhNYfLeuKsY+elkcrROPt9KkY7vmS6GTq8EMT
         rN8A==
X-Gm-Message-State: APjAAAWPEU6W1oiV01JEE+BkTdLUJZlHg9eU66QXxCc3Nw5oHRO1VZs9
        Owd0r4QVWvt7ymDlAxj/4V0gBam8Og07DY89kzmeYfAl1DVyGMaKJrqPGAudPKsQZ2R/IHrSx+V
        n/lzeKx5JzZE1wZhvVXyZ/Coi
X-Received: by 2002:a17:902:bb96:: with SMTP id m22mr6110811pls.158.1566816488019;
        Mon, 26 Aug 2019 03:48:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9v5IQAhWjTcE8c7v1y0W7cdjmyinoF6TfA1qB+qM4O/NEWXL8MtQPYXNVLiYIXRqW1tJDXA==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22mr6110798pls.158.1566816487856;
        Mon, 26 Aug 2019 03:48:07 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t189sm12062303pfd.58.2019.08.26.03.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 03:48:07 -0700 (PDT)
Date:   Mon, 26 Aug 2019 18:47:57 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Detect max PA width from cpuid
Message-ID: <20190826104757.GD1785@xz-x1>
References: <20190826075728.21646-1-peterx@redhat.com>
 <874l24nxik.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874l24nxik.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 10:25:55AM +0200, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > The dirty_log_test is failing on some old machines like Xeon E3-1220
> > with tripple faults when writting to the tracked memory region:
> 
> s,writting,writing,
> 
> >
> >   Test iterations: 32, interval: 10 (ms)
> >   Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
> >   guest physical test memory offset: 0x7fbffef000
> >   ==== Test Assertion Failure ====
> >   dirty_log_test.c:138: false
> >   pid=6137 tid=6139 - Success
> >      1  0x0000000000401ca1: vcpu_worker at dirty_log_test.c:138
> >      2  0x00007f3dd9e392dd: ?? ??:0
> >      3  0x00007f3dd9b6a132: ?? ??:0
> >   Invalid guest sync status: exit_reason=SHUTDOWN
> >
> 
> This patch breaks on my AMD machine with
> 
> # cpuid -1 -l 0x80000008
> CPU:
>    Physical Address and Linear Address Size (0x80000008/eax):
>       maximum physical address bits         = 0x30 (48)
>       maximum linear (virtual) address bits = 0x30 (48)
>       maximum guest physical address bits   = 0x0 (0)
> 
> 
> Pre-patch:
> 
> # ./dirty_log_test 
> Test iterations: 32, interval: 10 (ms)
> Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
> guest physical test memory offset: 0x7fbffef000
> Dirtied 139264 pages
> Total bits checked: dirty (135251), clear (7991709), track_next (29789)
> 
> Post-patch:
> 
> # ./dirty_log_test 
> Test iterations: 32, interval: 10 (ms)
> Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
> Supported guest physical address width: 48
> guest physical test memory offset: 0xffffbffef000
> ==== Test Assertion Failure ====
>   dirty_log_test.c:141: false
>   pid=77983 tid=77985 - Success
>      1	0x0000000000401d12: vcpu_worker at dirty_log_test.c:138
>      2	0x00007f636374358d: ?? ??:0
>      3	0x00007f63636726a2: ?? ??:0
>   Invalid guest sync status: exit_reason=SHUTDOWN

Vitaly,

Are you using shadow paging?  If so, could you try NPT=off?

I finally found a AMD host and I also found that it's passing with
shadow MMU mode which is strange.  If so I would suspect it's a real
bug in AMD NTP path but I'd like to see whether it's also happening on
your side.

Thanks,

-- 
Peter Xu
