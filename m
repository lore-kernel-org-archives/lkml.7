Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B14C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4792085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564249808;
	bh=vrrRUu3gAvFHcKDIO/TOiTWi5g7Vry0x1yGk3+byKTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hOVYSyE5CYmK+NuXjZAEHNN1SiQJ2lyQLDxPVSzbX7jxilOEowqn5CiF+iqvXybwn
	 BPqPk32+SRJTl3AIuoN908PvcbkkToiP6mlJEQf05kMhgvMMkL37vADnfFZHuj9wkD
	 1xNCZDXaPFwc7fT8u1nZbt98n/WTE0n+t5nBiaAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfG0RuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 13:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbfG0RuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 13:50:06 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8042085A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564249805;
        bh=vrrRUu3gAvFHcKDIO/TOiTWi5g7Vry0x1yGk3+byKTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q84HSiGg3cKhfoY4dY5sh2Mn1/gimTyap/UfjUaOKpPHJ3rEoyWUh04JaifT6bW7U
         EqAP86BREULglJctPkMZfszdGvRh8BEUQ5kNOZPdbjeG67WwiP0DobRftjet+cN43C
         sGkntWn+H6ycTCpusCvqjM8uhekYOT4kylnjfzTU=
Received: by mail-wr1-f53.google.com with SMTP id n4so57624335wrs.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 10:50:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWLUtWIxM36uoVPxJyHRHAv16BPwduq7G6bIToWlVVRJiROaJ7e
        4Z1pKAbyEV9OVDrm++1AMbTCnHOR9ZQ0fg4fWIjvEg==
X-Google-Smtp-Source: APXvYqznSvC240oQIG4cpm2q6Tg24GmIn2qmkyJO+R93Zf99euAYEgP5rMooLeNpX5M1k3Kno6yHZQ1FeGPq9jTrGuU=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr31344348wro.343.1564249803594;
 Sat, 27 Jul 2019 10:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook> <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
 <201907231437.DB20BEBD3@keescook> <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de>
 <201907231636.AD3ED717D@keescook> <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
 <20190726180103.GE3188@linux.intel.com>
In-Reply-To: <20190726180103.GE3188@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 27 Jul 2019 10:49:52 -0700
X-Gmail-Original-Message-ID: <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com>
Message-ID: <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on i386
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 11:01 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> +cc Paul
>
> On Wed, Jul 24, 2019 at 01:56:34AM +0200, Thomas Gleixner wrote:
> > On Tue, 23 Jul 2019, Kees Cook wrote:
> >
> > > On Wed, Jul 24, 2019 at 12:59:03AM +0200, Thomas Gleixner wrote:
> > > > And as we have sys_clock_gettime64() exposed for 32bit anyway you need to
> > > > deal with that in seccomp independently of the VDSO. It does not make sense
> > > > to treat sys_clock_gettime() differently than sys_clock_gettime64(). They
> > > > both expose the same information, but the latter is y2038 safe.
> > >
> > > Okay, so combining Andy's ideas on aliasing and "more seccomp flags",
> > > we could declare that clock_gettime64() is not filterable on 32-bit at
> > > all without the magic SECCOMP_IGNORE_ALIASES flag or something. Then we
> > > would alias clock_gettime64 to clock_gettime _before_ the first evaluation
> > > (unless SECCOMP_IGNORE_ALIASES is set)?
> > >
> > > (When was clock_gettime64() introduced? Is it too long ago to do this
> > > "you can't filter it without a special flag" change?)
> >
> > clock_gettime64() and the other sys_*time64() syscalls which address the
> > y2038 issue were added in 5.1
>
> Paul Bolle pointed out that this regression showed up in v5.3-rc1, not
> v5.2.  In Paul's case, systemd-journal is failing.

I think it's getting quite late to start inventing new seccomp
features to fix this.  I think the right solution for 5.3 is to change
the 32-bit vdso fallback to use the old clock_gettime, i.e.
clock_gettime32.  This is obviously not an acceptable long-term
solution.
