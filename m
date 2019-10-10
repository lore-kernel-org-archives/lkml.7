Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46938C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E32520650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1pijB1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbfJJMGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:06:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727320AbfJJMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570709199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLqhEmmSCKlL4Gh+Y3YA/NRWVx/mTIodKwq+1Ev+36s=;
        b=L1pijB1R7qAzk+ltQVE+SyxT9i3L4Y0JaEdXjbQKtti4O9iUfvQ0/MrLy3ZiCCeqm7kKSE
        tNK2je8/0EbJcZ3NAHkwgOSDqKfZdSYy2iE0CdyEAGQ72zW/HIjztS7dEM37HFusV0U+2B
        WwZGzYoser0r4+6NlgeoKdcXjqNUtPg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-5P6GeevJOq67rSmQxs04YQ-1; Thu, 10 Oct 2019 08:06:37 -0400
Received: by mail-ed1-f70.google.com with SMTP id s3so3473147edr.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 05:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0i7Jgh5uxOMKeZxcPFVuPgWkbxjfgaDzvKA2rlbDpOs=;
        b=TOP6JcPjR5MD5t79qtn79Ly9AcjfiQTSj2UyqdLJKIvbjygwcVAQmLOMEYasxzD5uL
         z1ik3nvRKtHg0R/7xOAhnL6TKDCITfK989ZV5zGhj57GzeqSqCQbOIsG2hARU2kHJA+x
         As2hkAJ9nXTlF2+L2KO/eNEQUzQVZvupgHfTmYUhD0HNXDCjPX5qGFP0rKJbkG415En1
         iPZ6TkExuotsxUweJwBKOMtraj5OXQPCR4La97C/xWrmaAnH7z0Ug2ROFsL/cVxp5u8K
         pRIHLSpMXM63PBzShq+FZmn6zqbFg396ne9GSs+D9RByv+MuMoMSJ/0c1lyq5//FWePY
         1g5A==
X-Gm-Message-State: APjAAAXuzUgv77FbD0eUlxq3UzxRDd9KeB1TDj9JHkoMy2S9yP7YQC8Y
        AF/uBMwlb6Nfa0BSHqBakPt4QARjWpKVJ4afz6xhuwtElid9J69WCuWprrVaGNWsONebS1+7vo+
        o2Czmo7xrVAFgBfje234q8wYF
X-Received: by 2002:aa7:c38f:: with SMTP id k15mr7953486edq.100.1570709196681;
        Thu, 10 Oct 2019 05:06:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy21h+E0vvwAqPxtXZ13HG+LjykboK3d9m2l1P2gFKMB6U/5R4krK18EqOX1PoOuJ5S9QcIMQ==
X-Received: by 2002:aa7:c38f:: with SMTP id k15mr7953445edq.100.1570709196447;
        Thu, 10 Oct 2019 05:06:36 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id y25sm652832eju.39.2019.10.10.05.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 05:06:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] extcon: axp288: Move to swnodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
 <8120fbf2-08d3-6ee2-21bf-458a4e12b29c@redhat.com>
 <20191008140159.GC12909@kuha.fi.intel.com>
 <20191010083110.GA4981@kuha.fi.intel.com>
 <7730d466-53bc-c14a-120f-dcb91de1e973@redhat.com>
 <20191010111620.GB4981@kuha.fi.intel.com>
 <20191010115839.GC4981@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4ddcdfe7-7627-6181-7e28-c6d7d63c3e22@redhat.com>
Date:   Thu, 10 Oct 2019 14:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191010115839.GC4981@kuha.fi.intel.com>
Content-Language: en-US
X-MC-Unique: 5P6GeevJOq67rSmQxs04YQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-10-2019 13:58, Heikki Krogerus wrote:
> On Thu, Oct 10, 2019 at 02:16:23PM +0300, Heikki Krogerus wrote:
>> In any case, do we leave this series as it is now, or should I add two
>> patches to it - one that just removes device_connection_add/remove
>> functions without any other changes, and another patch that removes
>> that device_connection_find() function (together with generic_match
>> etc.)?
>=20
> Forget about it. Let's leave this series as it is now.
>=20
> The device_connection_find() function we can remove separately.

That sounds fine to me. Note as mentioned I would remove the
device_connection_find() function before removing the builtin
connection support, that will make the builtin connection support
removal patch a bit cleaner.

Regards,

Hans

