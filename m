Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7CDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C8420674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8Bh4xj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404326AbfIFCF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:05:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41320 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbfIFCF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:05:56 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so9244135ioh.8;
        Thu, 05 Sep 2019 19:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNjAO7w9eS/oFTIrN8hMdx8IAfL3ao3OhGwC/h4NODs=;
        b=t8Bh4xj2REDoF1VC5A1yXzR++DYfGZ2hBOftZzOlHWjxGCJP3not1J15Q9nahr5wGS
         GIYP1R3pfOUEsxJNJlJIgGEbHuwblu+RbJWWIdC/x3zeLvf6PfcJ848aS8zqBkEY7ipN
         vitdSOSdFhgJ+zDY2bhyN0X1q9tgyIwj/vvFMG3O9VTzzj9Tt/6qEaaOCfi2S30ZOyXh
         9knxO2u+VvMhjNgdcamqQW67xPRedv/uj62VB/ygLGFQ+ZN5i7Cee1yLbF1X8JirI0d2
         3PjFnEel04uTrbagLUQ2hlmVit1hfe1M0mWzmsUNxQmta3kRX0JhzoCL2ZYrUy5aEYug
         olZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNjAO7w9eS/oFTIrN8hMdx8IAfL3ao3OhGwC/h4NODs=;
        b=NQ3KqUeAUkAo8MGt2Oy8pHGOdhFGBuLCqBY+7Db3kd95D64Ql9xkDCRCiB2bPZdv81
         htYlNEdMlbdwWU2vZSzpgVSEaCOTeOakFmVLqRsg93iAaSDISstS4+YjGM8dKZjhqS8D
         t07Q7fs8hQ6xXqorcnFhiFrbUnIYSSlGMmxAlvmUG9ZR4+9ypSOyPZLY2O1Ukk/aWGq5
         aGBb6pbHDoIhYKZy3X5GULGeVUVtXlpvKTP6jwCUQ++fh6uFb2egE1lP6+esBzYmQvGZ
         f4+SO9bu9Lfy3rmSCMEIXupGo49LHFqI4Qg34XAjl+3+1yALCcuJpjAi8yk/WyNLFtaT
         Tt6A==
X-Gm-Message-State: APjAAAVJKj36NMQ+ktehxGUF9u9aKZjZys/A3wpFgfyuNMZNX9Jy3cJ6
        we/O8Amc3mcoe+ruEPNhNaQ=
X-Google-Smtp-Source: APXvYqzrvldW3ojU/x20+y7cTaP88HXbmpOoRGCbe7AKvjRaefPQMetR6tFq1AYrY2esgO5umdzJJg==
X-Received: by 2002:a02:cbad:: with SMTP id v13mr6827583jap.69.1567735555412;
        Thu, 05 Sep 2019 19:05:55 -0700 (PDT)
Received: from [10.186.170.145] ([128.210.107.81])
        by smtp.gmail.com with ESMTPSA id k6sm2489169ioh.28.2019.09.05.19.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 19:05:54 -0700 (PDT)
Subject: Re: WARNING in hso_free_net_device
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        syzbot+44d53c7255bb1aea22d2@syzkaller.appspotmail.com,
        alexios.zavras@intel.com, "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        netdev <netdev@vger.kernel.org>, rfontana@redhat.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Neukum <oneukum@suse.com>
References: <0000000000002a95df0591a4f114@google.com>
 <d6e4d2da-66c6-a8fe-2fea-a3435fa7cb54@gmail.com>
 <20190904154140.45dfb398@hermes.lan>
 <285edb24-01f9-3f9d-4946-b2f41ccd0774@gmail.com>
 <CAAeHK+y3eQ7bXvo1tiAkwLCsFkbSU5B+6hsKbdEzkSXP2_Jyzg@mail.gmail.com>
From:   Hui Peng <benquike@gmail.com>
Message-ID: <02ef64cc-5053-e6da-fc59-9970f48064c5@gmail.com>
Date:   Thu, 5 Sep 2019 22:05:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+y3eQ7bXvo1tiAkwLCsFkbSU5B+6hsKbdEzkSXP2_Jyzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2019 7:24 AM, Andrey Konovalov wrote:
> On Thu, Sep 5, 2019 at 4:20 AM Hui Peng <benquike@gmail.com> wrote:
>>
>> Can you guys have  a look at the attached patch?
> 
> Let's try it:
> 
> #syz test: https://github.com/google/kasan.git eea39f24
> 
> FYI: there are two more reports coming from this driver, which might
> (or might not) have the same root cause. One of them has a suggested
> fix by Oliver.
> 
> https://syzkaller.appspot.com/bug?extid=67b2bd0e34f952d0321e
> https://syzkaller.appspot.com/bug?extid=93f2f45b19519b289613
> 

I think they are different, though similar.
This one is resulted from unregistering a network device.
These 2 are resulted from unregistering a tty device.

>>
>> On 9/4/19 6:41 PM, Stephen Hemminger wrote:
>>> On Wed, 4 Sep 2019 16:27:50 -0400
>>> Hui Peng <benquike@gmail.com> wrote:
>>>
>>>> Hi, all:
>>>>
>>>> I looked at the bug a little.
>>>>
>>>> The issue is that in the error handling code, hso_free_net_device
>>>> unregisters
>>>>
>>>> the net_device (hso_net->net)  by calling unregister_netdev. In the
>>>> error handling code path,
>>>>
>>>> hso_net->net has not been registered yet.
>>>>
>>>> I think there are two ways to solve the issue:
>>>>
>>>> 1. fix it in drivers/net/usb/hso.c to avoiding unregistering the
>>>> net_device when it is still not registered
>>>>
>>>> 2. fix it in unregister_netdev. We can add a field in net_device to
>>>> record whether it is registered, and make unregister_netdev return if
>>>> the net_device is not registered yet.
>>>>
>>>> What do you guys think ?
>>> #1
