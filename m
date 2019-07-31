Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED10C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1DC206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jj/3Q/u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbfGaOyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:54:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35376 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbfGaOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:54:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so49499553qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBLkQ5l7iqgRc/LZwzrYfujT+xXRrB58EoMCQ+Ui3VI=;
        b=jj/3Q/u2Xs29S6NlOoXNsCj1Bdc9Lbm5pq/+4qEzjuzz6zrOeGZvCnVobVV48T76Yt
         lhP6QIqCfTSMgdyUuA8id7soMBu8FVTcgqq9tZkC8bybvzKhlT1/O1NoAvtkmqU+uHA/
         lN1qKLKZH/ymKs8cGGKkcqZ3FoyRQ/dIjGPYuLoFcTfL5+v5B/AA0IQmqZYwaGdHN0ae
         QltUoH5udPdvBV4l2P47Aa9/cHVXXNY3jkrKsbxvYm5v9s3yN8pZAKC4v+LvOm3Nksx3
         DjtDb18xe32fUbpBwV9L8znF6djoInMDHvfKACmRHmqQuRp0qh6rvxjwq3ppdlNuSADi
         NdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBLkQ5l7iqgRc/LZwzrYfujT+xXRrB58EoMCQ+Ui3VI=;
        b=Gtiwm75oOarZfroUv9PGMMMW+uMJj52HvtFwr9Axp07ALfHAJqwOhUJp5UASY8sGRr
         Ealg6g57BIT+Y9JqLGar9aRKNIOY4J/RrqilWIIkO21PBjxEi0EUSKTOrBzqtRcrP3Un
         tKVP7wliHXeRNmX6OFnrkekFgVpEpe3eptw7EFInZOcVB0l15prdN63smRPAv5gIoeNB
         TTygeq060drY6AwaYs6zv+0uHKGJyZ7Tt4b43N/g6KuCDexQYe9dM5GpWS8KE+aQZkMp
         FFrLBDBkbYb28iRi/nAHnMgqnyOmQwkg7wGZfsuIqrUCGXC8F3HkqDbD4+1pr0gDgjVh
         W1Ng==
X-Gm-Message-State: APjAAAUyvBUusHqkJX08hd8439lPBgWJTzAUnmYPYTiY2BBeDzUETHja
        m/q6amX87n2ZB/dXjQNMDyouEw==
X-Google-Smtp-Source: APXvYqx+aQWLkT4Ece9S/qLSNvLPSnE6+9CTFSY4EuJdjy+FS1QE9EH891iVIapc59W/IB+tXlTypA==
X-Received: by 2002:ae9:ebc3:: with SMTP id b186mr82269098qkg.222.1564584845939;
        Wed, 31 Jul 2019 07:54:05 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n27sm23088492qkk.35.2019.07.31.07.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:54:05 -0700 (PDT)
Message-ID: <1564584843.11067.36.camel@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Wed, 31 Jul 2019 10:54:03 -0400
In-Reply-To: <20190731144839.GA17773@arrakis.emea.arm.com>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
         <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
         <1564518157.11067.34.camel@lca.pw>
         <20190731095355.GC63307@arrakis.emea.arm.com>
         <C8EF1660-78FF-49E4-B5D7-6B27400F7306@lca.pw>
         <20190731144839.GA17773@arrakis.emea.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 15:48 +0100, Catalin Marinas wrote:
> On Wed, Jul 31, 2019 at 08:02:30AM -0400, Qian Cai wrote:
> > On Jul 31, 2019, at 5:53 AM, Catalin Marinas <catalin.marinas@arm.com>
> > wrote:
> > > On Tue, Jul 30, 2019 at 04:22:37PM -0400, Qian Cai wrote:
> > > > On Tue, 2019-07-30 at 12:57 -0700, Andrew Morton wrote:
> > > > > On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@ar
> > > > > m.com>
> > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > @@ -2011,6 +2011,12 @@
> > > > > >  			Built with
> > > > > > CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
> > > > > >  			the default is off.
> > > > > >  
> > > > > > +	kmemleak.mempool=
> > > > > > +			[KNL] Boot-time tuning of the minimum
> > > > > > kmemleak
> > > > > > +			metadata pool size.
> > > > > > +			Format: <int>
> > > > > > +			Default: NR_CPUS * 4
> > > > > > +
> > > > 
> > > > Catalin, BTW, it is right now unable to handle a large size. I tried to
> > > > reserve
> > > > 64M (kmemleak.mempool=67108864),
> 
> [...]
> > > It looks like the mempool cannot be created. 64M objects means a
> > > kmalloc(512MB) for the pool array in mempool_init_node(), so that hits
> > > the MAX_ORDER warning in __alloc_pages_nodemask().
> > > 
> > > Maybe the mempool tunable won't help much for your case if you need so
> > > many objects. It's still worth having a mempool for kmemleak but we
> > > could look into changing the refill logic while keeping the original
> > > size constant (say 1024 objects).
> > 
> > Actually, kmemleak.mempool=524288 works quite well on systems I have here.
> > This
> > is more of making the code robust by error-handling a large value without
> > the
> > NULL-ptr-deref below. Maybe simply just validate the value by adding upper
> > bound
> > to not trigger that warning with MAX_ORDER.
> 
> Would it work for you with a Kconfig option, similar to
> DEBUG_KMEMLEAK_EARLY_LOG_SIZE?

Yes, it should be fine.

> 
> > > > [   16.192449][    T1] BUG: Unable to handle kernel data access at
> > > > 0xffffffffffffb2aa
> > > 
> > > This doesn't seem kmemleak related from the trace.
> > 
> > This only happens when passing a large kmemleak.mempool, e.g., 64M
> > 
> > [   16.193126][    T1] NIP [c000000000b2a2fc] log_early+0x8/0x160
> > [   16.193153][    T1] LR [c0000000003e6e48] kmem_cache_free+0x428/0x740
> 
> Ah, I missed the log_early() call here. It's a kmemleak bug where it
> isn't disabled properly in case of an error and log_early() is still
> called after the .text.init section was freed. I'll send a patch.
> 
