Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21FDC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8606922C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564072355;
	bh=xwPVtyJ5T1l4b3jgDCdQoLUD8adJlLm8DqRgOMu0TCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XhepjPfVraxH+DwWRTx7hV+Pw1XUA84ZabiofGcfvjP8qZDtSFrdiVrhEkcML3+Wo
	 YjWO2oQfzKI2oA94vF4M88jJon6nOVdDNrikuPeN5vDxyj6HrMjW7Bx9wNeATFO7Gt
	 loJpqta5HktqbDgvUGXPyN4sDynIrHwyncMYYlAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfGYQce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:32:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45828 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGYQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:32:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so34959890lfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqOFR6ie8Zaoa2hn6SZllwIPPh5UhjENPA2Q0bn9vfg=;
        b=CVnx+CPrZRWriTDWiJoish2j/9LHhqWaP2xJQvJOBX95wj/wrHDKQfrkszdzZTakLl
         iU/tjq16CMZ4gvuLAxJ3aV7rCxcl4fmpZvOkLHV8dl4gWnQauNEw/oiQgeh5vM3qdZOB
         1zDwearX/Gx62mziEFU3rTy1XcTR+XmyD9acE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqOFR6ie8Zaoa2hn6SZllwIPPh5UhjENPA2Q0bn9vfg=;
        b=c/Ys9y5onWEbW9+JtXBOZI3QA3AnIqWhJZM7A9RfeTbS9e7C0MYKK8EV30BCC7Nql6
         86c+dIsijJ8eY10DDPDouz0dkdryQuE3TwXobL5LGJdp4PR0FeKCwxPbFdVCvwpwKrfH
         Np3WB9cYVjvQFPUx4kHR3QOLjLlnZs/uKnF3Pf0Uwbh9zpN/u5yPrG2jNrx9Q1pzPLsX
         tZwMBe9qoWTCWstUmxrimDuiVLzc7GMz6e+unustXI8zmif9wUhp0SgQqt/4dHZmhXwN
         Cadbzpt97KTCmNAVL7XPVJ4lehXrjzSmqB/cArnk7bSGPBf2zzCGQq8jALlpqnKQ7/mG
         vnPQ==
X-Gm-Message-State: APjAAAUZ5Fif+SCivLinLYdtyoSuyMLbgbl6JPvrn+sHMUQOG87TT9Yv
        mULHOmL8WOmlOO12hcED1SHUnNQHYG0=
X-Google-Smtp-Source: APXvYqxhZLHIXMU+/pqE9V1UH7ZscTaG6PD3Ep0sirCgAQdbjJKIRbyoZDuk5QKuNxQG0Y7DbuY3qA==
X-Received: by 2002:ac2:546a:: with SMTP id e10mr42468630lfn.75.1564072350759;
        Thu, 25 Jul 2019 09:32:30 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 63sm9296725ljs.84.2019.07.25.09.32.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:32:29 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r15so17985074lfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:32:29 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr31129161lfp.61.1564072349436;
 Thu, 25 Jul 2019 09:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190725110944.GA22106@shao2-debian> <20190725132617.GA23135@rei.lan>
In-Reply-To: <20190725132617.GA23135@rei.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Jul 2019 09:32:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+yRjY_AUrjbgrN59OeGAWMF_q=-Dqf2cYtVzoY01j7Q@mail.gmail.com>
Message-ID: <CAHk-=wg+yRjY_AUrjbgrN59OeGAWMF_q=-Dqf2cYtVzoY01j7Q@mail.gmail.com>
Subject: Re: [LTP] 56cbb429d9: ltp.fs_fill.fail
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 6:26 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> This looks like mkfs.vfat got EBUSY after the loop device was
> succesfully umounted.

Hmm. Smells like the RCU-delaying got triggered again.

We have that "synchronize_rcu_expedited()" in namespace_unlock(),
which is so that everything should be done by the time we return to
user space.

Al, maybe that RCU synchronization should be after the mntput()s?

               Linus
