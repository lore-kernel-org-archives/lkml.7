Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BEBC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F3920862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570207990;
	bh=iYn7MmWiQMonlsgUlhh4XLpmY+Ud1LVtoHrFhdY0EWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MftWHDcBJ8jtbfvZBp0B4cimxkP1K2nizVUmbfi52rFWjS1uksJnYIvPj2mnCo5lR
	 LdJAIgtp167qJp+JBzVWoI559EcsjdZft13WXTObaLW8K8EhL09vsbPUaaPp0vEWvi
	 9CB8CNTactYVF9zN7U/VVT/qZQTq6Cvlgd5K/HDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfJDQxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:53:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39104 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJDQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:53:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so7212633ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xmm2BP8a9DWuDP+xds0k8TTHnrVyUujhwbGGQwiP4BU=;
        b=eXmEOfmog2EGekU7f6PlODmT8wkU1BJJwHVJjyillhE8vzFgDkJ/psUWheGVhia7JV
         UbbKj5qJD+z7tqKIFDLuguKIW4wE5mESUBF8Tn31nyynoCIy7mxChKbdwtBG8NclsAdk
         pT9e7uSJS8FK1k3lnsW2QtcdPrg3UdPesIjO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xmm2BP8a9DWuDP+xds0k8TTHnrVyUujhwbGGQwiP4BU=;
        b=B6X7FVwa5iyg00zhX42n7MPQz/UpG2KpAwkDY7s4FyHmP3xaLtJz1nVcrRieubz9q+
         Y2vSUbOkxatBkVSdlP7J4HZWRlI11YaWCyCVCDPFlewUDeEx/1kWMGkGE+1kbCGeioze
         eiO780BXOktOQBjURkZ2n702ZuE0qGkMsSOZQhoBjA8jrYPJTnZqdxMvveKMTTqoLoVI
         v0SlqPmKSTh8DWvpBHawCa4bx/qZPZshzFnZ59NiBjNyuYHAjMze0eA1qcw3eLdZ+UYk
         KalIZQX2PuuZ4bceT09PtFxLuWOCx7zO28EKOTlH1FHLCL+uwQbTRodmoMX4zwi5DY5F
         b7TQ==
X-Gm-Message-State: APjAAAV7Lv9T2lzUCBh4HdQ1/QbiO0RbGpc7jrKyxQ2dyyE9wFqM+/15
        wZNPVBowiCOYPw43kkO9oii6pYyOwro=
X-Google-Smtp-Source: APXvYqzR0i1UqUKUv3EgpK+cqpaiJNo1c6BqTJ4EfC0prOr4GL7Xy5jhw96Zqzhl/lgu8VlY7p9XGQ==
X-Received: by 2002:a2e:9450:: with SMTP id o16mr10061028ljh.178.1570207986841;
        Fri, 04 Oct 2019 09:53:06 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id t4sm1370702lji.40.2019.10.04.09.53.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 09:53:06 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id t8so4916814lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:53:05 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr9520991lfc.106.1570207985437;
 Fri, 04 Oct 2019 09:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191004140503.9817-1-christian.brauner@ubuntu.com> <20191004142748.GG26530@ZenIV.linux.org.uk>
In-Reply-To: <20191004142748.GG26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Oct 2019 09:52:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih7tK-PoRTSUXgarpgR-WA8kN_voiMynQr8eysvPPgfA@mail.gmail.com>
Message-ID: <CAHk-=wih7tK-PoRTSUXgarpgR-WA8kN_voiMynQr8eysvPPgfA@mail.gmail.com>
Subject: Re: [PATCH] devpts: Fix NULL pointer dereference in dcache_readdir()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Varad Gautam <vrd@amazon.de>, stable <stable@vger.kernel.org>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 7:27 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, vfs.git#fixes (or #next.dcache) ought to deal with that one.

Dang, I thought this already got merged. But we only discussed it
extensively and I guess it got delayed by all the discussions about
possible fixes for the d_lock contention.

Al, mind sending me that one - and honestly, I'd take the "cursors off
the list at the end" patch too. That may not be stable material, but I
still think it's going to help the d_lock contention at least
partially in practice.

               Linus
