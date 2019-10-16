Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54499ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2555C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CNtR654p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394598AbfJPTxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:53:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43262 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJPTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:53:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so35533pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=A96DxtMYbVnBC5BawUeHIwdFetpJSaKB+Iosg4eUKN4=;
        b=CNtR654pMu4sToO/k+dQ2GmkEMAIHlmjNOjDYMR8bYdZYKUD21TINej7dKnV7arjeF
         wax7tzf9aVQjOqlzitRy3XD/6B4bRZCWkMCqdBUKEAe3xF2DpNAuKVbi/+CPdZrxjGhJ
         bY1YTjq6KqzoGBLT0HadBoOXyrWkA29Cq259Z549J0qsrI2jTwM9wJEuChZ7efLdJwXm
         GzeAqpn3yAuGBHtGE1L4hcmr/pVbH6vtSkyTVnJRkP+FELWDodoyjBvdeFsDmrWHLOQm
         3MchZgFBNxAbUoiK5y+MefpsaqXMQgfq6kifT/YXm6IB2uRJHolFT/XwRp4c6t/4ajYq
         TJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=A96DxtMYbVnBC5BawUeHIwdFetpJSaKB+Iosg4eUKN4=;
        b=tLK1yjPccfssm+AzfQFn5trw86G5dVf0jvMgVGz2kra6ALR/awqd57e8EP/Q3MUaTp
         guJ7nSlDXUErwSa2M8QBcxS0NVX0cOgQJMZYErwj5dJS6pGX3t6iyjsqelPECnV2VilG
         q31LFi9Wby3G3DYf+4dyT9Kn1RnZtOQIs6w6L9vNQoE3iPXbdqTJL0YPxLRm+DuL8kJO
         RarDZUSfZ7CiAAi2ThbPTa12PDRSJ+7nQ3NVWxzZz29LNgZTBV+yjTsG0CTsndar53Rb
         Yz8I/MpNfMEIl/xqNmxJUUfOtTm2imgiEHLnqHcGgc5fmFgaZTFBZELAjmXLZrJra6tQ
         CVow==
X-Gm-Message-State: APjAAAVcfXOEDMKSiganAe+4flZy1CsUx/xcegNcqjAHlNT/87nMnzmE
        Awov1ej63vmDWZvV84YT5uQvZg==
X-Google-Smtp-Source: APXvYqy2E0tQRKJEwVptNPiqgFUNSbAOa04lFyLLh0P4iAMAlmi1134MphX5lC2smS2lQZG2rif3Cg==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr7057586pjt.38.1571255603146;
        Wed, 16 Oct 2019 12:53:23 -0700 (PDT)
Received: from localhost ([2601:647:5700:f97e:1021:e5a8:28ca:ce5f])
        by smtp.gmail.com with ESMTPSA id f13sm19053148pgr.6.2019.10.16.12.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 12:53:22 -0700 (PDT)
