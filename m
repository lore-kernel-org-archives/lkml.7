Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AFEC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F36222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569522115;
	bh=AXXrhWbwsofC1rmf8TbGYx+/8aqKnOhwDk1OD2n0Btc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HGASaJDmQgo1c14XQ8nE3U8Wl7dPXeSshGl1xOOKKDD4PFwK8lHOnf7fUlNHWmTfJ
	 HdKkVjwrdqDvNoc0pHc7Z/xv/rf0nLP1cGSBJ5kv/zH3im6T58rZMcntEzab1Zv9jE
	 Mq/yN70ojKMeHI49fuYBw2l81FbpzHeoN644OZ4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfIZSVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:21:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35556 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfIZSVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:21:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so2450537lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrcu3G8Duy/FeUjbYtKJnhs5/UkfjjDxGs8XQQZjFoU=;
        b=gzGIbnTBRa0MWz7TFhp8ocJz4Lh2yp/shAcSeubrA6fuXKkzxeQIMSMNUPYdBFXJYn
         /j0pV7SWgvNqO2g+oiezYX4Vi4visN26kdNsSZ+7eBfZXMOInvLGEWdmfAdWBQVuPnk5
         706kND9Z6EULVBwuXFq61uGYcokd+0OZjjggU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrcu3G8Duy/FeUjbYtKJnhs5/UkfjjDxGs8XQQZjFoU=;
        b=rfUUzcx4Ls4+aW4nLeW2jQTqtvpuv/gwpM1sCaINbLbH+0QYfNHxs8eqfNahxyTnWi
         0O7Vt3Lt/OTooCSzQClWN0XcFTzflbDKhgSkm1mKCWaSBHgavXSPAZTjxQ+wl4Ot3USz
         mdGpQz++RJILOiDIc2pCh4XAlHSj7RF8z5HzhvigYLyZrCN4tfw5Lwhu21Z6/Z5okiH7
         HLLaqmmsPztqIyD2QvK7pTf0d5lzG85HL2WDRN7BDDNXyII85yLSolPlus68ifpK4BVE
         kpxAHeE7VwGDYSP0IrySFtdbgE05CLkmJjBpPi4Sm/k8jWvWWxJtUNbsTBcL5jduhfYg
         efsQ==
X-Gm-Message-State: APjAAAWkcmMcJuCjpXP9UYHdi3dGCBnp/P5hj36wcciEFzvhKSvi6wNS
        KHuR7iFR78L6rb39Q5N8wodFN9NE9zs=
X-Google-Smtp-Source: APXvYqx1vnJRbF/otQNwVXPw/weDm3oPzVdHKKOlnbevrDMaoeOLkDtbqnT0idiYRTcJc7Q+Mwq2+w==
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr3196302lfm.67.1569522111844;
        Thu, 26 Sep 2019 11:21:51 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s7sm704457ljs.16.2019.09.26.11.21.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 11:21:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d17so2424519lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:21:49 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr3025988lfk.52.1569522109593;
 Thu, 26 Sep 2019 11:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
 <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
 <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
 <CAHk-=wh4cuHsE8jFHO7XVatdXa=M2f4RHL3VwnSkAf5UNHUJ-Q@mail.gmail.com> <CAJ-EccMy=tNPp3=PQZxLT7eovojoAdpfQmqhAyv7XO3GwPQBMg@mail.gmail.com>
In-Reply-To: <CAJ-EccMy=tNPp3=PQZxLT7eovojoAdpfQmqhAyv7XO3GwPQBMg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Sep 2019 11:21:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH25fp_9oMMi+1GxUR1h+WyXQRvW+GuNVq7vC9Kaad2g@mail.gmail.com>
Message-ID: <CAHk-=wjH25fp_9oMMi+1GxUR1h+WyXQRvW+GuNVq7vC9Kaad2g@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jamorris@linuxonhyperv.com>,
        Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 8:31 PM Micah Morton <mortonm@chromium.org> wrote:
>
>                The best way I know of ensuring this is
> for me to personally run the SafeSetID selftest (in
> tools/testing/selftests/safesetid/) every release, regardless of
> whether we make any changes to SafeSetID itself. Does this sound
> sufficient or are there more formal guidelines/processes here that I'm
> not aware of?

I think that would help, but I wopuld also hope that somebody actually
runs Chromium / Chrome OS with a modern kernel.

Even if *standard* device installs don't end up having recent kernels,
I would assume there are people who are testing development setups?

              Linus
