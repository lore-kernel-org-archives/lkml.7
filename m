Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61322C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330402070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQdP+6LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLBKGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:06:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34915 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726557AbfLBKGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575281213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWf99ClocJTrdl7yyjr79cgOtm906wplocGScS3IZvg=;
        b=hQdP+6LYLS6C0QH6q/JACMpCKo65hFnN6FxdN1EvcORDTAI+poZJPKLJjrfmZWf4yWweXY
        nTa0qYFC4KsP4uyK4/96FJPhzD6LWeSSO3Se76tze0E8YDGDoEFzil8rvAuXFtF3YvKZDA
        5Yot9NYuHlexbU+NuWyxeLqjsRvntWM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-DbAEa8CuOPCqily9HSKZzQ-1; Mon, 02 Dec 2019 05:06:51 -0500
Received: by mail-wm1-f71.google.com with SMTP id z2so1099627wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 02:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LWf99ClocJTrdl7yyjr79cgOtm906wplocGScS3IZvg=;
        b=GasaneW+EwUOWJDzzOtCjOlxE8ypgEssvPHeBtUA1BTHloA8nm2YHTf1U100V3o4il
         xQ45uUdhROZR8QqnqrsGUp2KQlFxw0uMXfX1Z7lixInCNIAHN1HkNSo+7embx8yqEh7c
         CYMDzgSc5BGQbGoBEghjOtXAC19FZaeiG3W6ad4b1gmv9CC7hOizxtwr21iMoPeC8DzL
         wnKb/FiioZTZhQmt+or44DZ5w6KsmJIH1sfLcuvltAaKyPvOPo1/uOaqSSaRpi6hKtBu
         /pvvjtqt7jXd+6XAhKzTjj08a2zZem0trSp7BPCAU56x2uHI4xk6BdFvEHpfRbKA8PVo
         2LzQ==
X-Gm-Message-State: APjAAAUZbOYTF/7TNYn6rLmtuIFUZ2htNNQbO0hpqF//HrigW2/nDXhS
        imqFGH5QHE5IJaOMhIZyf+2jBD4d/HsijgDCTL2mFbXrug0toDixm0yNtcUZ4bNt0QXb1XPnKwM
        bNDBYn6DM4u7QQhNKi8PVrXxP
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr12421024wrb.22.1575281210539;
        Mon, 02 Dec 2019 02:06:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhhcWugDGw+DX0hPY8W0LFXNpfNFg/3a/6ZsSrTvg2/gVh4gPEEBjHkxYw0bKDu8FVVN2YaA==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr12420998wrb.22.1575281210224;
        Mon, 02 Dec 2019 02:06:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id n14sm11013440wmi.26.2019.12.02.02.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 02:06:49 -0800 (PST)
Subject: Re: vfio_pin_map_dma cause synchronize_sched wait too long
To:     "Longpeng (Mike)" <longpeng2@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     qemu-devel@nongnu.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Longpeng(Mike)" <longpeng.mike@gmail.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Huangzhichao <huangzhichao@huawei.com>
References: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
 <34c53520-4144-fe71-528a-8df53e7f4dd1@redhat.com>
 <561fb205-16be-ae87-9cfe-61e6a3b04dc5@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42c907fd-6c09-fbb6-d166-60e6827edff5@redhat.com>
Date:   Mon, 2 Dec 2019 11:06:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <561fb205-16be-ae87-9cfe-61e6a3b04dc5@huawei.com>
Content-Language: en-US
X-MC-Unique: DbAEa8CuOPCqily9HSKZzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/19 10:42, Longpeng (Mike) wrote:
>> cond_resched in vfio_iommu_map.  Perhaps you could add one to 
>> vfio_pin_pages_remote and/or use vfio_pgsize_bitmap to cap the
>> number of pages that it returns.
> Um ... There's only one running task (qemu-kvm of the VM1) on that
> CPU, so maybe the cond_resched() is ineffective ?

Note that synchronize_sched() these days is just a synonym of
synchronize_rcu, so this makes me wonder if you're running on an older
kernel and whether you are missing this commit:


commit 92aa39e9dc77481b90cbef25e547d66cab901496
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jul 9 13:47:30 2018 -0700

    rcu: Make need_resched() respond to urgent RCU-QS needs

    The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urgent
    need for an RCU quiescent state from the force-quiescent-state
processing
    within the grace-period kthread to context switches and to
cond_resched().
    Unfortunately, such urgent needs are not communicated to need_resched(),
    which is sometimes used to decide when to invoke cond_resched(), for
    but one example, within the KVM vcpu_run() function.  As of v4.15, this
    can result in synchronize_sched() being delayed by up to ten seconds,
    which can be problematic, to say nothing of annoying.

    This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
    rcu_check_callbacks(), which is invoked from the scheduling-clock
    interrupt handler.  If the current task is not an idle task and is
    not executing in usermode, a context switch is forced, and either way,
    the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the current
    task is an idle task, then RCU's dyntick-idle code will detect the
    quiescent state, so no further action is required.  Similarly, if the
    task is executing in usermode, other code in rcu_check_callbacks() and
    its called functions will report the corresponding quiescent state.

    Reported-by: Marius Hillenbrand <mhillenb@amazon.de>
    Reported-by: David Woodhouse <dwmw2@infradead.org>
    Suggested-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>


Thanks,

Paolo

