Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D371AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7252184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555021630;
	bh=uTFkXkVdh/O7ixJtZ7bO2us+9D2yox0RXxQZN09Bofw=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=v8ofLeJ9Grl+3m/kuxSjJ3qOKBYfUvTyP7e14+yRSY1KidLW8FEdnVGr2dQQyMGLZ
	 557vIbq5mwwadncn6+gdXyvzQI5sMyF+9KAu/QCzMQqKWVHcae/Vg701qg7oB7ud+P
	 h6xLfiAP5e6FkJXekPGOqxn/9TwXKx+CGyOSvgOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDKW1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:27:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46573 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKW1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:27:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so9030923qts.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uTFkXkVdh/O7ixJtZ7bO2us+9D2yox0RXxQZN09Bofw=;
        b=UpfauI5G8dK9MFaxmZ6TrYsKjf75tbtr7Bg3NWfCQASLHnCiNQlyw4EREk5qP0tsUr
         uCI19XKKlKOazg9XmNum+RHN+3f3c0T53oCC4oXlhhhOtHzhGgjDrD0sH89dURTt+tsG
         9eIenLt86vWkYCIzOjI20uDKXRdOrcGzG1Q54zu8tvBXBT78xzswkLWxdNgGsmRxNwuQ
         FF63O35kKZ49hRAm/e+XoZBo+P2FDm7DqVtRqAnW3uOcLFCS+uMrVbIy4qeQn6jFiW3j
         qam8/DfdjHE7dmNRi3HwLf0Fs5DDmJ+RtD4NKfYU4n6Istaz1ltVRbnO5IWYfAiz1/E7
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uTFkXkVdh/O7ixJtZ7bO2us+9D2yox0RXxQZN09Bofw=;
        b=D6AsHpQhoOLS1J6uMRq9YtFPYnPO13wy0lfKc9PpfeQUflUz7qgYDWsTZ0qIQWA4IK
         ZK4PiQ14b7wu0klTVzG4fHO7jkXdSykJHJdE6m7bjPv2m9lsWMNBXfDDDx9C18TeiGNT
         Mr0eCyE8xSOQA4yg4XRZOLfflBewh+EYzGtyHPI5btD9N98swjXSauDt0wE7TDI9DDlI
         uOwIb7o+UxaPPgmrZIZSf4e8fV9vTYD4b5YvBHQRoiLk/owQhjUSyyMdnVjSHnx/xKr6
         DqHZ3pw7boVKJWT5TAGufglTBiQvEOQ2MaElhtqCpem7iSwmpN3nld1LGwORvTUrOyAB
         +fGA==
X-Gm-Message-State: APjAAAX2xmgzANRVtooKK3pyLJiOx+Rr35+kNu0PhDsf8xDFTubOMfcA
        UNBoJElO+t+2/xQPhto9FjU=
X-Google-Smtp-Source: APXvYqyG0Zy8cwQQrpDxeEIkbzcWh7vyHccO4N+DP2ggd+a+TVidKXEXLjY3EENwWwxK9ASCiEZ4rw==
X-Received: by 2002:a0c:c988:: with SMTP id b8mr42921864qvk.33.1555021626339;
        Thu, 11 Apr 2019 15:27:06 -0700 (PDT)
Received: from [10.84.150.23] ([167.220.148.23])
        by smtp.gmail.com with ESMTPSA id u3sm24733958qtk.97.2019.04.11.15.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:27:05 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2] init: Do not select DEBUG_KERNEL by default
To:     Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>
References: <20190410224213.20651-1-okaya@kernel.org>
 <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
 <135E84E9-F068-44CB-B4F6-A5AC2F4CDE3D@joshtriplett.org>
 <CAGXu5jLc_Z=TiNsMd40GN8-0D117RVbdD7Hy4MzjPQNbFf=bcg@mail.gmail.com>
 <FF2E07CA-99D7-4F9C-B281-425897535C84@joshtriplett.org>
 <e901a9cc-f335-fb31-535c-97dce2ca8f5b@kernel.org>
 <20190411221645.GA8692@localhost>
 <CAGXu5jKa4dUuCxc1kPdRGH5qrXeH0y09hnScb41-SQDo_amv8Q@mail.gmail.com>
Message-ID: <c3d57b73-c282-6114-52a8-2375b5dd0b61@kernel.org>
Date:   Thu, 11 Apr 2019 18:27:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKa4dUuCxc1kPdRGH5qrXeH0y09hnScb41-SQDo_amv8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2019 6:21 PM, Kees Cook wrote:
>> Proposed alternative plan: let's add a new symbol, something like
>> DEBUG_MISC ("Miscellaneous debug code that should be under a more
>> specific debug option but isn't"), make it depend on DEBUG_KERNEL and be
>> "default DEBUG_KERNEL" but allow itself to be turned off, and then
>> mechanically change the small handful of "#ifdef CONFIG_DEBUG_KERNEL" to
>> "#ifdef CONFIG_DEBUG_MISC".
>>
>> Does that sound like an appropriately rapid solution for this bug?
> Sure, that sounds fine to me. Sinan can you take care of that for v4?

Sure, let me work on this.
