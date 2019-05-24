Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86724C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4360F21855
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558676925;
	bh=kniP8lflxSW1ANVxsn0GMckkxNtkCWcdW66EPGHbMf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ORcQLcppPG0HOrgTKyDukJ9K2Mtj312tvqUsr7nQygqKJg/N318iFsbekBJB5RviS
	 /ShcD6RiOr7s0D3RmIKmdaoPBEGtFsGQ6PyzkaOcq8L4sD6lkWtlk8V+PwLJAQOwrL
	 CFhbyCBkvSTPTkASShj9mUb6goCJsAweRl6+UOqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbfEXFso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387535AbfEXFso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:48:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8822168B;
        Fri, 24 May 2019 05:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558676922;
        bh=kniP8lflxSW1ANVxsn0GMckkxNtkCWcdW66EPGHbMf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmoqDFbULhReo/Tswv/s2XraivvkocEHWYQtFwk85z8Bd6iwt6cEFUb5iM8YSUfXz
         96/jVjz1HgBQgfSihTAFvrnxmvuvy+uyY5sklyZSUXYNdsUWBssHvOtcR6MDvwh9lM
         Ek7lQD9fk5PE5OEWKuqHpfE0y4KEflu+mjM/UQMw=
Date:   Fri, 24 May 2019 07:48:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v1 5/5] driver core: Add sync_state driver/bus callback
Message-ID: <20190524054840.GB31664@kroah.com>
References: <20190524010117.225219-1-saravanak@google.com>
 <20190524010117.225219-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524010117.225219-6-saravanak@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 06:01:16PM -0700, Saravana Kannan wrote:
> This sync_state driver/bus callback is called once all the consumers
> of a supplier have probed successfully.
> 
> This allows the supplier device's driver/bus to sync the supplier
> device's state to the software state with the guarantee that all the
> consumers are actively managing the resources provided by the supplier
> device.
> 
> To maintain backwards compatibility and ease transition from existing
> frameworks and resource cleanup schemes, late_initcall_sync is the
> earliest when the sync_state callback might be called.
> 
> There is no upper bound on the time by which the sync_state callback
> has to be called. This is because if a consumer device never probes,
> the supplier has to maintain its resources in the state left by the
> bootloader. For example, if the bootloader leaves the display
> backlight at a fixed voltage and the backlight driver is never probed,
> you don't want the backlight to ever be turned off after boot up.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/of/platform.c  |  9 +++++++++
>  include/linux/device.h | 19 +++++++++++++++++++
>  3 files changed, 67 insertions(+)

Also:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h
