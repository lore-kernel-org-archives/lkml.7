Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36FC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EA121721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfGEFWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 01:22:48 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:50290 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725983AbfGEFWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:22:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 85F32181D3368;
        Fri,  5 Jul 2019 05:22:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: level75_17cfce2dff144
X-Filterd-Recvd-Size: 2521
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Jul 2019 05:22:43 +0000 (UTC)
Message-ID: <5f4680cce78573ecfbbdc0dfca489710581b966f.camel@perches.com>
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Date:   Thu, 04 Jul 2019 22:22:41 -0700
In-Reply-To: <20190704220931.f1bd2462907901f9e7aca686@linux-foundation.org>
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
         <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
         <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
         <20190705131435.58c2be19@canb.auug.org.au>
         <20190704220931.f1bd2462907901f9e7aca686@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 22:09 -0700, Andrew Morton wrote:
> diff(1) doesn't seem to know how to handle a zero-length file.
> 
> y:/home/akpm> mkdir foo
> y:/home/akpm> cd foo
> y:/home/akpm/foo> touch x
> y:/home/akpm/foo> diff -uN x y
> y:/home/akpm/foo> date > x
> y:/home/akpm/foo> diff -uN x y
> --- x   2019-07-04 21:58:37.815028211 -0700
> +++ y   1969-12-31 16:00:00.000000000 -0800
> @@ -1 +0,0 @@
> -Thu Jul  4 21:58:37 PDT 2019
> 
> So when comparing a zero-length file with a non-existent file, diff
> produces no output.

Why use the -N option ?

$ diff --help
[...]
  -N, --new-file                  treat absent files as empty

otherwise

$ cd $(mktemp -d -p .)
$ touch x
$ diff -u x y
diff: y: No such file or directory


