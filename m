Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB5BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F2C2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfEOVKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:10:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46379 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfEOVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:10:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id z19so1380733qtz.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KA/LxV6yFSvspEZyQMFq5IPmO1InVjem4vQ6fWt45JE=;
        b=EAp1gVrLT7Chq9+TIthWx6iYVl7XxrmjwTObjCakI8ZCxHW4UT48nJAZAnhjsy/m6P
         gcLsE/EAIUEd5qSb1CPejOZgOn0x/MFzpdR8JBhVaH2lQYbRPLIP9fxIEC1zeRVfM3Kj
         pPbASOYZOTeavOd+bZWjjaBGpRgx69x8oLmgZpnDqeN/PAF2dFALH2pdSb/52msdSidR
         ZtISYG5ocw4dlz/OmN1ziSoZQMVZXU1dGzNx8KOTNJhOmiIze199n3bLThuEAJkPhClf
         qT+TiOXbswCJmynR9aQJ20wy+aW/9Grcn+ax36Ce38n1f2IC3bTFyNx6IpIfTGpn4vg1
         M49w==
X-Gm-Message-State: APjAAAVxI5/wQ7CnLHqIr8QToKWr2AnoUUR8XpLSyJdubuhjU7xgWEWg
        5cvA2MpX7woIRu/TjH+a5dI6I4igZ17QVAp+yE3aaP0j01c=
X-Google-Smtp-Source: APXvYqzvuQSmvTzzjAy55AJpQArcLOnr0y4unK0rvwPaXUx2fVdvH15rrUWWNSUUIC8ccmC6aUqDlCFgVBOqYk7pnRk=
X-Received: by 2002:a0c:87f4:: with SMTP id 49mr35800916qvk.149.1557954605689;
 Wed, 15 May 2019 14:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <874f34f9bfc840c39719707a2e12fed4-mfwitten@gmail.com>
In-Reply-To: <874f34f9bfc840c39719707a2e12fed4-mfwitten@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 23:09:49 +0200
Message-ID: <CAK8P3a3g4Fb_027dkTMXeLLGQ+OevCc26-x7sx6FrK1BT4Nxfw@mail.gmail.com>
Subject: Re: The UAPI references Kconfig's CONFIG_* macros (variables)
To:     Michael Witten <mfwitten@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 6:29 AM Michael Witten <mfwitten@gmail.com> wrote:

>
> What is the correct way to think about this?
>
>   * Should the UAPI make no reference to build-time configurations?

Right, with the exception of uses inside of #ifdef __KERNEL__.

>   * Should the UAPI headers include sanity checks on behalf of the user?
>   * Should there be a `/proc/config.h.gz' facility?

This would not work, since applications don't always run on the systems
they are compiled on, in particular when cross-compiling to another
architecture.

      Arnd
