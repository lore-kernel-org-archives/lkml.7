Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0804C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7263121670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iQxmxhr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405790AbfIFPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:39:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43418 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404773AbfIFPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:39:39 -0400
Received: by mail-io1-f67.google.com with SMTP id u185so13628575iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MdfjTxN5SOgJB1OGke0HstginlQfCiAqgh1ZlMJdL5M=;
        b=iQxmxhr0Eehh//WtWgiVCBnOQNedwADskIWQWrQDQMZsClb78zvHu9hgpI9l4vRsxX
         Dt4VF0jB1ES83gsGXpQuMYayTg5icZJ39by0BVgCdsjc1xwU2iMeo8MZxV4XFg6c3LnE
         NqpsRanw0uCu4j9jA7BW/6pO22E7l9vW6VCaFPTSUgMA6ZGZyV+JUwGzdmIxtVeHOYQC
         HgkXXAriRRrHom++/NqocmTh+dDh8dY/ACafxTYgubpcsg680mg/Qn+LkzLqX0ZT9jeL
         yKnybe1UFjgDYVdm4YsehLDfLNNqHMAWP3DKdufzYcDlgUjP6ddchagZ2oDx1WMMp47H
         61Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MdfjTxN5SOgJB1OGke0HstginlQfCiAqgh1ZlMJdL5M=;
        b=NqzBXbn/YD71ibxIXAd4o55QN6KqaX02b3j5rn/on4pkeKX+lfUDp9GOoAWLvxx/QT
         qFyacdfrwqkP7eqkwBMhfJE0VMbwxQXGxrMZn8C+QAbNmaIfXUgF3tKDaIp0wrighguW
         e26SXqprAeJNFK0N/MQciS4Ko7S0UHv2j1lyEosKzhSNLBNAWR+EtQb7vxGvoWfGwoFY
         Zb3dcnWfV/6pVhSUHFQo8TVNYMv6vrulpYYIevR4hH/p4FBYnVyo2VAFzyEbuOZ2p64a
         xK7qgAvnnUfZPND9p3Bbpx0XFotxwqv4lcchIOppn5sN/E/u8XnBdmSoRsn2IeXbYhQz
         JO9g==
X-Gm-Message-State: APjAAAXFg8HKNhpJNvNaEK02/l2RLZ6oyZ9wttWBh1ERK9sZ4lyJnRcz
        I0jWuj/aZ9lxGYlQkmaV4rsBTgxDt8TFsw==
X-Google-Smtp-Source: APXvYqwIfGCXsY6+A9vxjZfhEunDp+sh5DIimV6KP61gWu6aK82Hhk0OIMcvdfLyTZMjqHHhjctsVg==
X-Received: by 2002:a5d:9dcf:: with SMTP id 15mr1370597ioo.181.1567784377906;
        Fri, 06 Sep 2019 08:39:37 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e139sm8592829iof.60.2019.09.06.08.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:39:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] watch_queue: make locked_vm accessible
To:     Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
References: <20190906153249.1864324-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1bfa4486-96db-dd83-dc6d-433302f3235f@kernel.dk>
Date:   Fri, 6 Sep 2019 09:39:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906153249.1864324-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 9:32 AM, Arnd Bergmann wrote:
> The locked_vm member of struct user_struct is guarded by an #ifdef,
> which breaks building the new watch_queue driver when all the other
> subsystems that need it are disabled:
> 
> drivers/misc/watch_queue.c:315:38: error: no member named 'locked_vm' in 'struct user_struct'; did you mean 'locked_shm'?
> 
> Add watch_queue to the list.

Should we either:

1) Make it unconditionally available

or

2) Introduce a symbol for this that others can select, like
   CONFIG_NEEDS_USER_LOCKED_VM or something like that.

?

-- 
Jens Axboe

