Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2270BC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C2A208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563741541;
	bh=hYvRrhbpdsyO4Qp79Qe8iUUhmkNadJdoita/rQ/p/20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Nxpf6z3DmFaYnvWvhaU8C9MLPCSDYU3Vw1VzozNk5emaeWlkYVtqMgauadH9aSsMt
	 OcjXSPvZuR5a6s1Tc/0iVQnQ8zSahwUasXOVvxN+L07zMmlIWszZUgmU9DA+tHvliL
	 QpwDHFEUSPZrvUiWqzbbX518xZ4s+p96rlB2SFXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfGUUi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:38:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44082 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGUUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:38:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so35474814ljc.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFhbBpOoZTNy9EMhjzpqd/YuAOOhoH6s3ZbDQhN/5VM=;
        b=EYyAu5FNL7gKp0HuaHxd3VFhuw6OMNQ1ynqqj6BKsVxhnlAOQzaSgoqA2/t5l63YVC
         UK7L9wQH/n7peWeSk05TUKDMFY6v8Jwp73ku2LrkRQvdJHt7ULoCbcRQ5wDFhLLVzafi
         fWcVH07bkb/MP62sTSMXJXpR9LaasGZFbWyfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFhbBpOoZTNy9EMhjzpqd/YuAOOhoH6s3ZbDQhN/5VM=;
        b=Ngg9neb3z0WJ2grJ7kmygA466dngAGzaQHTVh1nmE2zVEUDUOzA7bKK2Zo5EBNjBXC
         kYbRYabEk3pFidMcOCSVpB7YEXhWG+gbvEqqJF/9XmVGtlm/4vxRX/QyJVrr+6jvXOwB
         9bexU9eZLdj2+6O+dfuoYO7JRxzaoIyQhbxqkT5y3U7w3P+jNJLUANGg2nNgqKwq3qB4
         ijK6nKR7/QopEGEXZHkQYLkL83gaBvZnoDo7o0Rkegghg1jVLZShbm70nSXo3v0Vqnll
         ZzHyE401NDO7y05Yk8aO2Ui3J5PWSqelCQsYQ9PID8PIylxyjspmOT3+i5HK+qu7Z5y3
         Jy2A==
X-Gm-Message-State: APjAAAXcbjTwtvbc1/in7M2B1IYRUlSY03ZSavRk10Pgcn8yimlK0zT+
        UmB/CQiVQK61jCB7SzCC7QCFxmhqlAE=
X-Google-Smtp-Source: APXvYqzhYpEtzNlhEX9Do0kHPX+QL9JtXzOLTgANG+R54MWtgSVUepXo0rpYBTj0tvaNg+ft6GVOkA==
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr6938221lji.84.1563741536723;
        Sun, 21 Jul 2019 13:38:56 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v7sm7260285ljj.3.2019.07.21.13.38.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 13:38:56 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id v85so25069999lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 13:38:55 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr30384046lfd.106.1563741535585;
 Sun, 21 Jul 2019 13:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190721201956.941-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190721201956.941-1-daniel.vetter@ffwll.ch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Jul 2019 13:38:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaHB_0bS_x=p-xeyp7bW7bGgkZ9QkXe6SS9axu7OP95w@mail.gmail.com>
Message-ID: <CAHk-=wiaHB_0bS_x=p-xeyp7bW7bGgkZ9QkXe6SS9axu7OP95w@mail.gmail.com>
Subject: Re: [PATCH] fbdev: Ditch fb_edid_add_monspecs
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tavis Ormandy <taviso@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 1:20 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> It's dead code ever since

Lovely. Ack.

               Linus
