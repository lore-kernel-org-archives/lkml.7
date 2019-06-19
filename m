Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB64C31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961392084E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560965183;
	bh=N5PxLYnun4Xvz0BdjtwKbWDpQwtp22rQty5gxi4qc4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NAuot8RR+tC9OTyemJ5x9vgtsWLjBuUs2CjuU3AQZ4EyABAZERZCWtE0U57FivzwG
	 qwAIKGV6HVyo72tfO3T0SftNIacoFKuyDR0UIqGlyS/0Xxoy6hFsQgJC5Vhp4VjeTH
	 cgMWi0tgOk0T9YzbgpUEObs0E6uEH5Vzr/Elo/lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfFSR0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfFSR0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:26:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283C2206E0;
        Wed, 19 Jun 2019 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560965180;
        bh=N5PxLYnun4Xvz0BdjtwKbWDpQwtp22rQty5gxi4qc4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVr1wqN5LoMH34ghLuPi/5bKOuLBtzknSXH3BbpRGNKGCm1uUkSSp4fgZrPUuaMxX
         6I/Ka0fJKLGNa34KevOFjwlzME9A6RZG0/LZxACE1O5531XEMdmMtzNPAxcCL5RoSx
         Sl3op7HbS5N3KMXqt4nzeyn/FLaZ2hXNE8MjATls=
Date:   Wed, 19 Jun 2019 19:26:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] kobject: return -ENOSPC when add_uevent_var() fails
Message-ID: <20190619172618.GB24692@kroah.com>
References: <20190610210924.9514-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610210924.9514-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:09:24AM +0900, Masahiro Yamada wrote:
> This function never attempts to allocate memory, so returning -ENOMEM
> looks weird to me. The reason of the failure is there is no more space
> in the given kobj_uevent_env structure.
> 
> Let's change the error code to -ENOSPC.
> 
> This patch is safe since this function had never failed in reality.
> 
> The callers of this function put a fixed number of small strings into
> the buffer.
> 
> The buffer is defined to be large enough:
> 
>   #define UEVENT_NUM_ENVP                 32      /* number of env pointers */
>   #define UEVENT_BUFFER_SIZE              2048    /* buffer for the variables */
> 
> As you see WARN() in the error paths, any failure of this function is
> a software bug.
> 
> If such a case had ever happened before, you would have already seen
> a noisy back-trace, then you would have increased UEVENT_NUM_ENVP or
> UEVENT_BUFFER_SIZE.
> 
> Nobody has ever increased UEVENT_NUM_ENVP or UEVENT_BUFFER_SIZE since
> their addition, that is, this structure is always large enough.

That implies that we should just drop the WARN() entirely.  Especially
given that syzbot runs panic-on-warn, right?

How about doing both things at the same time?

thanks,

greg k-h
