Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8FCC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1393A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/GOFRJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfFLSET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:04:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40202 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfFLSET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:04:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so15917549ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HA7VYYB6HYTnwOsfSZ6IJMiRwVIheU8PeAUQ4SUxsDE=;
        b=Z/GOFRJXw0yo2NclXm9o0hxO/gUmaXJp5lNg1hcuR0tF6112X2HthCJzh8CXxy/QSX
         Casq6IhYPWFHSOoYCLPqB5YZn+lGzUwQDR1WTAPmX/8rdQITptlPHe92KHb2/yaoL1Qt
         OGcdLSSG0ZNjV51rjf3jHYjCGK90xs/bev2fp5W1lR0cxH4M1DMEqcSVFwkMuNOQm5xw
         6YU/glgO1ALD0evMQ/dDqytfrdWiSyB7glDGSG68T2gHvfxZHd4tJisB95h9lQor2gZu
         cbJMtpKGYitBwg44ruAKeGOHc2XkjHf/HsoByLHJvjodM4T3nwRt15ULmQgxdTiwyLJ3
         C2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HA7VYYB6HYTnwOsfSZ6IJMiRwVIheU8PeAUQ4SUxsDE=;
        b=YX6zDitIyGbbGJW2hwaWSASsQRvidTn3UwXBlGZcb+lcWc3+Fb4K8PjLpSt7gixrkj
         Y9mP9B/HUz9qqIBxSBsQU4t6E5taKXCW0OWq4DCXgFpfLnMxbp2Yfgj0UOpcagZn+dn/
         KpOuwcF2/Rx94ph2MqewiJTixlb1ee7kVxiMxii+F4oYXaqVhKFO67Q6kWQGDuyXyfvk
         akKJxGE0Bge0Bt2LKUg5VJ/ACVeTqWWCqsjw3OGGuMy5Fcu5LUV5qauZmvVIJNDQ+G/7
         vxPrCl6UUtF7JWI0HgYwa1U2tgSZMcIWQxb66NxObQf5EybcKxfDhYAr2U/Zy/0Hz5CE
         TaQA==
X-Gm-Message-State: APjAAAU7LCxIxKuUEUJ8Fu9eUObp5Bacr9FGw/GmJFWk96/GxJwcmCQJ
        oLs5sD8KBGILugZj53d42xg=
X-Google-Smtp-Source: APXvYqzotGrbJI9s/KdrG87kqY2e2cD44RcIacKKFE4JrKA3iuS7uYtR1JSgUbX5wF56fdmAE1QXjA==
X-Received: by 2002:a2e:890a:: with SMTP id d10mr1641465lji.145.1560362657186;
        Wed, 12 Jun 2019 11:04:17 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id w205sm96813lff.92.2019.06.12.11.04.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 11:04:16 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 90A854605BC; Wed, 12 Jun 2019 21:04:15 +0300 (MSK)
Date:   Wed, 12 Jun 2019 21:04:15 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [RFC PATCH] binfmt_elf: Protect mm_struct access with mmap_sem
Message-ID: <20190612180415.GE23535@uranus.lan>
References: <20190612142811.24894-1-mkoutny@suse.com>
 <20190612170034.GE32656@bombadil.infradead.org>
 <20190612172914.GC9638@blackbody.suse.cz>
 <20190612175159.GF32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612175159.GF32656@bombadil.infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:51:59AM -0700, Matthew Wilcox wrote:
> On Wed, Jun 12, 2019 at 07:29:15PM +0200, Michal Koutný wrote:
> > On Wed, Jun 12, 2019 at 10:00:34AM -0700, Matthew Wilcox <willy@infradead.org> wrote:
> > > On Wed, Jun 12, 2019 at 04:28:11PM +0200, Michal Koutný wrote:
> > > > -	/* N.B. passed_fileno might not be initialized? */
> > > > +
> > > 
> > > Why did you delete this comment?
> > The variable got removed in
> >     d20894a23708 ("Remove a.out interpreter support in ELF loader")
> > so it is not relevant anymore.
> 
> Better put that in the changelog for v2 then.  or even make it a
> separate patch.

Just updated changelog should be fine, I guess. A separate commit
just to remove an obsolete comment is too much.
