Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7713C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0B520844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IEWOQH9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfGHPJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:09:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41862 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfGHPJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:09:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x68F9EU8058607;
        Mon, 8 Jul 2019 10:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562598554;
        bh=5itJGPGTzjx5419mSRNNOzdOyOTaElCYDDdWPsFfInc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IEWOQH9VYiXdMKHlLPjKOLMOwZkbsesU7Ny8wLWX8bUmLUEL1yjbBcKwv9OHDzNt1
         ZWraRmqbh3643ufE+py+AsfHeTkDbxgocVcZwVdKTIO1Syi/P3Rl2MAK8Sl8RmBiCS
         +7UVTUK0ukceHKNRXzvZ+JaUP3xv4vFxW3QWTj0k=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x68F9ESO029329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jul 2019 10:09:14 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Jul
 2019 10:09:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Jul 2019 10:09:13 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x68F9Afu033254;
        Mon, 8 Jul 2019 10:09:11 -0500
Subject: Re: linux-next: build failure after merge of the usb and usb-gadget
 trees
To:     Felipe Balbi <balbi@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>, Greg KH <greg@kroah.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
 <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imsiyzo3.fsf@linux.intel.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <22eca6b8-253d-3502-ca70-0089d0984abb@ti.com>
Date:   Mon, 8 Jul 2019 20:39:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87imsiyzo3.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/19 1:55 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Pawel Laszczak <pawell@cadence.com> writes:
> 
>>>
>>> Hi,
>>>
>>> On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
>>>>
>>>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> After merging the usb tree, today's linux-next build (arm
>>>>> multi_v7_defconfig) failed like this:
>>>>>
>>>>> arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_output_dwc3_log_ctrl':
>>>>> trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
>>>>>
>>>>> Caused by commit
>>>>>
>>>>>   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")
>>>>>
>>>>> I have used the usb tree from next-20190703 for today.
>>>>>
>>>>> This also occurs in the usb-gadget tree so I have used the version of
>>>>> that from next-20190703 as well.
>>>>
>>>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can you
>>>> take a look at this to see if I messed something up?
>>>
>>> This looks like it was caused by Pawel's patches.
>>>
>>> I'll try to reproduce here and see what's causing it.
>>
>> Problem is in my Patch. I reproduced it, but I don't understand why compiler 
>> complains about usb_decode_ctrl. It's compiled into libcomposite.ko and
>> declaration is in drivers/usb/gadget.h. 
> 
> That's because in multi_v7_defconfig dwc3 is built-in while libcomposite
> is a module:
> 
> CONFIG_USB_DWC3=y
> CONFIG_USB_LIBCOMPOSITE=m
> 
> 
> I remember that when you were doing this work, I asked you to move
> functions to usb/common. Why did you deviate from that suggestion? It's
> clear that decoding a ctrl request can be used by peripheral and host
> and we wouldn't have to deal with this problem if you had just followed
> the suggestion.
> 
> Now we have to come up with a way to fix this that doesn't involve
> reverting my part2 tag in its entirety because there are other important
> things there.
> 
> This is what I get for trusting people to do their part. I couldn't even
> compile test this since I don't have ARM compilers anymore (actually,
> just installed to test). Your customer, however, uses ARM cores so I
> would expect you to have at least compile tested this on ARM. How come
> this wasn't verified by anybody at TI?
> 
> TI used to have automated testing for many of the important defconfigs,
> is that completely gone? Are you guys relying entirely on linux-next?

I just checked back to see what happened here. In our product kernel
(which does undergo build test with multiple defconfigs), we are using
v6 of these patches which did not have this issue.

I think 0-day kbuild tester could have caught the issue as well. Within
boundaries of existing infrastructure, that probably was the best bet
here. Not sure why that did not happen (probably just build scheduling).

Thanks,
Sekhar
