Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888AAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B2820844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2CeC6mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfHMPCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:02:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36972 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfHMPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:02:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so6126089wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z7Dmwu3NvM4EVDKo63p/xdtZ+TtWJUXj2RkugIVOSr4=;
        b=t2CeC6mtNnAdAq/OptzTNdCWbbeZeKOfLFYM6RAyQrZ+0HjWV7exL8BKTMrkb0IRDM
         w1Li2BGhGTUgB9ErTS9tgo1Yz6QM8ou/fnQvFN6GD0Mq7HXZ87yNGkmCJUWLXt6rKs6k
         PvKCClFv1ahlbnQuGeqpjbwvAm2MCWcT62/V8Td+35/tG+7ESPRSxLHC2rzBwxnuGt+N
         JimGsJMRY0GhBQWRwIO0JxQxJdHd67iGC8UwP5rCsyfQz/WRr5Bsj314c7Az6UMjqbaN
         eTmFEZ3FqInxcxhQiSqHVgIkIWsh+eMXoow+ZwoSg2w2a+BAHbQJr2ibqD7HnpeGDhzo
         kvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7Dmwu3NvM4EVDKo63p/xdtZ+TtWJUXj2RkugIVOSr4=;
        b=TOErSgqi656SZ+018N2ulsejBP5lDBUsJQhUu/4K/JYWjhp6MxEGM8nxTInu4qLpsq
         G3OQbGFNifgbzZsbBV42rx4gWaIT3vkTvocS7+gnzIdJKBf72CIAID3OCmIItH7YQZJK
         LZD75OR1B/DTlczJjtV007inpyGi5VFdIEzDHaBOC0sh3KZEvID5NGIo9NLqIJJ2S9P9
         af0/zFC/9rbUxiLVjBzxDv9TsbSusSFthe/Rp0cAQPv006LF7MM5XzuwDxaO6pmwSd1e
         7nWdt+hwK6PxnGjF3yg/bsxJ1Jc6yNyDv+W8LYzb77JNmT5RLhhWgGxjlzZMqtA0FpFz
         SCbQ==
X-Gm-Message-State: APjAAAWDYoqf4Zns9XRVww9XCYCjDPMeVNYDy1K3OwTg8tng0Q0bEH3J
        yRSn10KliqziYOyDWlGyxNeXaA==
X-Google-Smtp-Source: APXvYqzczT++Iinfypzj8ZDHy/UBigh5SKekIk8qmEwWyiX/x1k1vy+Nz2A/tkdRk+Iew06bsxv+eA==
X-Received: by 2002:a5d:670d:: with SMTP id o13mr36840270wru.289.1565708546723;
        Tue, 13 Aug 2019 08:02:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id p13sm42846847wrw.90.2019.08.13.08.02.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 08:02:26 -0700 (PDT)
Date:   Tue, 13 Aug 2019 16:02:21 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, maco@android.com,
        kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org,
        hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 10/10] RFC: usb-storage: export symbols in USB_STORAGE
 namespace
Message-ID: <20190813150221.GA107461@google.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-11-maennich@google.com>
 <20190813124708.GC12475@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190813124708.GC12475@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 02:47:08PM +0200, Greg KH wrote:
>On Tue, Aug 13, 2019 at 01:17:07PM +0100, Matthias Maennich wrote:
>> Modules using these symbols are required to explicitly import the
>> namespace. This patch was generated with the following steps and serves
>> as a reference to use the symbol namespace feature:
>>
>>  1) Define DDEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile
>>  2) make  (see warnings during modpost about missing imports)
>>  3) make nsdeps
>>
>> Instead of a DEFAULT_SYMBOL_NAMESPACE definition, the EXPORT_SYMBOL_NS
>> variants can be used to explicitly specify the namespace. The advantage
>> of the method used here is that newly added symbols are automatically
>> exported and existing ones are exported without touching their
>> respective EXPORT_SYMBOL macro expansion.
>
>Ok, I can't read text, this answers my previous question.
>
>But, as an example, shouldn't we also have some code here that uses the
>EXPORT_SYMBOL_NS() macro to ensure that it actually works?
>
I will create another patch for a different subsystem where the use of
the macros is more appropriate. Then we have both use cases covered.

Cheers,
Matthias

