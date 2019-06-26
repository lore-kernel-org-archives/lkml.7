Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B99C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7A2214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Tw/gev90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFZWtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:49:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37286 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfFZWtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:49:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so96767oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0kP6eyZ5Tl3qjozgE4k99bkRxQJ3H09e9k9c5FyUWQ=;
        b=Tw/gev90iyMsc/dD5bpBpfe6EbDeuQxWxztgIG1Tb0wvkgNK5zj66ER2rhFYtEbxiO
         ShXF7vBXsz61cy5UGxfGLTeF/jDqCW2uf2qhX4bW0mK7ocWgq5Y9Fs1RCDllx5yiLKP9
         xc411xHAStEVucb+J3FgI1sIEsS66my+EwH/qJIyasK57+GBEKfJYp7I8IOMy03vMelw
         PgMBwf3I6nAVD4Jfq6Igz6lM0TzZAwMU0KU6ROsQqd8kCaC/xO0ndSkm7hpG5/MjIfKb
         yvUrNFU/uaK4p25k85X9Fzce/IY57/WjHzzKten4XsXBCYpFdGmhTIP3Cm0PM7i4CS73
         iKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0kP6eyZ5Tl3qjozgE4k99bkRxQJ3H09e9k9c5FyUWQ=;
        b=fPWDfNhE83S0rFCRXhuuRB4DG2NLYYSF5b8S99X4tYxSJSHexM14iujLNgYN6cxmuk
         OQbZRf2+koAsijgFDgVXNci1C47CXUs9RpNHgDVoSUBN/AVRtBDrLmC6u/b/289RIg/z
         YNK4BMDBZgxtC0XlFL3ymBX+Bb415G1fRFGCT3rFICgxZ9w02+ZrLfiuxQ7pY1ijtLm+
         gEWWXaniWS+GSN+j4YYl697kUmG1ST0aPy50xiUcJkcv4eZ9NvbdkVh74ASM+eHcWkVz
         3mdHDr9SdJoiiR8LKdzgwB3NzXWDz59E9DOBA6B4nM2iAlN0ZEgK7vw6EjeRwEnfsp/N
         gU6g==
X-Gm-Message-State: APjAAAVwCY32MGXKZ8K6AwLjz26j2uzLOtJFWV/vD0Z6eE8XDcu0/LH3
        pLQQSB1oQXKjXMWxUCqux4LyVfilBiPTV0sytEnupA==
X-Google-Smtp-Source: APXvYqzI32LHQAFCU9npXcsvYo7m4WBrpQOfpOG3SMIRkj+jxIfMrh3RSnLB/Bz/rHPQilhrdSnxafPmLUuOTPKrY8s=
X-Received: by 2002:aca:af55:: with SMTP id y82mr463012oie.172.1561589349384;
 Wed, 26 Jun 2019 15:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190626005449.225796-1-trong@android.com> <20190626011221.GB22454@kroah.com>
 <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
In-Reply-To: <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 26 Jun 2019 15:48:58 -0700
Message-ID: <CANA+-vD+qBqENZrk_7KZzedbzGPMzHniHTE4sY93gnkzzBif6A@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 6:33 PM Tri Vo <trong@android.com> wrote:
>
> On Tue, Jun 25, 2019 at 6:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 05:54:49PM -0700, Tri Vo wrote:
> > > Embedding a struct kobject into struct wakeup_source changes lifetime
> > > requirements on the latter. To that end, change deallocation of struct
> > > wakeup_source using kfree to kobject_put().
> >
> > Ick, are you sure you need a new kobject here?  Why wouldn't a named
> > attribute group work instead?  That should keep this patch much smaller
> > and simpler.
>
> Yeah, named attribute groups might be a much cleaner way to do this.
> Let me investigate.

Say, we read /sys/power/wakeup_sources/foo/active_count. This
attribute's show function needs to find wakeup_source struct of "foo".
I'm not sure how to do that without embedding a kobject inside of
wakeup_source.
