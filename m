Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23185C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33A221900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm+JsRSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfCVBX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:23:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42744 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfCVBX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:23:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so326405pfn.9;
        Thu, 21 Mar 2019 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B46QIBIzguzuQr0SfuXfjkWdBRNFyX9AyKWMSdbfBrg=;
        b=hm+JsRStu8C/idqnAUcPxMv/7/cyum/wXukiXx4IJ411SupdBv6419L//2590d099x
         quAecFUcgdHHQDGeJYJs9hsQ1BWvR11ZXIwGllJrN7BKTStP7SDvYSOKl1EO53MQxv/m
         8IT1MJOj59rElmeXYLbx2oZrYkBVYffg/a1cvOwgXvJeOHv3BrVZFvQFKYS4Dsfj4dUU
         mQ2APCXx18mNa5SFnctRM+6fmvpssO+WKi4zUuD0Ihhvxrp1x+dwRJF7MvYJZDUEEDqS
         dRdgxt+e+8K3K1egiEaT9l9JRpd7ypfn2q90Xv3owDldfbXcv+hJYkrhJurr/XGzrQMJ
         wcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B46QIBIzguzuQr0SfuXfjkWdBRNFyX9AyKWMSdbfBrg=;
        b=kFci9sX5kB3DAdz5Qtp4k731SrVysMGZFIibvvrFsYJTJKrxC5EbALDWMs4dnyH4cH
         zINKLWILOu5GBX+owjKzZ03eVG2hB4N3kMzQhNRko3g/se0kFj/bYUgOxWHhowWzkUuD
         n/rPK1dmS1kDWtoE1YwpZmgGMqBxq1jRTg2uKH+eFuSAKeAUZSZVDjYO7uTreQ5rAy/l
         RxVyKSbjCdN8RiiE8O7Ii2ZXwBUJZITvoPcbpCZ8/keG5sZhCF45E4HrpFLC04hwznGT
         Y+0CZN+W2rswU9h+XkZ8DERBY5iss7D0tAZHrcFygXdmqmSrj1R7XjYbu49QWW9BZ3+N
         0EyQ==
X-Gm-Message-State: APjAAAVrZbyGkT8V2w6YUXP3bgwYglQ32Ljv1HLmiiwlYccEhct1JdZB
        ebq/exnsawWJAKyfPVINjfA=
X-Google-Smtp-Source: APXvYqwnlQ/k+jEHKf0clvUlHm1msVn6VbfcmcKWsrFFCEVlaK+EdjFaQbltlhnKzDDbuxO3s/gNfA==
X-Received: by 2002:a63:5452:: with SMTP id e18mr6371830pgm.386.1553217836568;
        Thu, 21 Mar 2019 18:23:56 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id k9sm11422638pfc.57.2019.03.21.18.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:23:56 -0700 (PDT)
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <CAFd5g45F3YUsAjse+Vt5hj5CLjaXrRWgr5zCZZ6CJKc0hboP6Q@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0e6eb370-3e62-e1a5-1b91-bccc5868e8e4@gmail.com>
Date:   Thu, 21 Mar 2019 18:23:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g45F3YUsAjse+Vt5hj5CLjaXrRWgr5zCZZ6CJKc0hboP6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 3:01 PM, Brendan Higgins wrote:
> On Thu, Feb 14, 2019 at 1:38 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>>
>> This patch set proposes KUnit, a lightweight unit testing and mocking
>> framework for the Linux kernel.
>>
> 
> <snip>
> 
>> ## More information on KUnit
>>
>> There is a bunch of documentation near the end of this patch set that
>> describes how to use KUnit and best practices for writing unit tests.
>> For convenience I am hosting the compiled docs here:
>> https://google.github.io/kunit-docs/third_party/kernel/docs/
>> Additionally for convenience, I have applied these patches to a branch:
>> https://kunit.googlesource.com/linux/+/kunit/rfc/5.0-rc5/v4
>> The repo may be cloned with:
>> git clone https://kunit.googlesource.com/linux
>> This patchset is on the kunit/rfc/5.0-rc5/v4 branch.
>>
>> ## Changes Since Last Version
>>
>>  - Got KUnit working on (hypothetically) all architectures (tested on
>>    x86), as per Rob's (and other's) request
>>  - Punting all KUnit features/patches depending on UML for now.
>>  - Broke out UML specific support into arch/um/* as per "[RFC v3 01/19]
>>    kunit: test: add KUnit test runner core", as requested by Luis.
>>  - Added support to kunit_tool to allow it to build kernels in external
>>    directories, as suggested by Kieran.
>>  - Added a UML defconfig, and a config fragment for KUnit as suggested
>>    by Kieran and Luis.
>>  - Cleaned up, and reformatted a bunch of stuff.
>>
>> --
>> 2.21.0.rc0.258.g878e2cd30e-goog
>>
> 
> Someone suggested I should send the next revision out as "PATCH"
> instead of "RFC" since there seems to be general consensus about
> everything at a high level, with a couple exceptions.
> 
> At this time I am planning on sending the next revision out as "[PATCH
> v1 00/NN] kunit: introduce KUnit, the Linux kernel unit testing
> framework". Initially I wasn't sure if the next revision should be
> "[PATCH v1 ...]" or "[PATCH v5 ...]". Please let me know if you have a
> strong objection to the former.
> 
> In the next revision, I will be dropping the last two of three patches
> for the DT unit tests as there doesn't seem to be enough features
> currently available to justify the heavy refactoring I did; however, I

Thank you.


> will still include the patch that just converts everything over to
> KUnit without restructuring the test cases:
> https://lkml.org/lkml/2019/2/14/1133

The link doesn't work for me (don't worry about that), so I'm assuming
this is:

   [RFC v4 15/17] of: unittest: migrate tests to run on KUnit

The conversation on that patch ended after:

   >> After adding patch 15, there are a lot of "unittest internal error" messages.
   > 
   > Yeah, I meant to ask you about that. I thought it was due to a change
   > you made, but after further examination, just now, I found it was my
   > fault. Sorry for not mentioning that anywhere. I will fix it in v5.

It is not worth my time to look at patch 15 when it is that broken.  So I
have not done any review of it.

So no, I think you are still in the RFC stage unless you drop patch 15.

> 
> I should have the next revision out in a week or so.
> 

