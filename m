Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58901C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264A720882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bukicog/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfDBOjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:39:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45826 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbfDBOjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:39:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id m16so11852217edd.12;
        Tue, 02 Apr 2019 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rbkCyfbfAwXe9a0XoOj/81mqHOhEYpL02LbTXDYZKLI=;
        b=Bukicog/B0N+wFsUB8MhV+erPvMzOE7SG5YNLZx6zaHmgQtXJm+xIc6WzfMTrRrgoZ
         TCqxzE2iJR+JVOhfsfAJQ8S9yMkPsUS8TAygy6d1HUxYCEBGB7682648b1AinOvnWKX5
         kNvV9qktB86NCgX+GNSQR6SjBNXaXc6axCo+U/g7ChYWCMGeSPVJW1wQq4ErZ5fdd+Rz
         kodsROGsbsstvbeKPVePJQQqm3fLFR4lVdUf1GCTsuFHDL7p0ZtNyY4siJGcCYi4G/OV
         nmOhmXyMjH9Z9UqegTxe9rmouWHckcehF6e/GLAoV6n11pEPnQ/AtQe4efurHDkQPdJd
         ZhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbkCyfbfAwXe9a0XoOj/81mqHOhEYpL02LbTXDYZKLI=;
        b=KoXXPTPmffUvQX+W80ItCKVJKbM7wq/Q5M7h4KZXhMrvkuG1Gk98y9Cp/ej2oensWo
         cBJXtMlr1gLWsVumvQgd2Qr+fHQ1QqbxUsAffnUNfHjsuwQWDuMUF7DvjuyPKa4nJOlM
         X056VqqrYIhaKU/JzBlBziBemWN2pq+gRhErwLg5aYeHVFMTc0fbqX65zSQ06HNz56uT
         7oo0wEpno2hOCZxApQhdAD2RmUgEhB0LfkUV2v3R1eeJcjHB5OXOqfBRjROV9H0KrM50
         70FztDk8ASkUB70ZmnoEaD5zKiopwRMx5jTuWLzoNMy2JxfeF83yaKvKgOoFm0lBJ4sp
         5M6A==
X-Gm-Message-State: APjAAAWjs9sSEXoRSLJMrpLHEngeXN4DwepVnNbkcF8NaBEeL3SV32mn
        f5gbkgx8QPRzxYBP2iXY7Jg=
X-Google-Smtp-Source: APXvYqyZWFy46ep/zPuXn3OIQB3RxkOvk0bjjWS9+J/GXng++V2lSTVSBgt3+ndMH/V21cX6Rk2xnA==
X-Received: by 2002:a17:906:6152:: with SMTP id p18mr11557276ejl.245.1554215957800;
        Tue, 02 Apr 2019 07:39:17 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a28sm4226702edm.91.2019.04.02.07.39.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 07:39:17 -0700 (PDT)
Subject: Re: [PATCH 3.16 23/99] tty/ldsem: Wake up readers after timed out
 down_write()
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     open list <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Kirjanov <kda@linux-powerpc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Dmitry Safonov <dima@arista.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <lsq.1554212307.17110877@decadent.org.uk>
 <lsq.1554212307.770456214@decadent.org.uk>
 <CAJwJo6ahUWWSMWfM+qk109YfzJAB0HBMKcrVFqK2wzdBv_OtGQ@mail.gmail.com>
 <0fb333560ad4ed9d5c8bc0f71a46fee5b448f9e6.camel@decadent.org.uk>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <2aa7996d-708a-b6b9-3197-94814b708881@gmail.com>
Date:   Tue, 2 Apr 2019 15:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0fb333560ad4ed9d5c8bc0f71a46fee5b448f9e6.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 3:32 PM, Ben Hutchings wrote:
> On Tue, 2019-04-02 at 15:22 +0100, Dmitry Safonov wrote:
>> Hi Ben,
>>
>> JFI: I haven't checked your tree, but the same patches set contains fixes
>> that are more important to my mind (looking at 4.9 stable tree):
>> - "tty: Drop tty->count on tty_reopen() failure" commit fe3241679009
> 
> You marked this as applicable to 4.6+.  Is it actually applicable to
> older versions as well?

Oh, probably you're right - I'll need to look at the v3.16 source to
tell better. I think, I've marked the proper version at that time.

> 
>> - "tty: Hold tty_ldisc_lock() during tty_reopen()" commit 83d817f41070
>>   with follow-up fixup "tty: Don't hold ldisc lock in tty_reopen() if
>> ldisc present"
>>   commit d3736d82e816
> [...]
> 
> I will include these in a later update, unless you think they are
> really urgent and should be added to this one.

Well, I thought worth to mention those patches, but in reality haven't
checked if they are applicable to v3.16.
It's just I remember "tty: Hold tty_ldisc_lock() during tty_reopen()"
was the main fix in the set, as many people suffered from issue under
it, so I thought strange that only a side-patch (which can lead to soft
lockup, so probably also important) is ported. But I managed to forget
that the code has changes since v3.16.

Thanks,
          Dmitry
