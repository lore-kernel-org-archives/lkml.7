Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE5DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13DA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCLOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:51:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41917 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:51:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id n14so2534268edv.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gqBj8nH0pazADWytM/e0oIVEVNfp64FgxLQOymyNMA0=;
        b=cazKa5SZg50YtR4UhOAI6N9pChENEOY5gKPFsrNeK8aCFB7PNXNXkAfZpRZiYJaQ+z
         vpXuOapdNI4iW/KQvTm57TzaxB2AYr/+t+IkJXdMrkyGCbxU7EovmhvaGxxKLraI5tXj
         tgxpT6WsOgn9vfRMMUVMVbCZjHQYLyaTPs2Dd2YwZwwwtquuFRhzt+74zFzbA1AodqvG
         pWHg2me8Nf4pPFxjosvI5JYBcIGzOX2IDu9V5zvzrx3EVLBqjmlbu3vYCU1gv+dol865
         BGsmfP6PmpWSgWA11YgTiyshdVtVla4TDaVCk0J7pqoLin6KQwrS/JLOx0qG8Y3B7yGe
         3LcQ==
X-Gm-Message-State: APjAAAXsO4JORchGB/xsTdT/oXQGOCbTaVFQgUwjRdgu8jwPVNTFs2O1
        TMuZSHB6WdnquSAv1UbXuKoLSmnB28A=
X-Google-Smtp-Source: APXvYqyQ8bRSbEjwqjlROUb9/2KJg1KwFNhCTlbj2DyuEp7oO6vCKZyqwiXHz7/KGyW0Xpg+nMxrJg==
X-Received: by 2002:a17:906:288d:: with SMTP id o13mr26416110ejd.66.1552402312677;
        Tue, 12 Mar 2019 07:51:52 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k3sm449809edn.43.2019.03.12.07.51.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:51:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] i2c: i2c-designware-platdrv: Allow a dynamic adap. nr
 without an ACPI fwnode
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190311112216.31391-1-hdegoede@redhat.com>
 <20190311112216.31391-2-hdegoede@redhat.com>
 <c519b0ea-670d-defe-5870-c6258c19ff74@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4b54ad0b-c3a7-3286-08bb-fda1cd243285@redhat.com>
Date:   Tue, 12 Mar 2019 15:51:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c519b0ea-670d-defe-5870-c6258c19ff74@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-03-19 15:47, Jarkko Nikula wrote:
> Hi
> 
> On 3/11/19 1:22 PM, Hans de Goede wrote:
>> Before this commit the i2c-designware-platdrv assumes that if the pdev
>> has an apci-companion it should use a dynamic adapter-nr and otherwise
>> it will use pdev->id as adapter-nr.
>>
>> On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
>> some of the LPSS i2c-adapters are enumerated through PCI and do not have
>> an ACPI fwnode. These devices are handled as mfd devices so they end up
>> using the i2c-designware-platdrv driver.
>>
>> This results in the i2c-adapter being registered with the mfd generated
>> pdev->id as adapter-nr, which conflicts with existing adapters, triggering
>> a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
>> adapter registration to fail.
>>
> I went thinking would we get a regression if we switch the i2c-designware-platdrv to dynamic numbering unconditionally?
> 
> Only drivers/mfd/intel-lpss.c and drivers/mfd/intel_quark_i2c_gpio.c register platform device "i2c_designware" and otherwise in the driver itself for known ACPI IDs and device tree bindings.
> 
> Things should be fine for ACPI cases if slave devices are also described in ACPI tables. As far as I've understood with device tree matching adapter number is irrelevant in slave device registration?
> 
> Andy: could you tell by commit 918fe70cf475 ("mfd: intel_quark_i2c_gpio: support devices behind i2c bus") are those devices described in ACPI or in some i2c_board_infos with referring to fixed adapter number either in or out of kernel tree code?
> 
> Then drivers/platform/chrome/chromeos_laptop.c is the only code searching for adapter named as "Synopsys DesignWare I2C adapter" without assuming any fixed adapter numbering.
> 
> What's unclear to me can there be device tree cases where i2c-designware probing comes with pdev->id not starting from zero or in different order? I.e. would it make difference do we use pdev->id or dynamic adapter numbering?

I've just completed analyzing all ways a designware_i2c (or compatible)
platform device can be instantiated and I've come to the conclusion that
always using dynamic adapter-nrs is fine and is a proper, clean fix for this.

Also see my reply to Andy which I send about the same time you send
your reply :)

Regards,

Hans
