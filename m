Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA019C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45512070D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565390780;
	bh=DAz46dt49PyDrm/vE30PhnCrcBdDBHPYJ82LMhimqQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w69CFtXW6OCIrHN1Us190BBDNRFPf7LE1jt/EK6XvdsNS+14J1n2NdpKH3+XCDIsn
	 s1ihYT2RMJYqQ4DBaOsEnZoia3TgqMvdcBDg5k/E/LQeXrEat8xVZ9dCCC+lVlRSX8
	 z2nXedvuo4ZNgOy0QgLNDQ35xAPxT8PHaWVLUIVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfHIWqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:46:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43017 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHIWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:46:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id c19so70609829lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1p81AB5H9qAkQ7oKXv/MOS/Ji9SglTShb5Ura3jIvoI=;
        b=ExyKgXkb/BGoNFg8m4OqIIXIlDmsmOJafAq7Bjan8ZmSwacpffwVH2GN6TnrJSxo2h
         pHsH9vYN7ejqSahUyY6p5X32G9bUFSvKCB4kFbng3x8FCMX/44gZS1FkYdunY1ss+guV
         vsAd1IZPy8LBDclYbvqOCO/UmVj8WlvHfETaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1p81AB5H9qAkQ7oKXv/MOS/Ji9SglTShb5Ura3jIvoI=;
        b=X9I8Rah4P63exU5GENQyH3mCOZzHHQoZH8xrs0am6vVyDK/CeL47ewv3zygKmGViKr
         e/UFvHEI93Ld1qz7XYbcF4EfC2RD3OsrOcvJN7aKZxSWvxisSCvJa5ZkXFXbuXcNeKk3
         TPyDWcLNW2IZuaT+e8H5tnJfEhfpTlG9Pjx22JnXd05KABFSfNk1sVHRz8qrCJz0In5M
         frjxEt6dy2m0wJizJ79YlfYjTMqBN39dQ+L8w1pwhDYp7NY+Vzkhk7cxGg0dDGU612mu
         c23+lL0H5Liy0JazEnGhz8eWBX6FeA0NY9BaUipKQWEP+yJltxp0vU1/383KvYRBundy
         BPnA==
X-Gm-Message-State: APjAAAU9/kj9iz3T7EvASYp7SYrxdeG9lzTKW6moH7F9jDhT0/FQhMD5
        rQc7vlxi+p3nLmlyi0EE9zN1SLTRpis=
X-Google-Smtp-Source: APXvYqx91m9+jV5ep2awaSschVbIVd91MyeyuKlkrB1iBhFxhS2KPvv4n9eD8i290j3AGOCn5xqmCQ==
X-Received: by 2002:a19:6753:: with SMTP id e19mr13953848lfj.187.1565390776492;
        Fri, 09 Aug 2019 15:46:16 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g5sm19845377ljj.69.2019.08.09.15.46.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 15:46:15 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x3so16830510lfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:46:15 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr14345185lfp.61.1565390774837;
 Fri, 09 Aug 2019 15:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com> <20190809223831.fk4uyrzscr366syr@master>
In-Reply-To: <20190809223831.fk4uyrzscr366syr@master>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Aug 2019 15:45:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
Message-ID: <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
Subject: Re: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 3:38 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> In theory, child may have siblings. Would it be possible to have several
> devices under xhci-hcd?

I'm less interested in the xhci-hcd case - which I certainly *hope* is
fixed already? - than in "if this happens somewhere else".

So if we do want to remove the parent (which may be a good idea with a
warning), and want to make sure that the children are really removed
from the resource hierarchy, we should do somethiing like

  static bool detach_children(struct resource *res)
  {
        res = res->child;
        if (!res)
                return false;
        do {
                res->parent = NULL;
                res = res->sibling;
        } while (res);
        return true;
  }

and then we could write the __release_region() warning as

        /* You should not release a resource that has children */
        WARN_ON_ONCE(detach_children(res));

or something?

NOTE! The above is entirely untested, and written purely in my mail
reader. It might be seriously buggy, including not compiling, or doing
odd things. See it more as a "maybe something like this" code snippet
example than any kind of final form.

               Linus
