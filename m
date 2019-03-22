Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FD120700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfCVH6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:58:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54794 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:58:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so1136321wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 00:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8xbd8CXr9XHUZUqs4XQNjd69dgLQnFeXMfj39ibW2YU=;
        b=LsNH5P28rKlAn85YB1vt7T7x2cwMwXxWErSiNv092ANi6mS7KGCkgMPtRFkB9CUNXJ
         W6Rw/KJK/1GmvTLfRAD0Nqa9mMAb/m+u+zVyWcDe+CNs0z8BEqNrt51VK5tYustR26xr
         f/KnpE+/Bo9xewUVFwf+zVWQacr9B1U5SmxQ2fEnT41Vzl5f3kVjCJFs+i+czxBTPUW9
         xNw3xbXjlQEEZkhnxyyY+0ICwi4/HNOqS/gH502qPwKP5kdZG1XZlLM9JrNEZ98r6YnA
         NYp/b15pt3DbFo6ydsIPNAcecugK3d2tixc2l3nwHOOj1xidgc6FQaZ7ifZxv1hCJelG
         4+tg==
X-Gm-Message-State: APjAAAU4Rw2lcYKWhHZJCejWvEIeje1Js6uSLuLse+A1OTKrssX7edwK
        CWX/mH2tbzIYcYqT3TvgA8Indg==
X-Google-Smtp-Source: APXvYqxueQnEChqmUzpNctyDssSa24HpcEB/BP0Eb9yt2jUYMgeNaIu/5gk/qPRXnlav9f/j6nFS+Q==
X-Received: by 2002:a1c:f718:: with SMTP id v24mr2131179wmh.1.1553241484655;
        Fri, 22 Mar 2019 00:58:04 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f11sm2605897wrm.30.2019.03.22.00.58.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 00:58:03 -0700 (PDT)
Subject: Re: [PATCH] virt: vbox: Implement passing requestor info to the host
 for VirtualBox 6.0.x
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        "Knut St . Osmundsen" <knut.osmundsen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190320093519.26029-1-hdegoede@redhat.com>
 <20190320182614.GB3907@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f8226ea5-ac37-5fbb-e532-717a1a8320c9@redhat.com>
Date:   Fri, 22 Mar 2019 08:58:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320182614.GB3907@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-03-19 19:26, Greg Kroah-Hartman wrote:
> On Wed, Mar 20, 2019 at 10:35:19AM +0100, Hans de Goede wrote:
>> diff --git a/drivers/virt/vboxguest/vboxguest_version.h b/drivers/virt/vboxguest/vboxguest_version.h
>> index 77f0c8f8a231..84834dad38d5 100644
>> --- a/drivers/virt/vboxguest/vboxguest_version.h
>> +++ b/drivers/virt/vboxguest/vboxguest_version.h
>> @@ -9,11 +9,10 @@
>>   #ifndef __VBOX_VERSION_H__
>>   #define __VBOX_VERSION_H__
>>   
>> -/* Last synced October 4th 2017 */
> 
> We don't care about the date sync anymore?

I did not sync with the latest version, I've picked
the svn revision number from the 6.0.0 release
(6.0.4 is out now) in case one of the 6.0.x releases
have introduced something new which we do not implement
yet.

>> -#define VBG_VERSION_MAJOR 5
>> -#define VBG_VERSION_MINOR 2
>> +#define VBG_VERSION_MAJOR 6
>> +#define VBG_VERSION_MINOR 0
>>   #define VBG_VERSION_BUILD 0
>> -#define VBG_SVN_REV 68940
>> -#define VBG_VERSION_STRING "5.2.0"
>> +#define VBG_SVN_REV 127566
>> +#define VBG_VERSION_STRING "6.0.0"
> 
> Do we really need to keep track of this?

Unfortunately yes, last time I checked the host has
some code checking the VBG_SVN_REV to determine whether
or not to apply some bug workaround.

