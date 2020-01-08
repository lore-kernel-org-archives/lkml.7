Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47FBC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B827B206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkO6N3S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgAHOz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:55:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39865 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbgAHOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578495354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kB1wibitGvfWmNgFh2wEqHR7clPpUt8eSyk7OyiPJMc=;
        b=OkO6N3S2xadLkMX/+nbpDvLFA606YeBL5lwSMkLnQk7ac9U9JFcibMPuAZgD8O16N70KDC
        2GrHTQ0vT5CJAxijez6rIRy2Y91e4LSFNEVLZDIcQJ7nHSoyR2+BF17qcteQ87MaVbhAUm
        gnBCRmwXE4FH/8wH+k0uR6huHjFEY38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-zbvrZkrPMW6ex5LogcNkeQ-1; Wed, 08 Jan 2020 09:55:37 -0500
X-MC-Unique: zbvrZkrPMW6ex5LogcNkeQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84990DB62;
        Wed,  8 Jan 2020 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79D7519C70;
        Wed,  8 Jan 2020 14:55:31 +0000 (UTC)
Subject: Re: [PATCH 4.19 089/219] ipmi: Dont allow device module unload when
 in use
To:     cminyard@mvista.com, Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
References: <20191229162508.458551679@linuxfoundation.org>
 <20191229162520.260768030@linuxfoundation.org> <20191230103218.GA10304@amd>
 <20191231213255.GC6497@minyard.net>
From:   Tony Camuso <tcamuso@redhat.com>
Message-ID: <0494ad8e-0f6b-2db8-7faf-9da89179aa9a@redhat.com>
Date:   Wed, 8 Jan 2020 09:55:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191231213255.GC6497@minyard.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/31/19 4:32 PM, Corey Minyard wrote:
> On Mon, Dec 30, 2019 at 11:32:18AM +0100, Pavel Machek wrote:
>> On Sun 2019-12-29 18:18:11, Greg Kroah-Hartman wrote:
>>> From: Corey Minyard <cminyard@mvista.com>
>>>
>>> [ Upstream commit cbb79863fc3175ed5ac506465948b02a893a8235 ]
>>>
>>> If something has the IPMI driver open, don't allow the device
>>> module to be unloaded.  Before it would unload and the user would
>>> get errors on use.
>>>
>>> This change is made on user request, and it makes it consistent
>>> with the I2C driver, which has the same behavior.
>>>
>>> It does change things a little bit with respect to kernel users.
>>> If the ACPI or IPMI watchdog (or any other kernel user) has
>>> created a user, then the device module cannot be unloaded.  Before
>>> it could be unloaded,
>>>
>>> This does not affect hot-plug.  If the device goes away (it's on
>>> something removable that is removed or is hot-removed via sysfs)
>>> then it still behaves as it did before.
>>
>> I don't think this is good idea for stable. First, it includes
>> unrelated function rename,
> 
> Umm, no, that's not unrelated, it was renamed so a defined could be
> done with the original name so the module could be passed in
> automatically.
> 
>> and second, it does not really fix any bug;
>> it just changes behaviour.
> 
> This is true.  I assume Tony asked for the backport.  I'm ambivolent
> on whether this gets backported.  I'll defer to Tony for justification.

I was PTO, and now I'm back, so I'll address this.

The fix returns behavior back to what it was before.
To at least some of our customers, the change in behavior this patch fixes
is a bug.

If backporting it causes an issue, then I'm okay with not doing that, since
we've already backported it into our kernel.

> -corey
> 
>>
>> Best regards,
>> 									Pavel
>> -- 
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> 

