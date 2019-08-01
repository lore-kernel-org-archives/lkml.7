Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669A1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3476D20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCph01Fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbfHAT2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:28:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41334 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHAT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:28:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so34644255pff.8;
        Thu, 01 Aug 2019 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U4fqs+7fIVsIV0e3PRzwKf7VHBpCEy8xtJL+SJDtpmw=;
        b=tCph01FrX08IAJGXNO3ZTGEgF0hjhzRupPshy7k4aBUHUpUaDN08gaqI0oDlDrZ8FY
         DtTss+1scBgYjqNjGI00SclIHHyn596DL89HjEbn3I1T4RQoxB3zsq4HEvUfwlIN1BML
         BKp/CE4Z8zZl5VzJ1NE87zk3t0bI0TU1XrYiaQwXXqTpWjCrelSbtGzCldQ4Zjo8yUxz
         hkZBiTDuAMzxbeu+9Ae2+dm3mZ8wu32rDTLkbnFbHQeEySoHb/GSfV1q5d5d96R03XXb
         YxV9Sb05YnYNfMr8VTa610wdUrnE7/Ybqc8PwjLetu53hE/U5HJY/m8hwUKPY1eTov5f
         +YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U4fqs+7fIVsIV0e3PRzwKf7VHBpCEy8xtJL+SJDtpmw=;
        b=YzIG3k+LFyxvvZFmCDcKh/96hKIO3J8RX5ZFQdlgVX0hfHPQqGO1JPPpfFLgMJTP0C
         XX4yUMTKwa8JU2u5/twRSSMzfJ+qn22KmbEzt3KxjzUVEUmVtEQw8RFKtihnAWJpvcCy
         DoIiQjwarEEwebmAPF/eM1VZMPo1Yhz7OPVBcEWikMRukc1ueWGWGNWwOLK5NblOXwda
         1gHYbD3In/U4QKS/6yU1dL6ozY3YvYV7YYiO+xFmRsOInF1BePoC0es7rLIizcpirjb1
         yZqe4J63PNOS2Gy3i1pTh1f/wAfADVvyUzwyPt73yd4scCNoCcvYk4Phndh0wI3rHJhD
         yK+Q==
X-Gm-Message-State: APjAAAWXIk3DY3e367WyfLPYz1nSUcX1cQrD/OQG1R4zMHZ+9ipvBFIv
        9NwPI5pfzIl5H/ekjpJ5P2s=
X-Google-Smtp-Source: APXvYqyafako6ZUoYO2ZC0gv32JQYkTg9Hvxeabrsg5mOPma+cs21PGmyZfob+3/upeUe8ljpIbJww==
X-Received: by 2002:a63:290:: with SMTP id 138mr28121312pgc.402.1564687695005;
        Thu, 01 Aug 2019 12:28:15 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id e11sm85899814pfm.35.2019.08.01.12.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:28:14 -0700 (PDT)
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
References: <20190731221721.187713-1-saravanak@google.com>
 <20190801061209.GA3570@kroah.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5a1e785d-075e-19a0-7d3d-949e1b65d726@gmail.com>
Date:   Thu, 1 Aug 2019 12:28:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801061209.GA3570@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 7/31/19 11:12 PM, Greg Kroah-Hartman wrote:
> On Wed, Jul 31, 2019 at 03:17:13PM -0700, Saravana Kannan wrote:
>> Add device-links to track functional dependencies between devices
>> after they are created (but before they are probed) by looking at
>> their common DT bindings like clocks, interconnects, etc.
>>
>> Having functional dependencies automatically added before the devices
>> are probed, provides the following benefits:
>>
>> - Optimizes device probe order and avoids the useless work of
>>   attempting probes of devices that will not probe successfully
>>   (because their suppliers aren't present or haven't probed yet).
>>
>>   For example, in a commonly available mobile SoC, registering just
>>   one consumer device's driver at an initcall level earlier than the
>>   supplier device's driver causes 11 failed probe attempts before the
>>   consumer device probes successfully. This was with a kernel with all
>>   the drivers statically compiled in. This problem gets a lot worse if
>>   all the drivers are loaded as modules without direct symbol
>>   dependencies.
>>
>> - Supplier devices like clock providers, interconnect providers, etc
>>   need to keep the resources they provide active and at a particular
>>   state(s) during boot up even if their current set of consumers don't
>>   request the resource to be active. This is because the rest of the
>>   consumers might not have probed yet and turning off the resource
>>   before all the consumers have probed could lead to a hang or
>>   undesired user experience.
>>
>>   Some frameworks (Eg: regulator) handle this today by turning off
>>   "unused" resources at late_initcall_sync and hoping all the devices
>>   have probed by then. This is not a valid assumption for systems with
>>   loadable modules. Other frameworks (Eg: clock) just don't handle
>>   this due to the lack of a clear signal for when they can turn off
>>   resources. This leads to downstream hacks to handle cases like this
>>   that can easily be solved in the upstream kernel.
>>
>>   By linking devices before they are probed, we give suppliers a clear
>>   count of the number of dependent consumers. Once all of the
>>   consumers are active, the suppliers can turn off the unused
>>   resources without making assumptions about the number of consumers.
>>
>> By default we just add device-links to track "driver presence" (probe
>> succeeded) of the supplier device. If any other functionality provided
>> by device-links are needed, it is left to the consumer/supplier
>> devices to change the link when they probe.
> 
> All now queued up in my driver-core-testing branch, and if 0-day is
> happy with this, will move it to my "real" driver-core-next branch in a
> day or so to get included in linux-next.

I have been slow in getting my review out.

This patch series is not yet ready for sending to Linus, so if putting
this in linux-next implies that it will be in your next pull request
to Linus, please do not put it in linux-next.

Thanks,

Frank

> 
> thanks for sticking with this!
> 
> greg k-h
> 

