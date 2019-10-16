Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E3C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB4F2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfWXUaQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391921AbfJPJKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:10:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55836 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390073AbfJPJKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571217038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wnyoD9GeD9sw6MkkIhYwLo8oYnwVXWUpolxWdoGChA=;
        b=BfWXUaQGCH2bhuhmVWHM2PVgxa3FHNgFVsvlpC/EZ2FaLy5eWYYCLS+ZxDRgNX2CGumUEJ
        ydzqE0fxu7TiS6PD2M1Y4lnhWjd9L9kQPxIFPaTKjbf4oq+zYY19jgf4zlwS2potRtU3Nz
        hcF9I1OiVQIoNNEwVRHempoZWiX1WGM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-c-XJhunPOOiU_UKakfhC5w-1; Wed, 16 Oct 2019 05:10:36 -0400
Received: by mail-wm1-f70.google.com with SMTP id n3so895325wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qHfslCZ2HogirkHDzVmppJbwUI7mmujl6qQWLisCUMs=;
        b=szmqursfFimiAk/pDxaGXMGYlGNF5wJzkPKeg7ZwMVcXqSbQXEouSfIRL/VwFV4JSf
         MzMx5/zEfZeXwrv/HWJk73GNK6ceeN3Ssh/m+IazUrzl3tQ6VibmFSCDPCn5bq9InTmp
         y1OSLYSf6YWInOnt0YdzbUzNWCaK9VQCX43ryDBfoPM+AWsQqivSU2eMzPbqSQlGX8lp
         PHsb72REiixMIGnui66eMn5g7da2S9qNkc5cvvT2b4Wm43unB7h1hzq28YxhSQ0xvzE7
         QEpyLax6/0e61/HlC959Ahk4CWE1mlSeSXvgHv5LXKlH15kVZi+7WBtPCRNW/d5rJE2f
         7bsg==
X-Gm-Message-State: APjAAAX7BpsmOK2Z8zIBB79VJqX7ZWhhbYEYYjPgWo5UFLeg52mjx7WB
        5hUsGeMtBrR2oAZtHlnCeWwkkkkmNr4te30G4G2aZ1cmGhym6o0Vjdie7d7iCUFQbmydnJqL0vs
        MtbC9boHe/tvx3PDD+5+VzplE
X-Received: by 2002:a1c:1901:: with SMTP id 1mr2497578wmz.28.1571217034679;
        Wed, 16 Oct 2019 02:10:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy3WMCefjHUGYQvI4sWMEM8pH1M69CagwLA3VNuvLu4BdnIwOsn3sYveiZPD4H4zv39QYS/pA==
X-Received: by 2002:a1c:1901:: with SMTP id 1mr2497551wmz.28.1571217034412;
        Wed, 16 Oct 2019 02:10:34 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id r65sm1692887wmr.9.2019.10.16.02.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 02:10:33 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com>
 <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
 <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
Message-ID: <7bd3a621-5983-90e3-8e1f-641a40007ddf@redhat.com>
Date:   Wed, 16 Oct 2019 11:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: c-XJhunPOOiU_UKakfhC5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/15/19 7:39 AM, John Stultz wrote:
> On Thu, Oct 3, 2019 at 1:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 03-10-2019 22:37, John Stultz wrote:
>>> Fair point. I'm sort of taking a larger patchset and trying to break
>>> it up into more easily reviewable chunks, but I guess here I mis-cut.
>>>
>>> The user is the hikey960 gpio hub driver here:
>>>     https://git.linaro.org/people/john.stultz/android-dev.git/commit/?i=
d=3Db06158a2d3eb00c914f12c76c93695e92d9af00f
>>
>> Hmm, that seems to tie the TypeC data-role to the power-role, which
>> is not going to work with role swapping.
>=20
> Thanks again for the feedback here. Sorry for the slow response. Been
> reworking some of the easier changes but am starting to look at how to
> address your feedback here.
>=20
>> What is controlling the usb-role-switch, and thus ultimately
>> causing the notifier you are suggesting to get called ?
>=20
> The tcpm_mux_set() call via tcpm_state_machine_work()
>=20
>> Things like TYPEC_VBUS_POWER_OFF and TYPEC_VBUS_POWER_ON
>> really beg to be modeled as a regulator and then the
>> Type-C controller (using e.g. the drivers/usb/typec/tcpm/tcpm.c
>> framework) can use that regulator to control things.
>> in case of the tcpm.c framework it can then use that
>> regulator to implement the set_vbus callback.
>=20
> So I'm looking at the bindings and I'm not sure exactly how to tie a
> regulator style driver into the tcpm for this?
> Looking at the driver I just see this commented out bit:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/usb/typec/tcpm/tcpm.c#n3075
>=20
> Do you happen to have a pointer to something closer to what you are descr=
ibing?

Look at the tcpm_set_vbus implementation in drivers/usb/typec/tcpm/fusb302.=
c
you need to do something similar in your Type-C controller driver and
export the GPIO as as a gpio-controlled regulator and tie the regulator to
the connector.

Regards,

Han

