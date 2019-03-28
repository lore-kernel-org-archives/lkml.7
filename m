Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B99C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808552173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aIhxUVfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfC1QwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:52:23 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40618 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1QwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:52:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id f22so8840620vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbl1SNk4PvheKZz5qsYVEhUXNVYtimdQQWOJdLLlLKw=;
        b=aIhxUVflmYcjVu2DzlplI3rw08mttvj8M2RWWI/spxGMr5ohzAQySOfMZ1Z9IkV8DN
         o4ryUCaRNgcCEIvMevrEh93osE0GAptpa6eZxxVaNUvw4VB/CpMOzMIMMK7eFga4NMmn
         ct4JR6xkp408qHR6LTyuutF38SnuiARMENAs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbl1SNk4PvheKZz5qsYVEhUXNVYtimdQQWOJdLLlLKw=;
        b=Uqn1exZQ64AZeFUDQmmBuaMGPPjHp7liojQnNisqBY5HlCT9gBuYhPE8CF1O6dFAEj
         6+PCptVHeAShki/ZylTLDXSPjIg5jsuMmPq43srOjMWjZTxI7vJdT0UBqpfqB1+YobzZ
         kEFB8NMfnQ0ogBw3r9oOe5fWKndHTvJw0oKM+xwgHXolMWcV5Hbi6mO7T5hUZ0zMX5y7
         1RUUU2w0YH6FVxkB5du1/wsR8K4DWdVULieurf3va7Da0kuhvQDrrjIiVFFh01Stc3lT
         B4z4z0v++phW4wUM+d53CPARAYUS4X+Fx2mCWpEkjf8Jw7+VPKvUpHmnMzMP3rVRVPUN
         6FEA==
X-Gm-Message-State: APjAAAW2qW3JfN4BZDMiHhim1d6ucHZ8T4WRcuUtBIwHRADMopSuqsSP
        ecuPE9oluJubpAnVd32s3yWvbP9/Gdo=
X-Google-Smtp-Source: APXvYqz/pc7kFay1esV2p+0GceC+075tFmn0M3BTHmB5v0S6/9ejSk+hziRGsbC+pV6PfFKOGh927g==
X-Received: by 2002:a67:dd0f:: with SMTP id y15mr14297382vsj.195.1553791941726;
        Thu, 28 Mar 2019 09:52:21 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 64sm7454116vkx.47.2019.03.28.09.52.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:52:20 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id t78so12562551vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:52:20 -0700 (PDT)
X-Received: by 2002:a67:6983:: with SMTP id e125mr25586428vsc.222.1553791940412;
 Thu, 28 Mar 2019 09:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190327145331.215360-1-joel@joelfernandes.org>
 <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
 <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com>
 <20190328023432.GA93275@google.com> <CAG48ez2bbSYpNHcC4oucx_AG=5y4K5pZfSOfN3mxGadJGpHuQQ@mail.gmail.com>
 <20190328143738.GA261521@google.com>
In-Reply-To: <20190328143738.GA261521@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 28 Mar 2019 09:52:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+CFmdPQd_u6=C6ew0Y-j6ihUN7yN1GpJO6V=x2_Q6kRA@mail.gmail.com>
Message-ID: <CAGXu5j+CFmdPQd_u6=C6ew0Y-j6ihUN7yN1GpJO6V=x2_Q6kRA@mail.gmail.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 7:37 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> Kees can you describe more the race you had in mind?

I just didn't see any barriers, so it seemed racey to me.

> Also note to the on looker, the original patch I sent is not wrong, that
> still applies and is correct. We are just discussing here any possible issues
> with the *existing* code.

Correct. And akpm has (correctly) taken this for -mm.

-- 
Kees Cook
