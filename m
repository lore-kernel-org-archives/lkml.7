Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE867C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ED9206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ND0Tq8uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfJMI1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:27:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36377 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfJMI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 04:27:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so13827949wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XrKArI22TbaXTpRRWMHp6kqWcuEnD9M+cArfNWS2v/M=;
        b=ND0Tq8uOyX79oTJxMZX4wHmFe5awTU4tQ0OU6c+OMeDb4TUDn1YhwyhTGIzENcDo6X
         D9Aw7TtMZVLxSEZrM57hDlkGvbSDTTz3W2fq7gSK3OODuwAFs7OEN0xNjnay7UfmX6ug
         Pwq17DqkY8cAbxaNCumWI0IGUlsZw6E6eOZXeDzu6RWisJuChfO4/HEZnhdaBwAoOXEj
         vfudEjgFpzA6DgXCpcrcC3o8eocxh+LQRHlQIyOCxeTNwUqAfpnzhe8UY85D1xq9rXmZ
         JjOm4dSTKn1dYGC+lkcT4c0NKdcY9Svbs79fonJOewUqcchKC97EIp/04xQvQh0PsAv5
         ZuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XrKArI22TbaXTpRRWMHp6kqWcuEnD9M+cArfNWS2v/M=;
        b=iIyWiHheawy2A/0/VH1v8z61VriXOo4hJa31V++5Qbz58u140rVgEtmJy8sV9xpQYM
         9E4idIkQS1T3vRI8nLJRZsYawNGeE3knmHbxR3Ow+5/z8w3dMylQSibYbG4yTwK9bbnQ
         sglzELm1WLgCBzdo1pT/GW776V6mBIDHU5LZj6wpQN9cmNzGNRfwXm3GtHS1oR1XTJUi
         zhq2jlawMUHxqA1W5C9VmDVRGy5oSCrCJgv9oOe7NWJe5/ByYv84P/+tvbWTH2fn3dMN
         At5d2+B+wrZYrRMhuDcQZwTWyIl4s9G4SnSZYp/XjLf92Nj7th84i1/LRhvg9mSzDcrf
         0REQ==
X-Gm-Message-State: APjAAAVyFAHYURVfsQEJ6poQsLENTTnrViC7fOri9yxZ6qvduhIAqIpT
        y0gZfUalyGWw2+aCWKpJfVJimfgf
X-Google-Smtp-Source: APXvYqwDMRUJtGfB/2Di1PCfLTYvrQQ9edaAlJwyEIx/GpcAbCLW4HyH6a79O5/aKJASu/Pi5DECVw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr11185175wmj.52.1570955220714;
        Sun, 13 Oct 2019 01:27:00 -0700 (PDT)
Received: from [192.168.1.20] (host86-143-38-66.range86-143.btcentralplus.com. [86.143.38.66])
        by smtp.googlemail.com with ESMTPSA id a3sm27883733wmc.3.2019.10.13.01.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 01:26:59 -0700 (PDT)
Subject: Re: Linux 5.3.6
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <48afc878-5424-7554-cd02-4175ec12eaea@googlemail.com>
 <CAEJqkgjAMkoiAQeitQ1gdEpmZWvdqQE+fAsQU4W7M7JGxHboyQ@mail.gmail.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <1b29b820-06e5-fed4-2dd3-a66ceded73c8@googlemail.com>
Date:   Sun, 13 Oct 2019 09:26:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAEJqkgjAMkoiAQeitQ1gdEpmZWvdqQE+fAsQU4W7M7JGxHboyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2019 21:55, Gabriel C wrote:
> Am Sa., 12. Okt. 2019 um 21:16 Uhr schrieb Chris Clayton
> <chris2553@googlemail.com>:
>>
>>
>>> I'm announcing the release of the 5.3.6 kernel.
>>
>>
>> 5.3.6 build fails here with:
>>
>> arch/x86/entry/vdso/vdso64.so.dbg: undefined symbols found
>>   CC      arch/x86/kernel/cpu/mce/threshold.o
>> make[3]: *** [arch/x86/entry/vdso/Makefile:59: arch/x86/entry/vdso/vdso64.so.dbg] Error 1
>> make[3]: *** Deleting file 'arch/x86/entry/vdso/vdso64.so.dbg'
>> make[2]: *** [scripts/Makefile.build:497: arch/x86/entry/vdso] Error 2
>> make[1]: *** [scripts/Makefile.build:497: arch/x86/entry] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>>
> 
> What is your default linker ?
> 
> Also does make LD=ld.bfd fixes that for you ?
> 

Thanks, Gabriel. The default linker is gold, but your suggestion above fixed the build. I think I'll set the default to
LD.bfd.

> See https://bugzilla.kernel.org/show_bug.cgi?id=204951
> 
> BR,
> 
> Gabriel C.
> 
