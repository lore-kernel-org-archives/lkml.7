Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC50C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A6C2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDBVN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:13:56 -0400
Received: from semf08.mfg.siteprotect.com ([64.26.60.171]:59976 "EHLO
        semf08.mfg.siteprotect.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbfDBVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:13:56 -0400
Received: from smtpauth02.mfg.siteprotect.com ([64.26.60.151])
        by semf08.mfg.siteprotect.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <vince@deater.net>)
        id 1hBQj2-0003aP-0c; Tue, 02 Apr 2019 17:13:46 -0400
Received: from pianoman.cluster.toy (unknown [100.16.227.202])
        (Authenticated sender: vince@deater.net)
        by smtpauth02.mfg.siteprotect.com (Postfix) with ESMTPSA id 44Yhl843Stz2YQR5y;
        Tue,  2 Apr 2019 17:13:24 -0400 (EDT)
Date:   Tue, 2 Apr 2019 17:13:15 -0400 (EDT)
From:   Vince Weaver <vince@deater.net>
X-X-Sender: vince@pianoman.cluster.toy
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI
 latency
In-Reply-To: <20190402150936.GB23501@uranus>
Message-ID: <alpine.DEB.2.21.1904021709340.24692@pianoman.cluster.toy>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net> <20190402130302.GL12232@hirez.programming.kicks-ass.net> <20190402132200.GA23501@uranus> <alpine.DEB.2.21.1904021050090.15645@pianoman.cluster.toy>
 <20190402150936.GB23501@uranus>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: mfg.siteprotect.com; auth=pass smtp.auth=vince@deater.net smtp.mailfrom=<vince@deater.net>
X-Originating-IP: 64.26.60.151
X-portal.siteprotect.com-Domain: mfg.outbound
X-portal.siteprotect.com-Username: 64.26.60.150/31
Authentication-Results: mfg.siteprotect.com; auth=pass smtp.auth=64.26.60.150/31@mfg.outbound
X-portal.siteprotect.com-Outgoing-Class: ham
X-portal.siteprotect.com-Outgoing-Evidence: Combined (0.18)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5l7TvaSqPwF+PYCypkGUb8l602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO80kiOOXohirsWhwY064v2npeso7Ho1FT6opA0QnLMBdpVMzexAGJZ2+mPn7fP4I3bGQ
 T8H3NmQhNu2O3z+K3mZwnXeuRadH9eS/0qlAQIeNVTCxY3GOeQ66b90JBslLPIYZZS/DUBLA5nGN
 6cIn1z9sSeI2joq9+ZZE6ghVOZbTTcd1LQTPB4kZ4onMihMMZ7yZgsqocyZY4jxjE3qUu/6r1AV5
 UTHwbtCAXgD9KinxOsXa9bPF5P+TU1Hkgqx+i85wXGAwCBBM9Wuz7xpUTUsouBFVfnbvOnQHVZOr
 UVdzPmpotkU9W6DwXKJZEzKGAWFx656NU5IkTRH0Up7qB8Lzno4t3kssqrr3QsvSu8BVGE1lcStX
 Kcni7YkebcsPef+Bu4/uGdQrw1B0vCxVYoig1tMG8QVeXDZzT/jhEuU0j8ig1B0+mXiY/UNNvkZ/
 yQS8oWDbSKQ3tXcknJwLqWmW2UPE+vsQVOjHQoB8kKI5ymRHVNByG1DH5bgZMma1xh/iSK71nlwT
 kZ/FUjBxvQvLVJD2VTUQ+kGxg2Pv3GfZNme3cik5CexJz1ox3HYe0QjaC0seZkfC0iy+spcexjk7
 SHzg1GyOaFo+K3vVD2LSW+n8Hj6CJNEWfIqe3AMrex08L8pZyQFEYMQabfOl4IqgLgoO+53/F59y
 H4idlSUpteH5C3/pSoxYOXdzgcqBafjL6IM/NPtmtMb38N+gNB/lgTl6fJxyntEfhZCKje4ZwyYO
 nmpuMeHRjSmbB6RrUkSyszVtUeslVn8uY5bzuQsgr/U0flMcy2Vi/IcBgY4amwfEOQVUNYnWQ300
 Dp6cJDE37L8A/sfCSfmp70N6CAkwoGPe+nvh19VPEW3k7miLRGgHloEW8jEP1L/Rx27Xzwchkg0M
 Z+srqme4bODOIeI192hajk3XGfwdIadDRhTgGisIGxUJr7hu9AMHjQD/EXDMIS0tLJXIAOtcIzBo
 I6meQp3k9SVx0LF1z2PwQHAv6PNCU/yT9rVFGLmNNL3pin9QfQfyieJWOKWrOSedp3vvZ+cXa4SP
 MMsvIvQ05tn8jrZXLGyv7MvlzLexb6aw2S5U0vr8V4hpI7WP/cQxrEkAaRsc+wBG/EwBmU8ITizl
 ZuM7jUXIESohoO51xWmU8XetsAn+dGLdW9wFnbfnLqlCsHZa6ansnqA1PsylvLlEhieaPV2+qeEY
 bMldDm0nFGt17RWWL3HibWMuPdCMisXylIuYEMGLGYbBbBR3JTh3+HGJA0RGaAhm/MWtyZJn3DMa
 IL48SHdwBur7C9FrSAVwMG9k36g/7bjS2E6qjwtRGvsY2hs/S+9Z3xB10KGOcqjxugQ/FndyXRUg
 v2aA0ZQ=
X-Report-Abuse-To: spam@semfq01.mfg.siteprotect.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019, Cyrill Gorcunov wrote:

> You know, running fuzzer on p4 might worth in anycase. As to potential
> problems to fix -- i could try find some time slot for, still quite
> limited too 'cause of many other duties :(


Well I fired up the Pentium 4
	/dev/sda1 has gone 1457 days without being checked

and eventually got it up to date (running "git pull" in a 5-year old Linux 
tree plus running "apt-get dist-upgrade" at the same time was maybe a 
mistake on a system with 1GB of RAM).

Anyway I have it fuzzing current git and surprisingly while it's hit a few 
WARNINGs and some NMI dazed+confused messages it hasn't actually crashed 
yet.  Not sure if I want to let it fuzz overnight if I'm not here though.

Shame on Intel though for not providing perf JSON files for the 
Pentium 4 event names.

Vince
