Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14B9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A20C20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfGQOIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:08:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58334 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfGQOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:08:38 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hnkbk-00007P-LC
        for linux-kernel@vger.kernel.org; Wed, 17 Jul 2019 14:08:36 +0000
Received: by mail-pf1-f197.google.com with SMTP id r142so14516678pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 07:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YArSjINoQ5yFdh8yhL0SWy97FyGsngj+ePsB8IsMtuk=;
        b=G4GSAjXqkH7v1r0zs4lDF6E9UT7FKFXpj4E7s9CEikxJUJa+nKK13rLt8bs3HCWvTQ
         owPBNlpUGdzFqMnqtQ2NkYY/iBm2eu8BKTgDoNGu+B4JOGaX3tDiamPwzJeQ3q2op2Kx
         sPjtqlRxNnVNgHsypoijWUQbZP/DlRJf5d2NqDWSzoMy5hB/J5Df3H4vG54RRGK2DvZI
         JyS+ceOyXqHTd/swUhFIlKqRMhXEzx2jkpJLwtBT0zSkCwRt103O4KLHw2s6noVHAt68
         /HRDjhn1t435dIdGVTqCgKFVEWVo3ykD+CUISFdEdqNEB7GiX75yv6H24aE1zkfLtwTX
         fO0A==
X-Gm-Message-State: APjAAAVzeQZP54YxHhBvsrj0I2I4gwN+cLEjq0wJ9XcAYwZMrs+q/RG3
        A5pLYJ23gl6sqOG+8zw3shUDrpOaH1g5mbcDV83bBz/macHwGv6U2iYe6ZQvICNuOe6kvj79pjt
        9UtCRKKoXXLIklF1hGyyqgnwGxoMaoMc7Y/kcrRAwdA==
X-Received: by 2002:a63:e807:: with SMTP id s7mr39993814pgh.194.1563372514782;
        Wed, 17 Jul 2019 07:08:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwlK6Qi5Xq0uNYDu0Hh6e2GHdN6OYbWnhf+LwNe56dEfyhwoAbcSFb9/k/IBE3NMcL02+5NqQ==
X-Received: by 2002:a63:e807:: with SMTP id s7mr39993775pgh.194.1563372514392;
        Wed, 17 Jul 2019 07:08:34 -0700 (PDT)
Received: from 2001-b011-380f-3c20-3096-77ea-5bd6-2b56.dynamic-ip6.hinet.net (2001-b011-380f-3c20-3096-77ea-5bd6-2b56.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:3096:77ea:5bd6:2b56])
        by smtp.gmail.com with ESMTPSA id q24sm21479100pjp.14.2019.07.17.07.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:08:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel: Add firmware lock function
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <7CE1949F-76D2-4D27-82B6-02124E62DF5C@holtmann.org>
Date:   Wed, 17 Jul 2019 22:08:30 +0800
Cc:     Johannes Berg <johannes.berg@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        Luciano Coelho <luciano.coelho@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>, linuxwifi@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <B50A91CA-7379-42F9-8335-8FE4A51BE66F@canonical.com>
References: <20190717074920.21624-1-kai.heng.feng@canonical.com>
 <7CE1949F-76D2-4D27-82B6-02124E62DF5C@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 21:36, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kai-Heng,
>
>> When Intel 8260 starts to load Bluetooth firmware and WiFi firmware, by
>> calling btintel_download_firmware() and iwl_pcie_load_given_ucode_8000()
>> respectively, the Bluetooth btintel_download_firmware() aborts half way:
>> [   11.950216] Bluetooth: hci0: Failed to send firmware data (-38)
>>
>> Let btusb and iwlwifi load firmwares exclusively can avoid the issue, so
>> introduce a lock to use in btusb and iwlwifi.
>>
>> This issue still occurs with latest WiFi and Bluetooth firmwares.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1832988
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - Add bug report link.
>> - Rebase on latest wireless-next.
>>
>> drivers/bluetooth/btintel.c   | 14 ++++++++++++++
>> drivers/bluetooth/btintel.h   | 10 ++++++++++
>> include/linux/intel-wifi-bt.h |  8 ++++++++
>> 3 files changed, 32 insertions(+)
>> create mode 100644 include/linux/intel-wifi-bt.h
>>
>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>> index bb99c8653aab..93ab18d6ddad 100644
>> --- a/drivers/bluetooth/btintel.c
>> +++ b/drivers/bluetooth/btintel.c
>> @@ -20,6 +20,8 @@
>>
>> #define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
>>
>> +static DEFINE_MUTEX(firmware_lock);
>> +
>> int btintel_check_bdaddr(struct hci_dev *hdev)
>> {
>> 	struct hci_rp_read_bd_addr *bda;
>> @@ -709,6 +711,18 @@ int btintel_download_firmware(struct hci_dev *hdev,  
>> const struct firmware *fw,
>> }
>> EXPORT_SYMBOL_GPL(btintel_download_firmware);
>>
>> +void btintel_firmware_lock(void)
>> +{
>> +	mutex_lock(&firmware_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(btintel_firmware_lock);
>> +
>> +void btintel_firmware_unlock(void)
>> +{
>> +	mutex_unlock(&firmware_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(btintel_firmware_unlock);
>> +
>
> so I am not in favor of this solution. The hardware guys should start  
> looking into fixing the firmware loading and provide proper firmware that  
> can be loaded at the same time.

Of course it’s much better to fix from hardware side.

>
> I am also not for sure penalizing all Intel Bluetooth/WiFi combos only  
> because one of them has a bug during simultaneous loading of WiFi and  
> Bluetooth firmware.

Yes, it’s not ideal.

>
> Frankly it would be better to detect a failed load and try a second time  
> instead of trying to lock each other out. The cross-contamination of WiFi  
> and Bluetooth drivers is just not clean.

Ok. Where do you think is better to handle it, Bluetooth core or USB core?

Kai-Heng

>
> Regards
>
> Marcel


