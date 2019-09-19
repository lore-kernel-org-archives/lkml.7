Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE511C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8962021D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idVsOT6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbfISNbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:31:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37679 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389492AbfISNbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:31:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so2371524pfo.4;
        Thu, 19 Sep 2019 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yh9xjWmC15LcRyyY8rJ60DM1QAslviok4sh9u5t35BY=;
        b=idVsOT6hSjTJOutVXIi7cTnrT2Va0yjY0ngf+59FSwgbSsMpdtUnsobGaI16bYsZpP
         Nyj/9wJLoBq6NANXDoiMW/08AB2iADjxMTquYFgixeJIK3RfSt4UE6Cg/xrDoM/s+liV
         oVQcLamYvey+XvNKUTwo/FRHz5/gzV6ssPpgkaX76BaMvniLXlHOWsejy5CommFe4nl+
         al0pq8RYP+Anq197wrPBrIpkmfYXtKHvOhs/nankpmhsSgMWAb4ivjs6sYZvTOk/AMgG
         gWojOcNrZCQMJhJNq8ZStoDOSE+dADmMThvZUJ2Le8nXpPOZcID65hALa4XhEJz1ZhZt
         fwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yh9xjWmC15LcRyyY8rJ60DM1QAslviok4sh9u5t35BY=;
        b=ShsP/n2Xtsltsw+h5wFt3Ha2yQ15IPFOyKLV91num2+xLHsel7dLibJjKqWFvP6z/V
         CpEtPAEQoC42DTWUhtCQxJ9rzyi341drWnO327wu1QpkGO4o+mZp0d0wJDegcSTlnOdq
         JHuO9sxjjNhRmHrm4H9XlYTxo6lyMaL13uZUYEQoOJgUl2Ba6E11i9i2ctqip2ZSQmlA
         GlHhrsn9lqoqmtEA03hZwmAKEGi5NlM69Iq6DBNdw/Snxu9AYTCTLEPud0lIDC8MgNTi
         LaHEv7c9sAcu735/TjC83tjIgUPT65o9BAuAjF71mL4WdQWINIGYOtqLrwdg0ABN5bAt
         X/ag==
X-Gm-Message-State: APjAAAVxU3/sjEqR0eXKilruQuCqWqH0uGbtx6VGhzkGcOmlC5kk7HKP
        0NNAlZi8VhD0xfgUXNc1VjgQP4lH
X-Google-Smtp-Source: APXvYqwfeIa6XLqv0I/gOqglay1G8ZnB9i4AF1+fjZxGxePEU2ZH7Aid1OS5yayuUuOfbhoLTVqJ2g==
X-Received: by 2002:a63:c11:: with SMTP id b17mr6136716pgl.24.1568899909567;
        Thu, 19 Sep 2019 06:31:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n9sm4839333pjq.30.2019.09.19.06.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 06:31:48 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: tcpm: collision avoidance
To:     Kyle Tso <kyletso@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
 <009662c6-2897-e2dd-03a7-992fc0a78599@redhat.com>
 <AM5PR1001MB099452876C75E45FD774BA77802B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CAGZ6i=10-DVWRseYXjRGVyRtnTijT9Mg_TBTkv=3qWiMfv28cw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <91295210-7eb7-7272-d6cc-e983e8bd3fdf@roeck-us.net>
Date:   Thu, 19 Sep 2019 06:31:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ6i=10-DVWRseYXjRGVyRtnTijT9Mg_TBTkv=3qWiMfv28cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 3:48 AM, Kyle Tso wrote:
> Ping! Anyone still reviewing this patch?

Which patch ? Hans' series was long since pushed.

Guenter

