Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89373C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDFB26FE6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559344751;
	bh=Z/UteNLbzavzD4j8t2dWkjaN9tNiB8lyWd2CzDP+rDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FuA8LEweTo2oDcrba4PoD7RVZgL6YjJpQZpzSwBSbhSMcBmzfjHiGh1Dc8bvDgE7f
	 cu3vab0MHc5oKBSk09I+OP9pSfGvJuOE0nfEZYNDTjMMecc6FZbBnL8XF7jErU4DC3
	 2FtE4MBk4y8zDYEu1K+q+gWizJwm6E2t1orwi2ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfEaXTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:19:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42380 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfEaXTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:19:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id r22so7058301pfh.9;
        Fri, 31 May 2019 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OBkn41KBzlGPK7jEmV7BtD0vX9tIAAepdrwcEGsA5+w=;
        b=f1LmKeIlF+EXuCgaz3EuG6LlWSltz+X7bsxaknz34pKaycrAKRLn9vvqYZA3JBev6r
         OCN7Lc8r39/kTKAkOVwhotscdF3y27IeIpCXRJMJlcROgjsRwTToq1AolFiU8zyNPhcf
         FxTtBcZDcfOXCRBdbkf8hZwQz1mQltjnKlLPgycKGiuVqdmJwJboVcu9ddUBjxphxa+X
         OpsxbOOaRwVFHE5//eefmSF+QfyXcjVQjxSZ7MIW94sOO1eJXVrGHkCD1BQQHe3cMOZM
         uyk0h2h6DN6zBJupx3x4ZQFWIPwkX193GsQiAN/71nWAfVzcMpbkbHJO6se95mSl/kXa
         GcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OBkn41KBzlGPK7jEmV7BtD0vX9tIAAepdrwcEGsA5+w=;
        b=ZTlfQU1SCIhaiCn+6oHCW3q6/lqCLla7KObqFY9Y66Tz+80IvaVNgcwtp8I5sTQDwx
         yDbR6fDapIuBFE9rTZ7cc5d/M5u1o0uSyJi2Jqy0qP1yQphiziN4ZjUPJQKLIRN5GI25
         lR7Eiq4yz4hpHADl+nC2gkieiG4I6wjuzRg5C9HpvA9212BGLXv8Zg8CNcuL9IBY8cGe
         2lNEzeK7BoqhMjibGAaMYYVZZjDBDk9MLhwsc4K0rRxNUnXvW44/Cn2Bmi+QdIcRj47G
         uBPyCHuo1W/K7C0WK/NL7wgqmU2538NUcY5Q4YEpLZuBCbLaSNjEO02lIfII5rPbohWl
         GIjA==
X-Gm-Message-State: APjAAAV593guGnp5YtzEsGa4sXcFtR1vadzs927eX6mhMoskXcnT0+uA
        +RUlKoUS4Js+9SMmv30rAkw=
X-Google-Smtp-Source: APXvYqwlaLnvjar6sK0YrFR/Mv80Eb/Txa+lx67buxss1QoweTkwqrSTUHaA0EACzyTCmeYVmOIJtA==
X-Received: by 2002:a62:1990:: with SMTP id 138mr13345803pfz.133.1559344749725;
        Fri, 31 May 2019 16:19:09 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id x18sm12173516pfj.17.2019.05.31.16.19.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 16:19:08 -0700 (PDT)
Date:   Sat, 1 Jun 2019 08:18:59 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [RFCv2 6/6] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190531231859.GB248371@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-7-minchan@kernel.org>
 <2fd5d462449f24b04adad2bbdf0e272647e62247.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fd5d462449f24b04adad2bbdf0e272647e62247.camel@opteya.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yann,

On Fri, May 31, 2019 at 12:06:52PM +0200, Yann Droneaud wrote:
> Hi,
> 
> Le vendredi 31 mai 2019 à 15:43 +0900, Minchan Kim a écrit :
> > 
> > diff --git a/include/uapi/asm-generic/mman-common.h
> > b/include/uapi/asm-generic/mman-common.h
> > index 92e347a89ddc..220c2b5eb961 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -75,4 +75,15 @@
> >  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> >  				 PKEY_DISABLE_WRITE)
> >  
> > +struct pr_madvise_param {
> > +	int size;		/* the size of this structure */
> > +	int cookie;		/* reserved to support atomicity */
> > +	int nr_elem;		/* count of below arrary fields */
> 
> Those should be unsigned.
> 
> There's an implicit hole here on ABI with 64bits aligned pointers
> 
> > +	int __user *hints;	/* hints for each range */
> > +	/* to store result of each operation */
> > +	const struct iovec __user *results;
> > +	/* input address ranges */
> > +	const struct iovec __user *ranges;
> 
> Using pointer type in uAPI structure require a 'compat' version of the
> syscall need to be provided.
> 
> If using iovec too.

I will fix them when I submit next revision.
Thanks for the review.
