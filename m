Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B7DC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 18:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C972083B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564250971;
	bh=UOffHRCjj9ElQhQERuuixgmFz2W1MpAZLsqqORG9pio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0anP6rn+BouzobM/GkHxRaXrPeW6608rUfhf2j3qRqN5/aQSqJyQMZm98BoCW4IBz
	 p0/GGNPAMAi86P8xj6f6AjbH/Xv1THwK/iroMTquP7iTLMjnIgY3s16hwYvTHR+pjs
	 +GmIyMR1xJPZhvu40U7zpvWI6P4sGIRpslBFxUss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbfG0SJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 14:09:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43840 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387935AbfG0SJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 14:09:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so29947707ljk.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S62s5rdsynYnqf1QhYZV3IIXT1WCgILS3kAJrNadYnw=;
        b=iMMrmeLTqTg8y3b1n8d+6Pj031iRNlztZCs/ZBC8A1feno5QZUZ+4IjNBWJWh3e6iN
         BAHDuoZC4gcRW3J6EC/R7+ttvngMKgi21/ubD8AjZpDFous3abUQ2sJty+gLAPh2WNLP
         HdDhCKajGZTrqRxwTA8uf1iyYeoGq27O/aQcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S62s5rdsynYnqf1QhYZV3IIXT1WCgILS3kAJrNadYnw=;
        b=NSD7Yohu8d+3rSzGVRcUC/Ca//3nfQ2SGwZSJOCQLnmdJ55rCYdDXVbQThbgEHF0x4
         A0YQEoA3xIThPTtc5kOuerv/Jj5l/1yPxq16T4XTMl5B8iPr1Io1eO79BiSCZRPVryTk
         IUdlDC+enb7VJYWGw5CZwbgC1FYyUW1BHoFalzLW+/JcWzsllfo7Agr3aav+AT0gzigW
         eqe4hL+xIWZfmk//YM/X4gc+JitP3cLV4dCoud6WeFy0T/gWbvFDo9pr4xheiTU98Clz
         bNuiC653kjmL+ZYW6/OBdR2PXJCjN6aSme7huQ82Pb4L1B5BDWrstJxi7TyUBGYG+soW
         kQVg==
X-Gm-Message-State: APjAAAUYtiafcqUOz4bvrY65fZ6sPmcMaIi6esfPb0Wm4vWKFDKX+vP9
        oPQ8myKqo7Lq5aG2+BE+75DDlV7skwk=
X-Google-Smtp-Source: APXvYqyRWFvyBThAlXTns/UwYvx+uzancqYGHfLNqd4HDgBmjSXufWKVApeHTYF954xDk/XUjc/OOA==
X-Received: by 2002:a2e:2411:: with SMTP id k17mr14650907ljk.136.1564250955431;
        Sat, 27 Jul 2019 11:09:15 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 27sm11212275ljw.97.2019.07.27.11.09.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 11:09:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c19so39236171lfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 11:09:14 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr36947244lfp.61.1564250953929;
 Sat, 27 Jul 2019 11:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190726025521.GA1824@embeddedor>
In-Reply-To: <20190726025521.GA1824@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Jul 2019 11:08:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw2Pdh-gAObS2wt4pF6Pgus9aHNS2WaVBkgYGsmaZyJw@mail.gmail.com>
Message-ID: <CAHk-=whw2Pdh-gAObS2wt4pF6Pgus9aHNS2WaVBkgYGsmaZyJw@mail.gmail.com>
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc2
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 7:55 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Here is a new pull-request that includes a fix for those warnings you
> were seeing with the dcn20_dccg driver.

Ok, I have tried re-pulling and if it passes my build tests cleanly
I'll push the result out.

                  Linus