> I have another change related to AMS.
> I will group them as a set and re-send it.
> 
> Regards,
> Kyle Tso
> 
> 
> On Mon, Apr 15, 2019 at 6:03 PM Adam Thomson
> <Adam.Thomson.Opensource@diasemi.com> wrote:
>>
>> On 13 April 2019 21:39, Hans de Goede wrote:
>>
>>> On 10-04-19 18:38, Hans de Goede wrote:
>>>> On 10-04-19 18:14, Adam Thomson wrote:
>>>>> On 10 April 2019 16:45, Hans de Goede wrote:
>>>
>>> <snip>
>>>
>>>>>> Starting toggling from tcpm_set_cc() just feels wrong; and currently
>>>>>> power role swapping is broken with the fusb302, which IIRC used to
>>>>>> work. I suspect this is related.
>>>>>>
>>>>>> I plan to write a patch tomorrow to functionally take tcpm_set_cc()
>>>>>> back to the way it was before. This should fix your case and I hope
>>>>>> this also fixes power-role swapping.
>>>>>>
>>>>>> This will re-introduce Adam Thomson's problem, but I have a feeling
>>>>>> that that actually needs a fix in the tcpm.c code rather then at the fusb302
>>> level.
>>>>>
>>>>> To be clear here, the names TOGGLING_MODE_SNK and
>>> TOGGLING_MODE_SRC
>>>>> are a misnomer from the HW spec for fusb302. The device isn't
>>>>> toggling anything as far as I'm aware, so I don't necessarily agree with your
>>> point.
>>>>
>>>> If I understand the datasheet correctly:
>>>>
>>>> "The FUSB302 has the capability to do autonomous DRP toggle. In
>>>> autonomous toggle the FUSB302 internally controls the PDWN1, PDWN2,
>>>> PU_EN1 and PU_EN2, MEAS_CC1 and MEAS_CC2 and implements a fixed DRP
>>>> toggle between presenting as a SRC and presenting as a SNK.
>>>> Alternately, it can present as a SRC or SNK only and poll CC1 and CC2
>>>> continuously."
>>>>
>>>> It is still attaching Rp resp Rd to CC1 or CC2 one at a time to detect
>>>> polarity, so it is still toggling, it just is not doing dual-role
>>>> toggling. This is also expected behavior for a sink, a sink may not
>>>> present Rd on both CC pins at the same time, otherwise the source
>>>> cannot detect the polarity and the source also cannot detect if Vconn
>>>> is necessary.
>>>>
>>>>> It's a mechanism to
>>>>> have the HW report when the CC line changes on connection. Without
>>>>> that we have no reporting from the HW for the fixed role scenarios.
>>>>
>>>> Not just connection, also polarity detection. Notice that the tcpm
>>>> framework / the driver also has a start_drp_toggling() method. I think
>>>> we may also need a start_srp_toggling function just like it and call
>>>> that from the SNK_UNATTACHED and SRC_UNATTACHED states for single-role
>>>> ports. I agree that we need to start toggling when in those states,
>>>> but tcpm_set_cc gets called in a lot of other places where AFAIK we
>>>> should NOT restart toggling and your patch causes us to restart
>>>> toggling in those cases.
>>>
>>> Ok, so as I suspected, commit ea3b4d5523bc ("usb: typec: fusb302:
>>> Resolve fixed power role contract setup") is what caused the power-role
>>> swapping breakage I've been seeing.
>>
>> Apologies for the breakage. Annoyed I didn't catch that when submitting that
>> patch. Thanks for looking to resolve this and will review your updates shortly.
>>
>>> So I've prepared a 3 patch series:
>>>
>>> 1) Add a new start_srp_connection_detect function which, when implemented
>>> by the tcpc_dev, gets called instead of start_drp_toggling for single role ports
>>> (SRPs)
>>>
>>> 2) Implement 1. for fusb302 to fix the SRP issue Adam was seeing, without
>>> depending on set_cc starting "toggling"
>>> or something like it for the fix
>>>
>>> 3) Revert commit ea3b4d5523bc, restoring power-role swap functionality.
>>>
>>> This should also fix the issue Kyle Tso was seeing when trying to change from one
>>> Rp setting to another.
>>>
>>> I'll send out the series right after this email.
>>>
>>> Regards,
>>>
>>> Hans
>>
> 

