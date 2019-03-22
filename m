Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BEEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307D62190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1iECVvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfCVA16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:27:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46949 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVA16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:27:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so232119pfj.13;
        Thu, 21 Mar 2019 17:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IsboZMZzpqO5S/0DS4OcY4AmfYrMhfnNfJkBZoSGcQU=;
        b=Y1iECVvIVVSpwd9pAmqVNcGMmvzJCj9l/MRub8b+Vi2ThATVmBdw3MXvnXBWsYGuUI
         Fk2Kv4ylgKnkjuVhBGkJTkyTEiRSh+UdhZuaRic/RhB4sJqxi8tmyWEIVPpceZOTj7Wk
         KVJvRvC92QBC2YjIKbAcfYhYmfVeL6IiagsWWWkkOL+Q+/gXNnVz+GLcTlpHSPSyEeEk
         9H2UN6LBjmb4zeOPfdoJvlgbqw2xBEEQZPRnuhzBu3P5fATt+8XDqPuFUcvhGenIogaA
         ARjQmYoTViiE2nRWjElg5RKaSAG+JaJM8Nw2Umv6B3DXKtqYLMWrC5bBWTHVKBSxKrn3
         lPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IsboZMZzpqO5S/0DS4OcY4AmfYrMhfnNfJkBZoSGcQU=;
        b=TJhSaGqzSM3bPmeEotS4cpshLOrA6CrGsKYy6ww3xHBCNf5coES5TpaFN0/ll71J17
         r0exvE947H+q/Y+E26UdJ8/spuPmwHKDl3w/DjBjs9UMMRiPX3fU3qtm249E5PJ8Q8yV
         H8xUa7CBqrxhy8XijuE6yq41pmuMzYQG354EhoM8ZerCvICS4Ma1LpRFFXbdzK5NNtKd
         AxID7DinyF+wueXJJnIOQOhlfKbVcSsbgpGs6wIuKnxtu4G0XJnHSDrrFBoF+Go5F69I
         z//xpI3jEcrMi4mqWDUO/mh9P2GGB/AUBxxrkpKv04fJlrbqK5XwxdDosd4lyL7WyJEn
         D5tA==
X-Gm-Message-State: APjAAAWA/cSooPtfh4mFdREmH+hSV5MKWVJRMqtoV4p2VdRnYD80xPS0
        Xita9dpKSDt3y8PkDbtQX98=
X-Google-Smtp-Source: APXvYqzQvgd1Ni9qH3lox2p4l/bauvjKgF7KVLLt2U5+4vb5cUYKLMhoEFWIg/U5Y0QcplivPBnw4Q==
X-Received: by 2002:a62:1342:: with SMTP id b63mr6196962pfj.7.1553214477765;
        Thu, 21 Mar 2019 17:27:57 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z124sm13935947pfb.150.2019.03.21.17.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 17:27:56 -0700 (PDT)
Subject: Re: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, kieran.bingham@ideasonboard.com,
        Knut Omang <knut.omang@oracle.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <f34ee937-83d6-3ff6-12b3-c6cd9acbfc38@gmail.com>
 <CAL_JsqL0t_p8=Ueq4mHS5i2YEQdc7S7AtPWfkcOsj1g2SixUkA@mail.gmail.com>
 <CAFd5g47cDKSdXGAL8pbDxEU2O8A-9Ajq1wCM+PtPF40T4wYKow@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ec4c1020-4b53-e0f2-4a9d-3fc73af56746@gmail.com>
Date:   Thu, 21 Mar 2019 17:27:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47cDKSdXGAL8pbDxEU2O8A-9Ajq1wCM+PtPF40T4wYKow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 3:10 PM, Brendan Higgins wrote:
> On Tue, Dec 4, 2018 at 5:49 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Tue, Dec 4, 2018 at 5:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> Hi Brendan, Rob,
>>>
>>> Pulling a comment from way back in the v1 patch thread:
>>>
>>> On 10/17/18 3:22 PM, Brendan Higgins wrote:
>>>> On Wed, Oct 17, 2018 at 10:49 AM <Tim.Bird@sony.com> wrote:
>>>
>>> < snip >
>>>
>>>> The test and the code under test are linked together in the same
>>>> binary and are compiled under Kbuild. Right now I am linking
>>>> everything into a UML kernel, but I would ultimately like to make
>>>> tests compile into completely independent test binaries. So each test
>>>> file would get compiled into its own test binary and would link
>>>> against only the code needed to run the test, but we are a bit of a
>>>> ways off from that.
>>>
>>> I have never used UML, so you should expect naive questions from me,
>>> exhibiting my lack of understanding.
>>>
>>> Does this mean that I have to build a UML architecture kernel to run
>>> the KUnit tests?
>>
>> In this version of the patch series, yes.
>>
>>> *** Rob, if the answer is yes, then it seems like for my workflow,
>>> which is to build for real ARM hardware, my work is doubled (or
>>> worse), because for every patch/commit that I apply, I not only have
>>> to build the ARM kernel and boot on the real hardware to test, I also
>>> have to build the UML kernel and boot in UML.  If that is correct
>>> then I see this as a major problem for me.
>>
>> I've already raised this issue elsewhere in the series. Restricting
>> the DT tests to UML is a non-starter.
> 

> I have already stated my position elsewhere on the matter, but in
> summary: Ensuring most tests can run without external dependencies
> (hardware, VM, etc) has a lot of benefits and should be supported in
> nearly all cases, but such tests should also work when compiled to run
> on real hardware/VM; the tooling might not be as good in the latter
> case, but I understand that there are good reasons to support it
> nonetheless.

And my needs are the exact opposite.  My tests must run on real hardware,
in the context of the real operating system subsystems and drivers
potentially causing issues.

It is useful if the tests can also run without that dependency.

-Frank


> 
> So I am going to try to add basic support for running tests on other
> architectures in the next version or two.

< snip >
