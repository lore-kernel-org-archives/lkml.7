Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF4C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5319E2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbfGHNEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:04:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39323 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfGHNEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:04:32 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkTJi-0000A0-Ui; Mon, 08 Jul 2019 15:04:27 +0200
Date:   Mon, 8 Jul 2019 15:04:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>
cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2] time: Validate the usec before covert to nsec in
 do_adjtimex
In-Reply-To: <1562582568-129891-1-git-send-email-zhangxiaoxu5@huawei.com>
Message-ID: <alpine.DEB.2.21.1907081458400.1926@nanos.tec.linutronix.de>
References: <1562582568-129891-1-git-send-email-zhangxiaoxu5@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, ZhangXiaoxu wrote:

> When covert the usec to nsec, it will multiple 1000, it maybe
> overflow and lead an undefined behavior.
> 
> For example, users may input an negative tv_usec values when
> call adjtimex syscall, then multiple 1000 maybe overflow it
> to a positive and legal number.
> 
> So, we should validate the usec before coverted it to nsec.

Looking deeper before applying it. That change is wrong for two reasons:

 1) The value is already validated in timekeeping_validate_timex()

 2) The tv_usec value can legitimately be >= USEC_PER_SEC if the ADJ_NANO
    mode bit is set. See timekeeping_validate_timex() and the code you
    actually modified:

>  	if (txc->modes & ADJ_SETOFFSET) {
>  		struct timespec64 delta;
> +
> +		if (txc->time.tv_usec < 0 || txc->time.tv_usec >= USEC_PER_SEC)
> +			return -EINVAL;
>  		delta.tv_sec  = txc->time.tv_sec;
>  		delta.tv_nsec = txc->time.tv_usec;
>  		if (!(txc->modes & ADJ_NANO))
			delta.tv_nsec *= 1000;

    	The multiplication is conditional ....

Thanks,

	tglx


