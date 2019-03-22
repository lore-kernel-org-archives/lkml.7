Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A51A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWwbDMl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCVBeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:34:25 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:40682 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfCVBeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:34:25 -0400
Received: by mail-pg1-f176.google.com with SMTP id u9so310956pgo.7;
        Thu, 21 Mar 2019 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8aqHsW8JcapCofl+YH/dCzbvTqp7scjhme0ZJfomfWU=;
        b=KWwbDMl9Qe+BPtbJbX8KxquzN0eCieYViNZemNQw1CJvLGys81uUIuaX+pexvstUju
         344us/BEQUaKlgY4slS6CYAvWXjwrH4ilyMOUMvujcO2Hzo2a9rgjnjUS1VAeHT+AP1X
         dfoCDk2F4/QWKbyNE9dR9FUoju7gWuZKUFekjIO7NuCQy4+la/NLJ6HloY05ZIt8QJMi
         Dg/wdh5z25HJACEaIrwwg8UAJJpt6qll/gKEkIJlbEI9X5Xo7lXBXIu9rvPcb6aRVns6
         Y0Y/rk4KeOAbDw6w9p+FjVMyRkkmUy+JP9P+lviveZx6I81xrkXOY/aRmUHN3QwbBaZE
         nldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8aqHsW8JcapCofl+YH/dCzbvTqp7scjhme0ZJfomfWU=;
        b=iDqjVkGD7x32Znlp2k2aUIAQnVmX3GEbWLNIN6gYTYCw4PZnWjIw/pXnEiBSoti+fK
         jGhE5wR3T/AaePhBwpjpEZQ8KGVG0tw+4dab+pFCsJphCyGM7lAf7qRYnKKx7Dy6GfBF
         YrmWLnBwH4Iy/8Zkuet3hfSG78VX9RC3HLixxDbQg7tmCnMsDlmnsmfya6d8F931a1GK
         M1Tnlanq2D7UBDORXsrsrwarRwGWgySkX5X1ry1yKzKJCuVq1pMPwGDOBIpnjrk8ZAIe
         gYCEhCqPYaa8Qpwo9t5VJ9DDeyLYBSBoXQ8HEF0WvWAJ1mOTyhOe+lX/BqR4bUqYpBfP
         tl3w==
X-Gm-Message-State: APjAAAUd36GkN4FvBnoVVSVbh1DSIZiQnnky0kf21sAAYG/M5stgMx+I
        XeYel0YGXn01MJkZgDosyEM=
X-Google-Smtp-Source: APXvYqw7chzlfzrE4CPh7ZUlr4HOfmFJgsZ0XPQxSeMpRfMeW6COrLrwoGJrEwZ+O0IiR43xvv/Rdg==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr6447768pgr.48.1553218463898;
        Thu, 21 Mar 2019 18:34:23 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id w67sm10634754pfw.173.2019.03.21.18.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:34:23 -0700 (PDT)
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
From:   Frank Rowand <frowand.list@gmail.com>
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
        Knut Omang <knut.omang@oracle.com>
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
Message-ID: <767d14bf-3429-58b7-dcbf-c8ef86133265@gmail.com>
Date:   Thu, 21 Mar 2019 18:34:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bb5bcd3d-a09a-cfbe-c7fa-16e5eb75b0e4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 5:22 PM, Frank Rowand wrote:
> On 2/27/19 7:52 PM, Brendan Higgins wrote:

< snip >

>> Now I know that, hermeticity especially, but other features as well
>> (test suite summary, error on unused test case function, etc) are not
>> actually in KUnit as it is under consideration here. Maybe it would be
>> best to save these last two patches (18/19, and 19/19) until I have
>> these other features checked in and reconsider them then?
> 
> Thanks for leaving 18/19 and 19/19 off in v4.

Oops, they got into v4 but as 16/17 and 17/17, I think.  But it sounds
like you are planning to leave them out of v5.

> 
> -Frank
