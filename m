Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C317DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9940E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfCTJwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:52:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37493 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:52:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so506889wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZRyTYuUQUUo3qbf5oF6NaALqEbZIa8lBEhAHa+zZ64=;
        b=iLaVT8AGUHImuTlv8gj3T6p4HmOI0yX62niIqpftp4MY64SFX0UfHdWQfAO6CeFuOR
         GuefBAHibEO34xTXhyob17NU0puTP6p/UrW4rCOqVcDmG1SDbXwzA8iM+4nlsVNOa+34
         Ydo3I1ixKTXBN4dvwhx/PlO6hPB3Wo53NzZecyyLdMln5SpnL9DhhltlGwxnQmGQghvB
         JgO/qdPrELxMZu/E0N1lW3VXNpXMpM5ZR+3KpvMHI07KY4CsenDQAQbmTVXUkjM7J9q7
         VHqqJ5kYLFFqAYeZI6OybE1Xx94WTAnNwkLlgMwHz+dTEwn+TNjrugo0JcKLJg8QjwwE
         O3Ew==
X-Gm-Message-State: APjAAAVsWJx/H2i1DhduMqRyzYPm2SR/zb+t+wyw8NGPDpWLA9pYLDj7
        VAbElcD5ylCTPsanYAnkDYfoAQ==
X-Google-Smtp-Source: APXvYqwKAVUToUxzYOvdfVmOs4OeGrRx1HyjNLA2Pxp3YQo3VzltHohgGrvfjPbNDj7MnRSmzgeMdQ==
X-Received: by 2002:adf:efca:: with SMTP id i10mr9375207wrp.265.1553075527145;
        Wed, 20 Mar 2019 02:52:07 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id q63sm1578016wma.21.2019.03.20.02.52.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 02:52:06 -0700 (PDT)
Subject: Re: [PATCH] virt: vbox: Implement passing requestor info to the host
 for VirtualBox 6.0.x
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        "Knut St . Osmundsen" <knut.osmundsen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190320093519.26029-1-hdegoede@redhat.com>
 <20190320094601.GA30735@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <29c6e212-6233-364f-5a90-564f91bca989@redhat.com>
Date:   Wed, 20 Mar 2019 10:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320094601.GA30735@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-03-19 10:46, Greg Kroah-Hartman wrote:
> On Wed, Mar 20, 2019 at 10:35:19AM +0100, Hans de Goede wrote:
>> VirtualBox 6.0.x has a new feature where the guest kernel driver passes
>> info about the origin of the request (e.g. userspace or kernelspace) to
>> the hypervisor.
>>
>> If we do not pass this information then when running the 6.0.x userspace
>> guest-additions tools on a 6.0.x host, some requests will get denied
>> with a VERR_VERSION_MISMATCH error, breaking vboxservice.service and
>> the mounting of shared folders marked to be auto-mounted.
>>
>> This commit implements passing the requestor info to the host, fixing this.
>>
>> Cc: stable@vger.kernel.org
> 
> This feels like support for a "new feature", so why would this need to
> go to older kernels?
> 
> It's not our fault that vb implemented a non-backwards-compatible change
> for their new release, right?  So why should we be forced to add new
> features to stable kernels?

 From a technical point of view I completely agree with you and I'm unhappy
with this breakage after vb agreed with me to keep ABI compatibility so
that we could add a version of the vboxguest driver to the mainline kernel.

OTOH this is going to bite users out there, which is why I added the Cc:
stable. But this is entirely your call.

> I have no problem to add this for 5.2, but not for older stuff.

Can we at least at it as a fix to 5.1 ? It is not very adventurous.

Regards,

Hans
