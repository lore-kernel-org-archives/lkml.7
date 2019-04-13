Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A2C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40600206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfDMUiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:38:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45068 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDMUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:38:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id o26so11251674edv.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 13:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZiCM0RO/92DahOkwyKD8HuHBHkhV62I5tXQ5to8Sh3U=;
        b=LhTkKGGj5KSYEpY00WykJl6BK1ClMDzAd/IJc/4oBIH5yor6cUYtCMPCwkNqGhoMkd
         pcXAkYWimfMXAKSzTF7sGpPByEA6Njsydc+h8lDZhC84ruFE6KWUyhS1iC9UsMuYY0Wx
         XCt3ovJ8N4bz/6xKn+ZGX/29qOTTa7ZaI48oVYSWc2OQFUbe5unQdeeIUcRwXyvMaunH
         6Hb1+Z6DY9U+PcDi+dL/Ox2Ow8khlxYlzxAFL7AYIbqfvbx8JXY1qKwseHo9VGYDh8AV
         jMspPeLha9SiwVKO6Y8/lwn6PESiJdYL+ZgtdUbvEKOgj69uMRJAzJ+rfW2lx1Oycfq2
         9vnA==
X-Gm-Message-State: APjAAAV7FTkDiceKSj3+FouemCCzOSSsT6AgCRWUcpdAgvRng8FMHlt8
        OVGg2QUbqXAI4w7RF7zcFxYpqXmZ794=
X-Google-Smtp-Source: APXvYqzKc5fhn1Q6UZXIajWWRE56dECMmxAz3LeQHXAevL1M5sUq/3bED6DH+hQ68GwjclmYAUoB8Q==
X-Received: by 2002:a50:f5c3:: with SMTP id x3mr11649166edm.28.1555187931559;
        Sat, 13 Apr 2019 13:38:51 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r1sm4275960edx.12.2019.04.13.13.38.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 13:38:50 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: tcpm: collision avoidance
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Kyle Tso <kyletso@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190322121745.159768-1-kyletso@google.com>
 <20190404141345.GF21319@kuha.fi.intel.com>
 <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net>
 <CAGZ6i=2zKLhS4By8Xanc863G+jSxPYg8SLU-UHkY94r5MiEYag@mail.gmail.com>
 <20190409130230.GC20058@kuha.fi.intel.com>
 <20190409130649.GD20058@kuha.fi.intel.com>
 <9c9d17e3-bd99-c877-359c-a0a1b10a8d73@redhat.com>
 <AM5PR1001MB099440C3AA6DA6BA2AB0F2AE802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CAGZ6i=0rRgNH5bU-zcP58MNi+VSa+xeAQWL67egaZ-ui-ebmYA@mail.gmail.com>
 <9f9a2de9-2cfb-385c-8e99-54b2587113ce@redhat.com>
 <AM5PR1001MB09943830CFED9CB321CC883D802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <76a3c6df-63c0-78e7-c1ca-c83a30e95d38@redhat.com>
Message-ID: <009662c6-2897-e2dd-03a7-992fc0a78599@redhat.com>
Date:   Sat, 13 Apr 2019 22:38:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <76a3c6df-63c0-78e7-c1ca-c83a30e95d38@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-04-19 18:38, Hans de Goede wrote:
> On 10-04-19 18:14, Adam Thomson wrote:
>> On 10 April 2019 16:45, Hans de Goede wrote:

<snip>

>>> Starting toggling from tcpm_set_cc() just feels wrong; and currently power role
>>> swapping is broken with the fusb302, which IIRC used to work. I suspect this is
>>> related.
>>>
>>> I plan to write a patch tomorrow to functionally take tcpm_set_cc() back to the
>>> way it was before. This should fix your case and I hope this also fixes power-role
>>> swapping.
>>>
>>> This will re-introduce Adam Thomson's problem, but I have a feeling that that
>>> actually needs a fix in the tcpm.c code rather then at the fusb302 level.
>>
>> To be clear here, the names TOGGLING_MODE_SNK and TOGGLING_MODE_SRC are a
>> misnomer from the HW spec for fusb302. The device isn't toggling anything as far
>> as I'm aware, so I don't necessarily agree with your point.
> 
> If I understand the datasheet correctly:
> 
> "The FUSB302 has the capability to do autonomous
> DRP toggle. In autonomous toggle the FUSB302
> internally controls the PDWN1, PDWN2, PU_EN1 and
> PU_EN2, MEAS_CC1 and MEAS_CC2 and implements
> a fixed DRP toggle between presenting as a SRC and
> presenting as a SNK. Alternately, it can present as a
> SRC or SNK only and poll CC1 and CC2 continuously."
> 
> It is still attaching Rp resp Rd to CC1 or CC2 one at a time
> to detect polarity, so it is still toggling, it just is not
> doing dual-role toggling. This is also expected behavior for
> a sink, a sink may not present Rd on both CC pins at the
> same time, otherwise the source cannot detect the polarity
> and the source also cannot detect if Vconn is necessary.
> 
>> It's a mechanism to
>> have the HW report when the CC line changes on connection. Without that we have
>> no reporting from the HW for the fixed role scenarios.
> 
> Not just connection, also polarity detection. Notice that
> the tcpm framework / the driver also has a start_drp_toggling()
> method. I think we may also need a start_srp_toggling function
> just like it and call that from the SNK_UNATTACHED and
> SRC_UNATTACHED states for single-role ports. I agree that we
> need to start toggling when in those states, but tcpm_set_cc gets
> called in a lot of other places where AFAIK we should NOT
> restart toggling and your patch causes us to restart
> toggling in those cases.

Ok, so as I suspected, commit ea3b4d5523bc ("usb: typec: fusb302:
Resolve fixed power role contract setup") is what caused the
power-role swapping breakage I've been seeing.

So I've prepared a 3 patch series:

1) Add a new start_srp_connection_detect function which, when
implemented by the tcpc_dev, gets called instead of
start_drp_toggling for single role ports (SRPs)

2) Implement 1. for fusb302 to fix the SRP issue Adam was
seeing, without depending on set_cc starting "toggling"
or something like it for the fix

3) Revert commit ea3b4d5523bc, restoring power-role swap
functionality.

This should also fix the issue Kyle Tso was seeing when
trying to change from one Rp setting to another.

I'll send out the series right after this email.

Regards,

Hans

