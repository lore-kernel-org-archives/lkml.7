Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B0DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1B20692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmVtjoxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfKUQCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:02:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40413 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbfKUQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574352167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=rcqdeTgChHnCDo5l36uHf88TY7b96FHBlN+sSTw6btQ=;
        b=BmVtjoxIr5/kEVcZAGQEG9/n33t+2C5KAAe3WQ1Moe8EfYTCkq3Ub9NVIDH3X8gQlxJQac
        egxxbRY8mkJ8Xy8lHJWl3S2dsAHraHWq/iBzaYLsPieamtDQJcH52QP6FOqMP6kQDQ0S6X
        l0CNvcmuW3wPynZrxYChEVQsejv7Gbo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-OL8DMrZQOAKklK-1YLdTlg-1; Thu, 21 Nov 2019 11:02:45 -0500
Received: by mail-wm1-f71.google.com with SMTP id y14so2034914wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qM2tyh78ojNvdG7Z8M8T/3nGHyd1QQztV+4YABQwg58=;
        b=KXl77w9Ju2fsX7nSkQbZKc/24L2YO5EvKjf+InEG5HJHyhgZj2etTRnH2MNQOPE4j5
         DKYcws8ACuCIOno9wDj3zu7fMRL4/4wUhJs1zcopr+tu1rzLAZi0ow7V9G3lPyhkUnaJ
         aLqgvQTYlY7WsHlnMlDhE9PNczGsk3kmBk2K/HMgRVJKlJsjUbnZbVPFBCAXnzny38Df
         SNgXX+akrDaqWbKpqyA8W5wvTYZyVTEVNO7d1/WWAMsxXVcG/6q6UhljohlJw9cTMwSO
         jjdTqodl6HI/dgmBLAF8iuSLiw2YAJ5WEvce3ZpzG9orVcstA0WOHnVPR0M0QIqQXaH/
         Ccow==
X-Gm-Message-State: APjAAAXlmzhgSQ6RJaFcd86l6VuYhVNdhmme3hZT08q19EH8QZ7vaI/a
        UQWwVkk4APfe49ZNXNxFDYwh4MCyOuhgPCwnGWBFTn8TUFiv+BlfHYw86tkxtQE422MqQp+Rsgn
        YtDUtAfC5oxBAwxOKdJUir67Z
X-Received: by 2002:a1c:6641:: with SMTP id a62mr10623029wmc.54.1574352164372;
        Thu, 21 Nov 2019 08:02:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/tD9hcxHhcQWoHQpZcdfK2t0X0v9XjAW7cHY4kYJ0mn+rkqwZ9CmqXq9Xn2xNMJAol/s4ww==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr10623001wmc.54.1574352164065;
        Thu, 21 Nov 2019 08:02:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id x5sm94545wmj.7.2019.11.21.08.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:02:43 -0800 (PST)
Subject: Re: [PATCH v7 2/9] vmx: spp: Add control flags for Sub-Page
 Protection(SPP)
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmattson@google.com, sean.j.christopherson@intel.com,
        yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-3-weijiang.yang@intel.com>
 <d6e71e7b-b708-211c-24b7-8ffe03a52842@redhat.com>
 <20191121153442.GH17169@local-michael-cet-test>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <58b4b445-bd47-d357-9fdd-118043624215@redhat.com>
Date:   Thu, 21 Nov 2019 17:02:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191121153442.GH17169@local-michael-cet-test>
Content-Language: en-US
X-MC-Unique: OL8DMrZQOAKklK-1YLdTlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/19 16:34, Yang Weijiang wrote:
> On Thu, Nov 21, 2019 at 11:04:51AM +0100, Paolo Bonzini wrote:
>> On 19/11/19 09:49, Yang Weijiang wrote:
>>> @@ -228,6 +228,7 @@
>>>  #define X86_FEATURE_FLEXPRIORITY=09( 8*32+ 2) /* Intel FlexPriority */
>>>  #define X86_FEATURE_EPT=09=09=09( 8*32+ 3) /* Intel Extended Page Tabl=
e */
>>>  #define X86_FEATURE_VPID=09=09( 8*32+ 4) /* Intel Virtual Processor ID=
 */
>>> +#define X86_FEATURE_SPP=09=09=09( 8*32+ 5) /* Intel EPT-based Sub-Page=
 Write Protection */
>>
>> Please do not include X86_FEATURE_SPP.  In general I don't like the VMX
>> features word, but apart from that SPP is not a feature that affects all
>> VMs in the same way as EPT or FlexPriority.
>>
> So what's a friendly way to let a user check if SPP feature is there?

QEMU for example ships with a program called vmxcap (though it requires
root).  We also could write a program to analyze the KVM capabilities
and print them, and put it in tools/kvm.

Thanks,

Paolo

