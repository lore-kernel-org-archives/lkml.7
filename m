Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6573CC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAAD21726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WPxVI7wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFZVAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:00:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37257 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:00:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so2900817qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qf+CT2mZcsc1wHQKyoDf7Pyvzizaa33wknAn8WnxhsI=;
        b=WPxVI7wR/DwoNAi7i3PyIvUgpTlkBnmoD2JTHStbRFDqb0McytK19CQWYQKatTjfnZ
         GssU7arEPrVHitisRc67KBOl8S3z0cpWijE24J7/mVo6qVmmbkoMFZvvtkKQB7FsIKAd
         1fJQOXVonx0pV3KLQneEhLhjW4cyQrYgdiFCE8LwRqu546LR5vuhg1SeuP4Y879VlmZS
         SSWVqcHU8NhByBvuXaZdwEEwIlpZd9DWA+I6rLblnJrAiAzHK33dCo3GjgBWRehb4yT1
         i1LTG4TxZUoO5SYY2098mC0brOvMx0R54xNsJY2rpcp38CuBJm5yunyl/qLifmfVP/lC
         eegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qf+CT2mZcsc1wHQKyoDf7Pyvzizaa33wknAn8WnxhsI=;
        b=Tu/F7UcE6zZ4PdKo4u3HJ/WQOK0rl+aqbVcvDmWBjGMiYDdySyECCAnRcPeg97+sd4
         EYhNRKNcvv6b37Fb0udyNBqAw2CYrszwqQdtEcQNAqXedGpeSq0iWXB3nKBUEjktufcK
         WAnvqe6Y5iRTd5caGaWumnDy6t7y/WLq6KXJoVCq3ZC6kWJUL1HL9DQX0v5hKOvpguJn
         uCzN8qM3nS2/OqLnk9oEGXR+iYYcoTDEsVfrx9j1Fsj5FItOgCM1KXlawvTYnhUfqRYI
         Z3aATY3g23yoy39kTIMHejKezz5Qmru+ZX7WxD2NszZvRyws3KDv19n2NFR/U3qg0rRB
         hFIw==
X-Gm-Message-State: APjAAAUdxDWKvGjGFaBIAdUrCL7c+flN6XKVia6ZkYzwPw3HXwC7NyL7
        4l+A38n44Rm1tYPExNgzfL2DoQ==
X-Google-Smtp-Source: APXvYqz4ArMmY4amnoRNUTWTY/UqNE29DEE3V4j9H3MnV7OKZWACOHcxFi9QpO1iIKQ0WvAVOW9KFQ==
X-Received: by 2002:a37:a142:: with SMTP id k63mr103601qke.278.1561582830308;
        Wed, 26 Jun 2019 14:00:30 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f6sm8486072qkk.79.2019.06.26.14.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 14:00:29 -0700 (PDT)
Message-ID: <1561582828.5154.83.camel@lca.pw>
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
From:   Qian Cai <cai@lca.pw>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Date:   Wed, 26 Jun 2019 17:00:28 -0400
In-Reply-To: <cd6db786ff5758914c77add4d7a9391886038c84.camel@intel.com>
References: <20190514150735.39625-1-cai@lca.pw>
         <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
         <7ba8164b60be4e41707559ed6623f9462c942735.camel@intel.com>
         <CAPcyv4gLr_WrNOg58C5tfpZTp2wso1C=kHGDkMvH4+sGniLQMQ@mail.gmail.com>
         <cd6db786ff5758914c77add4d7a9391886038c84.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-16 at 00:29 +0000, Verma, Vishal L wrote:
> On Wed, 2019-05-15 at 17:26 -0700, Dan Williams wrote:
> > On Wed, May 15, 2019 at 5:25 PM Verma, Vishal L
> > <vishal.l.verma@intel.com> wrote:
> > > On Wed, 2019-05-15 at 16:25 -0700, Dan Williams wrote:
> > > > > diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> > > > > index 4671776f5623..9f02a99cfac0 100644
> > > > > --- a/drivers/nvdimm/btt.c
> > > > > +++ b/drivers/nvdimm/btt.c
> > > > > @@ -1269,11 +1269,9 @@ static int btt_read_pg(struct btt *btt,
> > > > > struct bio_integrity_payload *bip,
> > > > > 
> > > > >                 ret = btt_data_read(arena, page, off, postmap,
> > > > > cur_len);
> > > > >                 if (ret) {
> > > > > -                       int rc;
> > > > > -
> > > > >                         /* Media error - set the e_flag */
> > > > > -                       rc = btt_map_write(arena, premap,
> > > > > postmap, 0, 1,
> > > > > -                               NVDIMM_IO_ATOMIC);
> > > > > +                       btt_map_write(arena, premap, postmap, 0,
> > > > > 1,
> > > > > +                                     NVDIMM_IO_ATOMIC);
> > > > >                         goto out_rtt;
> > > > 
> > > > This doesn't look correct to me, shouldn't we at least be logging
> > > > that
> > > > the bad-block failed to be persistently tracked?
> > > 
> > > Yes logging it sounds good to me. Qian, can you include this in your
> > > respin or shall I send a fix for it separately (since we were always
> > > ignoring the failure here regardless of this patch)?
> > 
> > I think a separate fix for this makes more sense. Likely also needs to
> > be a ratelimited message in case a storm of errors is encountered.
> 
> Yes good point on rate limiting - I was thinking WARN_ONCE but that
> might mask errors for distinct blocks, but a rate limited printk should
> work best. I'll prepare a patch.
> 

Verma, are you still working on this? I can still see this warning in the latest
linux-next.

drivers/nvdimm/btt.c: In function 'btt_read_pg':
drivers/nvdimm/btt.c:1272:8: warning: variable 'rc' set but not used
[-Wunused-but-set-variable]

