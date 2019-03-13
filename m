Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B13FC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB89E2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XVhxodS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCMBGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 21:06:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40379 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfCMBGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 21:06:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id x8so257489otg.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZK3UMA0+jcYLH9GlOc1de7OArJB5HWUsfhSIV+qw/o=;
        b=XVhxodS/cWi1+Kj0zcuMgBSdNtgToQjq+8zyn9JVumzlZtbH0+u3oMW5gy/suWMBp7
         cJ/u6/9rAbYc03wFDmk2ca7iID5lAsbN5R+aWhjKEKe5Wpxfayck71YUPVAqqqigj58O
         WAvR7oAPg7Nmo0R8A0sgLCcDrruerUv+Ib4vukplAt7U4DfYdh+NpbYxLtTY4KftS4Pv
         4Cevpn9yEX0quULptFuWBkXtcIa+Bu0J6JWXggDCI79WzhwglU0r5DO8RfAnGdzdvXCk
         JhhzmvjVws2VsBBbqDzbxyoF8nU1mYSD/my4iNqwGoExV/cBrWu83WZza99ubsFkNqhd
         rqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZK3UMA0+jcYLH9GlOc1de7OArJB5HWUsfhSIV+qw/o=;
        b=BhW/OqB1MH2RI3AWNtVfbEfAcqU4jBRQc8oELAZyO+vtZZMdTAK6gbAgSn6Tc/Sx8r
         oM+WCg49Qan2zeE52igk4vHN4xTc5RWoHPsnKTqQxHYhiHlGYh+DfSmrPMbnLUJ9Oy3g
         H8fTH1XzkIkKDGjquPuxqxfvJ8ZWFqo6FSfJiwx2jfBCrX2X5omsMocULZFrcFhNFXXw
         41ihH6ZuRpRn+jVPhTPRBysFEYw3KqjtDw+BPhMkJlT60259rez9CBy4I2jysPgBAiD+
         ZAtS4X5Sr6nBkEdR/d43Gp2cxUN6NLsBfX8C40kXQVmTbSrkN3HOIzpI7w5AmktqjgKC
         0GaA==
X-Gm-Message-State: APjAAAVsb7542mF1Zx87eRfHFPgzhI9bVc1XAzpT8gsWnkQkIjYlm3aU
        2RFEJ8YsVUeRisyn+GRxvID7cBpa+AMTYWGucB3OgQ==
X-Google-Smtp-Source: APXvYqxsMNMGK6e/Fpi42NFWPK3QTmiBgY/COyLYD70QTD/njfoKOA8X+IxFRFTr7yYcjC2F5nme4fECbkh7IFz9I0M=
X-Received: by 2002:a9d:7a87:: with SMTP id l7mr25469024otn.98.1552439195041;
 Tue, 12 Mar 2019 18:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
 <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
 <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
 <20190307094654.35391e0066396b204d133927@linux-foundation.org>
 <20190307185623.GD3835@redhat.com> <CAPcyv4gkxmmkB0nofVOvkmV7HcuBDb+1VLR9CSsp+m-QLX_mxA@mail.gmail.com>
 <20190312152551.GA3233@redhat.com> <CAPcyv4iYzTVpP+4iezH1BekawwPwJYiMvk2GZDzfzFLUnO+RgA@mail.gmail.com>
 <20190312190606.GA15675@redhat.com> <CAPcyv4g-z8nkM1B65oR-3PT_RFQbmQMsM-J-P0-nzyvvJ8gVog@mail.gmail.com>
 <20190312203436.GE23020@dastard>
In-Reply-To: <20190312203436.GE23020@dastard>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Mar 2019 18:06:23 -0700
Message-ID: <CAPcyv4htpVHm9GSYdKS=i4Ry011XZQUkOdMz9CXMrxJccRW9tw@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:34 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Mar 12, 2019 at 12:30:52PM -0700, Dan Williams wrote:
> > On Tue, Mar 12, 2019 at 12:06 PM Jerome Glisse <jglisse@redhat.com> wrote:
> > > On Tue, Mar 12, 2019 at 09:06:12AM -0700, Dan Williams wrote:
> > > > On Tue, Mar 12, 2019 at 8:26 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > [..]
> > > > > Spirit of the rule is better than blind application of rule.
> > > >
> > > > Again, I fail to see why HMM is suddenly unable to make forward
> > > > progress when the infrastructure that came before it was merged with
> > > > consumers in the same development cycle.
> > > >
> > > > A gate to upstream merge is about the only lever a reviewer has to
> > > > push for change, and these requests to uncouple the consumer only
> > > > serve to weaken that review tool in my mind.
> > >
> > > Well let just agree to disagree and leave it at that and stop
> > > wasting each other time
> >
> > I'm fine to continue this discussion if you are. Please be specific
> > about where we disagree and what aspect of the proposed rules about
> > merge staging are either acceptable, painful-but-doable, or
> > show-stoppers. Do you agree that HMM is doing something novel with
> > merge staging, am I off base there? I expect I can find folks that
> > would balk with even a one cycle deferment of consumers, but can we
> > start with that concession and see how it goes? I'm missing where I've
> > proposed something that is untenable for the future of HMM which is
> > addressing some real needs in gaps in the kernel's support for new
> > hardware.
>
> /me quietly wonders why the hmm infrastructure can't be staged in a
> maintainer tree development branch on a kernel.org and then
> all merged in one go when that branch has both infrastructure and
> drivers merged into it...
>
> i.e. everyone doing hmm driver work gets the infrastructure from the
> dev tree, not mainline. That's a pretty standard procedure for
> developing complex features, and it avoids all the issues being
> argued over right now...

True, but I wasn't considering that because the mm tree does not do
stable topic branches. This kind of staging seems not amenable to a
quilt workflow and it needs to keep pace with the rest of mm.
