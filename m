Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A41FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EAF2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574361182;
	bh=wE2tHf3ZYWYbliD+R/Z0yBNHf5NZkidjFVls8TJM8C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uREcq0ealAL/AVvGysn8y4QeAxgLJA7KladlSsv53nZqjjsQhv/pTQcyLOybxkZBG
	 5X/d135h3aY/235j32ppDneNjjMyo6IjnWa9RJYTYh3aSTqduCNOrvWaPCOfAP1lBr
	 5UCoWVRSW3lDHbVG1N+wLgTZgL1JkYlnZdYvBk+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfKUSdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:33:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52173 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUSdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:33:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so4603074wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QpdFGCi5ivXxDIzboDWyNYO66cHHS/lXg7ziVev9IZo=;
        b=jgCStv+qGqRqOTsBMWfs2Jen+gMWWaUoAyhn0xoaM56h0671j8K3ZpBnXIqKTolMly
         PunnmPMGBqBe2PWVlSJ3OxfES+8WRolNvYNd4C7jJb8ctYk33ZZj1jA2FI4ujcthwzLa
         oi6vKi84bgrulrqNHINLZKKcPRK7EHcIbNITnG8Nzl5Dc2txlK4RtHY/vwBdCJbJxics
         LNP2F9LhLW+/juuQ4N+/eIfgwd0IOfvCRs6+JTnUOiKphpVQECIdIARC3gE7JDMG/fCg
         3yx8FBYoMWJhUwBge7uNaKxEg6e5QoGb1ybUb5y+16ppzoSlyDQv6sdVhxPq5U3cWJ6b
         iE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QpdFGCi5ivXxDIzboDWyNYO66cHHS/lXg7ziVev9IZo=;
        b=oUgda+sqBU0LI1Finmci9d4W8UXF2Wy+F0/lJgVEHvh/GmtOKdUMozYvwaCAA7wGQV
         T4cZF699TpAFCrN2AaFVUIFeSEBIxDmDVC4Bsne4zBhPCH+5z7BlT/wY4wjnIwlsmf2z
         G+5h9t1YhWfioNEMxkmBaDepn3pyepGXqoU5ZA4htO2SwQJBXlj8iI9gvW/fGh43/92J
         GiSWsM3PauSm8I3PYxdh9IyILKSO1bKFyAzow6CB8FH7qQSbU6t8DPuKhbufXBBQRJtm
         xr4o0jyEytZuxzQQL8ihdXe38hs9vStNwoqmnRw+rqU6e92zFXJfNsiMFwEhuJk2V/fK
         w9Gg==
X-Gm-Message-State: APjAAAXM+rVxBDBzL/gAUsuJLG5ROQ0Ue5KwIyZ1RFxnd6Vaza5Cko1V
        YYQHI+joneNFck2qCmOMg8Q=
X-Google-Smtp-Source: APXvYqxGdwJCh/RRx1XOPoqG1UX9YkIrYDWrkN5YLSJmIqCy3k62JPFmw42dzBYNc2cawVlYml+ZJQ==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr12081590wmh.81.1574361179554;
        Thu, 21 Nov 2019 10:32:59 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t185sm526758wmf.45.2019.11.21.10.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:32:59 -0800 (PST)
Date:   Thu, 21 Nov 2019 19:32:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] spinlock_debug: Fix various data races
Message-ID: <20191121183257.GA124760@gmail.com>
References: <20191120155715.28089-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120155715.28089-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Marco Elver <elver@google.com> wrote:

>  static inline void debug_spin_lock_after(raw_spinlock_t *lock)
>  {
> -	lock->owner_cpu = raw_smp_processor_id();
> -	lock->owner = current;
> +	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
> +	WRITE_ONCE(lock->owner, current);
>  }

debug_spin_lock_after() runs inside the spinlock itself - why do these 
writes have to be WRITE_ONCE()?

> @@ -197,8 +197,8 @@ static inline void debug_write_unlock(rwlock_t *lock)
>  	RWLOCK_BUG_ON(lock->owner != current, lock, "wrong owner");
>  	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
>  							lock, "wrong CPU");
> -	lock->owner = SPINLOCK_OWNER_INIT;
> -	lock->owner_cpu = -1;
> +	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
> +	WRITE_ONCE(lock->owner_cpu, -1);
>  }

This too is running inside the critical section of the spinlock - why are 
the WRITE_ONCE() calls necessary?

Thanks,

	Ingo