References: <20191004000933.24575-1-mkorpershoek@baylibre.com> <474814D3-A97F-48D1-8268-3D200BE60795@holtmann.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_core: fix init with HCI_QUIRK_NON_PERSISTENT_SETUP
In-reply-to: <474814D3-A97F-48D1-8268-3D200BE60795@holtmann.org>
Date:   Wed, 16 Oct 2019 12:53:21 -0700
Message-ID: <87sgnsfowe.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel,

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Mattijs,
>
>> Some HCI devices which have the HCI_QUIRK_NON_PERSISTENT_SETUP=20
>> [1]
>> require a call to setup() to be ran after every open().
>>=20
>> During the setup() stage, these devices expect the chip to=20
>> acknowledge
>> its setup() completion via vendor specific frames.
>>=20
>> If userspace opens() such HCI device in HCI_USER_CHANNEL [2]=20
>> mode,
>> the vendor specific frames are never tranmitted to the driver,=20
>> as
>> they are filtered in hci_rx_work().
>>=20
>> Allow HCI devices which have HCI_QUIRK_NON_PERSISTENT_SETUP to=20
>> process
>> frames if the HCI device is is HCI_INIT state.
>>=20
>> [1] https://lore.kernel.org/patchwork/patch/965071/
>> [2] https://www.spinics.net/lists/linux-bluetooth/msg37345.html
>>=20
>> Fixes: 740011cfe948 ("Bluetooth: Add new quirk for=20
>> non-persistent setup settings")
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>> Some more background on the change follows:
>>=20
>> The Android bluetooth stack (Bluedroid) also has a HAL=20
>> implementation
>> which follows Linux's standard rfkill interface [1].
>>=20
>> This implementation relies on the HCI_CHANNEL_USER feature to=20
>> get
>> exclusive access to the underlying bluetooth device.
>>=20
>> When testing this along with the btkmtksdio driver, the
>> chip appeared unresponsive when calling the following from=20
>> userspace:
>>=20
>>    struct sockaddr_hci addr;
>>    int fd;
>>=20
>>    fd =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
>>=20
>>    memset(&addr, 0, sizeof(addr));
>>    addr.hci_family =3D AF_BLUETOOTH;
>>    addr.hci_dev =3D 0;
>>    addr.hci_channel =3D HCI_CHANNEL_USER;
>>=20
>>    bind(fd, (struct sockaddr *) &addr, sizeof(addr)); # device=20
>>    hangs
>>=20
>> In the case of bluetooth drivers exposing=20
>> QUIRK_NON_PERSISTENT_SETUP
>> such as btmtksdio, setup() is called each multiple times.
>> In particular, when userspace calls bind(), the setup() is=20
>> called again
>> and vendor specific commands might be send to re-initialize the=20
>> chip.
>>=20
>> Those commands are filtered out by hci_core in HCI_CHANNEL_USER=20
>> mode,
>> preventing setup() from completing successfully.
>>=20
>> This has been tested on a 4.19 kernel based on Android Common=20
>> Kernel.
>> It has also been compile tested on bluetooth-next.
>>=20
>> [1]=20
>> https://android.googlesource.com/platform/system/bt/+/refs/heads/master/=
vendor_libs/linux/interface/
>>=20
>> net/bluetooth/hci_core.c | 15 +++++++++++++--
>> 1 file changed, 13 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/net/bluetooth/hci_core.c=20
>> b/net/bluetooth/hci_core.c
>> index 04bc79359a17..5f12e8574d54 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -4440,9 +4440,20 @@ static void hci_rx_work(struct=20
>> work_struct *work)
>> 			hci_send_to_sock(hdev, skb);
>> 		}
>>=20
>> +		/* If the device has been opened in HCI_USER_CHANNEL,
>> +		 * the userspace has exclusive access to device.
>> +		 * When HCI_QUIRK_NON_PERSISTENT_SETUP is set and
>> +		 * device is HCI_INIT,  we still need to process
>> +		 * the data packets to the driver in order
>> +		 * to complete its setup().
>> +		 */
>> 		if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
>> -			kfree_skb(skb);
>> -			continue;
>> +			if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>> +				      &hdev->quirks) ||
>> +			    !test_bit(HCI_INIT, &hdev->flags)) {
>> +				kfree_skb(skb);
>> +				continue;
>> +			}
>> 		}
>
> 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> 	    !test_bit(HCI_INIT, &hdev->flags)) {
> 		kfree_skb(skb);
> 		continue;
> 	}
>
> Wouldn=E2=80=99t it be enough to just add a check for HCI_INIT to this.=20
> I mean it makes no difference if ->setup is repeated on each=20
> device open or not. We want to process event during HCI_INIT=20
> when in user channel mode.
Thank you for your review. You are right. We always want to=20
process
events during HCI_INIT in user channel mode.

I'll send a v2

Regards,
Mattijs

>
> Regards
>
> Marcel

