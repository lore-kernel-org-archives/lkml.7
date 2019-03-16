Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3DEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3948621872
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552700971;
	bh=rhucAxpADybmaOTkPe42dRghha6wO96JTN4OiIzVN2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rOcQfdPxAzbiCPC0jxHxiUKMp57wBAYZxQufbIs8QzE70Dmm41i6Lglf8sM9Mln6x
	 +pmigG7Voet6FEPxjy71T/UPwpGRYQKuVS8EV9g6wlG9OyKJPxhxUTvUfBm591xYP9
	 dIydpgWM3ECpnqkMZeI4x26QddlN71NS3JQ5jqxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCPBta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 21:49:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43589 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCPBt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 21:49:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id z20so9496342ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZ9keLsoqxizG4n/mz6mPuOXvZiAzBcHeRDiG3bZ3Co=;
        b=bjkCi4EKnUp8bAyLsgwmj7BrMch8NGHoP1r9iBpN9YpUEvT4ZjDyGXiC8bSM9Eb9kn
         a9j83yJ1gl3YjFUoKWPVB2wXdW3WvonvUb4+f/xq8Zvstma9jWySH6m6U4MrR03JDGlJ
         IegkzZD5U73Dhgqnq+90gitb3ckswhcYm6/eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZ9keLsoqxizG4n/mz6mPuOXvZiAzBcHeRDiG3bZ3Co=;
        b=n+lWpycMtCChduKMCiUt+A9sBYnGD/jXqc/iQGf/jT6WseYXcdH6TcrGEk5WbEL7nM
         Sibq3YGsfOmJE46LrSMGnOtpjTvsxEAAcFTLSiAEaOkX8xQtjLYxnFAidIEwaH2EQpdf
         rAqej0NwVw1Y7MAOk5iutLvp93dR8bLVuzrDytk+7CCPVmU6EIZ8UjUtkNPTmuR5JqeK
         in0dcdTBviLwWFUg4Fz4zCkKWX3RvCtoUmuaIfZfRMS0Gpvlly7y76Zl0SC2UwLxxL+j
         f83glVLLp9z6H2lpliL8xU/7OMrsn7Ja0QzxQAxgB7qUzFtaQaJHTByc97jToSxwC/hF
         0W0g==
X-Gm-Message-State: APjAAAXTqpuTTUbd25rSBGCZOG/t8+uXTRmku8SpMBOw4jJcevKEPZ99
        nmcwnJ9w0XjKOdbK7/NFSVCa40DGg/A=
X-Google-Smtp-Source: APXvYqxeQ6Rf+C3sL/+oqTRL4UdcbEClmiz063pM5jf1DlCSowBkTQPg/D7YQWKZf69V3WWgyNgpEg==
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr3747570ljj.181.1552700966435;
        Fri, 15 Mar 2019 18:49:26 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m26sm737355lji.22.2019.03.15.18.49.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 18:49:25 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id g7so8143295lfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 18:49:25 -0700 (PDT)
X-Received: by 2002:ac2:548f:: with SMTP id t15mr3830644lfk.166.1552700965063;
 Fri, 15 Mar 2019 18:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <12246.1552693296@warthog.procyon.org.uk>
In-Reply-To: <12246.1552693296@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Mar 2019 18:49:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisFUf55wZ3o5pv8ZY5st9utSdWELAofsJ6AwAwYByPPg@mail.gmail.com>
Message-ID: <CAHk-=wisFUf55wZ3o5pv8ZY5st9utSdWELAofsJ6AwAwYByPPg@mail.gmail.com>
Subject: Re: [GIT PULL] AFS fixes and other bits
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 4:41 PM David Howells <dhowells@redhat.com> wrote:
>
> Here's a set of fixes and other bits for AFS to improve the life of desktop
> applications such as firefox.

I pulled, and immediately unpulled.

The thing hasn't even seen a compiler, and when you *do* show the code
to a compiler, said compiler correctly warns about
afs_do_silly_unlink() potentially returning an uninitialized variable.

And yes, it's _trivially_ and obviously uninitialized.

Feel free to submit this for 5.2 after it has actually seen testing.
But this late in the 5.1 merge window, I'm no longer interested in
totally untested new crap. It clearly wasn't ready before the merge
window, and it clearly isn't ready *now*.

Much too late to try to fix this up,

                  Linus
