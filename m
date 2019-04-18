Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097E2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C573F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG9xiBJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbfDRNge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:36:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38742 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:36:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so1220375pgl.5;
        Thu, 18 Apr 2019 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A3qEJxG71mV/MtOf4z6uQrRXkxG1lxjXuCfRlYLAv7A=;
        b=UG9xiBJuTZdQiPCaf+FajXBT+7nZRfAoNmTX8g9dpC0/oC1LH9qxdyWT1MKLanTzpA
         FLhx3F7qFv2MgUnwLoemztMXLFxSC5+O36L4177m1gLxkolhNuuTbqi242SbWgqAr5L/
         Dd67KQvZ3ISY24w3qmmdK1Sx+29U3Z0CCUXZCnUHVbFFy0GKDbeQKmmFy/Iglmgi13Ov
         1UYcd+VPeKavqGbHLvG339Cbp4i9PW+gXa0jp7lMY8S+QfKmeVvYTa7vYwmqEdokxblc
         3LgqA70Bzt//aNMD3l31CjJzynXzKLwBdbsDr8/nXTcAkh+2blUbU+MCxKDoW9qDugWS
         j81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3qEJxG71mV/MtOf4z6uQrRXkxG1lxjXuCfRlYLAv7A=;
        b=UJ9X3VNYKhuwNo+abnmJk2zjwvR+yu+p1EMnHBa8V8ew2QuLDirxn4y8dchvax4Qp9
         /Ju9Tj+C7dIvdZIa9PJVX3yjCWeF6wPMLLxR4rT0xBiwGPMIroBG3cvpCrJuAnIscRoG
         Kvft9UC3foyzm7T1lyCb8mbDd6RjvkVEMEnWuXa/feOToLoaeGMHttjMr4ZtVa+oJo88
         2yURIh+MLGYbF3qq6VmyarU2pv5/vmHuR2bMBoFWtcaqY050BBdhUOrILOVyeypUbsCK
         WvUGqxTIvb1H8xoMruOfnRs+MN/6OALwlNvU2Tuf7T2jHSXjezbSaHqvSTj4zHIrqMeK
         EQDg==
X-Gm-Message-State: APjAAAX9pECcosB0PDQ8NUE7T+RoaDZGKMFB5vedRJ2ti9N4jex7mhjn
        QYynn5s9HHupVc1tPF35Dr0=
X-Google-Smtp-Source: APXvYqzgjypd+v1qREA+odD5pdg0Ei3jnzbcdRlqFEDNryZG+QNyXDJ8tKREvIl5Fa1doKkjK6qipA==
X-Received: by 2002:a65:44c6:: with SMTP id g6mr37427292pgs.157.1555594593200;
        Thu, 18 Apr 2019 06:36:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a17sm5416860pfj.123.2019.04.18.06.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:36:31 -0700 (PDT)
Subject: Re: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dirk Eibach <eibach@gdsys.de>,
        George Joseph <george.joseph@fairview5.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Huang Rui <ray.huang@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Andreas Werner <andreas.werner@men.de>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
        patches@opensource.cirrus.com
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net> <20190417141352.3225bbb3@coco.lan>
 <20190417142215.791df5e7@coco.lan> <20190417174337.GA16749@roeck-us.net>
 <20190417174728.GA17706@roeck-us.net> <20190418064436.1803bf3a@coco.lan>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <55790eec-a81e-75af-dbab-e4f15ad14274@roeck-us.net>
Date:   Thu, 18 Apr 2019 06:36:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418064436.1803bf3a@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 2:44 AM, Mauro Carvalho Chehab wrote:
> Em Wed, 17 Apr 2019 10:47:28 -0700
> Guenter Roeck <linux@roeck-us.net> escreveu:
> 
>> On Wed, Apr 17, 2019 at 10:43:37AM -0700, Guenter Roeck wrote:
>>> On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:
>>>> Em Wed, 17 Apr 2019 14:13:52 -0300
>>>> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
>>>>    
>>>>> Em Wed, 17 Apr 2019 09:47:41 -0700
>>>>> Guenter Roeck <linux@roeck-us.net> escreveu:
>>>>>    
>>>>>> On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:
>>>>>>> Now that all files were converted to ReST format, rename them
>>>>>>> and add an index.
>>>>>>>
>>>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>>>>>>> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
>>>>>>
>>>>>> I applied all patches except this one, which fails due to a conflict in
>>>>>> ab8500. I also notice that this file has not been touched by your series,
>>>>>> which is odd. At the same time, patch 20/21 is missing from your series,
>>>>>> and has been missing all along. Does the missing patch possibly touch
>>>>>> Documentation/hwmon/ab8500 ?
>>>>>
>>>>> Patch 20/21 is the biggest one. Maybe vger rejected it either due to
>>>>> its size or due to the number of c/c.
>>>>>
>>>>> Just bounced it to you. Please let me know if you didn't receive it
>>>>> yet.
>>>>
>>>> Btw, LKML got it:
>>>>
>>>> https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung@kernel.org/
>>>>    
>>> patchwork didn't get it (or didn't accept it). I got it now.
>>> All patches applied, and pushed out to hwmon-next.
>>>
>>> We have one (new) unconverted file left - Documentation/hwmon/lochnagar.
>>
>> Plus ir38064 and isl68137. Lots of new drivers recently.
> 
> Ok, just sent a patch for those three new files. I wrote a more
> detailed description about what steps I followed at the conversion
> of those tree files, and why I did it.
> 
Did the patches get lost ?

> Hopefully, this would help hwmon developers
> that may already be preparing a new driver for submission.
> 

That would be very useful.

Thanks,
Guenter
