Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C842190F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDOXv7K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfFDPmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:42:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43530 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfFDPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:42:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so7144388qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xaM3I79HUiU67Y+8mYQAROOi+VnFe/U6hSKYVL5KqaU=;
        b=pDOXv7K1WORffANfKdcXl8SMjsVLKfhiu7hIEvDqR/NO3n4Oj8TAbMRwu9Gp/SPFcH
         D/muppqIo9lA1+/5F8s+rMeWxyOPz/BvVXRScvO32v6E5WCsfNJIke+BJY+i5ygM0xcG
         DOpdgB+BgE9F4njvqMMEaap9V20APrS7x/xhuQpPvbCjd7cVVOm0a2M5IFLxDAkUIKrG
         HYdqh5UQ/U7nJWIcZ2CrcOBWf0szZK0NwS2peazbRU/jHzwAieuAonxnUEBlyDnIuCJx
         zARfhgpnkoMTVjCi/9scqwc0K9cRwBK0+6i0pPWENMk8IYkjIHS3JYX81qF4izjL+M7/
         erFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xaM3I79HUiU67Y+8mYQAROOi+VnFe/U6hSKYVL5KqaU=;
        b=Sf/R+rleChN7KFk5mqVPSwawuSuVzjdwiZ1jbx4BeIYuUvdN7NIjVBv04pGETCOsIq
         FL4PMq7RPB77bXZOUwQ/LBRoLh0P1/KmQM6qtWlGTYHsMgfoNf5ElklyrkfWDcT3shea
         bpkeLfP4OCx1zYFJoaUq3dYbfcAZ+SstwhJN+7NGHZG+ZyLffsztNytz/hyaRuwsNCrV
         KqiNy3CcQYMqIH1X9yh3f5mMJr9P4pXaSDGJgr186onYL8FAOKjN41+/KTEmO3pVtCv4
         FuKDDjtUQ0hbjLrSrNrJcSbCNH6q5gm1qzTIXie56fi4M2hnZYG06Jzx6Pp3gxuv4c4b
         vM3g==
X-Gm-Message-State: APjAAAVrQBSFpcPJRpAtnK2MhVijgqNcTXMw67knNqjJJq4YP05bfN+2
        jeZZU3tB34tYjLxndTSfidQ=
X-Google-Smtp-Source: APXvYqxxpZEg2kJ1xpJn/5rSXpG6qK0M6oI6AUnMpjPF+Ih06Q1luIKUEi4p2imuAyawU7D1XK0mSg==
X-Received: by 2002:ac8:28ee:: with SMTP id j43mr29065465qtj.248.1559662931298;
        Tue, 04 Jun 2019 08:42:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id y29sm2119136qtm.66.2019.06.04.08.42.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 08:42:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27F0341149; Tue,  4 Jun 2019 12:42:08 -0300 (-03)
Date:   Tue, 4 Jun 2019 12:42:08 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190604154208.GH24504@kernel.org>
References: <e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com>
 <20190530194111.GA6540@kernel.org>
 <3dc0c67e-9ea3-b9f5-1aa2-e87603b29c37@linux.intel.com>
 <20190604141220.GG24504@kernel.org>
 <ecf1d25f-8c28-934d-f426-26c9d0a68304@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf1d25f-8c28-934d-f426-26c9d0a68304@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 04, 2019 at 05:56:30PM +0300, Alexey Budankov escreveu:
> 
> On 04.06.2019 17:12, Arnaldo Carvalho de Melo wrote:
> > Em Fri, May 31, 2019 at 09:27:38AM +0300, Alexey Budankov escreveu:
> <SNIP>
> > 
> > Now cross building to a few arches is failing, so far:
> > 
> > [perfbuilder@quaco ~]$ cat /tmp/dm.log/summary
> >  alpine:3.4: Ok
> >  alpine:3.5: Ok
> >  alpine:3.6: Ok
> >  alpine:3.7: Ok
> >  alpine:3.8: Ok
> >  alpine:3.9: Ok
> >  alpine:edge: Ok
> >  amazonlinux:1: Ok
> >  amazonlinux:2: Ok
> >  android-ndk:r12b-arm: Ok
> >  android-ndk:r15c-arm: Ok
> >  centos:5: Ok
> >  centos:6: Ok
> >  centos:7: Ok
> >  clearlinux:latest: Ok
> >  debian:8: Ok
> >  debian:9: Ok
> >  debian:experimental: Ok
> >  debian:experimental-x-arm64: Ok
> >  debian:experimental-x-mips: FAIL
> >  debian:experimental-x-mips64: FAIL
> >  debian:experimental-x-mipsel: FAIL
> >  fedora:20: Ok
> >  fedora:22: Ok
> >  fedora:23: Ok
> >  fedora:24: Ok
> >  fedora:24-x-ARC-uClibc: FAIL
> >  fedora:25: Ok
> >  fedora:26: Ok
> >  fedora:27: Ok
> > [perfbuilder@quaco ~]$
> 
> That below can fix it. Unfortunately can't test in advance on that architectures.

Thanks for the prompt fix, just from visual inspection it looks good,
but just in case:

[perfbuilder@quaco ~]$ dm debian:experimental-x-{arm64,mips,mips64,mipsel} fedora:{24-x-ARC-uClibc,30-x-ARC-{g,uC}libc} 
   1   debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
   2   debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
   3   debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
   4   debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
   5   fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
   6   fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
   7   fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
[perfbuilder@quaco ~]$

So I merged this fix with your v5 so as to keep the tree bisectable,

- Arnaldo
