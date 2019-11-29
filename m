Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12788C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 05:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF22F2158A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 05:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575007144;
	bh=LdL+vAnGuCkPxtGqeXP+W2h1ySZ6qmJlGZ5sylIKRn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ybhVS2noPdA9BWyElBVn3rlu7Mk0zzXJawNbYlrxWxcc5aijm5PScXdNTDb1VPNsy
	 8IvlTxn4yK0QgQpi6R2Pje4u0RxejN8jSBBzJeVaTFIUL2ZEVRp+IFAkT6EM3v9gVA
	 C6zKiEsGMrgXyoi5vpstfKvwj6H19HsXJqfw7tFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2F7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 00:59:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38089 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfK2F7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 00:59:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so33624365wro.5;
        Thu, 28 Nov 2019 21:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ioNIU7t6mZ0CnA/UswH5ZLUB0tSFVkLol+P/E37ea2E=;
        b=VbNftRLfkq+9fFUO+Wmb8bDi3lg7kjFMD6XtxSF3XbKOq0Cun49zMfskmHd19aqWvL
         Pe76PDwuElxFoD+rBsLV+VlhsiSMW1JwKtIG+KCbKIB3r+4adO9EfyD58HsIxVk6IKMW
         gsI8Glzni860A5uhiSsrr9YamZVIkAqJ14FrUqzig8hqdPul0AokanXBzGpJKZjqgiAs
         sNPdOg6IdYrhUVlUwDObV6QEEYh4NuMk4W9venA6Katm47Sm3MDygzECdb7b578w9dZL
         C1CDGtYNNuociSQKocmbTFRK8JIcUdG8hMCZOUsRIgEd/uzudH2cc5PI0ljcBiUxamra
         43sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ioNIU7t6mZ0CnA/UswH5ZLUB0tSFVkLol+P/E37ea2E=;
        b=EVKAEunA/clH/GguSfxDDLK59iGqSEdwyocFufJ3xSE/nOcy83gy0rlpUA0Ll0WccG
         HFv6VcsivHVbiBOU6kd5P/N5Xmdns/7nbcWl/OAKMVVtn84R8ow2l+zktUAvvQEDthi8
         NN4gPJWqlrI39NV0kzeDNEeEsP2SBNQDTnLTzMVLoW2dHlpSSd8dbNed2K29VVDoARz0
         4QcHe+LkWUBwXffkL6up/VloiU2JK4c/zeuqqX8WFaTfKleQw6tj+ZvDAbpTRH0moGr7
         aYq8IxzO0WysL+2xENFvMkwebkbsgbG9x5jM+9fC+uGB/uZS9YSVPvemzJ4bP2Ob6LQ0
         GAnw==
X-Gm-Message-State: APjAAAVbEwylfjT09txOuxtFnetjMuA+QyuKbcKqSvfwFRr5kvNM5w9G
        rn+xaQ0BEtRQ1NcRUltTQZc=
X-Google-Smtp-Source: APXvYqwx04TZmylORF0eK0Z3O5ziryGInmFkAEXtR7Rsm7CqNqQa3bUe6zbhvMmwYzyuPsrUkuoi7w==
X-Received: by 2002:adf:c786:: with SMTP id l6mr15450295wrg.45.1575007141351;
        Thu, 28 Nov 2019 21:59:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c72sm13219254wmd.11.2019.11.28.21.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 21:59:00 -0800 (PST)
Date:   Fri, 29 Nov 2019 06:58:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20191129055858.GA14825@gmail.com>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling, this has a merge with mainline to pick
> bpf stuff, and the build-test and container build tests were performed
> with two extra patches I cooked to fix libbpf issuers in some odd 32-bit
> arches and on generation of some bpf helpers headers that will hit
> mainline via the bpf/net trees.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 2ea352d5960ad469f5712cf3e293db97beac4e01:
> 
>   Merge remote-tracking branch 'torvalds/master' into perf/core (2019-11-26 11:06:19 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191128
> 
> for you to fetch changes up to 5172672da02e483d9b3c4d814c3482d0c8ffb1a6:
> 
>   perf script: Fix invalid LBR/binary mismatch error (2019-11-28 08:08:38 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf script:
> 
>   Adrian Hunter:
> 
>   - Fix brstackinsn for AUXTRACE.
> 
>   - Fix invalid LBR/binary mismatch error.
> 
> perf diff:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use llabs() with 64-bit values, fixing the build in some 32-bit
>     architectures.
> 
> perf pmu:
> 
>   Andi Kleen:
> 
>   - Use file system cache to optimize sysfs access.
> 
> x86:
> 
>   Adrian Hunter:
> 
>   - Add some more Intel instructions to the opcode map and to the perf
>     test entry:
> 
>       gf2p8affineinvqb, gf2p8affineqb, gf2p8mulb, v4fmaddps,
>       v4fmaddss, v4fnmaddps, v4fnmaddss, vaesdec, vaesdeclast, vaesenc,
>       vaesenclast, vcvtne2ps2bf16, vcvtneps2bf16, vdpbf16ps,
>       vgf2p8affineinvqb, vgf2p8affineqb, vgf2p8mulb, vp2intersectd,
>       vp2intersectq, vp4dpwssd, vp4dpwssds, vpclmulqdq, vpcompressb,
>       vpcompressw, vpdpbusd, vpdpbusds, vpdpwssd, vpdpwssds, vpexpandb,
>       vpexpandw, vpopcntb, vpopcntd, vpopcntq, vpopcntw, vpshldd, vpshldq,
>       vpshldvd, vpshldvq, vpshldvw, vpshldw, vpshrdd, vpshrdq, vpshrdvd,
>       vpshrdvq, vpshrdvw, vpshrdw, vpshufbitqmb.
> 
> perf affinity:
> 
>   Andi Kleen:
> 
>   - Add infrastructure to save/restore affinity
> 
> perf maps:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Merge 'struct maps' with 'struct map_groups', as there is a
>     1x1 relationship, simplifying code overal.
> 
> perf build:
> 
>   Jiri Olsa:
> 
>   - Allow to link with libbpf dynamicaly.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

>  66 files changed, 2230 insertions(+), 618 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
