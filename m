Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B8C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D0C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556315920;
	bh=xFo1AWoo+FJvjFfz3vvsCE2vpswgx4GYGmT8PrhXSlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1VkaAVn0rd59b/9iAWqkq0DdRPIYYQd1PsM81JKh9KqdDcyzF2vHBs3bcR0nYCToh
	 XCBWyKI7lS4uZO7piv1l1hzGZq7ifnqy2/mDmFeP8C1XWL0ZQ59C7hsYY3rhpF2fTu
	 Q98Nd7med2tSulz0qbNsYBNISxchww+YhCZ6bXmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfDZV6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:58:39 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:42595 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDZV6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:58:37 -0400
Received: by mail-qt1-f182.google.com with SMTP id p20so5834343qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=28sz1X9hgL9gonuzA5yRTpM2Y8vcCEDGRsaxGwl49io=;
        b=HQWVcZbBpNx18a39shjLpQak1a5R+CkftllPGDFe8GLgarSWHbYXZGW1jYJRsNHGC3
         lNv9Zz+ak93IiCd9Tp0vZrvlW3MpE/umL4+RQ4gaho7euCpShI4/RCXs4SsfRIZlZWJC
         YVVUuuLNcHOHrmTVVR9h6Sd4H8S8RtZrBcoIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=28sz1X9hgL9gonuzA5yRTpM2Y8vcCEDGRsaxGwl49io=;
        b=XyEGmuKDRJ0A1nZw0rL1/IhKuBwgaFinH0pSypVeBvGUdU7wMcJB0TxyykYkkINmkK
         qXA3GtGG7pMD/FTpgMgOuJaW8SQoyePTYBKPLwz7PvRZ/DfZ0Ty5QfReZqDRkAut2C9A
         WFV1dcteV/WcKWgcPlrbmBj/9OK2FZT/i2nZD24yxUR+iiBKlciD0Ac53pIecQ0RJblK
         JVhXGXbFm/Np27zzlRjngsutZu+3TL17/2KGZ4bnII0QUjJnktUaVsBsDH3SjsgmdSZj
         GAYLfb94H/6aqbX/W4TJj1F+e/g9da0RDnFgRzhrIY+gVr5YJo+9dtJtLZmJp3t/zpMK
         oKMA==
X-Gm-Message-State: APjAAAXHdBUQ7+CEm4FJFz/FWPSISdUKDWqaNUpivzbJlZKU+q2YNiSI
        Uu7MU+spMQru+BfIjaWwEymw/w==
X-Google-Smtp-Source: APXvYqzoy3uKdiWQvW7vbln9UbWikGgEcVp+4tJiNbrxte4L5Dqqrr3WZ5tCL/TVOevXxph/8vSv/w==
X-Received: by 2002:a0c:9922:: with SMTP id h31mr37734348qvd.137.1556315916783;
        Fri, 26 Apr 2019 14:58:36 -0700 (PDT)
Received: from chatter.i7.local (192-0-231-225.cpe.teksavvy.com. [192.0.231.225])
        by smtp.gmail.com with ESMTPSA id u12sm1766544qta.3.2019.04.26.14.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 14:58:36 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:58:34 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/10] arm64: unbreak DYNAMIC_DEBUG=y build with clang
Message-ID: <20190426215834.GA26334@chatter.i7.local>
References: <20190426130015.GA12483@archlinux-i9>
 <20190426190603.5982-1-linux@rasmusvillemoes.dk>
 <88270f30-fa5d-5bc5-931c-dc643ca8acc5@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <88270f30-fa5d-5bc5-931c-dc643ca8acc5@rasmusvillemoes.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:27:46PM +0200, Rasmus Villemoes wrote:
>On 26/04/2019 21.06, Rasmus Villemoes wrote:
>
>> Andrew, please apply and/or fold into 9/10.
>
>Hm, I'm getting bounces for Andrew's email address:
>
>                   The mail system
>
><akpm@mail.linuxfoundation.org>: host 172.17.192.39[172.17.192.39] said: 550
>    5.1.1 <akpm@mail.linuxfoundation.org>: Recipient address rejected: User
>    unknown in local recipient table (in reply to RCPT TO command)
>
>I think these fixups need to go through his tree as well. Any ideas
>what's going on?

When did you get this bounce? Can you give me more headers, especially 
with timestamps? Andrew's mailbox was recently switched to a different 
platform, so it's possible you're getting some unintended backscatter 
from when we briefly delivered mail to both.

-K
