Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA8FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 06:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BE82089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 06:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gdiYDH2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfIMGL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 02:11:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45748 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfIMGL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 02:11:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so21189618lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 23:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R/K1vQUHZEwV1W95kV0s91z3Z0oEdJdKOjyfPcHhkNw=;
        b=gdiYDH2BdkgR+dq3uVZ40rAx3LUdqoBEZVZJkQZJcDCcI4Rn7xiEubzH9WdB9U/Wmu
         +cXy/4/W3FjcYNvuhMy+MgiiVgK060L8LnzLXykmy/ejqAegnDrX8XAsxrxTosclLiGn
         uTzgE04lMvx7TGAKCPwAQYkT0DpziVFcGxuLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/K1vQUHZEwV1W95kV0s91z3Z0oEdJdKOjyfPcHhkNw=;
        b=tOwWbFyvo4kBuPJyzYl1LtU9crUOfucT/vTEKC1dRNz3xIxXwp68754ihiHDotssx5
         zRpJW85Z5AtRk25szNQeP1cG/yFmeEtT5p0mZYvjwM/5WHQHHFULCsK3yEvAzl6xBBoo
         fHjzBc3Ew8A1KCYX9933IjPpldOYA6x0FTqdZem8ScdrGrhp18ByJqj5ez9CGzBIEWL+
         3o7akfLOeFA5gOta+JZFHnQTGFD0h9D8HOwbu69SLGUNMhNiQN9wVQ7BC4ThFMbkfJWb
         aUkQZLwR7WUaooLIW9RXwacLYwVgt1mku45uxsnIMl6GojKBMogZx+73IVA4NZRcntkz
         dLQg==
X-Gm-Message-State: APjAAAV11qITnBMIm0z0ZadWNjFdvFFRju0d0C18dwLU7pxeL7lpoFo2
        kRq3262Dt0hftT/TRvL1khiw3wGe/v/Y/Rk0
X-Google-Smtp-Source: APXvYqy7FyZ4U44Jbx/pb8pLaVSQTSWwaUMPzp8ugSZPfTNcig3dznvvpzORMdtTDKSp1khqDLNmFQ==
X-Received: by 2002:a19:4bd7:: with SMTP id y206mr4426716lfa.9.1568355086349;
        Thu, 12 Sep 2019 23:11:26 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r27sm6000064ljn.60.2019.09.12.23.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 23:11:25 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] make use of gcc 9's "asm inline()"
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
 <CANiq72n_KxKGwrN4onWotocTuZjVSAqENF_5Pk9t1-pk7NDrgQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d47740cc-a373-91a9-df33-d2def69a370d@rasmusvillemoes.dk>
Date:   Fri, 13 Sep 2019 08:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANiq72n_KxKGwrN4onWotocTuZjVSAqENF_5Pk9t1-pk7NDrgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2019 00.30, Miguel Ojeda wrote:
> On Fri, Sep 13, 2019 at 12:19 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> Patch 1 has already been picked up by Greg in staging-next, it's
>> included here for completeness. I don't know how to route the rest, or
>> if they should simply wait for 5.5 given how close we are to the merge
>> window for 5.4.
> 
> If you want I can pick this up in compiler-attributes and submit it as
> a whole if we get Acks from rtl8723bs/x86/...maintainers.

Ingo has now acked the x86 parts, and Greg has already picked up the
rtl8723bs patch, which is at least an implicit ack. I'm just unsure of
how and if it will work if you also pick up that one - but, if you
don't, your tree would be (somewhat) dependent on Greg's staging-next :(

Rasmus
