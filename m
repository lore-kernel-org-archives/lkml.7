Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B324C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3B52186A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObupjRdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfEYAQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:16:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38394 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfEYAQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:16:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so5879527pgl.5;
        Fri, 24 May 2019 17:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d7aQViEDIr+VGtoRMxStm5J2GmDvTPyvdjwYM6esIEg=;
        b=ObupjRdk/ipcpfVFRToKc1gu4eR0ZK4LUQ1392M1q70yjWi0s/wfAygyYzDPKcd6cT
         XtqroIrO93NhV8WCrUpMd+s7RaD1D4MnJ6vNsn/II5k54EhTihEdS227cAqoaKVkcRLW
         sq/wMzgrTnUjRSSNLjkIjKskOO+Keqox8RpGuIQIM+0Q10ag3oW2TEDIqSCxtwIHYzsi
         wv8i7jK0y7t4W4sZiReiw1n3BjPRzS1UzDs6hnLMelHqs2oZw6uH4sySkhtIYv67XyYB
         0qz43XtqLPc3hD7KhQ95ygRVK98outXzlp2kq8ZFHqwYnSO0MorKs8r8buLZd+aGjCIh
         emwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7aQViEDIr+VGtoRMxStm5J2GmDvTPyvdjwYM6esIEg=;
        b=lSf1Y/L6sTl3MURRnQu0Lfz64/jo/rcGXypddj+Kd5g2QsezCzdwHO7RfsJqDdDR88
         BlvrOAi5NqXeeER/dfsaxruruFkGJ+4AV4F1mDDQAJG6J8XUk+uZOOlwWpYdjGWyKWL9
         xO6a1QRTPZ448r4El6JWkW3KsyLO14/5gzfVolE6KUfH4KWtkmQEnyB6++d+0gX2mdVg
         voDG84P7jpFsqGhg3YJ6Xe89DThIqC3Tz0HKZ+SBdtF1zs3djNVkltKLDpks1xdKS5oU
         e1wfz2N+OVfpma6z2ci4PJpJ+xfGziM4PHaXM71znsvggMRLqN0ZuhzDBCcj/I0hn8HK
         jRwA==
X-Gm-Message-State: APjAAAUuphjuV9XUoj0gAIjYdBR/uiQD+mlLy87cWu3SZQP0r+g5vIh5
        3mWUmKWOPKVxwRNXKNBU6O0=
X-Google-Smtp-Source: APXvYqx8iPeB8PF8NlNmDL+f+Io/SdC4lgQvNSgIBtmvOOjjLmJ7YyMgludw2NkPc4UMy0dnUB2MfQ==
X-Received: by 2002:a62:4ece:: with SMTP id c197mr116406029pfb.139.1558743399265;
        Fri, 24 May 2019 17:16:39 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c185sm4148177pfc.64.2019.05.24.17.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 17:16:38 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
References: <20190524010117.225219-1-saravanak@google.com>
 <06b479e2-e8a0-b3e8-567c-7fa0f1c5bdf6@gmail.com>
 <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <18c3c4d7-a0cd-d526-9d8f-b09f8c166c88@gmail.com>
Date:   Fri, 24 May 2019 17:16:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 5/24/19 2:53 PM, Saravana Kannan wrote:
> On Fri, May 24, 2019 at 10:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/23/19 6:01 PM, Saravana Kannan wrote:

< snip >

> 
> -Saravana
> 

There were several different topics in your email.  I am going to do
separate replies for different topics so that each topic is contained
in a single sub-thread instead of possibly having a many topic
sub-thread where any of the topics might get lost.

If I drop any key context out of any of the replies, please feel
free to add it back in.

-Frank
