Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526E6C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271DD2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559852740;
	bh=DKhd22QxqBDA4KYT2cEZlqhYj/PumKxUwK/zMkdDIFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=APqp7FofIx4TAfVIMkcAzyV/fV9biwNviYDKKo58ZIJKmJbKjrQdWxl8qo7ek1L7g
	 m9LBlmLueW35hNWKCu6TYjjPq+MVp+m/XKZGmjhUOswxJLsEoMFfd6fp5rbqE7TGrC
	 RYbPHgYHTWGWCfdgT+ysVukNPh4ba8OC71P6r2/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFFUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfFFUZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:25:37 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 324CA21479
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559852736;
        bh=DKhd22QxqBDA4KYT2cEZlqhYj/PumKxUwK/zMkdDIFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G0CVtpqeJtYYi6ZVaBFtvvXvsAJWteRf+Hozt3FdnG/AgCfB13Ad6uwZ0nLaLABj2
         Ly/i51Lug8kHTeKHt0sOEyAEaFq4S0eb4MTCLoZsHoQIebL3w5+kFZd//YQMmGUiXU
         4WkplG7Ari2A2w0tOQzaO/RkIK0JrHzIWXgmzQyU=
Received: by mail-wr1-f47.google.com with SMTP id e16so3766652wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:25:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWfA269NKfVTK08uuvegUeuCfJnnLcu/wLLs+QrOj/ThXzwn86v
        J2hte0EW+UlL8dCCV9qcznrm4Fn6s1I1nGLfldaMhg==
X-Google-Smtp-Source: APXvYqyiVg/qughgzdZroKp3BApJXIniApUU+56AdTnkB3j3XqqcAGvsvRwbxtgUhLtiuuaGb5s/W6OHjaS71guGj14=
X-Received: by 2002:adf:f2c8:: with SMTP id d8mr4513620wrp.221.1559852734693;
 Thu, 06 Jun 2019 13:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-11-yu-cheng.yu@intel.com>
In-Reply-To: <20190606200926.4029-11-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 13:25:23 -0700
X-Gmail-Original-Message-ID: <CALCETrUZ9vu8+9WrMcMdV6DvmB3nRQmLjd5_uDk8x1NMQUtPpg@mail.gmail.com>
Message-ID: <CALCETrUZ9vu8+9WrMcMdV6DvmB3nRQmLjd5_uDk8x1NMQUtPpg@mail.gmail.com>
Subject: Re: [PATCH v7 10/14] x86/vdso/32: Add ENDBR32 to __kernel_vsyscall
 entry point
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 1:17 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> Add ENDBR32 to __kernel_vsyscall entry point.
>

Acked-by: Andy Lutomirski <luto@kernel.org>

However, you forgot your own Signed-off-by.

> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>


--Andy
