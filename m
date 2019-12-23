Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B33CC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B88C2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="nIF/rtU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLWUp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 15:45:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36618 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfLWUp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 15:45:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so17963953wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 12:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RfB76wwaEX/78cbszFlEp1zzCnUTfDY/Sh7gy/S4Lbo=;
        b=nIF/rtU2CboWVUUhYtDjyEwhh2pLvmBwpXRDenb7QB+hciZC4vK0N69+PUkjMN7aDK
         RRlAU40oBB+K9zy7rIki+yoYkvykfYmfp98ExrjDAXen7Q4WBr44moYjTmVm13NhpzXp
         KrmGxTN3IeAgaWFHuzcn/KNRF7a/w2CjQMWoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RfB76wwaEX/78cbszFlEp1zzCnUTfDY/Sh7gy/S4Lbo=;
        b=CnvaczDNSZfA//D5+mRE3ol9RmNfLSyYnhVNh5QIHrvEaXkU1hp8nf1/rF1oHIanL8
         +jy80OnPi1hMH6LUY5fXDQpBC0eplsmVqPcH8t3WsuyniP8hM/Rl3d7TgKeeXGn6rfOn
         RdsLdPVyHaLvJWH9Zf9HKOHX3sUPFGhsiNblSmMgiZoCY63tyQTVk8oaD1EQ8hj3OE7E
         NPRamlcljbP2CPXpARoGDhdjFTl3n02OBzb6Ua2iTWKHPWed5ILqV2ROlqgIAHMKETMk
         XbQHRuzTZfOPii9X7DV9O2DNo/zj3jkmcBfEctLUC/5SrpdKYmyhx7NTz6WGr113ZbOL
         /5XA==
X-Gm-Message-State: APjAAAWMRAW3zACIeXKeJnnscEoEtFI8QVOZmBiVYXugn0ma10aEJq51
        p5Lu6v3LN2Zarb8XmHEL/KJOlg==
X-Google-Smtp-Source: APXvYqx0rT7XFoKtJISTWdjiz/59q0aYkCoY6+XhmuAF4uBKOfMLvzlxtpIE9vJ0+tKDjKe9Ordrow==
X-Received: by 2002:adf:df03:: with SMTP id y3mr34226407wrl.260.1577133954181;
        Mon, 23 Dec 2019 12:45:54 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:94bc])
        by smtp.gmail.com with ESMTPSA id b10sm22304212wrt.90.2019.12.23.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 12:45:53 -0800 (PST)
Date:   Mon, 23 Dec 2019 20:45:51 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "zhengbin (A)" <zhengbin13@huawei.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20191223204551.GA272672@chrisdown.name>
References: <20191220024936.GA380394@chrisdown.name>
 <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
 <20191220121615.GB388018@chrisdown.name>
 <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
 <20191220164632.GA26902@bombadil.infradead.org>
 <CAOQ4uxhYY9Ep1ncpU+E3bWg4ZpR8pjvLJMA5vj+7frEJ2KTwsg@mail.gmail.com>
 <20191220195025.GA9469@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191220195025.GA9469@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
>On Fri, Dec 20, 2019 at 07:35:38PM +0200, Amir Goldstein wrote:
>> On Fri, Dec 20, 2019 at 6:46 PM Matthew Wilcox <willy@infradead.org> wrote:
>> >
>> > On Fri, Dec 20, 2019 at 03:41:11PM +0200, Amir Goldstein wrote:
>> > > Suggestion:
>> > > 1. Extend the kmem_cache API to let the ctor() know if it is
>> > > initializing an object
>> > >     for the first time (new page) or recycling an object.
>> >
>> > Uh, what?  The ctor is _only_ called when new pages are allocated.
>> > Part of the contract with the slab user is that objects are returned to
>> > the slab in an initialised state.
>>
>> Right. I mixed up the ctor() with alloc_inode().
>> So is there anything stopping us from reusing an existing non-zero
>> value of  i_ino in shmem_get_inode()? for recycling shmem ino
>> numbers?
>
>I think that would be an excellent solution to the problem!  At least,
>I can't think of any problems with it.

Thanks for the suggestions and feedback, Amir and Matthew :-)

The slab i_ino recycling approach works somewhat, but is unfortunately neutered 
quite a lot by the fact that slab recycling is per-memcg. That is, replacing 
with recycle_or_get_next_ino(old_ino)[0] for shmfs and a few other trivial 
callsites only leads to about 10% slab reuse, which doesn't really stem the 
bleeding of 32-bit inums on an affected workload:

     # tail -5000 /sys/kernel/debug/tracing/trace | grep -o 'recycle_or_get_next_ino:.*' | sort | uniq -c
         4454 recycle_or_get_next_ino: not recycled
          546 recycle_or_get_next_ino: recycled

Roman (who I've just added to cc) tells me that currently we only have 
per-memcg slab reuse instead of global when using CONFIG_MEMCG. This 
contributes fairly significantly here since there are multiple tasks across 
multiple cgroups which are contributing to the get_next_ino() thrash.

I think this is a good start, but we need something of a different magnitude in 
order to actually solve this problem with the current slab infrastructure. How 
about something like the following?

1. Add get_next_ino_full, which uses whatever the full width of ino_t is
2. Use get_next_ino_full in tmpfs (et al.)
3. Add a mount option to tmpfs (et al.), say `32bit-inums`, which people can 
    pass if they want the 32-bit inode numbers back. This would still allow 
    people who want to make this tradeoff to use xino.
4. (If you like) Also add a CONFIG option to disable this at compile time.

I'd appreciate your thoughts on that approach or others you have ideas about. 
Thanks! :-)

0:

unsigned int recycle_or_get_next_ino(ino_t old_ino)
{
	/*
	 * get_next_ino returns unsigned int. If this fires then i_ino must be
	 * >32 bits and have been changed later, so the caller shouldn't be
	 * recycling inode numbers
	 */
	WARN_ONCE(old_ino >> (sizeof(unsigned int) * 8),
		  "Recyclable i_ino uses more bits than unsigned int: %llu",
		  (u64)old_ino);

	if (old_ino) {
		if (prandom_u32() % 100 == 0)
			trace_printk("recycled\n");
		return old_ino;
	} else {
		if (prandom_u32() % 100 == 0)
			trace_printk("not recycled\n");
		return get_next_ino();
	}
}
