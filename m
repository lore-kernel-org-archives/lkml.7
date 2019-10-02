Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB0C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED50205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569997694;
	bh=fVItT2HxwNdcXXxgKH5Yp7bDuMnswxDhPRLu5gC6rKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hHxeat0b/VfBl7mBpoQFiuzoVMvrnbgj122k0GRz5qz9YJm29+jB+IS/wB3uLDAY6
	 ch8+FNmiLmj8ljm0WXEkCtHUtzi0xiy4rweELw72+Jm+/9m7s/H9gjqCNoAcEoYsvq
	 G5xABqX1vsryX2SNCzFNnOpFMjoC/3vhBXAYgIL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfJBG2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 02:28:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53054 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBG2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 02:28:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so5761739wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 23:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poWop88QlN5QK7naJWh5A87wySFd+Tin97FQEhhro8U=;
        b=YXP0+k1kcfIKa/3jW36X3/jnkfUsKuvs9wn6H1dZlGLeP2yehfPn1kzsUEbmcJ5N/6
         BeejmHEIGOemUe4k7qCsvswY/ghr+90ff015QsXUV2YvGwVUqcYFH8J//BdcSoSO7otP
         ZhsccMr//IqMX1Djfo/5oDz9cR6NNBuL/plnoW/x1oHoTDA0QNxFjVx4zDs94QOgZ4wF
         NEFblpCul5TzTdfC9iw0OZggYHVqEYN10KV4NSU05hnGH4SiuL+Mqsk6sbvFP7MPd0J0
         EzxLVIRwMuMVVt8p0drJi8grGrHHovBQTyDwMGmMbDtHNzVC/LiDckLshgoyElwWN1t9
         XsNA==
X-Gm-Message-State: APjAAAUY0+eFMNf5oI8e7bL8vH7jT5UiVNa4qu5RB/c+EZgHesmnMGDA
        USOv9Wf4+dBglZg6H3d7z3IcgPqKQwbLaKfofYs=
X-Google-Smtp-Source: APXvYqwUT5Nm7O/07O3Gh1ksBHZ4Yj+7UjgAmKwhB+2W0AWNmtij5IbhB24Pl0acFHNxujU+O5zygR2Z+EtABC9sc9k=
X-Received: by 2002:a1c:e008:: with SMTP id x8mr1358115wmg.85.1569997691326;
 Tue, 01 Oct 2019 23:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com> <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com> <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
 <20190916152325.GD3084169@devbig004.ftw2.facebook.com> <CAPhsuW54+YNkj3fnmS6P0=eEdzZ4YvV7Yv+t-d-OnRNNgxPS+Q@mail.gmail.com>
 <CAM9d7cg_AKCyifV7xDm7sJ4=wgG_K=qu013TSTHqLiCRh9m_pg@mail.gmail.com> <20190920210411.GB2233839@devbig004.ftw2.facebook.com>
In-Reply-To: <20190920210411.GB2233839@devbig004.ftw2.facebook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 2 Oct 2019 15:28:00 +0900
Message-ID: <CAM9d7cjbt6TYL_uiwu9DSiJLW-nx3P=BpWvqu-pR=DNSD2Dzdg@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
To:     Tejun Heo <tj@kernel.org>
Cc:     Song Liu <liu.song.a23@gmail.com>, Ingo Molnar <mingo@kernel.org>,
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

Sorry for the late reply.

On Sat, Sep 21, 2019 at 6:04 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Sep 20, 2019 at 05:47:45PM +0900, Namhyung Kim wrote:
> > Thanks for the sharing information!  For 32-bit, while the ino itself is not
> > monotonic, gen << 32 + ino is monotonic right?  I think we can use the
>
> It's not.  gen gets incremented on every allocation, so it has not
> high but still realistic chance of collisions.

In __kernfs_new_node(), gen gets increased only if idr_alloc_cyclic()
returns lower than the cursor...  I'm not sure you talked about it.

Thanks
Namhyung
