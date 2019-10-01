Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B662C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160AB21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569922734;
	bh=6+oWkvMUsGtq0GBx5dh3yc1sqkoRm9y7wM7hepbH7/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P1PaTt4+J52s3zXV9KyRnM8bZe2e35g/0DZ4jjY8XWxY7cvMl5zN5Z/OpCq9CuSpe
	 uqJnHibNY7zfncrouYo6FACfrD2zwRqrivDNylkBK+2wllzJ9Im41y7wqJDJmqxw4/
	 TopUOpDUM2+Wv3F3WuhYgnmKrsWqWIyfqt6+bQpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfJAJix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbfJAJix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:38:53 -0400
Received: from localhost (unknown [89.205.130.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7437C215EA;
        Tue,  1 Oct 2019 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569922732;
        bh=6+oWkvMUsGtq0GBx5dh3yc1sqkoRm9y7wM7hepbH7/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvezovxKSITFw09Qy95zXh7z4nBFmvmR0686U2aVGc2JofqddohPlueOG+Y7U/oWd
         hfpgYSoPcsoYS0HQJQxXcqejb4AJtIh7RrJRf0scdFBZfw2uO37pvc5uWN9whs0WXN
         0/SBEvLLq/2Xbw/Hirahx8Voes4/znSwZPcPYuck=
Date:   Tue, 1 Oct 2019 11:38:49 +0200
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
Message-ID: <20191001093849.GA2945163@kroah.com>
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

As this is a totally different version, please drop my reviewed-by as
that's really not true here :(

