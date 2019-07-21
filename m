Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2A1C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DCF208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="hj0GFN8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfGUUhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:37:34 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44720 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfGUUhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:37:33 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 199BE1A02E0;
        Sun, 21 Jul 2019 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1563741453; bh=W3XfJWnWhH14ISZ95oKKFD712umDCzjhU++DOEBCHzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hj0GFN8FsAUqAo3PwwCaBAjWHhhFpIgsntH2NHLbEod5PP/HqqEQ+AeuG/PU6WLZW
         DM0Y6DWOxztV40IGjPTxhZGP3ziIdy4xufsEqU2qTyiXcCaYEM947vF29Sh5WjYnms
         X+BLVvoy4Id5pd/n7Q0Y2ihEEFWtScXWik9sXP10=
X-Riseup-User-ID: 060C099BE3A56F342C111FDE49890A5BFED934EC9FB32B0CFFFDC8448FE3247C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 143EC120328;
        Sun, 21 Jul 2019 13:37:32 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 21 Jul 2019 13:37:31 -0700
From:   avoidr@riseup.net
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Karszniewicz <avoidr@firemail.cc>,
        linux-hwmon-owner@vger.kernel.org
Subject: Re: [PATCH v3 1/1] hwmon: (k8temp) update to use new hwmon
 registration API
In-Reply-To: <20190721151408.GA13373@roeck-us.net>
References: <1d0f98fb-a0a6-38b7-98f6-ec4c365587b0@roeck-us.net>
 <20190721120051.28064-1-avoidr@riseup.net>
 <20190721151408.GA13373@roeck-us.net>
Message-ID: <16e03db49372a5f240b241f985f8685c@riseup.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-21 17:14, Guenter Roeck wrote:
> On Sun, Jul 21, 2019 at 02:00:51PM +0200, Robert Karszniewicz wrote:
>> Removes:
>> - hwmon_dev from k8temp_data struct, as that is now passed
>>   to callbacks, anyway.
>> - other k8temp_data struct fields, too.
>> - k8temp_update_device()
>>
>> Also reduces binary size:
>>    text    data     bss     dec     hex filename
>>    4139    1448       0    5587    15d3 drivers/hwmon/k8temp.ko.bak
>>    3103    1220       0    4323    10e3 drivers/hwmon/k8temp.ko
>>
>> Signed-off-by: Robert Karszniewicz <avoidr@firemail.cc>
>> Signed-off-by: Robert Karszniewicz <avoidr@riseup.net>
> 
> Applied.

Thank you! It's been a joy!

>> ---
>> Changes from v2:
>> - if (data->swap_core_select)
>> -     core ^= 1;
>> + core ^= data->swap_core_select;
>>
>> However, that produces slightly more .text than v2, and is a tad too
>> "tricky", I personally find.
>>
> Interesting - for me it produces ~30 bytes less code (with gcc 7.4.0).

Strange. I just verified to make sure and I do get ~30 bytes /more/ code
(with gcc 9.1.0).
