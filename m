Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA65C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B179218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jed/ZBxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCVBrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:47:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfCVBrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:47:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so381745pff.3;
        Thu, 21 Mar 2019 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Rdn/0bCCJC02mpdJgqbDeyik9/k0VweQXkLGqLKN8o=;
        b=Jed/ZBxo0WgVo38E2ViocCFdUtZfyYZOpW7AYrnxcXPwOwvcJBfeCzacJifmi09A5h
         5WrXcEW67FY0Uxfl2mX1qZWXPnqVplZhJi1xyEp9t2RC1HLPEH9pVDtnMeFjRTfxuFEA
         GwzJ2PNYW0Swioa+WSEby0d7BIb+sYQ9cbvCOhpBxt5hH1K4kZ+oq8BFQ0s8yRRGW/ER
         d9nftZ4ivV6a51uSskU6tCwDe8vBD4s8LRP+sFcj5TbO8ZyCp3LtfUCM1yyBrdYl7R5X
         cO8klcg1G3BTdR6eVjU1fBzfS01tGcJy7aSbL5m9Y4gJRt4Nu8YuT/IWMTlguAQ+vLtJ
         3YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Rdn/0bCCJC02mpdJgqbDeyik9/k0VweQXkLGqLKN8o=;
        b=eLWUV9pNcooA0uZPVJF+W/LG+6XR9oOSHxNZKq91jMowr8HBfDWTlHomyZbOXC6H2B
         dh0F+M+h0ItHAAzqHhYDjIBLuq3sai/dGkxZGP+QNnC4ghneYAXdZPfmRiTPWU2W0IsU
         Gu0bIZ0d52xVuxmu57fm4qVkmLOJcjiUvaAfMlIYHLHhU/ZIkHPcmDgtu1tZ6wHZrVPg
         ubSPVTVZcjCrPWl/u6vqW65buRpWEGtq94TB762bpApibuWMpyDyhm3+Yw24hlfbwoTw
         DprYVqQZtMoIalIrO2s5OHE1rYSfIMQNQRRjX5L1YVWZkkGRot7PnrNmqPVgI51iq79M
         RUZA==
X-Gm-Message-State: APjAAAUy/e+zrBRRg71ALEzXSts9p+hp/njvFivoP+17swGFsusV9KCn
        43jcue5eLBYVN4+ccASMebk=
X-Google-Smtp-Source: APXvYqy/hGOta4IJ96Cr/4ODKRX76GkYY1raKvboZtGQYV65izD1dy/3ObjggWoFstkmRVyZd9gFSw==
X-Received: by 2002:a17:902:284b:: with SMTP id e69mr6689994plb.11.1553219258560;
        Thu, 21 Mar 2019 18:47:38 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 71sm9969386pgc.23.2019.03.21.18.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:47:37 -0700 (PDT)
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>,
        Frank Rowand <frowand.list@gmail.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com>
 <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
 <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com>
 <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
 <0e311e88-c4d4-e98d-1720-53a04bd526fc@gmail.com>
 <CAFd5g44NTZoSAJPMvXP2xvJgn7m5QoV-KJu2AMrr67+eL+CKrQ@mail.gmail.com>
 <d9f7e000-4cac-a35a-3ff9-60130e12ebea@gmail.com>
 <72cd1c5b-6f68-73ad-c8fd-f3a3268a0529@gmail.com>
 <CAFd5g46UU9wk+F6A5wnKYYtYKmmtv__SaY8eg6v-T9xUjsoxhA@mail.gmail.com>
 <bb5bcd3d-a09a-cfbe-c7fa-16e5eb75b0e4@gmail.com>
 <CAFd5g448xQLOJwVYU5Zmu4+OPWuboiWZPhBvK6au8Pgm5B9haQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <bf094685-3f2a-dc7b-7291-0340136b87f3@gmail.com>
Date:   Thu, 21 Mar 2019 18:47:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g448xQLOJwVYU5Zmu4+OPWuboiWZPhBvK6au8Pgm5B9haQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 6:30 PM, Brendan Higgins wrote:
> On Thu, Mar 21, 2019 at 5:22 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2/27/19 7:52 PM, Brendan Higgins wrote:

< snip >  but thanks for the comments in the snipped section.


>>
>> Thanks for leaving 18/19 and 19/19 off in v4.
> 
> Sure, no problem. It was pretty clear that it was a waste of both of
> our times to continue discussing those at this juncture. :-)
> 
> Do you still want me to try to convert the DT not-exactly-unittest to
> KUnit? I would kind of prefer (I don't feel *super* strongly about the
> matter) we don't call it that since I was intending for it to be the
> flagship initial example, but I certainly don't mind trying to clean
> this patch up to get it up to snuff. It's really just a question of
> whether it is worth it to you.

In the long term, if KUnit is adopted by the kernel, then I think it
probably makes sense for devicetree unittest to convert from using
our own unittest() function to report an individual test pass/fail
to instead use something like KUNIT_EXPECT_*() to provide more
consistent test messages to test frameworks.  That is assuming
KUNIT_EXPECT_*() provides comparable functionality.  I still have
not looked into that question since the converted tests (patch 15/17
in v4) still does not execute without throwing internal errors.

If that conversion occurred, I would also avoid the ASSERTs.

> 
> < snip >
> 
> Cheers!
> 

