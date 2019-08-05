Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD8C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392BE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skYgA7Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfHEMSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:18:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38618 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHEMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:18:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id z14so2417302pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQ4ulFEyF6VrvHFlKf881bAuYun1TIHdSMkPsNYgHWs=;
        b=skYgA7Agimy3OMPxQskR5Po6L586nWbs5cHU4HtighVcSAC1Jk4olQop9weN10YKcN
         lJTu85PM2kgRgzigjN3o3npEzbPlvzdc3SeMnYYb7bpMGIBAbyWsnAnew5y1eKhjUveS
         R1fJhUsjEsUVtR4uLzIpWuzkvBh1DAQtUVNi7gD5voDXHpp9jc6en2jTlWKiJZXaqNRQ
         /9qnXTDTBsgjeqTfMwXPYj40gqgjRwR7lkhP94kuy5xubPI0OneqYZ4iJhu8JcxZkf1k
         EspqxkYRFeYT040UoHXCNmJMz0hsEG/c0XI6Xl8JHZskdOf+fBkQTyp3Sq47JFoc3LN2
         Oj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQ4ulFEyF6VrvHFlKf881bAuYun1TIHdSMkPsNYgHWs=;
        b=cqP8USIiSpadGsBW13BXrijnARl5D5FC41yWEkHXuCSZH0W019H9n/oJHXqFGlLrwn
         0Wotd11CPJUIy/aYUDVTAPm/p9w8pyamxDRvCjhXj+hNy1oA4RTZYvvsfzqhrbrTGLfv
         6SzL5HzTTwVStbirx1Z3smalAedQEA2y94Qif5Z0DBkoNHBKJLOi0GrImykl//EuErOC
         n2S076vvPyS6RqGuDdQwPIoiCZ/Nub6CzSMKOxNzcC3/tYmzC2tZ1FyUPR6eCLFuo7gQ
         B9dBNGqrdUn1qYDTUwRiHF/aVSTBLXMKyO4kJBX0xI1TjBJebLIXd/zlVRUrsZiIyDEu
         Ik+w==
X-Gm-Message-State: APjAAAVf2FdrK1TdEo92E15cDxtKgPZY5DsQvCg1s06BxRiwYU1H+Idp
        YVVUzL1UCdvszawiaPnQMuOHqi/C
X-Google-Smtp-Source: APXvYqzyT8QjHHdcSrat1OwwQ0vhk53R4wCstX+rAg/Vla6vKkTNCl7Xfh+HTR8In37p7l5Iumf9sg==
X-Received: by 2002:a62:7695:: with SMTP id r143mr75038886pfc.173.1565007515870;
        Mon, 05 Aug 2019 05:18:35 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id g18sm130360927pgm.9.2019.08.05.05.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 05:18:35 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] m68k: Prevent some compiler warnings in coldfire builds
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9ec2190f5be1c4e676a803901200364578662b6d.1564704625.git.fthain@telegraphics.com.au>
 <fd5ccd89-987a-3d4b-5c49-9068abadf81d@linux-m68k.org>
 <CAMuHMdW=cPipS6pmxAtU6r1MaVaPWfhGQ-AAe0E-TJGbXftHfA@mail.gmail.com>
Message-ID: <e73a9616-23c3-f04d-1519-185483adcb98@linux-m68k.org>
Date:   Mon, 5 Aug 2019 22:18:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW=cPipS6pmxAtU6r1MaVaPWfhGQ-AAe0E-TJGbXftHfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 5/8/19 5:14 pm, Geert Uytterhoeven wrote:
> On Sat, Aug 3, 2019 at 1:36 AM Greg Ungerer <gregungerer00@gmail.com> wrote:
>> On 2/8/19 10:10 am, Finn Thain wrote:
>>> Since commit d3b41b6bb49e ("m68k: Dispatch nvram_ops calls to Atari or
>>> Mac functions"), Coldfire builds generate compiler warnings due to the
>>> unconditional inclusion of asm/atarihw.h and asm/macintosh.h.
>>>
>>> The inclusion of asm/atarihw.h causes warnings like this:
>>>
>>> In file included from ./arch/m68k/include/asm/atarihw.h:25:0,
>>>                    from arch/m68k/kernel/setup_mm.c:41,
>>>                    from arch/m68k/kernel/setup.c:3:
>>> ./arch/m68k/include/asm/raw_io.h:39:0: warning: "__raw_readb" redefined
>>>    #define __raw_readb in_8
>>>
>>> In file included from ./arch/m68k/include/asm/io.h:6:0,
>>>                    from arch/m68k/kernel/setup_mm.c:36,
>>>                    from arch/m68k/kernel/setup.c:3:
>>> ./arch/m68k/include/asm/io_no.h:16:0: note: this is the location of the previous definition
>>>    #define __raw_readb(addr) \
>>> ...
>>>
>>> This issue is resolved by dropping the asm/raw_io.h include. It turns out
>>> that asm/io_mm.h already includes that header file.
>>>
>>> Moving the relevant macro definitions helps to clarify this dependency
>>> and make it safe to include asm/atarihw.h.
>>>
>>> The other warnings look like this:
>>>
>>> In file included from arch/m68k/kernel/setup_mm.c:48:0,
>>>                    from arch/m68k/kernel/setup.c:3:
>>> ./arch/m68k/include/asm/macintosh.h:19:35: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
>>>    extern void mac_irq_enable(struct irq_data *data);
>>>                                      ^~~~~~~~
>>> ...
>>>
>>> This issue is resolved by adding the missing linux/irq.h include.
>>>
>>> Cc: Michael Schmitz <schmitzmic@gmail.com>
>>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
>>
>> Looks good to me:
>>
>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>>
>> Geert: I can take this via the m68knommu tree if you like?
>> Or if you want to pick it up then no problem.
> 
> If you have fixes for m68knommu for v5.3, feel free to queue it.
> Else I can queue it for v5.4.
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

I don't currently have any fixes for 5.3 queued.
And there is no real hurry on this anyway, it can wait for 5.4.
So please add to your queue for 5.4

Regards
Greg


