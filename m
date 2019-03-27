Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AB7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44A721741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbkrirWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfC0SJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:09:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36640 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbfC0SI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so14205650ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Npju4SxUJ0U47mgz38YlqnxeUTW5KvOkHejF21m5IVY=;
        b=jbkrirWUy7gUKHB/nLOWdxyCTyJdtE65evx3Fea+5F7BPDzM+pLlNzRTTidrlkDkyo
         3wbkddSyt+sJ74dQkDCVC9bmMeFRsetnq+S5IOoKRU4Pb7EjN5ED+4fT4dHx65q3xOUX
         hQVmTy4mAip0bqlUmfGy8g+0iV5jwUD2bmhMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Npju4SxUJ0U47mgz38YlqnxeUTW5KvOkHejF21m5IVY=;
        b=P2iqSsmyozeUs0lWfPIsog7oLVnTOPpj/f+WGSshPDnxD2FnrOF5ePRyYDEInrJUuQ
         s6sONhNkSmjmQ81soalVyy+MJ5QFbdZ59rzgr4a+iZpSyzhQSELZdNDaEXCceVDnTuDJ
         qrXjGIO1Ph37e93xjb7VOqGWFOigh6vewZfBwdIiAlMHm3SjqJVo30YQuYbY/k/+fvfz
         AlTz0RfmS5qMbmaulQu/d+VErgSYLY0c5AykqvSW/2AigambWWZI3rickP+sVnRZf9li
         0omlHqCvHVcuhffzNM1j4n3B+oJ7p+HYXRyZV3hGFfLfpbCCWkuIj0my50X0ldqCz1+Y
         4TJw==
X-Gm-Message-State: APjAAAWLJo4iQGfB32D6oYEcfAWfFk/WceWfAeLi4+eEU8Yqk5EZA+md
        wBaeGV9Z8rEgKiavhe3kmsi5wDAiTsw=
X-Google-Smtp-Source: APXvYqyPylKNLSFcwACCumDS5cxlZPEp5z4ASw9Xz0SYCGjBEytsL6fFULJdNlTchbCJnjR759IcXA==
X-Received: by 2002:a2e:9457:: with SMTP id o23mr18937526ljh.71.1553710136582;
        Wed, 27 Mar 2019 11:08:56 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f25sm2162303lfc.46.2019.03.27.11.08.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 11:08:55 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id a6so12078991lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:08:55 -0700 (PDT)
X-Received: by 2002:ac2:569b:: with SMTP id 27mr20621267lfr.24.1553710135430;
 Wed, 27 Mar 2019 11:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190327180158.10245-1-sashal@kernel.org> <20190327180158.10245-116-sashal@kernel.org>
In-Reply-To: <20190327180158.10245-116-sashal@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 27 Mar 2019 11:08:43 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM751is4yQvH=2Ti=YJH7Za6SzswZQ5k7bEV4PnqQQmqQ@mail.gmail.com>
Message-ID: <CA+ASDXM751is4yQvH=2Ti=YJH7Za6SzswZQ5k7bEV4PnqQQmqQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.0 116/262] mwifiex: don't advertise IBSS
 features without FW support
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:05 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Brian Norris <briannorris@chromium.org>
>
> [ Upstream commit 6f21ab30469d670de620f758330aca9f3433f693 ]
>
> As it is, doing something like
>
>   # iw phy phy0 interface add foobar type ibss
>
> on a firmware that doesn't have ad-hoc support just yields failures of
> HostCmd_CMD_SET_BSS_MODE, which happened to return a '-1' error code
> (-EPERM? not really right...) and sometimes may even crash the firmware
> along the way.
>
> Let's parse the firmware capability flag while registering the wiphy, so
> we don't allow attempting IBSS at all, and we get a proper -EOPNOTSUPP
> from nl80211 instead.
>
> Fixes: e267e71e68ae ("mwifiex: Disable adhoc feature based on firmware capability")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

The backport seems valid and useful:

Reviewed-by: Brian Norris <briannorris@chromium.org>
