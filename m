Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B4C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073062083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559852926;
	bh=7dtJJy+tpf1euG0sliaeXpcZWtPy4t0cTCPj40HG3Gc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nifaKanpzAHx68lGmIU1/HAkwphsQBsd82OFEr94EbFqOeQ7+74F4xzP7uQfRA3Ir
	 qQqlnLHUVff2g+BilQwmKqrPbu2V0/yyj5cz0koPeU8deTXSEgytJCYX9iKjj1ad6i
	 XZ0vRP7lMqqSFTbWV8yi/xBsrbpKK827wz6wjYI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFFU2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfFFU2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:28:43 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2369B2083E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 20:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559852922;
        bh=7dtJJy+tpf1euG0sliaeXpcZWtPy4t0cTCPj40HG3Gc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t2yJVjGScNVAceTq64NgeNXeja0FCFjw2J41UevfqpsJ6YUmmYc3K+axFdZgrqoNG
         C2AFooBLHsfBQPFkZFLDhZOpkV8pWCqBrBk+Gm5E0fJSf8nVZ02y7HDywrc4PNgA0e
         TOjlgx5CqdRDt/Fp31naUp8cvXov8xmEnxZSVXlM=
Received: by mail-wr1-f52.google.com with SMTP id c2so3743675wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:28:42 -0700 (PDT)
X-Gm-Message-State: APjAAAVze56tCOsRmFyf5FhsJ6N1tFqUust/kDZMX4vLDFVwomhCrjOJ
        TMkyxaMKSb+p6KScc6bshKeXHKGfIbU6gircnFHb0A==
X-Google-Smtp-Source: APXvYqx3f5u5Y/rrwHdW2awhxgUt4xQ4wEw0oHwPvy7YsU0l9vHaF//oE/ev6LAssDbkzIcjGWy/PjsLduMkPyZyoyU=
X-Received: by 2002:adf:f2c8:: with SMTP id d8mr4520549wrp.221.1559852920790;
 Thu, 06 Jun 2019 13:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-12-yu-cheng.yu@intel.com>
In-Reply-To: <20190606200926.4029-12-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 13:28:29 -0700
X-Gmail-Original-Message-ID: <CALCETrXWehe=s4i+VkjxJBLh2AVWRioybpY0nbEWXZjvY_rFeQ@mail.gmail.com>
Message-ID: <CALCETrXWehe=s4i+VkjxJBLh2AVWRioybpY0nbEWXZjvY_rFeQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/14] x86/vsyscall/64: Add ENDBR64 to vsyscall entry points
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
> Add ENDBR64 to vsyscall entry points.

I'm still okay with this patch, but this is rather silly.  If anyone
actually executes this code, they're doing it wrong.

--Andy
