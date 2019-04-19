Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB8C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FB9222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caOIYLew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfDSSXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42575 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfDSSX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so4570911lfc.9;
        Fri, 19 Apr 2019 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mRAge5Pmqaqc5fZ0NHqu5gKTW2B1I9IBJzxof3qVcIg=;
        b=caOIYLewrzJO0tx1/p2iMgF7wSWM9NpTC/5/mjYtUwzbQgZHONS7KIVKSEKhVUbSrL
         DWY+wem1NdyiPS97aDwsDtNeSfVWqCQ9E+6xnRXm+TPxW8cMxAcNPbRJgQH/7Ho/oPWM
         ufyMKQhkHl0HanrOL9jrilMbs5VEEDH2wmr4Yk8bVZEd4hGy7MuTcJMqWRxDI8Ff+8WQ
         YIK9Y2GNYs5Ea+r88JNXtL6NTYFgMGycXyeA85r403/DBFswslVQAGLzXx9D3Dz6zxHk
         +yWDzhmsFdRAc6OUm7hr5RqxX3eLAok2osfQPep2Je/jdzkiVijJGYLVQwh5HfYrxtPp
         BDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mRAge5Pmqaqc5fZ0NHqu5gKTW2B1I9IBJzxof3qVcIg=;
        b=Lrg0liq0LDje8nhGTU7jdy95tKxVxd5xpscsnJ0aTo0vmvel/ymMBGDhemPNC3Nxyg
         Vx/3t/bAGiFGnGdVcpjHiVdPdd/U4l6RCvqwfi8blvzC8lZI3TzOVztgTcx8n1d2Fwpa
         DCrnAnLmfQTXAItikiWBqOK+RKo4B2Xn3oshczG3a1WoAbkCxgwfbhv3t1gvcrEydK3o
         Ap2oteGCXgFgn5EyBPSqZWSGRhXQmR3LpncX965tmvF4m2y7aoZeGZhb/0Z7cJgoUGsv
         rUNPGuyhkn2MlPCvFEhk2bKP3eqEevsFWONAnF75A48QqhUSONmWyEt1iZGuX5VLWvCx
         95Ng==
X-Gm-Message-State: APjAAAXFmf05+6gdf41XclNH5wKPtaqcGO4x7h5frTpty98ZI2fBSdsG
        BWgABrnwCHztDawFe22rVfY+JNBXp5OYVdmYsX2s1Q==
X-Google-Smtp-Source: APXvYqxrilCnuTySbmUdOUICSZcFng2tCWgPTQgGgRchTIx3ZTPRaH32HTbwlG4QHhUSpLfcq5ZsEuPGgaqRGAN0dt0=
X-Received: by 2002:a19:a8c8:: with SMTP id r191mr2931043lfe.161.1555696435059;
 Fri, 19 Apr 2019 10:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
In-Reply-To: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
Date:   Fri, 19 Apr 2019 18:53:44 +0100
Message-ID: <CACfOrNdEpC2vNgCOBXtrW-HjGHNG_6iLAFUCtVoZstGASPtcsA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: add CCI-400 PMU nodes support to
 Exynos542x SoCs
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch can be dropped, as it needs more work.

In fact, the interrupts seems to be wrong. The interrupts suggested by
Anand Moon gave the same following results.

export CCI_DEV=CCI_400
export OMP_NUM_THREADS=2
sudo --preserve-env ./perf stat -a \
  -e armv7_cortex_a7/config=0x11,name=a7_cycles/ \
  -e armv7_cortex_a15/config=0x11,name=a15_cycles/ \
  -e armv7_cortex_a7/config=0x19,name=a7_bus/ \
  -e armv7_cortex_a15/config=0x19,name=a15_bus/ \
  -e ${CCI_DEV}/config=0xff,name=cci400_cycles/ \
  -e ${CCI_DEV}/config=0x0,name=cci400_si_rrq_hs_any/ \
  -e ${CCI_DEV}/config=0xc,name=cci400_si_wrq_hs_any/ \
  taskset -c 0,7 /home/user/cg.x.A 1

[..]

 Performance counter stats for 'system wide':

     9,362,850,550      a7_cycles
     1,682,125,760      a15_cycles
        68,920,347      a7_bus
        61,484,352      a15_bus
     3,789,936,935      cci400_cycles
                 0      cci400_si_rrq_hs_any
                 0      cci400_si_wrq_hs_any

       9.541340558 seconds time elapsed

cg.x.A comes from NAS benchmark suite, compiled with fopenmp support, setup
to run 2 threads and taskmapped to ran on both a7 and a15 clusters.
a7_bus and a15_bus report main memory accesses.

Only cci400_cycles seems to be correct. However, all pmcs from the master
interface are reported as unsupported and all pmcs from the slave interface
return 0, which is probably not correct.
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0470f/CJHICFBF.html

Would it be possible that someone from Samsung provide the right
interrupts values?
Many thanks.

Regards,
Willy
