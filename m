Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB83EC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C41214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573102473;
	bh=Pl4qu8kzGZ9lvi3i1gt+uVv/Z5lppHLT30c0XPXoRw0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Oa+0sW0n3q60ZYc76dK4wgQAlCN9j3cxWnb34KD48yqJ+pS3atOQpBv8iJLsfcP4R
	 aak9IokkHO/5pIHoYayn51dogDrHLoVtg2rmAEXGhnQFSllQooOOeO/DkU0S0w+R8m
	 ydIK/Tem7NELb9SRk9nGGJIWRa4nqqMdlP6ub+yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbfKGEyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:54:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfKGEyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:54:25 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715C1218AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 04:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573102464;
        bh=Pl4qu8kzGZ9lvi3i1gt+uVv/Z5lppHLT30c0XPXoRw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ykYRP6DtUkUGypCR6R6+YJS2v4Nw9HpSTGSVcgyZwjfBWCfLb6Ag+poWQuVUlrybk
         k1t8HwCXGHx9E5dNzjSxxUbG7OpIYhnFxFie1OL8KDyO+4En4+w4Zgs9XGzXR2tJxb
         1f/Wty+i5K/HW822ID7spFB8P2PkB4hW3jxr8DFc=
Received: by mail-wm1-f53.google.com with SMTP id b11so949770wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 20:54:24 -0800 (PST)
X-Gm-Message-State: APjAAAXlDQH+Qb0w69fPfDXJaXmZ4mtPAzYfcoqUi+lnP5ppYGYHdF6N
        65GEnrKCHaWodep65LUlUSfhcdilexX5XhI2CMD+aw==
X-Google-Smtp-Source: APXvYqzsUFooU67yeXhiAtz+H363Fs4Jc9JTHz4dC5wMwcNYUT67D5nuES5s7t9BRpVPqdMzHUeqAh/sB+dhgfOUqeM=
X-Received: by 2002:a05:600c:3cf:: with SMTP id z15mr973206wmd.76.1573102462951;
 Wed, 06 Nov 2019 20:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20191107044109.22272-1-laijs@linux.alibaba.com>
In-Reply-To: <20191107044109.22272-1-laijs@linux.alibaba.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 6 Nov 2019 20:54:11 -0800
X-Gmail-Original-Message-ID: <CALCETrWdxV7fOpqZjSqB5NuLhFbSMdgf4UOq8eweVDZ7Qbemeg@mail.gmail.com>
Message-ID: <CALCETrWdxV7fOpqZjSqB5NuLhFbSMdgf4UOq8eweVDZ7Qbemeg@mail.gmail.com>
Subject: Re: [PATCH untested] x86_32: fix extable entry for iret
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 8:41 PM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
>
> 3c88c692c287(x86/stackframe/32: Provide consistent pt_regs)
> added code after label .Lirq_return and before 'iret', an instruction
> which should be expected to be found in the extable when there is
> an exception on it. But the extable entry stores the address of
> .Lirq_return not the new address of 'iret', which disables
> the corresponding fixup. This patch fixes the extable entry
> by using a new label.

Egads!

What happens if you run tools/testing/selftests/x86/sigreturn_32 with
and without this patch?

--Andy
