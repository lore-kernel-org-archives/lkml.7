Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA8CC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D42173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555530341;
	bh=cL4EzZi/IUnfVtsgQ2ZFF/yOnZpkBepXRBmF6l1CzJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VHMJ3FESGDffgwY8xT+aDDAuBKLbnCkm0HtMzoCmiZ8rM8Ej5My8o48lx43HRYY5p
	 IvISGEgdUn76XKLXrY1wd8saMayaa0sOgVyMpf+ZwfXLSE1de1obn2ldkKPL2lwBKB
	 mix8h/XLszx/SY2xUzrzUdW29/lO0PpC4nda2sDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfDQTph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbfDQTpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:45:32 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C5C9206BA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555530331;
        bh=cL4EzZi/IUnfVtsgQ2ZFF/yOnZpkBepXRBmF6l1CzJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y1WeZKb+x2wLYH5JOCf5RMZ+pt0QOlNGo/Med0Y+7XoHJfM51ExKKmlwN3z1fAQb2
         JHeX7pAwa3qO1u/K/zRHTUvpNFqxLHV2R1nEIKzeoLcn0kOOU6w/pKUrhBgX0Amg6o
         AyVqZVRlywoQdVRM/KXOryDjpNO7ptP5me/qDNB4=
Received: by mail-wr1-f43.google.com with SMTP id k11so33505976wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:45:30 -0700 (PDT)
X-Gm-Message-State: APjAAAVkJRQuvikcJL69VG+5y8MdmsffSfV0RzBfuRUbVFBo+9dJGb0c
        7S1Ub09e7TlwS3M4CMW8TeA24ptDFeeHXFbh5lGUfw==
X-Google-Smtp-Source: APXvYqzxP0uiBcY0Bzu1LYAhF6H28ro+GVmjLUj07Z4OKqCrthZxnrjCtZrYQRUQAGNcYIVrgtikztxrac4I2YzTzic=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr1100275wru.309.1555530329659;
 Wed, 17 Apr 2019 12:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190416063250.7514-1-aubrey.li@linux.intel.com> <20190416160143.8292ced993dc803aae7fa0da@linux-foundation.org>
In-Reply-To: <20190416160143.8292ced993dc803aae7fa0da@linux-foundation.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Apr 2019 12:45:18 -0700
X-Gmail-Original-Message-ID: <CALCETrUjF9PBmkzH1J86vw4ZW785DP7FtcT+gcSrx29=BUnjoQ@mail.gmail.com>
Message-ID: <CALCETrUjF9PBmkzH1J86vw4ZW785DP7FtcT+gcSrx29=BUnjoQ@mail.gmail.com>
Subject: Re: [PATCH v15 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, aubrey.li@intel.com,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 16 Apr 2019 14:32:48 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
>
> > The architecture specific information of the running processes could
> > be useful to the userland. Add support to examine process architecture
> > specific information externally.
>
> The implementation looks just fine to me.  Have you had any feedback on
> the overall desirability of adding this feature?

I think I've been the most outspoken, and my not-all-that-strong
opinion is that I don't really like it.  /proc/PID/status is already a
bit of a mess, and I don't think we really want it to be a mess that
is different on different architectures.  Hence my suggestion of
/proc/PID/x86_status instead.  Or we could do /proc/PID/arch_status, I
suppose, and make sure that everything in it is namespaced.  (We could
easily end up with a situation where status fields from more than one
architecture are present.  Think i386 + x86_64.  Thata's also the case
where qemu userspace emulation is used to run binaries meant for one
architecture on a different architecture's kernel.)

--Andy
