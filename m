Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE62C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916B420675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sIyWfeXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfFTPVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:21:20 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:36776 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfFTPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:21:20 -0400
Received: by mail-yb1-f173.google.com with SMTP id w6so1387849ybo.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWcTTKF/82/ExwUFM1sAVWc5mPz5k5o+tscsjovzbdY=;
        b=sIyWfeXi6KwmuxnVzP1J8xyTlUH5LBx2rOkbUmIHEEbH4qtiKxfEot6fOUNodIzm22
         BOJW1KLRlcqTIDUm8mvA/hgZCQETxs35ZW/FmAUe6Zz32N7cSqPifP+EbGHCidGq3khp
         Eof5Mn2YrAR2RN89YJGr1V3fs4rAfIqkKhf4LvfOAOrYz+abZYmErCDqSUVwQkTUMKRq
         Vx4ZzS+Hgyd1dAsgOYqaHRnJYgP/FhxvvhspEM7MWOkB6uUALFE/ST9Kwm4Agq9rbdul
         Lbs78S9dLslqZ+yiWdtzwaU9D+5G10ulweUt/JDewc/ksWRSjfGvLCDAoDnMHSTGA8bi
         YjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWcTTKF/82/ExwUFM1sAVWc5mPz5k5o+tscsjovzbdY=;
        b=ZlqwQCA7dA+Yk1DOS+FwV/FuUOQP+d21/cTfXRxr+j/gIilIjcuyDbImTvdgEoufpk
         huXiHdGKOYwHn6ZWxUdHxaLRrn+CFm5AB5k2ww2HrKDK1ZJFio3Ye/oCVMVI3G9GGsag
         dP//rhRn3DYcV/9u9CAAOMN5KnsI+nDW1XFMRAycalVJx3Uc7LUM1G0os0ocg98dF7VG
         sA9tQSHEcjzNo5VOcEQmUaKZFD0vrngm1AxhClwycvmKXmwnudHHzxiFPP4yYj2Uzy1E
         +CVaDeT2KuK3pWtF+4yI9EICMWuw9Tf+KFyAaA0L4cn3CL+5Tl2cm+wrXVu22dJ6sGao
         oafg==
X-Gm-Message-State: APjAAAX2N2v/ittBaJ2KFGq1G5dJ/tERDPGUlAZ9L2jWksVm0/VSW27u
        XksYtlM2XW56IPDdUIsYmbNhyPqqQ3eYbLOLV3Btlg==
X-Google-Smtp-Source: APXvYqw+46mmXl47rsAlKbBelFwFwq7OOcf4h9cRWpPp+rUk2J7SVChb5VwvnPH8XQ2VsyehJ0FK86XudESDLPdUqXs=
X-Received: by 2002:a25:bf83:: with SMTP id l3mr67617590ybk.446.1561044078765;
 Thu, 20 Jun 2019 08:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <1561042360-20480-1-git-send-email-cai@lca.pw>
In-Reply-To: <1561042360-20480-1-git-send-email-cai@lca.pw>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 20 Jun 2019 11:21:07 -0400
Message-ID: <CANn89iLBy+u3KTjjfvyc8-r4eUdL2b6VX=fNgqFg8f7t84EUNw@mail.gmail.com>
Subject: Re: [PATCH -next] inet: fix compilation warnings in fqdir_pre_exit()
To:     Qian Cai <cai@lca.pw>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 10:52 AM Qian Cai <cai@lca.pw> wrote:
>
> The linux-next commit "inet: fix various use-after-free in defrags
> units" [1] introduced compilation warnings,
>
> ./include/net/inet_frag.h:117:1: warning: 'inline' is not at beginning
> of declaration [-Wold-style-declaration]
>  static void inline fqdir_pre_exit(struct fqdir *fqdir)
>  ^~~~~~

Interesting warning, this is kind of new compiler major feature I guess :/

BTW :

$ git grep -n "static void inline"  | wc -l
9
