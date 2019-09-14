Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC779C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 14:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8CA20830
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 14:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLWQXsiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfINODD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 10:03:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38609 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbfINODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 10:03:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so10710587qta.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FILpjNL+RmY6Z8jojDq41S9B56t8mMa/fsPAusJZOio=;
        b=SLWQXsiAhmwj62UAX0GnvilBsNPnufvkJAh5HS7n6HTVmIdgJ+fHcCCPcvXxVaIqOp
         ZzgaKO4ZtzPlCH0RKHTyIFfDnR5KHLFhicEun4sViedpWlSdiw0zxM/WnzUsfI9ZXBbr
         pV7T0PZFp3oO5Zb5WzvWJgz7Rb7DU9JnmCxB7RKG1dHfXNSPCRm91ZPfEcsSPhyN6qty
         qA7ALNCtMfzdMne8tIdViX0cFnw4SR6fJ+S/SQGTHBvjXkgOXXtedpAQpyBbuj1zuweR
         pVh/66Q9713kEcl8N7RfWJu85sQVnifXvjQGBbGoOs4RgNS8+ko5Haw89/3WeQpl+uqF
         iwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FILpjNL+RmY6Z8jojDq41S9B56t8mMa/fsPAusJZOio=;
        b=A45P8xBOJRfxCX4BQtW7hy8dVj+OX9LT1+3K8DSTbuH77+07Un3kO5cbbP1o2o09NB
         9hRvSal2c0dAz/Q0EGdf4eQeek/bPDz8iPH+0+R8u9MsYxzIRMdY8aMLswJTeM7JbA09
         GsEX8W6DIxRNZzZH88QRnUn+ZaZux9aPinjiIDAAuhOV0rcYA8nMuOvEp7K7U56SD4AG
         VTupJBAS70Id9/L1hpmuhJ9i8uzdnjV8DHf1A+oNe12j/koQm7+caKc/QflgbXO0vtQ0
         gpLe6J8mbnQ6yLvMZoLg7wAGY93hqhJ6d+ZHxj4a6wycUGcjEYv3L1nv0slTobJyezue
         d1xw==
X-Gm-Message-State: APjAAAVLEoBUF146ElBlF3nO9w5auQqZ9d0bPOpEu5pr8iBWW7+ttf7d
        JlSagB9pQid/mSREbvsi6hoQzL6qhdEDvCfIOq0=
X-Google-Smtp-Source: APXvYqwLiQUllQUIh8zLE8dwEGGoUOkDVgf4keDH2nKeyYOUQZdJBg3xxtflqpFNvIJ9v49An7i84HmTlS2htdbFTqs=
X-Received: by 2002:ac8:3021:: with SMTP id f30mr8450945qte.193.1568469782620;
 Sat, 14 Sep 2019 07:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com> <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
In-Reply-To: <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 14 Sep 2019 15:02:51 +0100
Message-ID: <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
To:     Tejun Heo <tj@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Sat, Aug 31, 2019 at 6:01 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sat, Aug 31, 2019 at 12:03:26PM +0900, Namhyung Kim wrote:
> > Hmm.. it looks hard to use fhandle as the identifier since perf
> > sampling is done in NMI context.  AFAICS the encode_fh part seems ok
> > but getting dentry/inode from a kernfs_node seems not.
> >
> > I assume kernfs_node_id's ino and gen are same to its inode's.  Then
> > we might use kernfs_node for encoding but not sure you like it ;-)
>
> Oh yeah, the whole cgroup id situation is kinda shitty and it's likely
> that it needs to be cleaned up a bit for this to be used widely.  The
> issues are...

Here are my 2 cents about this.

I think we don't need a perfect identifier in this case. IIUC, the goal of
this patchset is to map each sample with a cgroup name (or full path).
To achieve this, we need

1. PERF_RECORD_CGROUP, that maps
           "64-bit number" => cgroup name/path
2. PERF_SAMPLE_CGROUP, that adds "64-bit number" to each sample.

I call the id a "64-bit number" because it is not required to be a globally
unique id. As long as it is consistent within the same perf-record session,
we won't get any confusion. Since we add PERF_RECORD_CGROUP
for each cgroup creation, we will map most of samples correctly even
when the  "64-bit number" is recycled within the same perf-record session.

At the moment, I think ino is good enough for the "64-bit number" even
for 32-bit systems. If we don't call it "ino" (just call it "cgroup_tag" or
"cgroup_id", we can change it when kernfs provides a better 64-bit id.

About full path name: The user names the full path here. If the user gives
two different workloads the same name/path, we really cannot change that.
Reasonable users would be able to make sense from the full path.

Thanks,
Song
