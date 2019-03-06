Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D777C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E453C2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfCFIl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:41:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33105 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:41:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id c55so9616929edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 00:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulrnVIj5Q+aLCZZsBaNOoX+Fht88UjTblSz0G/hMNbk=;
        b=hkCg8kc4Ofmu/kVg79AJ00lkFmlzLxN+DZzPufknjNy5siCX9CfIjpaljXRuMovCgO
         jgd08+TqWbHDsypieNm5bV2YcruCsmWRGuq7Y4G/Y3MLSJH9moRSod1EWcyM8Nik06B5
         TqURNKp1iSDDtz8AhijKKzjHBPwXKq8BKlU7qPvR8ktuZOyEy2YZs6ifLOfParDlTOBp
         4S7DdmZ+LPIA/reZHH3Y/S/+qm79+g0D2WFJ2TmCEjOW1QDC9cDzX6cN2fGC6PHMYn+t
         QzByINNtPvwqcouGLDIHSeRGm99TFPMFQaaxGtJhdGddzEsEO6UYU2ivQIPXUjvWBdtn
         0LSw==
X-Gm-Message-State: APjAAAUqYSy4ADaPZgf+QaqBwrnQcIYhMgvN/t5hvd+y0TwQEvgGf1o+
        Y2TGOB6hlz7h72tOuYzFB1f3Kw==
X-Google-Smtp-Source: APXvYqzRbcfM7ExA5BEIPmSjnlewS9hmpzBbWil+cdS4fVSkLD/Ta9dopC3PpqLR61p3T6rUEZxfWw==
X-Received: by 2002:aa7:c808:: with SMTP id a8mr22597506edt.105.1551861684838;
        Wed, 06 Mar 2019 00:41:24 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a17sm211353ejr.62.2019.03.06.00.41.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 00:41:24 -0800 (PST)
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
 <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
 <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
 <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
 <57b32bc1-8ef2-1e1e-a70f-04444f5919a2@amd.com>
 <6fbcd261-f9e2-1685-1ef7-f148007aab9d@redhat.com>
 <51078b59-161a-0e13-6d8d-87d37c3375f2@redhat.com>
 <62f91d1a-4dc7-9628-5c87-5ffca0cd1a0f@amd.com>
 <92a886e1-1eca-7b94-2c62-9f42abc66bcf@redhat.com>
 <20190305195432.GI8256@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e8d1128f-ff81-3dc9-90ae-86ce5d8f69b2@redhat.com>
Date:   Wed, 6 Mar 2019 09:41:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305195432.GI8256@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-03-19 20:54, Borislav Petkov wrote:
> On Tue, Mar 05, 2019 at 08:40:02PM +0100, Hans de Goede wrote:
>> Finger pointing at the firmware if there are multiple vendors involved
>> is really not going to help here. Esp. since most OEMs will just respond
>> with "the machine works fine with Windows"
> 
> Yes, because windoze simply doesn't report that spurious IRQ, most
> likely.

So maybe we need to lower the priority of the do_IRQ error from pr_emerg
to pr_err then ?  That will stop throwing the errors in the users face each
boot on distros which have chosen to set the quiet loglevel to such a level
that pr_err messages are not shown on the console (*).

Regards,

Hans


*) Since there are simply too much false-positive pr_err messages in the kernel,
try e.g. plugging in a usb-stick and then do "dmesg -level=err"
Note the messages will still be in dmesg and in the system logs

