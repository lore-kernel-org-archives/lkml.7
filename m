Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33111ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30C420854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571177674;
	bh=rPbTSoHNEIC5WjuGfABGhzt2oAh6+ric+JzfcxM3/x4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yRc/LEKuOFYhDjEuT/d1P0nUrzwnsPMCEKqYRRCEO2MrKdVr4/EaO+6CURoS4V91v
	 0l9QIqJk98B9OTcj5MH7gtNmpO3B5Hd/lNRIv/Dw9KR+UYev1SFvfda09R18ZZJLPX
	 SCh4OEE4yW7n4gPCx8fjuZzLK0a31iJwUkRvP/Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbfJOWOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:14:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44655 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:14:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id q12so15690242lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/Zz9M4vXV5ymfLbgnz4oj5mAYZiyyFZ4Ij6h9abXFA=;
        b=AlIXJO/ZLBv/p7d/ORSQnj90qcyxXZ/L4tcwMN1ksd4hi9eaymWS714WViotqQRLhk
         vIRHrilEHfQt3hkm1+JjO4o2Ud7MKCdkuXafJuo44Fo4GYyzQ/9AmESct2Xx7IfOK7Ok
         haqnjvvfI/PnFSGBeuzLe9ZId2U0u1ulJkPj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/Zz9M4vXV5ymfLbgnz4oj5mAYZiyyFZ4Ij6h9abXFA=;
        b=I61GokqHtd621DY4709HB74Sp1AYpwUEaN72cHc5vYGp1wOY5D4HO2jgSqr+2mXE/G
         lacSXA6iTK942UsUihl9Jol3Nv0BVqZwhd1JsQg0BUEKKIte7CMbcl72FTifF5UzwnmG
         Hlq0LLH9CoXWt99Ad5+CSCkCtxTiW5xRDoaYuDVO61OkkTt9Pke8BNnS1c0fWrQ7+fVm
         noH/DoNdRsEwnUlYzukmbP5LX7zTWU/vXTwHiFCjwyqho37tlC4Pjg2rNTaxl4012Mnv
         6Xrt8nj6Ph5FpYMybRTVhi+8eiWOXZImQKfqMpMxjCdKR5CWBAhnrUtN8O+epvihIL/b
         8VkA==
X-Gm-Message-State: APjAAAUR9qZTwQC+Aip0VTMfahmtvu1W7bTiDG2XrSoy2RnqDagEssRo
        4RS8Jcq05sdzNygG0ndwVvn8b4YM8YM=
X-Google-Smtp-Source: APXvYqxlOZtssPSB4OTW4/9nzNGZvH6Ljo7YskdoPnbogAdIFYylAfN7P1I9dEAMllSaAUdzbE6ANg==
X-Received: by 2002:a19:4a02:: with SMTP id x2mr20630643lfa.17.1571177669844;
        Tue, 15 Oct 2019 15:14:29 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id h5sm5707221ljf.83.2019.10.15.15.14.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:14:28 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f5so21879208ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:14:27 -0700 (PDT)
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr23595993ljc.97.1571177667184;
 Tue, 15 Oct 2019 15:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:14:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com>
Message-ID: <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/21] Add a prelocked wake-up
To:     David Howells <dhowells@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 2:48 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a wakeup call for a case whereby the caller already has the waitqueue
> spinlock held.

That naming is crazy.

We already have helper functions like this, and they are just called
"wake_up_locked()".

So the "prelocked" naming is just odd. Make it be
wake_up_interruptible_sync_poll_locked().

The helper function should likely be

  void __wake_up_locked_sync_key(struct wait_queue_head *wq_head,
unsigned int mode, void *key)
  {
        __wake_up_common(wq_head, mode, 1, WF_SYNC, key, NULL);
  }
  EXPORT_SYMBOL_GPL(__wake_up_locked_sync_key);

to match the other naming patterns there.

[ Unrelated ]

Looking at that mess of functions, I also wonder if we should try to
just remove the bookmark code again. It was cute, and it was useful,
but I think the problem with the page lock list may have been fixed by
commit 9a1ea439b16b ("mm: put_and_wait_on_page_locked() while page is
migrated") which avoids the retry condition with
migrate_page_move_mapping().

Tim/Kan? Do you have the problematic load still?

              Linus
