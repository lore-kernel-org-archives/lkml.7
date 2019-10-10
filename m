Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1162C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A980A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Z2Y6iMRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfJJOaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:30:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44978 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfJJOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:30:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id w6so5036735oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJ4xsQtnmbNbtQPuMzUcS/Crf0fRiybq/RQZW0N2ou4=;
        b=Z2Y6iMROzX1lFH94Pe5S/VUAV16TG4jco5oEnqJqk6ymR4R3d32XPsE8IGJncDXfAy
         gcIPiwJ4NeNBsuA0RuYwIw4fxgqBevVYm/SCbQqQHfkoiT7UHtxiBTOCIuofzFrS0ZJ4
         Ztsq1PNOZTfkDZpW+HSbO52LFwBaMFN8NoXPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJ4xsQtnmbNbtQPuMzUcS/Crf0fRiybq/RQZW0N2ou4=;
        b=pGnoZ8p0cF2BiGD+3nkpdPNPTOG6j58jiuQvZfOfWcyVtFt9CGZK69A6b/8fVM3/jy
         sgs1tUdHOvInJNg6rdGQjISfbPMAH/4LuNjL3gky1a3NraXYUttzYS4EpYzCF1smZUrP
         tFx/2Ax5ii6GFXzCgYY/Put8AcDAziOXx2RBdevkcxpxunlHf8x9+7zoTQ+ufSpZbw3U
         9u1cly6yMLewAJFKoN4MCfBBebSUhyMoEbYMhqQlXb0pQzyOWc9nfzn8hdmU8dQiDabB
         qi34lUy9tCRvYR3prDUCm37gQJsAo08aJv6d7SQcuohU4FNptsx5R0vIktG6FriqBh6K
         4d/A==
X-Gm-Message-State: APjAAAWq/XO3CSBlxRH5V8HJyUcv89xbiYxk8JiTdc32AxbMB4zWwajI
        ir1qujLEZwdowg7Zn6Eug2JrC+WJgh/kl7RzAWXHPg==
X-Google-Smtp-Source: APXvYqwpTdrni78lzedCnFmfEtgKVKZKULWgJi//ul6gHs9Z5OzR3dtKZlNfwCRPZls8pQipDQeUIlEmgRm50zXCdIs=
X-Received: by 2002:aca:5f0a:: with SMTP id t10mr8016452oib.20.1570717800194;
 Thu, 10 Oct 2019 07:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190802153715.GA18075@sinkpad> <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com> <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu> <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu> <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com> <20191010135436.GA67897@aaronlu>
In-Reply-To: <20191010135436.GA67897@aaronlu>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Thu, 10 Oct 2019 10:29:47 -0400
Message-ID: <CANaguZDCtmXpm_rpTkjsfPPBscHCwz4u1OHwUt3XztzgLJa_jA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't see why we need do this.
>
> We only need to have the root level sched entities' vruntime become core
> wide since we will compare vruntime for them across hyperthreads. For
> sched entities on sub cfs_rqs, we never(at least, not now) compare their
> vruntime outside their cfs_rqs.
>
The reason we need to do this is because, new tasks that gets created will
have a vruntime based on the new min_vruntime and old tasks will have it
based on the old min_vruntime and it can cause starvation based on how
you set the min_vruntime. With this new patch, we normalize the whole
tree so that new tasks and old tasks compare with the same min_vruntime.

Thanks,
Vineeth
