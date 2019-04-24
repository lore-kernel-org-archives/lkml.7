Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C65C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A6F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556101922;
	bh=ax0g9jitiNGjYIX6ExJoP067eNLm3btd/DegLm1doro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DSOrxfh7H+JQfZ5dxMnSwySwdRVP3ZDzvZChfzXDvGRuowZ2wTvRXDZWjsbKrWYST
	 3MDCstZ5g/zEgti6FgGnxfBXkf/BkytplPdhK+8CBi2qU6lZzpksX6H2IqyVzX4yMr
	 IY12EMH8lVsD4tyvNL1YEy3lxqpKwXF3VL0O9zHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDXKcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:32:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51031 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfDXKcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:32:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so3962916wmk.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=itCzwScRRo83ShQ1/r2v1gdr2KVluBrOV9tdo4Cc/MY=;
        b=UPhF82Tf2KB8KVcaG48zawIIpMKqHj6qs0MIMtlejtHrP1S9kcfdeFvUSoCUElfbGi
         DHLG15P7lrMLh/t3LRHds+zWUtS8KFm0Y8cf3Lir7l4QT9rLy4YNC+6NYP4qaAdt7k6W
         Zb3kKQd1JULXTOAF6HVgSzKwRQCFIuE5RpVs0olbxI0Dh3FSvuYAPTq8JTCpLoo6GhjI
         bmHllfpD3RqO6h3pMHswabUi+zNfacO0qRxSXMrfZ6bWMdRNHQHWwIIuC9ulFa1X1zi9
         UU2xRdqP/vNXEKWrOKeufUBwCFrQYiT7B2/zpFxS5KE5/p+DTVV9rToxbqEtuqKBWAtH
         bGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=itCzwScRRo83ShQ1/r2v1gdr2KVluBrOV9tdo4Cc/MY=;
        b=ehu5DurmNcYZaw5Ytak2D4tnxA2vhdcOsL/AgGQtLiLXId4S7D2oS6DgNeV+yeOPYL
         6BvyEKKad5woGcLbBgk/O4yOu78efReohIFyaKDH3Qpjx4nDJf8KHAfQAWovaXQ0O6wG
         AykEPnuBEZXkC5HoOIhB7JkP5V7bSIQqkM7gzl4HXtFBj53Sk1+pUoq1mlrfmqkRLEwK
         PVE1rgKQ5q6dRT5TUZmfIJAcmfXB0dumhDM7Uj2cBCzJJv7csuncKsQ4vzkcQuYzLMJN
         lGX+LL3fgExxtO1gaFM2kkQoae8K1NblVzKh/FDC+yQn06J5v1/PcFinSVPwnOFVS84B
         sk4Q==
X-Gm-Message-State: APjAAAXUWlU0lsblCb1TxKb+ZC2IqL7ybhCnuyG5wcuPCTEaGnbJblKZ
        L14QICtQZPPaawc5tG/8CxI=
X-Google-Smtp-Source: APXvYqxfGfAZuLX/4h6wg7N23wZa+dpazZ7oW7kAXJrYwHLX/++rsU++FgRnvK8/c+9o3iS76LCgvQ==
X-Received: by 2002:a05:600c:24f:: with SMTP id 15mr5752432wmj.48.1556101919039;
        Wed, 24 Apr 2019 03:31:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c20sm23812646wre.28.2019.04.24.03.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 03:31:58 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:31:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/percpu-rwsem: Add DEFINE_PERCPU_RWSEM(), use it
 to initialize cgroup_threadgroup_rwsem
Message-ID: <20190424103155.GA9642@gmail.com>
References: <20190423163241.GA15866@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423163241.GA15866@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> Turn DEFINE_STATIC_PERCPU_RWSEM() into __DEFINE_PERCPU_RWSEM() with the
> additional "is_static" argument to introduce DEFINE_PERCPU_RWSEM().
> 
> Change cgroup.c to use DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem).
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/linux/percpu-rwsem.h | 8 ++++++--
>  kernel/cgroup/cgroup.c       | 3 +--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index 6887636..2809b44 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -17,14 +17,18 @@ struct percpu_rw_semaphore {
>  	int			readers_block;
>  };
>  
> -#define DEFINE_STATIC_PERCPU_RWSEM(name)				\
> +#define __DEFINE_PERCPU_RWSEM(name, is_static)				\
>  static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
> -static struct percpu_rw_semaphore name = {				\
> +is_static struct percpu_rw_semaphore name = {				\
>  	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
>  	.read_count = &__percpu_rwsem_rc_##name,			\
>  	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
>  	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
>  }
> +#define DEFINE_PERCPU_RWSEM(name)		\
> +	__DEFINE_PERCPU_RWSEM(name, /* not static */)
> +#define DEFINE_STATIC_PERCPU_RWSEM(name)	\
> +	__DEFINE_PERCPU_RWSEM(name, static)

Which tree is this against? It doesn't apply to tip:master nor latest 
-git.

Thanks,

	Ingo