>>   
>>   #endif
>> diff --git a/drivers/virt/vboxguest/vmmdev.h b/drivers/virt/vboxguest/vmmdev.h
>> index 5e2ae978935d..6337b8d75d96 100644
>> --- a/drivers/virt/vboxguest/vmmdev.h
>> +++ b/drivers/virt/vboxguest/vmmdev.h
>> @@ -98,8 +98,8 @@ struct vmmdev_request_header {
>>   	s32 rc;
>>   	/** Reserved field no.1. MBZ. */
>>   	u32 reserved1;
>> -	/** Reserved field no.2. MBZ. */
>> -	u32 reserved2;
>> +	/** IN: Requestor information (VMMDEV_REQUESTOR_*) */
>> +	u32 requestor;
> 
> They didn't use the first reserved field?  Oh well :(

There is another header for a hgcm-call which partly mirrors
this one and there they are using reserved1, I think it has
something to do with this.
>> --- a/include/uapi/linux/vbox_vmmdev_types.h
>> +++ b/include/uapi/linux/vbox_vmmdev_types.h
>> @@ -102,6 +102,37 @@ enum vmmdev_request_type {
>>   #define VMMDEVREQ_HGCM_CALL VMMDEVREQ_HGCM_CALL32
>>   #endif
>>   
>> +/* vmmdev_request_header.requestor defines */
>> +
>> +/* Requestor user not given. */
>> +#define VMMDEV_REQUESTOR_USR_NOT_GIVEN                      0x00000000
>> +/* The kernel driver (VBoxGuest) is the requestor. */
>> +#define VMMDEV_REQUESTOR_USR_DRV                            0x00000001
>> +/* Some other kernel driver is the requestor. */
>> +#define VMMDEV_REQUESTOR_USR_DRV_OTHER                      0x00000002
>> +/* The root or a admin user is the requestor. */
>> +#define VMMDEV_REQUESTOR_USR_ROOT                           0x00000003
>> +/* Regular joe user is making the request. */
>> +#define VMMDEV_REQUESTOR_USR_USER                           0x00000006
>> +/* User classification mask. */
>> +#define VMMDEV_REQUESTOR_USR_MASK                           0x00000007
>> +/* Kernel mode request. */
>> +#define VMMDEV_REQUESTOR_KERNEL                             0x00000000
> 
> Wait, isn't that the same as VMMDEV_REQUESTOR_USR_NOT_GIVEN?

The call coming directly from the call, rather then through the
/dev/vboxguest or /dev/vboxuser devices is indicated by the
lack of the VMMDEV_REQUESTOR_USERMODE bit. I will add a

#define VMMDEV_REQUESTOR_MODE_MASK				0x00000008

To make this more clear for v2 and add blank lines to group the different
items together per mask.


>> +/* User mode request. */
>> +#define VMMDEV_REQUESTOR_USERMODE                           0x00000008
>> +/* Don't know the physical console association of the requestor. */
>> +#define VMMDEV_REQUESTOR_CON_DONT_KNOW                      0x00000000
> 
> And here, why is this number recycled?

VMMDEV_REQUESTOR_USR_NOT_GIVEN (the first 0x0000000 define) is part of the
which user made this call mask: VMMDEV_REQUESTOR_USR_MASK, this is part
of the is the user behind the physical console info mask:
VMMDEV_REQUESTOR_CON_MASK

I've omitted the other defines since we are not using them, I will add
them to make this more clear.


>> +/* Console classification mask. */
>> +#define VMMDEV_REQUESTOR_CON_MASK                           0x00000040
>> +/* Requestor is member of special VirtualBox user group. */
>> +#define VMMDEV_REQUESTOR_GRP_VBOX                           0x00000080
> 
> Can you add a blank line here to make it more obvious it is "TRUST"
> stuff here?

Ack.


>> +/* Requestor trust level: Unspecified */
>> +#define VMMDEV_REQUESTOR_TRUST_NOT_GIVEN                    0x00000000
>> +/* Requestor trust level mask */
>> +#define VMMDEV_REQUESTOR_TRUST_MASK                         0x00007000
> 
> So those bits are the "trust" values?

Right, again I did not add defines for values we do not use under Linux
(this value comes from some Windows authentication mechanism, so under Linux
it is always VMMDEV_REQUESTOR_TRUST_NOT_GIVEN)


> that's odd, oh well, it's their api, not ours :(
> 
>> +/* Requestor is using the less trusted user device node (/dev/vboxuser) */
>> +#define VMMDEV_REQUESTOR_USER_DEVICE                        0x00008000
> 
> Wait, what is this for?
> 
> So the dev node isn't as "trusted" as some other api?  Why not?

There are 2 device nodes:

/dev/vboxguest
/dev/vboxuser

With the latter being mode 0666, the vboxguest code already disallows
some requests / IOCTLs when done on the /dev/vboxuser node.

With this new requestor mechanism, the purpose of which is to allow host
admins to write finer grained policies for which requests to accept from the
guest AFAIK, we are now also forwarding the info that the request was done
on the world accessible /dev/vboxuser node, rather then on the restricted
/dev/vboxguest node to the host.

Regards,

Hans
