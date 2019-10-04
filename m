Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A14C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2E2215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570180187;
	bh=hm9yY4mY6cAad/FS1LSmCGDFTnHyfdN4fmY2yqMQxzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SkG90dCmlygw3wMcDwxwitLQsVx0BTV8RKWFTrWdbcG3P+4PFzbB4GE9Ptio9w2LQ
	 3LHhnY5ojW5DHd/Bdbyur2mxghG1prMJ5s/jNpEeoTmcijgf+4Nj4XR/NDy1J50KxL
	 ICEYFD/O8t8c6UJZe3Xw6x5L3Gqt/N5uAdHqgurE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfJDJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDJJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:09:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D9A20867;
        Fri,  4 Oct 2019 09:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570180185;
        bh=hm9yY4mY6cAad/FS1LSmCGDFTnHyfdN4fmY2yqMQxzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=17pnv8iBTAvOsSYGBVxGkVbDS9BdRJYY/2WIpvd2Zd/zgyS36I7AxeKuUf0E0xSFQ
         UuqHUn4K0QMnphSNfcR2pPU/m4gk/bcCPKSN6Ys4XwiSoC4zRTH+g+CFGKqGhGZpbP
         3qMHJFANMlS43Mk0L9U0tJaOorP0MFBscY+E7cqI=
Date:   Fri, 4 Oct 2019 11:09:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Vishal Kulkarni <vishal@chelsio.com>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3] string-choice: add yesno(), onoff(),
 enableddisabled(), plural() helpers
Message-ID: <20191004090943.GA306905@kroah.com>
References: <8e697984-03b5-44f3-304e-42d303724eaa@rasmusvillemoes.dk>
 <20191001080739.18513-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001080739.18513-1-jani.nikula@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 11:07:39AM +0300, Jani Nikula wrote:
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
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # v1
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

For this version at least :)
