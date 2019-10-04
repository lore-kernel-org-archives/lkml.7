Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A43C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8335F222C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570203521;
	bh=ahSmtqyT5HnuQSk9ikHwqOk8+VCiDL3Y5UaVL5kUMzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AcNRIJbP1FAp5Fno5oSSs8/+1If/GNMvm1rfUIy73oTYWrCIvTKftpKKI7GZ/G5qf
	 5MDXKiBkA2WEp0RWTPkrmAjApEajTIMsyLl7PdVEMUXMUZYE5VQH1XKghIVVIfSrJL
	 rVGKTAjlPM1XZ/tAYISuonGMQOLsrYLAlGiFYhAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbfJDPil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbfJDPik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:38:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B900320830;
        Fri,  4 Oct 2019 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570203520;
        bh=ahSmtqyT5HnuQSk9ikHwqOk8+VCiDL3Y5UaVL5kUMzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzKa8mM0FZqiUyspB6CxpZtt8XOp77CL+qpe6ASmOzB51y0fmy+BgY6MoSH66WQt0
         ZRpyVRV5fCo4eD/0i3eFQ1NAx9v3ZtDI0CErJYm/4XgRK/wehmrDuV3KojPcUrowuY
         ZJsgDjFRoeryjlqbxIkfVAX2752IXG8+sJICst/g=
Date:   Fri, 4 Oct 2019 17:38:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [char-misc for v4.5-rc2 2/2 V2] mei: avoid FW version request on
 Ibex Peak and earlier
Message-ID: <20191004153837.GA826718@kroah.com>
References: <20191004181722.31374-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004181722.31374-1-tomas.winkler@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 09:17:22PM +0300, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> The fixed MKHI client on PCH 6 gen platforms
> does not support fw version retrieval.
> The error is not fatal, but it fills up the kernel logs and
> slows down the driver start.
> This patch disables requesting FW version on GEN6 and earlier platforms.
> 
> Fixes warning:
> [   15.964298] mei mei::55213584-9a29-4916-badf-0fb7ed682aeb:01: Could not read FW version
> [   15.964301] mei mei::55213584-9a29-4916-badf-0fb7ed682aeb:01: version command failed -5
> 
> Cc: <stable@vger.kernel.org> +v4.18
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2: Drop offending debug message

s/offending/unneeded/ :)

