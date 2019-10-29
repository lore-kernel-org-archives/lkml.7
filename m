Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DE4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48528214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O31fbQcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbfJ2Oh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:37:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50787 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbfJ2OhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:37:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id 11so2871925wmk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a8mYbXXK5+KQUQaIvwcfrpjKf765samV6cQUxQNL5/o=;
        b=O31fbQcpDlQPaRDMeDghKQyKCpUZLsxpwu5wp8yldw9TK1V9CNDL4LgeBq9uR+2RGU
         ZjKJfJPZgpHiq3YdbZwMZPw9/RupSHfV+4O4Z5Nbe1YaYCM2hI3wpBupabJz6x77n3ug
         GhibiP9aLjoivl9amK7q9d+E+dGxrhAdMc4FJ2by+d54SbGyhS1b78g5i6PG1E6lhXMb
         CsYCOCOtkiSbxWs+bpBnQIA4YRmFwor5bXbUBkgsl8kWWHlNRjYCJmNf0ngNRywGoNv4
         PAKHgYlpuy54myGByRZTIBDXAyFCUqGvePGyDkK2up/0Xj/5VJTozHUssa87+G31WlCK
         WZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a8mYbXXK5+KQUQaIvwcfrpjKf765samV6cQUxQNL5/o=;
        b=TFoBe1/t46CoT32MFCMgO1uqw79WJANVs52mhdfxWaXdf+jZorpzZE9qfsupKlgv8g
         ktDHVMAsVbfouHlNYIYpZxrHva2t09JXSD3KRA/NcYmNux3JLBguqfcwC8mCao8OLkG+
         qr8ToGscZaLFQ6knb3PMk+TqqN6Cn9fLKACDRJTL4KzZpOjgkM/gM80iwWMdKxkYbXKa
         aDmX7fJd3cBIdSugYsqvOEFGdaKQp4kxuuzNsugqUF6O4KaG3ssKgP+cC36x90RTyPqz
         n1WX1A8KeEUm0iGwIy7I2FXHTTUF5HXQxkY6c/rRjT7xp3LdRYqtOCffRsAPWZoYHbL0
         SeOQ==
X-Gm-Message-State: APjAAAV+IUyJqnrEwL9b7EuGWcFy8olWOgEn/ro2GOPeYOkIJ6zUr9LR
        uIY+Sp6EO2+ZKM6IT/7XTmcwJg==
X-Google-Smtp-Source: APXvYqzxpBRLFqGiJ7f1v7UKKd7e/gFBpwDGG+pYQ2pl8w7igd0rtuIooHzTdvIWuV6CCe5R2FioCw==
X-Received: by 2002:a05:600c:410:: with SMTP id q16mr4391860wmb.169.1572359843859;
        Tue, 29 Oct 2019 07:37:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id b66sm3229561wmh.39.2019.10.29.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:37:23 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:37:22 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Warning message from 'make nsdeps' when namespace is lower cases
Message-ID: <20191029143722.GB33177@google.com>
References: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
 <alpine.DEB.2.21.1910291437450.2179@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910291437450.2179@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Oct 29, 2019 at 02:38:36PM +0100, Julia Lawall wrote:
>
>
>On Tue, 29 Oct 2019, Masahiro Yamada wrote:
>
>> Hi.
>>
>> When I was playing with 'make nsdeps',
>> I saw a new warning.
>>
>> If I rename USB_STORAGE to usb_storage,
>> I see 'warning: line 15: should usb_storage be a metavariable?'
>> Why? I think it comes from spatch.
>
>Yes, it would come from spatch.
>
>> It should be technically OK to use either upper or lower cases
>> for the namespace name.
>
>What is normally wanted?  Uppercase or lowercase?

There is no (documented) preference or convention yet. The existing
namespaces (USB_STORAGE and MCB) use upper case. While technically both
should work, I have a personal preference for consistently using upper
case. Is there a way to suppress this warning as I agree that it might
be confusing?

Cheers,
Matthias

>
>julia
>
>>
>> Just apply the following, and try 'make nsdeps'.
>>
>>
>> diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
>> index 46635fa4a340..6f817d65c26b 100644
>> --- a/drivers/usb/storage/Makefile
>> +++ b/drivers/usb/storage/Makefile
>> @@ -8,7 +8,7 @@
>>
>>  ccflags-y := -I $(srctree)/drivers/scsi
>>
>> -ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
>> +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=usb_storage
>>
>>  obj-$(CONFIG_USB_UAS)          += uas.o
>>  obj-$(CONFIG_USB_STORAGE)      += usb-storage.o
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
>>
