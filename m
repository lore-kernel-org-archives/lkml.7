Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD6C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0773D20665
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFqDtmt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfFPRpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 13:45:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52045 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfFPRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:45:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so6934864wma.1;
        Sun, 16 Jun 2019 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TmMKvk0Y/efQ9776d0JK7qE9fx/6TxNcAmHxPwXoHyM=;
        b=BFqDtmt9riw10MJscByJwnnr2a/As2PlvIkifKPqrxZWYDjtLUHaFoEKn71aFNR7GA
         5qjf8UoKTSOmWVTgBQ0TlyCQD/3WepUFOyW9UMk+K+bkvI4OQKBDv14yDvbGrQeheQWf
         F/FIsc4beRNK/aeQhWMK88DYTsjHAMYz79xDiJ1Zc+idD1jIkqb0QutGbJhd8coOJwJ9
         6j2Of7YaSyi6uSvVXqoMLxSwhhGfs/oetYx06KT4Y33H1uCB0ErrFgtqBZgLnlngC34e
         izfRsZiVaqR2r9xDXQYantooSSwdU90zYcQFyEtE6FkRRiGuUAtdyl3A9NaQxTKarjop
         jmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TmMKvk0Y/efQ9776d0JK7qE9fx/6TxNcAmHxPwXoHyM=;
        b=V2fTQCvB3gjzOz0+tiBCj0e94NlZo4J9SN5mq0uXRxgXHh0jHctJ8d1PNlr+wFBOp2
         YIy6lOBb/sfGWDge2EX9l4x50jSe+h17FGszlI8T+BmaG1TFgIta/QwhMlP5nrh+/dZK
         X9jK8Yt5M5qdGqIbgO6Jgi5+XCYgtQHvgkIuRTG2hjZKuQTiQ1QFPAEhMb4ZVtKCDp0c
         oqa05p0e4RIlnmWKQ4aAQdQRqroExl4q4QU/rapXZMtBjIcswxonqX2aP3DQdPMQNGcy
         LFW1KHk/WRdtUQzI69XFZoxhsiZDjH2CAqWS9R05qC9y2mbZ2YNkSfXC6Nvy5rpvr0yc
         hDCA==
X-Gm-Message-State: APjAAAW983j0iQPLFNEUj8jdsLWKP3l67Zx7dkMOs0kcw5Q42p/CKLdw
        ogr0Kq308z32rJq498/GU4E=
X-Google-Smtp-Source: APXvYqzBVejEk5jhiWJ+MCxmdIzc5sebCeZDMZ4Od1RtJ5lcxx0kejBniAQoAn1YYSLYWGg0M7MeAQ==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr16236942wmc.77.1560707138877;
        Sun, 16 Jun 2019 10:45:38 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j18sm9222429wre.23.2019.06.16.10.45.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 10:45:38 -0700 (PDT)
Subject: Re: [PATCHv4 07/28] posix-timers/timens: Take into account clock
 offsets
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190612192628.23797-1-dima@arista.com>
 <20190612192628.23797-8-dima@arista.com>
 <alpine.DEB.2.21.1906141538240.1722@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <07bdc25f-3b06-e021-886c-8bad19a14b56@gmail.com>
Date:   Sun, 16 Jun 2019 18:45:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141538240.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/19 2:42 PM, Thomas Gleixner wrote:
> On Wed, 12 Jun 2019, Dmitry Safonov wrote:
> 
>> Subject: posix-timers/timens: Take into account clock offsets
> 
> Please avoid that '/timens' appendix. It's not really a new subsystem or
> subfunction of posix-timers.
> 
> posix-timers: Add time namespace support to common_timer_set()

Ok

> 
>> From: Andrei Vagin <avagin@gmail.com>
>>
>> Wire timer_settime() syscall into time namespace virtualization.
> 
> Please explain why this only affects common_timer_set() and not any other
> incarnation along with an explanation why only ABSTIME timers need to be
> converted.

Will do.

Thanks,
          Dmitry
