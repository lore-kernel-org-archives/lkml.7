Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1592C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9538420840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565676345;
	bh=3uzo3mQSzc78ZoKZlKPkT2B9slgeag95jiTjsCYmpaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oC69x+TJixWxSLjqwJk6pNwOSsBEK7OJ/ZWYPXUnlgejvX2CnKX/dXfngNyrAq8zS
	 isxj3qq27bRe22ODaKUN5Zl6K3UgwVwWoaMW+365zEhdpP9CCaL+dqZ5JuOSeg8rBd
	 YmEm5xaE7PNjujT5V/Ztl/6A75Znuls06gMk88bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfHMGFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfHMGFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:05:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D64AE206C2;
        Tue, 13 Aug 2019 06:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565676342;
        bh=3uzo3mQSzc78ZoKZlKPkT2B9slgeag95jiTjsCYmpaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BY1UtaM6n6FcoS/iA1XdjC21fMDu+9Wxt4sbmhraEEStUVvaFlmnfinXcD0BEoy8b
         pFQgZoiO82x5vt5JeCA5OLDzgJ8Rn8MgRIeCoFTNbrReVvZCAtCPRUeRufmmvXZ1oi
         xariAfItaUFM41pVrfLpgveD55w1synbGRWF2ctc=
Date:   Tue, 13 Aug 2019 08:05:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        kbuild test robot <lkp@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] driver/core: Fix build error when SRCU and lockdep
 disabled
Message-ID: <20190813060540.GE6670@kroah.com>
References: <20190812214918.101756-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812214918.101756-1-joel@joelfernandes.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 05:49:17PM -0400, Joel Fernandes (Google) wrote:
> Check if lockdep lock checking is disabled. If so, then do not define
> device_links_read_lock_held(). It is used only from places where lockdep
> checking is enabled.
> 
> Also fix a bug where I was not checking dep_map. Previously, I did not
> test !SRCU configs so this got missed. Now it is sorted.
> 
> Link: https://lore.kernel.org/lkml/201908080026.WSAFx14k%25lkp@intel.com/
> Fixes: c9e4d3a2fee8 ("acpi: Use built-in RCU list checking for acpi_ioremaps list")
>  (Based on RCU's dev branch)
> 
> Cc: kernel-team@android.com
> Cc: kbuild test robot <lkp@intel.com>,
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> Cc: Josh Triplett <josh@joshtriplett.org>,
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
> Cc: linux-doc@vger.kernel.org,
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>,
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
> Cc: rcu@vger.kernel.org,
> Cc: Steven Rostedt <rostedt@goodmis.org>,
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Nit, drop those blank lines above, should all be in one big "block">

> ---
>  drivers/base/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 32cf83d1c744..c22271577c84 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -97,10 +97,12 @@ void device_links_read_unlock(int not_used)
>  	up_read(&device_links_lock);
>  }
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>  int device_links_read_lock_held(void)
>  {
> -	return lock_is_held(&device_links_lock);
> +	return lock_is_held(&(device_links_lock.dep_map));
>  }
> +#endif

I don't know what the original code looks like here, but I'm guessing
that some .h file will need to be fixed up as you are just preventing
this function from ever being present without that option enabled?

thanks,

greg k-h
