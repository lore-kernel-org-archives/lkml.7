Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83272C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0C1222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570225720;
	bh=WA3T/PAtDprvjgAO0DxDIqyu/cLUaJW7k84J4sbMSlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HdjERgG12m7hUC57xSaCs7xXuo72k8N6pNZkKjILT3S6Tlpct/2a/IZcuDP/kpMLZ
	 +hjDef0R3XpkM6gCYHurHewQ0/v0h0dOl9hGhrl+q8P0mQpMv8HQffgUlcUw8AQTcQ
	 yzy+dgxnCmY16tMLzmVh2AGaTuPXXe59x2TiE+BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfJDVsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:48:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37417 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJDVsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:48:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so7940141lje.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSvi6bN3MgmA9q6zMgIL0cUcdQWLY9tbHblghBTgstI=;
        b=hBuewRInP5i+6gtlRLW9UtlDY0YPe0z67E0xbXSSSKYA7biQf+uXTlrPp7zLuAUPeq
         5uQ2rwixtXebf99m1RfUdMDyjGKPh3VgF3DuF8NvshRtQGRa2wNkvwDCWMNQ0VKjXHWB
         ZmI6XqYkyQwmdmiffnmLI1+ZMJ0oT9STysqR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSvi6bN3MgmA9q6zMgIL0cUcdQWLY9tbHblghBTgstI=;
        b=gtFvGo54fP6FCMpghCBK0KW0WxtOwtI17EEhfbDZeIr30IaABFRMcXG9qF6dY2A13Z
         9hQVgFwQSuEVu4DAwQh9a7s8tba8WjftVOSwwP18Xn1qg6hopiON751fVG4YhyT55a2n
         8VuTw4/9G2wiy6Kf3V9+OOsR01E+mzlgoHrFgge4hIfPKi3d9+sSwFatwuBlteK5u8q2
         Lq9tB6EccwJECkIjNiuOJoKYyfg+42rB988RaR6PxUmYDU0jDBtNVeLrmCTTXlJz0OSn
         G/to35Zddr+/YphnD38lzbqbiDqIvgmACohMp8HiTZPBU3PyjqCIVC2BKlQaPUbUnSLZ
         0F9A==
X-Gm-Message-State: APjAAAXC2tBUn/zgmboHbn8PF0H2z7NMPq1pgztS/HhExgL0AZOeZWDN
        znXRgxeQRCq9IDAuf9QYG7hPtPfvGzI=
X-Google-Smtp-Source: APXvYqyYoPX0suHREaVTfCqPa1djgbBm9vi35cZDHzpc6+3ezCSM2a9/5U8VtWXfEncjDzHHUexgNg==
X-Received: by 2002:a2e:7d0d:: with SMTP id y13mr10876610ljc.170.1570225716623;
        Fri, 04 Oct 2019 14:48:36 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id n3sm1344200lfl.62.2019.10.04.14.48.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 14:48:36 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x80so5476444lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:48:36 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr10113290lfc.106.1570225353484;
 Fri, 04 Oct 2019 14:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com> <20191004213812.GA24644@mit.edu>
In-Reply-To: <20191004213812.GA24644@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Oct 2019 14:42:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
Message-ID: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        kieran.bingham@ideasonboard.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, robh@kernel.org,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>, Tim.Bird@sony.com,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> This question is primarily directed at Shuah and Linus....
>
> What's the current status of the kunit series now that Brendan has
> moved it out of the top-level kunit directory as Linus has requested?

We seemed to decide to just wait for 5.5, but there is nothing that
looks to block that. And I encouraged Shuah to find more kunit cases
for when it _does_ get merged.

So if the kunit branch is stable, and people want to start using it
for their unit tests, then I think that would be a good idea, and then
during the 5.5 merge window we'll not just get the infrastructure,
we'll get a few more users too and not just examples.

             Linus
