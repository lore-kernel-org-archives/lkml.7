Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC794C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9187720854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QwmUPGvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfDOW2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:28:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37645 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:28:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so17215644ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMaZXz6By2iwHhD+stE1YvyaSWn2hUD/riIBFiDiwhM=;
        b=QwmUPGvCRq2OmhkQ940+xQYKb/cXiSgEwXGW3FoGvYuiwD95NJcAqs4INVriK5csyu
         NennEoc3GUV4a65ySI18YEGDNy6rOH0Gj7R49/FkMcaLPDYrUxEZRv0HcO6kuz5zMCC3
         /3ZK27MA3lYPMYCdH5iw4/y6wy23GkdHDWPAAinPRI+kNqZx9zzq1VwjP1de0alqdCTU
         O3/aLV0R/Zbtk7N1EPgDbl86GnyavkRZcc1lDqaQylCN39C2CIkkO/b82sqXG8ClNahe
         F52GPE5lrU3thrUo6OjtjEtA+6SaAI8fF4f5PtpRMBxZpqTzsnk+E8NkAUKtV3iRCcjK
         Hh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMaZXz6By2iwHhD+stE1YvyaSWn2hUD/riIBFiDiwhM=;
        b=q35R1LgmhKiu4KepOUauIOq6nwPqXa9CXO6wWOJjyAAASvquNT55Z+5ysrwiM/OfoZ
         QlokcIsOuZqUJswwOXi7L9SefnvtGc0/ROlh9xo7OQFVB4gyH/M3MaYRwzygZt2qHfHP
         t/FYnljwljN0333S0SVka3cBjOcRUeQO/KUvTTTpbUvbbo5axplh0x4HhE6FkJvAZOK8
         nOUcQJ4HrUuYC9bNMlfacSGDx7WmbPUW+nCH1p/XqdnvH3PMxBrKZzBKDlvsCH2vj3ES
         B9T3ru1ZfYl1Rs1CwOLa0dOSwesgcgJIR5kHUcUHIWchnpDzNCsTxi9nHbR16PpNi0gR
         zWtA==
X-Gm-Message-State: APjAAAXkCE3+B7GmTmJN0LTZrLwVZVibgtLybBrIJX5HfAGp64cgWfEJ
        kF7TOpZPYmZubuz4Fks2SVSbkVaQI701YxR2IKzJ
X-Google-Smtp-Source: APXvYqxSZOc86TDMYVpE6RLo+Nvf4HftxPZCqGU+yCU0kBEs/ecAmrjlpFQ2XF3WZgerQdsGoDEe28oCSfCjAxhs/tA=
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr19613180ljk.131.1555367328963;
 Mon, 15 Apr 2019 15:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190410091420.23987-1-omosnace@redhat.com> <20190410091420.23987-3-omosnace@redhat.com>
In-Reply-To: <20190410091420.23987-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Apr 2019 18:28:37 -0400
Message-ID: <CAHC9VhRmfGmYSQ0h1HosJ9OWZz1M69VhMrJopJuNdtoKynikcQ@mail.gmail.com>
Subject: Re: [PATCH ghak10 v8 2/2] ntp: Audit NTP parameters adjustment
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
> Emit an audit record every time selected NTP parameters are modified
> from userspace (via adjtimex(2) or clock_adjtime(2)). These parameters
> may be used to indirectly change system clock, and thus their
> modifications should be audited.
>
> Such events will now generate records of type AUDIT_TIME_ADJNTPVAL
> containing the following fields:
>   - op -- which value was adjusted:
>     - offset -- corresponding to the time_offset variable
>     - freq   -- corresponding to the time_freq variable
>     - status -- corresponding to the time_status variable
>     - adjust -- corresponding to the time_adjust variable
>     - tick   -- corresponding to the tick_usec variable
>     - tai    -- corresponding to the timekeeping's TAI offset
>   - old -- the old value
>   - new -- the new value
>
> Example records:
>
> type=TIME_ADJNTPVAL msg=audit(1530616044.507:7): op=status old=64 new=8256
> type=TIME_ADJNTPVAL msg=audit(1530616044.511:11): op=freq old=0 new=49180377088000
>
> The records of this type will be associated with the corresponding
> syscall records.
>
> An overview of parameter changes that can be done via do_adjtimex()
> (based on information from Miroslav Lichvar) and whether they are
> audited:
>   __timekeeping_set_tai_offset() -- sets the offset from the
>                                     International Atomic Time
>                                     (AUDITED)
>   NTP variables:
>     time_offset -- can adjust the clock by up to 0.5 seconds per call
>                    and also speed it up or slow down by up to about
>                    0.05% (43 seconds per day) (AUDITED)
>     time_freq -- can speed up or slow down by up to about 0.05%
>                  (AUDITED)
>     time_status -- can insert/delete leap seconds and it also enables/
>                    disables synchronization of the hardware real-time
>                    clock (AUDITED)
>     time_maxerror, time_esterror -- change error estimates used to
>                                     inform userspace applications
>                                     (NOT AUDITED)
>     time_constant -- controls the speed of the clock adjustments that
>                      are made when time_offset is set (NOT AUDITED)
>     time_adjust -- can temporarily speed up or slow down the clock by up
>                    to 0.05% (AUDITED)
>     tick_usec -- a more extreme version of time_freq; can speed up or
>                  slow down the clock by up to 10% (AUDITED)
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/audit.h      | 61 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           | 22 ++++++++++++++
>  kernel/time/ntp.c          | 22 ++++++++++++--
>  kernel/time/ntp_internal.h |  4 ++-
>  kernel/time/timekeeping.c  |  7 ++++-
>  6 files changed, 112 insertions(+), 5 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
