Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C235C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40366208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557762681;
	bh=VO5BWtK/NhFMUgfePe27x1pllPiG08W6xyS+rnVVOZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F51II0tWDH05OCD/H6UE9fxRGzxTTwcxAjUe/dTvYUOyUY6p5swkF+D9lHBTuP8J1
	 r64N56CCYekDVVttO4C9dPwRUbBZjYt8GvnQ8dMbqzl62lMnExellpjkY/l9kgQbTF
	 +SJ50zgvb5DUYTDbMTCzsiic2kA+EuvdOZKQEtHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfEMPvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbfEMPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:51:19 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAE9214C6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557762678;
        bh=VO5BWtK/NhFMUgfePe27x1pllPiG08W6xyS+rnVVOZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fyu+eEytsVWPHDXWOsfR/TJPqHCmbiYlK1Fnjgm+jpYglv6rVvm/+qXEvZm5ZT01+
         Y5BbMjwW0+hAE1oCsSINHifec3q/3FiaUs/zGMRfMHVEN4gqXnxNhy75utPulzWWZm
         sbdTaN4z+XaFRnmavwNqVm51mR8QZNfjMl4l8AIg=
Received: by mail-wr1-f42.google.com with SMTP id c5so15840316wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:51:17 -0700 (PDT)
X-Gm-Message-State: APjAAAWxeMxmA63vHV9V5n5jJNPuoeJyKR9f/we02NpK1zNY3AatMEPs
        cVmyKaw9uuhNeSH5OoMf8nngHHe78F7EtXSUF3P/Fw==
X-Google-Smtp-Source: APXvYqweIyAAst47IlG9+M3dW2MMDYappTrLz+EbgygcUMyvETKgI8UQlTIVNk0ihEUxrA0VUAbnkkOWJOGlHuc0t+0=
X-Received: by 2002:adf:ec42:: with SMTP id w2mr17344670wrn.77.1557762676520;
 Mon, 13 May 2019 08:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com> <1557758315-12667-7-git-send-email-alexandre.chartre@oracle.com>
In-Reply-To: <1557758315-12667-7-git-send-email-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 May 2019 08:51:04 -0700
X-Gmail-Original-Message-ID: <CALCETrUzAjUFGd=xZRmCbyLfvDgC_WbPYyXB=OznwTkcV-PKNw@mail.gmail.com>
Message-ID: <CALCETrUzAjUFGd=xZRmCbyLfvDgC_WbPYyXB=OznwTkcV-PKNw@mail.gmail.com>
Subject: Re: [RFC KVM 06/27] KVM: x86: Exit KVM isolation on IRQ entry
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 7:39 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> From: Liran Alon <liran.alon@oracle.com>
>
> Next commits will change most of KVM #VMExit handlers to run
> in KVM isolated address space. Any interrupt handler raised
> during execution in KVM address space needs to switch back
> to host address space.
>
> This patch makes sure that IRQ handlers will run in full
> host address space instead of KVM isolated address space.

IMO this needs to be somewhere a lot more central.  What about NMI and
MCE?  Or async page faults?  Or any other entry?

--Andy
