Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F09C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC9620665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfE2JR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:17:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41186 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2JRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:17:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so2629849edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R3M9/Nb+iAWv/ivQtmJwp21umz3a07n0D41zlbH+5Vg=;
        b=s3T2GSdphAWkYobC3Max9vR57e6XQgriTnSmDtIrqf+d4b93noxJvMPW/11iZzsSZo
         w3i+CYfAR+D3lMkz6uD6M5+6bKeuoMhjtEO7DvbsRSWD3T1BW5pvyTpFhNMUw+CARQgg
         E5jJFFeBkXSmdOvf6T2PrBtJ8WecCrbRXRppkovHfY48D2dER8t3qF7PdboI7U84OEuM
         HPb8z96BBEiMDXNx8jOe1ng5u1Mei1OdKXiiQhMwZJTxM4qK32di5Wp2uiLorn4bQYwh
         lsENU70R0cY53xhNxmNXTkBCNGt2PT3ppk4spwUDxrSu4Rr1YBBDpSsqaBs+DgpvaYjy
         QcRw==
X-Gm-Message-State: APjAAAXzLIqvY9mJMEsJjr/Cjoh6GXiCIgX0/LvcwNepDvyaOOMP2piu
        69i7B6Fe3ME0lzPh88pHjiRtYSpHxnU=
X-Google-Smtp-Source: APXvYqzDN/m677MUndnaGXnszTXxjNj7JaHW/w/uv+QBZba0k9DL4JeHhTsUPJBOX1W+yTOiYDL77Q==
X-Received: by 2002:a50:b487:: with SMTP id w7mr136594551edd.45.1559121473400;
        Wed, 29 May 2019 02:17:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id x49sm5023051edm.25.2019.05.29.02.17.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:17:52 -0700 (PDT)
Subject: Re: hid-related 5.2-rc1 boot hang
To:     Dave Hansen <dave.hansen@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
 <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
Date:   Wed, 29 May 2019 11:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/28/19 8:11 PM, Dave Hansen wrote:
> On 5/28/19 10:45 AM, Benjamin Tissoires wrote:
>> On Tue, May 28, 2019 at 7:15 PM Jiri Kosina <jikos@kernel.org> wrote:
>>> Just to confirm -- I guess reverting 4ceabaf79 and a025a18fe would work
>>> this around, right?
> 
> Yes, reverting that pair on top of 5.2-rc1 works around the issue.

Thank you for catching this and for testing the reverts. We've several bug
reports which I suspect are related to this.

/sbin/modprobe really should not hang when called by the kernel, as the
kernel does this in several other places too.

At the same time this clearly is a regression, so I'm afraid we will need
to revert the 2 commits.

Benjamin, Jiri, I really like the improvements these 2 commits bring
combined with Benjamin's changes removing the need for all the device specific
drivers to have  HID_QUIRK_HAVE_SPECIAL_DRIVER quirk.

Maybe instead of reverting them, we wrap them in a Kconfig option, which
defaults to N, with a warning that this requires an userspace where
/sbin/modprobe does not hang ?  It would be useful for the Kconfig
help text if we knew why it hangs. I guess this may have something to do
with it running from the initrd? Maybe this is not the real modprobe but
busybox's modprobe?

Dave, can you try building your initrd without the hid-logitech-dj module
included in the initrd?


Also can you check if your modprobe is provided by module-init-tools
or by kmod ?

I believe we really need more information before we can properly decide
how to deal with this. Luckily we still have same time.

Regards,

Hans

