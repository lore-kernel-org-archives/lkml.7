Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDBDC28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E61E206E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfFFLr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:47:59 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:42595 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbfFFLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:47:59 -0400
Received: from [192.168.2.10] ([46.9.252.75])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Yqs5hzKus3qlsYqs9hmPS4; Thu, 06 Jun 2019 13:47:57 +0200
Subject: Re: [PATCH 4.19 262/276] media: saa7146: avoid high stack usage with
 clang
To:     Pavel Machek <pavel@denx.de>, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030541.589347419@linuxfoundation.org> <20190606114439.GA27432@amd>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <bf6e478e-8993-8b99-7061-79616785b982@xs4all.nl>
Date:   Thu, 6 Jun 2019 13:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606114439.GA27432@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGNkpSF/LKKl1EbbPpwSZeOpmJU0JtjvAbuHp6TgtAdbfxHvD6hn+AThWsvmkBlX4TM+9M4209YgjqIwIUcsgws2qI97mXfJUR3xkzoo6WNNyxG+Ywx3
 qaT3UZB6nROWXMS9A9FOPN1P2bxs8Qf0+yeo1MJrIs1CcAKOhs5go0w70kZWoFH8o28TzEBJF6BaXje3jwpg2eOTSUSNtVvPNMuli8SgM/PXS8q/Fvox7kA9
 c0wXeSAMYeQMGX5u6OYws8xpSX811a4+vnRlX7faCzxvGOXe9b0DCYk8uwgEbOWQKtWOYGLU3Hf+E4cjz44qol0FCv7blPr0dltqW/KaQLx86iVuAriINQRZ
 fTm0gstz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/19 1:44 PM, Pavel Machek wrote:
> Hi!
> 
>> Two saa7146/hexium files contain a construct that causes a warning
>> when built with clang:
>>
>> drivers/media/pci/saa7146/hexium_orion.c:210:12: error: stack frame size of 2272 bytes in function 'hexium_probe'
>>       [-Werror,-Wframe-larger-than=]
>> static int hexium_probe(struct saa7146_dev *dev)
>>            ^
>> drivers/media/pci/saa7146/hexium_gemini.c:257:12: error: stack frame size of 2304 bytes in function 'hexium_attach'
>>       [-Werror,-Wframe-larger-than=]
>> static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_data *info)
>>            ^
>>
>> This one happens regardless of KASAN, and the problem is that a
>> constructor to initialize a dynamically allocated structure leads
>> to a copy of that structure on the stack, whereas gcc initializes
>> it in place.
>>
>> Link: https://bugs.llvm.org/show_bug.cgi?id=40776
> 
>> --- a/drivers/media/pci/saa7146/hexium_gemini.c
>> +++ b/drivers/media/pci/saa7146/hexium_gemini.c
>> @@ -270,9 +270,8 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
>>  	/* enable i2c-port pins */
>>  	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
>>  
>> -	hexium->i2c_adapter = (struct i2c_adapter) {
>> -		.name = "hexium gemini",
>> -	};
>> +	strscpy(hexium->i2c_adapter.name, "hexium gemini",
>> +		sizeof(hexium->i2c_adapter.name));
>>  	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
>>  	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
>>  		DEB_S("cannot register i2c-device. skipping.\n");
> 
> As a sideeffect, this removes zero-initialization from
> hexium->i2c_adapter.
> 
> Is that intended / correct?

It's correct, the hexium struct that contains the i2c_adapter is zeroed with
kzalloc, so there is no need to zero it again.

Regards,

	Hans

> 
> [I tried looked at saa7146_i2c_adapter_prepare(), and that does not
> initialize all the fields, either.]
> 
> Best regards,
> 									Pavel
> 

