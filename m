Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4694FC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126762070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pedrovanzella.com header.i=@pedrovanzella.com header.b="TXsLmCAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHwOWwIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFEXmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 19:42:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59665 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbfFEXmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:42:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CC21022220;
        Wed,  5 Jun 2019 19:41:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 05 Jun 2019 19:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        pedrovanzella.com; h=content-type:mime-version:subject:from
        :in-reply-to:date:cc:content-transfer-encoding:message-id
        :references:to; s=fm3; bh=EZbhrfK1JpnzKGEc0M0CscFfmH3oWhxRjJB5iY
        MW6yU=; b=TXsLmCAL7fVbwBMJ5dEKxOJDmOUMBJf5jfF8iOXdXDsIGUTm3pDDOi
        eNSm5xLv9RsEvpYvwGzBRJDwhtEl2A4smnt7vtTt9Jnytlye2Memz17UFfTfC8OC
        LygO8cfyQmzuA/zQONM3vH8XkPdKUWgeLz0PxjLwKqQZDN2MK+Zpo6ZnhiWa2zm8
        6x6jJ51JdCA9hToaeKhcc8pWT+WoCXQFIAj6lPYYM47aSIMhiRviXxaczNTJeWe9
        TQNfMTJW0oa7AtbnmSltSfZDdo9L5dCOkF+x1z21g5X7pQuDLrgxuUdpIFjmSHfg
        MjfCyM+NMAqMbVLcTOWv+k3yQAgo1sYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=EZbhrfK1JpnzKGEc0M0CscFfmH3oWhxRjJB5iYMW6
        yU=; b=KHwOWwIfSEM8VhNSd/NaE6ERaqiHXmzoRPzwVJULFLZBPvzeg89XdygkU
        hp5H0o1+yG196mMCG8U7fX5EjUVwV1mLdiVPNKE5fnfoMSKx+BsH6+2mT2EGmzIL
        2n4lb5k/KmrM3RT6VxNnh3CXqEkKIHR5HRf8Uwdg4ZP3hz20RT9dfAB8zi6+A3We
        m/3LD3vIkG/MNeYHFIJOCaYfQkedcQDteEkZG9Klvp+sR26T9HM+BRxv58oKR35E
        mXS9xvlCGMlTNiTUFACFpmyWRgcIhfe6VAGNGtQpkmcdZhZfM2gncv1o1d9W7IU2
        Mx9ZrgD0ToI8ouy558PomeGxxOYyA==
X-ME-Sender: <xms:RVP4XEQIfqIvge0X2bA6tA-H2IEGLKZh7KD8OOoyNatI8gSkhbXxag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudegfedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhofgjfffgkfhfvfesthhqmhdthhdtjeenucfhrhhomheprfgvughr
    ohcugggrnhiivghllhgruceophgvughrohesphgvughrohhvrghniigvlhhlrgdrtghomh
    eqnecukfhppeduleelrdejrdduheejrddvgeenucfrrghrrghmpehmrghilhhfrhhomhep
    phgvughrohesphgvughrohhvrghniigvlhhlrgdrtghomhenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:RVP4XNk8ja6SubDyGnbQauppK7iCKClG2xfMJXVLg0yrORpYvJgXnQ>
    <xmx:RVP4XIQCQZj78vYL9kOPgZitH02GXdYyXusNTOcNhUtNpdviRWSvcg>
    <xmx:RVP4XEuvy5nTv9nNcC3UxIYMjGSU3XFXElWAWB960XqhrgvDGKShBg>
    <xmx:RlP4XGNrOlhtOIGoIYk5oA_XdiRyzLAVr4wCEF2_RldwpMgIKsZfTg>
Received: from [10.155.24.203] (199-7-157-24.eng.wind.ca [199.7.157.24])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9EDDF380089;
        Wed,  5 Jun 2019 19:41:57 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/4] Read battery voltage from G403 and G900 mice
From:   Pedro Vanzella <pedro@pedrovanzella.com>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <0d998fe0ff4473be2a9341c1f5ddf55957d18ad8.camel@archlinux.org>
Date:   Wed, 5 Jun 2019 19:41:56 -0400
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEC01F32-27A7-4C05-B82C-27ADD6591F3E@pedrovanzella.com>
References: <20190605194533.18717-1-pedro@pedrovanzella.com> <0d998fe0ff4473be2a9341c1f5ddf55957d18ad8.camel@archlinux.org>
To:     =?utf-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 5, 2019, at 6:24 PM, Filipe La=C3=ADns <lains@archlinux.org> wrote:=

>=20
>> On Wed, 2019-06-05 at 15:45 -0400, Pedro Vanzella wrote:
>> The gaming line of Logitech devices doesn't use the old hidpp20
>> feature
>> for battery level reporting. Instead, they report the current voltage
>> of the battery, in millivolts.
>>=20
>> This patch set handles this case by adding a quirk to the devices we
>> know
>> to have this new feature, in both wired and wireless mode.
>>=20
>> This version of the patch set is better split, as well as adding the
>> quirk to make sure we don't needlessly probe every device connected.
>>=20
>> Pedro Vanzella (4):
>>  HID: hid-logitech-hidpp: add quirk to handle battery voltage
>>  HID: hid-logitech-hidpp: add function to query battery voltage
>>  HID: hid-logitech-hidpp: report battery voltage to the power supply
>>  HID: hid-logitech-hidpp: subscribe to battery voltage events
>>=20
>> drivers/hid/hid-logitech-hidpp.c | 150
>> ++++++++++++++++++++++++++++++-
>> 1 file changed, 147 insertions(+), 3 deletions(-)
>>=20
>=20
> Hello,
>=20
> Why using quirks? 0x1001 is a feature, it should be discoverable in
> IFeatureSet (0x0001). I don't understand the need to hardcode the
> supported devices, HID++ exists specifically to prevent that.
>=20
> Wasn't this what you started in your previous patch? Why move away from
> it?

I was asked to change to conform to the way the other features were handled.=
 I=E2=80=99ll let the maintainers decide, but I agree with you that the othe=
r way was better.

In fact, since the kernel only needs to support about half a dozen features,=
 we could refactor the probe function to, well, probe the device for those f=
eatures and set the capability flags. It looks to me like that would be clea=
ner and easier to extend (and would make it easier to support future devices=
).

> Thank you,
> Filipe La=C3=ADns
> 3DCE 51D6 0930 EBA4 7858 BA41 46F6 33CB B0EB 4BF2

