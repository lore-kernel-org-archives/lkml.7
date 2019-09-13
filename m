Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE32FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C2E20692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568414035;
	bh=cjHWd/DP/ktp4XlsM94VTm3zAuEBIhGetjG0yqa3Vpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HThKBPTtY0OE7tdLidxdI0Ry3d4XxbJSMA0Amua2F/1dqq6TjdDcyGoz6uj7Rne5V
	 /HvNgHyaoj1f2o99UX4Rgjm6hNQsTPrere/XXYy5Ct6tY2mtf5ZFxsiDXI4OakN8qj
	 7GBkznUqIzXv+OKkVirzS5JHz+kpE6V2ukwEO0XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404107AbfIMWdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404024AbfIMWdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:33:54 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8641020692
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568414033;
        bh=cjHWd/DP/ktp4XlsM94VTm3zAuEBIhGetjG0yqa3Vpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Shx+YhqmnYQhvRxpDQzXq2LKpo2FsVCT+XFmPwhhAX+tQmtCGIYXSfUWMUztzps72
         ouPOTWKeZK8oS62uraJ5Qz3ywUvgW3NLvFpjWqyEPf2+UL5FgkKqgupinuUXN8HvLv
         oFD88zu2HhTcI+fVcDzei5WGMIebaN/wultrawDo=
Received: by mail-wm1-f53.google.com with SMTP id g207so4213758wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:33:53 -0700 (PDT)
X-Gm-Message-State: APjAAAWVafmWyk4el4xF9jchFF0sIUuSbb2ioyZX42EOBl+neD0SrCwo
        v/SVylcGbA6oBPaYJXh3s6iipVkHp1E9FMKCfueM4A==
X-Google-Smtp-Source: APXvYqy9QAudp9O1l3JDGJFrkseEYt0y6LJl89z3ULzFHS1HQQrA3UVVBRPBBAoSKdW9dWWxIwhkRprKBm9C2FfD1xI=
X-Received: by 2002:a1c:5f0b:: with SMTP id t11mr5096545wmb.76.1568414032091;
 Fri, 13 Sep 2019 15:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190913210018.125266-2-samitolvanen@google.com>
In-Reply-To: <20190913210018.125266-2-samitolvanen@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Sep 2019 15:33:40 -0700
X-Gmail-Original-Message-ID: <CALCETrXDRY_q+-C24qZd3FNMLS2W8yCBOSMOHaA7jiVD-ayVNQ@mail.gmail.com>
Message-ID: <CALCETrXDRY_q+-C24qZd3FNMLS2W8yCBOSMOHaA7jiVD-ayVNQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: use the correct function type in SYSCALL_DEFINE0
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 2:00 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Although a syscall defined using SYSCALL_DEFINE0 doesn't accept
> parameters, use the correct function type to avoid type mismatches
> with Control-Flow Integrity (CFI) checking.

Acked-by: Andy Lutomirski <luto@kernel.org>
