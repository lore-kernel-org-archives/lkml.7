Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4008AC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 03:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F4D20890
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 03:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568606222;
	bh=jHscCwR520z2f2FZxR9F6Mo9SHIyoEz0tswC/hhyZIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BSF6ZQ2nP5oz9AidiZZ5hRTVpffZ38Ic9XxJifkoBakoq9ANwKK0zRRueraqwKf47
	 N7T4+oofW1aLilOa5ian6o1NRUkMqDlGiMuoRPMRwZvh/o7ids2++g2iggZIOO77PE
	 EY5Mis/fE6DYrZMNGAmRg9Y4Sjn0NbB7McWl7fp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfIPD5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 23:57:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37386 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfIPD5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 23:57:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id c22so4504228ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WJOiZU+ONLAF5VZ8QdOdt/8naAIMcee9SR9+Sx4feo=;
        b=CtTVmBweTrysJ5DoBdCUD/t7zNLy0x4eKmXubkXkdKS8+ArCc5ANYpzn9sH94OOKbs
         Jk5h0KuyermsSKSl+qKF7ca6CUOT9A6LKnCKJZbR4H18skYWhZHhR7XelAKdszwFd9Z2
         hKybKfniHYIfTwncY2S8j6sL+gJCjCg2rE644=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WJOiZU+ONLAF5VZ8QdOdt/8naAIMcee9SR9+Sx4feo=;
        b=MJhk41viJFetiV/OH13ABmC2rGggvbpY1/MOyhIPDxNBJg0h90uMdAxy47vMwBMrQ2
         Ab3orDKApf1n4vt55k4sMb+1ncXLZp9o9SHmKH2XgVXrV/9cNT44OElz46YFvSb2G0kb
         +zVd4JakhWg1BYGloL/1XRY9D7XUdjmF0hnuANM/HEqRotHv8DkK9OEYvOxsIbDHI3Bj
         wCTFGthZD+jrXivhNZUn4tCnd0qHYaV4ZwZKHwFvToGO8BC4jSZQngXMe994ufNTZctN
         uWbqxLPaSWtPR5zWhF/vbZSwh++0OGK7qcT68/WdlVRbl02YxIbw+5agm/KO805V4KNl
         9YpQ==
X-Gm-Message-State: APjAAAX2ZHC66CFdDTqBxivirXSSm6S4fKnh1/LRCvOJOjMZTVCkqGkc
        qUdHFLuejj56kxpeNvUthIbZMGUYM/4=
X-Google-Smtp-Source: APXvYqzWJgqHu3d72ezigTTH0cJIFgdoFKWpdSPxBUDBrA7hML392iC7SxlikqPVx2bK1l7OvxAxRw==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr36471612lji.64.1568606218444;
        Sun, 15 Sep 2019 20:56:58 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r6sm2000862lfn.29.2019.09.15.20.56.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 20:56:56 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id d5so32310678lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:56:55 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr5154441ljs.156.1568606215653;
 Sun, 15 Sep 2019 20:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login> <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
 <20190916032327.GB22035@mit.edu> <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
In-Reply-To: <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 20:56:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPDR6_crhmvaoXDo8q6Joz5rD02bZpd2x9rr-LazPxRA@mail.gmail.com>
Message-ID: <CAHk-=wjPDR6_crhmvaoXDo8q6Joz5rD02bZpd2x9rr-LazPxRA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 8:40 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you want secure keys, you can't rely on a blocking model, because
> it ends up not working. Blocking leads to problems.

Side note: I'd argue that (despite my earlier mis-understanding) the
only really valid use of "block until there is entropy" is the
systemd-random-seed model that blocks not because it wants a secure
key, but blocks because it wants to save the (now properly) random
seed for later.

So apologies to Lennart - he was very much right, and I mis-understood
Ahmed's bug report. Systemd was blameless, and blocked correctly.

While blocking for actual random keys was the usual bug, just for that
silly and pointless MIT cookie that doesn't even need the secure
randomness.

But because the getrandom() interface was mis-designed (and only
_looks_ like a more convenient interface for /dev/urandom, without
being one), the MIT cookie code got the blocking whether it wanted to
or not.

Just say no to blocking for key data.

            Linus
