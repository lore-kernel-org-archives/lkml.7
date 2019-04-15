Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1D220818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UXhV7X7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfDOW2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:28:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34379 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:28:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id h5so11422402lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s20Xe9TqthSSxxnIZaJBgutBEZrWVbxrjTBZdaMm8/8=;
        b=UXhV7X7nDpnM+5Na0NpJHkOvBAqkeme2hBUFXWhFFF0RCLMjpMEVz3EynjiNZGyxvB
         r8LNVYSbfYcXIBgcML34j6AaNzPRDCP7xf4WxO2q/NJg3VBFFbAFWXni6Ry5ZZXFSf1f
         kNNlQBqxGT3mbHs8nvZUOOCCX8fdArHz8yKk3P8eVtuHpfXS+bDa1J846GnyY4bSFIkR
         rLaq/GU6G3Lb2HhK27XDze/pGnedvL7XQZIYONeQaVb+G5QQq/lf53Ljg4FHWI1wAlKo
         GekCpPaybaNqo76kJ1JEcLz+mjF+wQUlEPhNUWKawJsJAp5wUCkTKe4v5vLtcMsG8h0W
         kbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s20Xe9TqthSSxxnIZaJBgutBEZrWVbxrjTBZdaMm8/8=;
        b=fTE/9PvNsOWxKG3VxcdQIyJu4kMmFzFg8jnVfiauKo+QO+UbVDzgJTw7ZPBqRM+U2H
         J7Vtg1KXCDW+eKUuFczN5FnbT02CUGA38tK6q+3TCiv5oYh0Hz0rYdFQrkqTqEL2u1p1
         Bn8b5bJa5a39QrhQPiQcLAUFg3K1GG3qZHFBtodGZ7atBAnRk1GFjgdAiiag/XN0jMB0
         sew68vzhqQAVaIWzUK/yckiucR0GsdHNcmwhIrnxszPiK78PustNCLnoCotJYhuVymM3
         DzqB4J90ubXjUZhsUDGzDSJSCVIFSf5dAtdi9g7ZYOrX45T9jURmHXNrLXAZBxjDI3VL
         yXXw==
X-Gm-Message-State: APjAAAU02F6fpm6vyKeMI0LBx+ckHBJAfIKy6KHWi0ENaKltJ5D/WdQ2
        3PfJdLjkuA4hEIGa9F3xCJOGtOV1YZhz4iNl7MXW
X-Google-Smtp-Source: APXvYqxfjWHwQNTQFXVPwpdwo1HnLnZDYeWQGiOC8z5hp4uowYaI5sd1wbC/A8ZeyBWkoKgzTne5t7ssQOLhYT9YLXM=
X-Received: by 2002:ac2:4148:: with SMTP id c8mr41790641lfi.2.1555367300325;
 Mon, 15 Apr 2019 15:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190410091420.23987-1-omosnace@redhat.com> <20190410091420.23987-2-omosnace@redhat.com>
In-Reply-To: <20190410091420.23987-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Apr 2019 18:28:09 -0400
Message-ID: <CAHC9VhSMiMnBK=N97LgD=mCS1BNVDjoHToPYm3DPBcw+trsr6g@mail.gmail.com>
Subject: Re: [PATCH ghak10 v8 1/2] timekeeping: Audit clock adjustments
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-audit@redhat.com, Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 5:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Emit an audit record whenever the system clock is changed (i.e. shifted
> by a non-zero offset) by a syscall from userspace. The syscalls than can
> (at the time of writing) trigger such record are:
>   - settimeofday(2), stime(2), clock_settime(2) -- via
>     do_settimeofday64()
>   - adjtimex(2), clock_adjtime(2) -- via do_adjtimex()
>
> The new records have type AUDIT_TIME_INJOFFSET and contain the following
> fields:
>   - sec -- the 'seconds' part of the offset
>   - nsec -- the 'nanoseconds' part of the offset
>
> Example record (time was shifted backwards by ~15.875 seconds):
>
> type=TIME_INJOFFSET msg=audit(1530616049.652:13): sec=-16 nsec=124887145
>
> The records of this type will be associated with the corresponding
> syscall records.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/audit.h      | 14 ++++++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           |  6 ++++++
>  kernel/time/timekeeping.c  |  6 ++++++
>  4 files changed, 27 insertions(+)

Merged into audit/next, thanks everyone.

Ondrej, please watch your line lengths, I had to break up another line
greater than 80 chars.

-- 
paul moore
www.paul-moore.com
