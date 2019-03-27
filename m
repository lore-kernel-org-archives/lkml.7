Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC67C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B6F204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711461;
	bh=MK2lpkszqDm/5Wp7CLy6wDYR8tEK71fy4Wh7Uh3Xucc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ain2SeZ98wiG9X5gyoQAr/VyzAsNr/n40g1YnVUN1AeC8S2AXV6N0Ax0iwHTU6h2i
	 tmPrU02Hb7GzQKp5mNhgRooDwWUE6CEcUEV2DPJZaljR0/QDvpkAMJ+LMMyjQkhy0D
	 Ca/ekAiOciD/WZzHzyp213C8zRkkxPM2gAuvrp/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbfC0S0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404291AbfC0SZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:25:53 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88242217D9;
        Wed, 27 Mar 2019 18:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711153;
        bh=MK2lpkszqDm/5Wp7CLy6wDYR8tEK71fy4Wh7Uh3Xucc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3v+T3xsQVlrA8xPUqdbN4mKTr/ioFtqP8IjtKu1DHYZ31zWo+kHYJLXB5B1jpXyQ
         gnz24MJ+sn1qgjRsaOp1V3yNckLGIKJGlGaqZtu3qlotvQn9v2rtQeYpKkoe4Nk1C7
         zMjkIxwP/cQresXSHshXfAlpZ92MfwvzoGUFcZ7Q=
Date:   Wed, 27 Mar 2019 23:35:59 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging/android: use multiple futex wait queues
Message-ID: <20190327143559.GB14931@kroah.com>
References: <20190215074401.GA20188@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215074401.GA20188@behemoth.owl.eu.com.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 08:44:01AM +0100, Hugo Lefeuvre wrote:
> Use multiple per-offset wait queues instead of one big wait queue per
> region.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
> Changes in v2:
>   - dereference the it pointer instead of wait_queue (which is not set
>     yet) in handle_vsoc_cond_wait()


How did you test this change?  This code needs a lot of testing by
someone before I can take it.

thanks,

greg k-h
