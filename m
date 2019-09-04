Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3329C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3DC2339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567580736;
	bh=aWGzlmrB2PaClSzN/gYS8Kh4U8lGww1SuEpNwf6L34c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zf81Ux6vXT2qThZieIuPoAAsBC86Xv9qaoI+ILITlUXrCQMD9FRxOAIyW4GgK3AjG
	 3Fc9QtqLGk11+ZWKXZf7wjRYh7bWLi6jCLDCOe9yZLjOpdk/ZSDjQwW9eMz02o80Jr
	 i2juhWoY6F7YqXXf1YRDU26CPD/hm4BU4J5+4ntU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfIDHFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDHFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:05:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10BF322CED;
        Wed,  4 Sep 2019 07:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567580734;
        bh=aWGzlmrB2PaClSzN/gYS8Kh4U8lGww1SuEpNwf6L34c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1XbJYryFvML98L8MUbUNMCVghNaG0ZM/kQjPjHdov2dtaPX33t3c4blqrFhgHB3X
         CsaSNk+frGyPriJzkBiC1Mb7JjcHzaMMqtcAdmekkZqnalpeTSQlfZCNSkRHwbW44n
         Shg6hZE5liVhGBAjhIHYqI5SEvhN10z5DxlY0rv4=
Date:   Wed, 4 Sep 2019 09:05:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Vishal Kulkarni <vishal@chelsio.com>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2] linux/kernel.h: add yesno(), onoff(),
 enableddisabled(), plural() helpers
Message-ID: <20190904070532.GB18791@kroah.com>
References: <20190903133731.2094-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903133731.2094-1-jani.nikula@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:37:30PM +0300, Jani Nikula wrote:
> The kernel has plenty of ternary operators to choose between constant
> strings, such as condition ? "yes" : "no", as well as value == 1 ? "" :
> "s":
> 
> $ git grep '? "yes" : "no"' | wc -l
> 258
> $ git grep '? "on" : "off"' | wc -l
> 204
> $ git grep '? "enabled" : "disabled"' | wc -l
> 196
> $ git grep '? "" : "s"' | wc -l
> 25
> 
> Additionally, there are some occurences of the same in reverse order,
> split to multiple lines, or otherwise not caught by the simple grep.
> 
> Add helpers to return the constant strings. Remove existing equivalent
> and conflicting functions in i915, cxgb4, and USB core. Further
> conversion can be done incrementally.
> 
> While the main goal here is to abstract recurring patterns, and slightly
> clean up the code base by not open coding the ternary operators, there
> are also some space savings to be had via better string constant
> pooling.
> 
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Vishal Kulkarni <vishal@chelsio.com>
> Cc: netdev@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_utils.h             | 15 -------------
>  .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 11 ----------
>  drivers/usb/core/config.c                     |  5 -----
>  drivers/usb/core/generic.c                    |  5 -----
>  include/linux/kernel.h                        | 21 +++++++++++++++++++
>  5 files changed, 21 insertions(+), 36 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
