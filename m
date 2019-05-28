Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70412C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B34B20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559082309;
	bh=Eib3HSk01dW5l0nHav6C98yfNqkElQM63OIgSVsyDYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=BacMoQeO9+nCxy3oUGZWSMpZpqmsk/qoTxnYzgz8qDHwX4qs8oNi2JXypV0BGhhia
	 uBc6lE4MaL35zw1xWIoRwt8Sz+YHfJwMSzjWSoEVElR0ckC/7SCMmLII0eya5GVbMt
	 P0I01mb6sgZYcuOsgngcYOQNK79X0stMVm2GS/Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfE1WZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1WZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:25:08 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E8D208CB;
        Tue, 28 May 2019 22:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559082307;
        bh=Eib3HSk01dW5l0nHav6C98yfNqkElQM63OIgSVsyDYc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=c/QHmgslhOjg1F4akUy/FwjSWVsmaBUFZ/BfEA97p3nHOO5Cf71sOBa491w4H8FRq
         P7rRxYDlzh8WZ4BeUqevnaD3FrHoVes4emX0d9KMgdbJ8EwHaYDaMtHpJ+aNQBS0w+
         a4c7x5kBmZa/bRW+BXBKoELGtwcJSIqUUPG5kQCI=
Date:   Wed, 29 May 2019 00:25:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, pmladek@suse.com, tglx@linutronix.de
Subject: Re: [PATCH] stacktrace: fix CONFIG_ARCH_STACKWALK stack_trace_save_tsk_reliable
 return
In-Reply-To: <20190517185117.24642-1-joe.lawrence@redhat.com>
Message-ID: <nycvar.YFH.7.76.1905290023400.1962@cbobk.fhfr.pm>
References: <20190517185117.24642-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019, Joe Lawrence wrote:

> Miroslav reported that the livepatch self-tests were failing,
> specifically a case in which the consistency model ensures that we do
> not patch a current executing function, "TEST: busy target module".
> 
> Recent renovations to stack_trace_save_tsk_reliable() left it returning
> only an -ERRNO success indication in some configuration combinations:
> 
>   klp_check_stack()
>     ret = stack_trace_save_tsk_reliable()
>       #ifdef CONFIG_ARCH_STACKWALK && CONFIG_HAVE_RELIABLE_STACKTRACE
>         stack_trace_save_tsk_reliable()
>           ret = arch_stack_walk_reliable()
>             return 0
>             return -EINVAL
>           ...
>           return ret;
>     ...
>     if (ret < 0)
>       /* stack_trace_save_tsk_reliable error */
>     nr_entries = ret;                               << 0
> 
> Previously (and currently for !CONFIG_ARCH_STACKWALK &&
> CONFIG_HAVE_RELIABLE_STACKTRACE) stack_trace_save_tsk_reliable()
> returned the number of entries that it consumed in the passed storage
> array.
> 
> In the case of the above config and trace, be sure to return the
> stacktrace_cookie.len on stack_trace_save_tsk_reliable() success.
> 
> Fixes: 25e39e32b0a3f ("livepatch: Simplify stack trace retrieval")
> Reported-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Jiri Kosina <jkosina@suse.cz>

IMHO this should go in ASAP. Sorry for the delay,

-- 
Jiri Kosina
SUSE Labs

