Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6498C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E18208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OXL0DJrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfFLOrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:47:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36756 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfFLOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:47:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so6854458wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xVfFJLv5dW5aoHUXpc1sbJZh/y+oS0CZ+4jF9K929Ic=;
        b=OXL0DJrvcuXnFE6j3/rttToGT7J8dbIWTIpGZw2iNsWo3aTmAoVkFzJyCr05LqGz8X
         cnzpG334ZYRq5Gc5Vck+gPJXBpslNBUSwpuA6L3qt3suXolVqb6B54eD3fUWQwxfCt+q
         /9qpskkDkpxaqK+SImjqYcea2sMKQbq7Us+Hh0hxlSE1E5a7aw10adBhzEUScbnVSajd
         pW79Pb5gI0sq6doAnODKqhGh4MYN50IDBON5fkioe6DA/KpyQrysI8F1pFUVjSKbxqG+
         9Rq3qZpeUyl4xE7Zlv+jfD+W5gQbtFpwXnTLC+HhTbK2CpGR/h6L9MmLdzaAike3tdQQ
         oH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xVfFJLv5dW5aoHUXpc1sbJZh/y+oS0CZ+4jF9K929Ic=;
        b=e2vvqXAUoeWg/NfbGad73894gqpJQVofsfH/d62CeYEN2e+nr4djjGmNacIaLIHAJG
         YsfgLvrgs3MB1E0E3FHpAew0tMFDW/99qYrA9Ta+L2bkxrEaGQSK6Z2UUoloUYY6wowT
         aDDHdr6isZlu7DyDyVuAQUkyeXdlMrULe59XH5sOcG/9qysG4kkdIr8jNzIvzUSBoC2F
         J3MnoyRC7OW06ny6j4XzJypWlZMqkcf3DIAorWM3OjMBhthGwlhTA1r1Qb1OpuvZbqq5
         xK2HvlWK5CEixBRIu9uNK3wW2d3zLfS5oOcsDxrILu1aD9WZYISK8XE+99tfWlGvw96C
         Sdsw==
X-Gm-Message-State: APjAAAVkYXvx7/CC2fGqVDrI7qi3kKg++n4YOIafo3/h1Do7AAckvOQB
        r6FHGHkQF28hS7ksNinteztAU9HYKTQ=
X-Google-Smtp-Source: APXvYqwMEP9IsARouhljexIF2ov+S/cFFLZePUwjrlALbWU1ji3V37i6Q9oBb26w6TYFPVRjg/X0KQ==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr22212885wmj.143.1560350860016;
        Wed, 12 Jun 2019 07:47:40 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c24sm256466wmb.21.2019.06.12.07.47.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 07:47:39 -0700 (PDT)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV> <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
 <20190603065153.GA13072@jagdpanzerIV>
 <20190606071039.txqczrjlntrljlrx@pathway.suse.cz>
 <20190612083643.GA7722@jagdpanzerIV>
 <20190612120012.mmokgz4yybywfs26@pathway.suse.cz>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <34698b8a-5204-e9e8-b96b-dbb16340423d@arista.com>
Date:   Wed, 12 Jun 2019 15:47:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612120012.mmokgz4yybywfs26@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 1:00 PM, Petr Mladek wrote:
> On Wed 2019-06-12 17:36:43, Sergey Senozhatsky wrote:
>> On (06/06/19 09:10), Petr Mladek wrote:
>>> Just to be sure. I wanted to say that I like the idea with
>>> KERN_UNSUPRESSED. So, I think that we are on the same page.
>>
>> I understand. All I wanted to say is that KERN_UNSUPRESSED is
>> per-message, while the most interesting (and actually broken)
>> cases, IMHO, are per-context, IOW things like this one
>>
>> 	console_loglevel = NEW
>> 	foo()
>> 	  dump_stack()
>> 	     printk
>> 	     ...
>> 	     printk
>> 	console_loglevel = OLD
>>
>> KERN_UNSUPRESSED does not help here. We probably can't convert
>> dump_stack() to KERN_UNSUPRESSED.
> 
> I agree. I take KERN_UNSUPRESSED like a nice trick how to pass
> the information about the unsupressed printk context via
> printk_safe and printk_nmi per-CPU buffers.
> 
> The single line in sysrq __handle_sysrq() seems to be the only
> location where KERN_UNSUPRESSED can be used directly.

I likely don't understand all the reasons why it's not possible.

Looking at kdb - prints those can't be converted straight-away are
show_regs() and show_stack().. could we add helpers those take a
loglevel to show the info? (having as an example show_trace_log_lvl()
that can "eat" a modifier already).

Not that I want to sell the idea of KERN_UNSUPRESSED, but to my mind the
alternative patches were kind of too intricate and bring more complexity
to printk.. and there are only ~3(?) places those manipulate
console_loglevel directly in the kernel tree (so we might want something
simple and dumb as hell).

Thanks,
          Dima
