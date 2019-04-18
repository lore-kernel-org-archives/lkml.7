Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AC4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47812064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTAIU/ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391610AbfDRSXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:23:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44829 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391513AbfDRSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so1505220pll.11;
        Thu, 18 Apr 2019 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M84pVHi7QUoGbkpTQqGc/KjlrR1jeH2e5lPBKjhZDPk=;
        b=cTAIU/kiErqEy8Si5CmKVT1NW1pUL07abrAVIzHT0BN8kExtZgl9cmiVM8eRw8pBzX
         y3FbTznUwrHHyWID8PqSODK7dQI1bSkl7AHqV+jTXT4buiDHyHFii8bZBPInLvb3cKlC
         dQTLhQFTBUA51JcOesEDuDZXTAIl6mY7i48WuKG8morCwdJpcqTR3EtmyZO07i6IG+F3
         e2b3I2YgR9vji9H7iFAkpXb56e/jgclWdD8CFhe946seVPt+Lth1VA8S1U2vnNG1PI36
         1Fs8Nu6XhoSLOe4UElMPpCB8ajxeB211MEWYItbTMUw6IpXObzSyay607OScDEZuKZsK
         soUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=M84pVHi7QUoGbkpTQqGc/KjlrR1jeH2e5lPBKjhZDPk=;
        b=YmXOUpUW7h0e0pVti6+awCPd/WONXRU9NwCE78d8EwWo9MMlw7WzZNqNxYX7pIqm3+
         fEjhxv1orL+qG/LIhjcqrVpkbevDmTK6ON6eYUHIZ2y7e5knfavY+wUH/CEPKb2WH6/K
         //s93aXfn5KbPGe+yNgP1efX8aZEZ18ezCUpK8crjV/hJ3YFTtYuMEY7wo2oaIi50Bn9
         7rWHv3bI4+M2pucbjdgvQe1jk5mzHNTHEq8H4H2SMXutiPgJynSa26xo1NmGCHMO6v2o
         qPaBPitPRS2cYmzriEFh5LouoAFjCm1kdr+XQ99545Ju7K2NFoeJYti/8bi7LeXft1qg
         14qA==
X-Gm-Message-State: APjAAAWa+MIjUx2CTSRu2IB9maI0nvJ+hGrQGhjvh12pdKqS3J+nyWaz
        qPe0ZNH73CnhrVJMALo6W4vz933k
X-Google-Smtp-Source: APXvYqyLwhXnuSDn2GzS8iGcfgIbKN3NqdNdbp0yVdhOqQ7za2Eo1c6Gu6mDigJphG7IBfJ5i11x8Q==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22mr97518136pll.28.1555610799643;
        Thu, 18 Apr 2019 11:06:39 -0700 (PDT)
Received: from udknight.localhost ([59.57.228.71])
        by smtp.gmail.com with ESMTPSA id k1sm5172670pfc.83.2019.04.18.11.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 11:06:38 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id x3II0nFn004727;
        Fri, 19 Apr 2019 02:00:49 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id x3II0nxA004725;
        Fri, 19 Apr 2019 02:00:49 +0800
Date:   Fri, 19 Apr 2019 02:00:49 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: fix compile errors with older glibc
Message-ID: <20190418180049.GA4716@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Yonghong Song <yhs@fb.com>, "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190417174839.GA16679@udknight>
 <ecd56ebd-d19f-8834-9373-088ad7c9a725@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd56ebd-d19f-8834-9373-088ad7c9a725@fb.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 05:09:53AM +0000, Yonghong Song wrote:
> 
> 
> On 4/17/19 10:48 AM, Wang YanQing wrote:
> > The older glibc (for example, 2.23) doesn't handle __UAPI_DEF_*
> > in libc-compat.h properly, and it bring below compile errors:
> 
> I have an even old glibc 2.17 and it still works. Not sure
> why it failed here. Could you explain more?

We will meet these errors with the combination of some versions of kernel headers and
some versions of glibc headers.

After some research on the git history of glibc and kernel, I find the reason behind
the scene is a little complex:
There are some same definitions between glibc's netinet/in.h and kernel's linux/in6.h,
IPPROTO_HOPOPTS, etc.
These same definitions willn't bring trouble when we include both of them if kernel and
glibc coordinates with each other well, but the reality is the coordination is poor and
unsynchronous in history.

Kernel and glibc uses guard macros to detect whether need to export their definitions,
linux/in6.h includes libc-compat.h which will check the guard macro, _NETINET_IN_H, and
netinet/in.h includes bits/in.h which will check the guard macro, _UAPI_LINUX_IN6_H
(glibc-2.19~821 6c82a2f8d7c8e21e39237225c819f182ae438db3 "Coordinate IPv6 definitions for Linux and glibc"),

the problem is in the installation process of kernel headers, the "_UAPI" in _UAPI_LINUX_IN6_H
in linux/in6.h will be stripped due to commit 56c176c9cac9
("UAPI: strip the _UAPI prefix from header guards during header installation").

The good news is the glibc fix this the trouble by checking the guard macro, _LINUX_IN6_H, too.
(glibc c9bd40daaee18cf1d9824e4a7ebaebe321e0a5a8 "Bug 20214: Fix linux/in6.h and netinet/in.h sync.").

My environment still have this trouble:
lsb_release -a:
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.6 LTS
Release:	16.04
Codename:	xenial

dpkg -l | grep libc-dev:
ii  libc-dev-bin              2.23-0ubuntu11           amd64        GNU C Library: Development binaries
ii  linux-libc-dev:amd64      4.4.0-145.171            amd64        Linux Kernel Headers for development.


I will send out the v2 which I will change some words in changelog.

Thanks for review.
