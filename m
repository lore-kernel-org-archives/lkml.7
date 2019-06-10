Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9B9C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE4A2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="LURtpcrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389731AbfFJVFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:05:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43096 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbfFJVFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:05:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so7303189oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oSQd/dSw9k2CrxkKH2qz7mRm8NK534f/ZzuWAbekOrY=;
        b=LURtpcrReLRABUoMAIwSom5ga/OKgTe0xfdabX/kdRy9Rm7RCH5sAzwzDhmTkEKnH1
         IUCzTbXO68bH57ix5kN28ABttmSEFv4JeZLTQnqkq/s8K2j5PQrtePsBpaN8KN8csrYK
         RJR/syXc8cefiQ4U/QNL86rZLegUZ628MfkNe9PhFHuWcnLI+4oOFFxMLqwrrVmByY8K
         MnU4gBRBR52HaQHUgomf8H5XrpVPDSZC1EhTLLCs63UVe9quEay6lPuwybaLuBAYETIb
         xqS+39iZgiXEyEga76eFd4XzW8I6f4fHc4pBbPFaq4HYv6fXzAZW02avChLkdlf5FdZk
         qmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oSQd/dSw9k2CrxkKH2qz7mRm8NK534f/ZzuWAbekOrY=;
        b=rHegYeWfB+JHwDkFbeXwWk8Jn/BL6AmNSdZIseu8ROMY0Ha95GDtvX1TU0OYvHqDwv
         bE6FzmzuuzX1WKBqbeVDYf7vmOUuDtsdWccJyPwK7w8UaW8kDQN9mgDJObKEMAehjLdS
         zXz25ADFDRb3hc7JFxitSxLQ9v1QZ9Ry7xrcA5s8NHeJQ0w9qLfCYNo/Jt3s7vDMIZz0
         Jec6zofr+pyVxgzdbyu7kWNOwAg2iBTlFvC5/I2h0Y3immKf8FBQYklnd95yICM/URB6
         kyuA58NocUULnAw5DLESM9wqxJCpujLAnLMft4AMgB2mNekWO8Gc6xbHFNyDy2YhKVNH
         GWJw==
X-Gm-Message-State: APjAAAW4PD8xS1Wv8ick3j2lofFSK9AilxyfIvOr8x8/dABwDj62IBlw
        G0MfEPvj39NkjYljqgrMxY5yNw==
X-Google-Smtp-Source: APXvYqzoUEQI9eCBkBS8xmW/CfZpKBfLzCJjJsS97rILi72k6uSNDleje2blyLFm/Je8nshzhc0rVA==
X-Received: by 2002:aca:ec0f:: with SMTP id k15mr12966767oih.13.1560200714329;
        Mon, 10 Jun 2019 14:05:14 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id d21sm4644203oih.21.2019.06.10.14.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:05:13 -0700 (PDT)
Subject: Re: [PATCH 0/7] TTY Keyboard Status Request
To:     Arseny Maslennikov <ar@cs.msu.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Vladimir D . Seleznev" <vseleznv@altlinux.org>
References: <20190605081906.28938-1-ar@cs.msu.ru>
From:   Rob Landley <rob@landley.net>
Message-ID: <0db56bba-96fd-ab99-aa54-360ab171b703@landley.net>
Date:   Mon, 10 Jun 2019 16:06:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605081906.28938-1-ar@cs.msu.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/19 3:18 AM, Arseny Maslennikov wrote:
> This patch series introduces TTY keyboard status request, a feature of
> the n_tty line discipline that reserves a character in struct termios
> (^T by default) and reacts to it by printing a short informational line
> to the terminal and sending a Unix signal to the tty's foreground
> process group. The processes may, in response to the signal, output a
> textual description of what they're doing.

I had a long twitter thread about this with some BSD developers,
https://twitter.com/landley/status/1127148250430152704
asked on the toybox list for opinions,
http://lists.landley.net/pipermail/toybox-landley.net/2019-May/010461.html
and became aware of this patch set when the android bionic maintainer pointed me
at news coverage of it
http://lists.landley.net/pipermail/toybox-landley.net/2019-June/010536.html

So there would appear to at least be interest in the concept.

(The conclusion I came to looking at it last month is is it can't be done
without kernel support, but if such support _does_ arrive I want to add it to
toybox.)

Rob
