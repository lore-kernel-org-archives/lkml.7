Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B0BFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E38821848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571236083;
	bh=a/0Mo+yQV9Rtw2SL/6iBHZjhh3OlOHHqnfsKkqcVhJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q6w8NS4/dKSRI8dPKaauNK0XQKASgh1cyhuZje6rabxZ4PzLaN277VWFSQ73R1Zjv
	 fr5ppsmbUAEhXf0nQmYFHlcftX487J7pIaUDikrkT4EETHtApOnsFGhj1O8p292kze
	 HSmlrDosPAcsJdoAvOj43Yx4PLl/8OY9yWR0C8Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394058AbfJPO2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:28:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36187 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfJPO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:28:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so22940535qkc.3;
        Wed, 16 Oct 2019 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pWLBPoWyBcOr16gWtiZJvZNkZ+CpdbY6LbEquS4WgGs=;
        b=SWezzmlqWZweUFaF4bfjHi2Tkkw8IwVCxK4pMU0MbQZvbR2h4E82Y8SaKq2ezH2umM
         WfPRhFIQakPbA8Otm9Wuc/6yBmHY4iHer+p4UI/OZl4/gWanrHa4EIwbFby9zsvbYmst
         sWi85/Xa/YV9FyaWVkBgxd8vgS0+SgZgr1wypsV68+Tu6PJ9AimgXsQ0fRyR3xx73Q7/
         VQ/IVepjPClxC2g2duudYJbd/4GD7ExOPqSKzsrX/nP38Q/ZBh6/JL0z+o5sg5Qz/npy
         zyNO86sjKko2KZdlxldTUeds1q9AfwACNfH60szRWGnZJwbBwXGDTDGCU2n/HhUGYXR/
         zDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pWLBPoWyBcOr16gWtiZJvZNkZ+CpdbY6LbEquS4WgGs=;
        b=Q84H98xY79oTc8lUrYgc8V83YBeberotMMqhmkPaxDzfJEHh0TfYEVFf3G+fzX3QM5
         35HnAsrVyF/qd5B3+EMU3K2+0MF5RWiKJrTnZpb5IeM/CXzKzZJJs5UMOpVcvLhAkGH0
         354zO0RwxsERQ67AvOBElJotyFQJkrfbGUmbAWlvnL30stg7KFj3Fw2y22HxcM2sIGqp
         b8VlOMm/BLLxSgRDc9MxzXLYmj+djFlXIWiMzluPtybowPnEsmWmxthHcDdPknUusUSz
         0bzxHJ9R9Uw+wszyfxvDMDE0tjah7Y64Kmjxw8d6G8lAi7hPJtwi3fUnKZpugruVMaeS
         0sZQ==
X-Gm-Message-State: APjAAAVoIgtgU8T8U3zXCmONFhH+EioT0r/jii6keZtBQKg8G0Reuhgy
        05lT5GS7gaF0qA53uExCEvg=
X-Google-Smtp-Source: APXvYqz36gDcDPyEKnQuRJpODNwdYI7/eHC6toKsYq0xzoKu6JG9Ve4tnsU7B/Lb3kB7hGC2V8yaRw==
X-Received: by 2002:a37:68a:: with SMTP id 132mr3949742qkg.359.1571236080574;
        Wed, 16 Oct 2019 07:28:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:2d57])
        by smtp.gmail.com with ESMTPSA id g194sm12328186qke.46.2019.10.16.07.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:27:59 -0700 (PDT)
Date:   Wed, 16 Oct 2019 07:27:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cgroup: pids: use {READ,WRITE}_ONCE for pids->limit
 operations
Message-ID: <20191016142756.GN18794@devbig004.ftw2.facebook.com>
References: <20191012010539.6131-1-cyphar@cyphar.com>
 <20191014154136.GF18794@devbig004.ftw2.facebook.com>
 <20191014155931.jl7idjebhqxb3ck3@yavin.dot.cyphar.com>
 <20191014163307.GG18794@devbig004.ftw2.facebook.com>
 <20191016083218.ttsaqnxpjh5i5bgv@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016083218.ttsaqnxpjh5i5bgv@yavin.dot.cyphar.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Aleksa.

On Wed, Oct 16, 2019 at 07:32:19PM +1100, Aleksa Sarai wrote:
> Maybe I'm misunderstanding Documentation/atomic_t.txt, but it looks to
> me like it's explicitly saying that I shouldn't use atomic64_t if I'm
> just using it for fetching and assignment.

Hah, where is it saying that?  The alternative would be seqlock or
u64_stats or straight-up locking but idk for this atomic64_t should be
fine.

> > The non-RMW ops are (typically) regular LOADs and STOREs and are
> > canonically implemented using READ_ONCE(), WRITE_ONCE(),
> > smp_load_acquire() and smp_store_release() respectively. Therefore, if
> > you find yourself only using the Non-RMW operations of atomic_t, you
> > do not in fact need atomic_t at all and are doing it wrong.
> 
> As for 64-bit on 32-bit machines -- that is a separate issue, but from
> [1] it seems to me like there are more problems that *_ONCE() fixes than
> just split reads and writes.

Your explanations are too wishy washy.  If you wanna fix it, please do
it correctly.  R/W ONCE isn't the right solution here.

Thanks.

-- 
tejun
