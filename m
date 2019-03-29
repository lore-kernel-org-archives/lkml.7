Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F60C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44D9218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553880320;
	bh=ngxFW+W5XrWQNd2xGUxU/KGmqchYGw00TMLB6wfvNyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CZcSl+i7J98Ay3l2B44q4CkuBetcvLPEDFsPfe8IYt3Fu+xCCjcdHdlVKCLro6tF1
	 asmedIHigz4pgc4llgYqzrUdZ/UzQwrITxI3kw4hpby/b+uZL5TXbKfwWQh0EKFo6w
	 tFDeYQf6U0EhHLoLHe+/bTRSCrNzlC7q/EiVbCIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfC2RZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:25:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35330 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfC2RZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:25:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so1996740lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJoD5hB53StG/AeSgpCKUMebn37Ye+HqJ4vctuuxeKw=;
        b=C0ZKIR2IjogA5H+vrzkTEcdkJAK8trCxmweLhb06P5vHnnwZjv0hXvzVmfnagAzalt
         nrM6BTS/V/jAJ6aF7PckKhMfLMWwq48P0z6Q00426Lop/kI12gxBTbxfL/gJVSyXXbL5
         QflR5GiEGEJkkijfR6eT4hhE4rBvdbVe9X5qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJoD5hB53StG/AeSgpCKUMebn37Ye+HqJ4vctuuxeKw=;
        b=jdnvqaOm6HjRup+FEs8cmAsduRSXXiIfki3n5uy/UCTrbDOQ/AyZ9hSSZUrZDpbdGt
         1bSGsNyP7lq24bo4+/zlW5LULbMDFzAb0XAWwuyKjEM9aY1Q7HO2q7Hy6fQ9JBKeMwJY
         jEHfk/Yv7OtaKI9koXdB34Tm6bvIcAfLsyLK4mp1dajMcAMST1Mq7VMoZfzzfpyWJTyn
         CxOePqmel0eAmuif1p2IR0tBIpdUK3GFUbKzPi0/BZEu+zrZVVVhJobnDGi5sMP7mIfX
         a19LRCpRGlLUjjOuH3G/K74WN2ZmcbDwEmkECurxDzI4ISTO8z//VOX9upbnoGjMdKrD
         vohg==
X-Gm-Message-State: APjAAAVi3hFgeyFUgSBumNINeT7Xw+J3c80hoiXuYQWB3hutpV/rXMh0
        YsoqP1FAgJffg2qvsFJkY3bVu8+jrLw=
X-Google-Smtp-Source: APXvYqyrkjvCT5OVDydIMDR3ytnqjy/8WsORjK7NWrOta2KApSxuoWBeo4jwDC/B/y6CczyxDuy1sA==
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr5445328lfk.138.1553880316221;
        Fri, 29 Mar 2019 10:25:16 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y10sm389597lfg.44.2019.03.29.10.25.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:25:15 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id h16so2630252ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:25:14 -0700 (PDT)
X-Received: by 2002:a2e:9213:: with SMTP id k19mr5879557ljg.118.1553880314426;
 Fri, 29 Mar 2019 10:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230512.486297455@goodmis.org>
In-Reply-To: <20190328230512.486297455@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Mar 2019 10:24:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
Message-ID: <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from syscall_get_arguments()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole series looks fine to me.

I still suspect that we should just remove the syscall_set_arguments()
thing entirely, but even without that, the cleanup of the calling
convention is at least an improvement.

                     Linus
