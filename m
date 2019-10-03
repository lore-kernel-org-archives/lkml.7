Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754CDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56397222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJCFVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 01:21:45 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45796 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfJCFVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:21:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46kLw7068qz1rK4B;
        Thu,  3 Oct 2019 07:21:42 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46kLw66CYBz1qqkK;
        Thu,  3 Oct 2019 07:21:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 80Da5VYQF329; Thu,  3 Oct 2019 07:21:41 +0200 (CEST)
X-Auth-Info: LFxTrFuYi+4nz3f5ZE4LbrlcIC7kNleGhCNFGo/I4KE=
Received: from [192.168.1.106] (213-197-88-96.pool.digikabel.hu [213.197.88.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  3 Oct 2019 07:21:41 +0200 (CEST)
Reply-To: hs@denx.de
Subject: Re: [PATCH 1/2] misc: add cc1101 devicetree binding
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
References: <20190922060356.58763-1-hs@denx.de>
 <20190922060356.58763-2-hs@denx.de>
 <5d94b1e3.1c69fb81.9d89.1cce@mx.google.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <2329ed8f-7e34-596a-ae94-c9b5ac263908@denx.de>
Date:   Thu, 3 Oct 2019 07:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5d94b1e3.1c69fb81.9d89.1cce@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Am 02.10.2019 um 16:19 schrieb Rob Herring:
> On Sun, Sep 22, 2019 at 08:03:55AM +0200, Heiko Schocher wrote:
>> add devicetree binding for cc1101 misc driver.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>>   .../devicetree/bindings/misc/cc1101.txt       | 27 +++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/cc1101.txt
> 
> Can you please convert this to DT schema.

Of course, missed this point, sorry, reworked. Is there a HowTo
for writting a schema?
(beside Documentation/devicetree/bindings/example-schema.yaml)

>> diff --git a/Documentation/devicetree/bindings/misc/cc1101.txt b/Documentation/devicetree/bindings/misc/cc1101.txt
>> new file mode 100644
>> index 0000000000000..afea6acf4a9c5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/cc1101.txt
> 
> Normal naming is to use compatible string. So ti,cc1101.yaml for schema.

renamed.

> 
>> @@ -0,0 +1,27 @@
>> +driver cc1101 Low-Power Sub-1 GHz RF Transceiver chip from Texas
>> +Instruments.
>> +
>> +Requires node properties:
>> +- compatible : should be "ti,cc1101";
>> +- reg        : Chip select address of device, see:
>> +               Documentation/devicetree/bindings/spi/spi-bus.txt
>> +- gpios      : list of 2 gpios, first gpio is for GDO0 pin
>> +               second for GDO2 pin, see more:
> 
> Is there a GDO1? Would be hard to add later because you can't change the
> indices once defined.

Good point. There is a GDO1, so yes, this makes sense, added.

> 
>> +               Documentation/devicetree/bindings/gpio/gpio.txt
>> +
>> +Recommended properties:
>> + - spi-max-frequency: Definition as per
>> +                Documentation/devicetree/bindings/spi/spi-bus.txt
> 
> Notice that this file is now just in redirection...

Ok.

> 
>> + - freq       : used spi frequency for communication with cc1101 chip
> 
> What's this? Doesn't spi-max-frequency cover it?

Of course, removed.

Thanks for your time and review.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
