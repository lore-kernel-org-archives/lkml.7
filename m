Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF695C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23202186A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlN7oP/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEYAZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:25:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfEYAZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:25:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so5870671pgp.11;
        Fri, 24 May 2019 17:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=deDS/pIxO2dFWIXtTid/DUueANeWghHsDbsx0a/VuOA=;
        b=QlN7oP/JPfshSJRePhMLsGMICgMtM8fquVI5hwUQS9du6NjLhVvge4OzLLGuHi42bq
         Z5m+NxQmLXa4Ux8NQOKyLgYaTC79SKefs8PiEJ0M+3zIRepsbcgqRWlu+usktORtKnfu
         vCQJdYkeqFEtWklwAFB77fvkV8+fb24+CZu6NWbsPfvN7vaLp/QlbgVY21cSeJjrv7qE
         cukr4T2JMaTPniJUaU9/sMLeJ90jt1cEVCEJcD+MaV4OjGoV7BwKM6Dbxdfg5PW55jld
         8wNEgvt2va1+gZ1uadXn14pwIu2z/Pw/g4YQNMG4T0pX1T1w3n4mzaKlRwJ4kLXKsqCk
         9Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=deDS/pIxO2dFWIXtTid/DUueANeWghHsDbsx0a/VuOA=;
        b=siyqCl74JtDo12Y9oMp2mjHseQj06bVVMzVEUMZlEGlbnXcGCbLm5Qimf1mJtAmRHL
         Z0oc3dS/gGumRnGS+/XvW41ueD/IT5pcTmexg0ZwC2zSW31pkcdfYa4b4bTcRaiO0H1l
         Nk8DuiceVN+faWsDg/1fGRJVpDNdd7Me+3dljxVx+vs8ddtSWHNcL3tP9HL9mtI/wsvf
         KvSQAwxHH6nH9x6MmBy9wVa9ba16XRYwbgseqc8D4sLLpWa6zB6ZdojuC/cUvpiXAmaM
         BKtDOVJtMLjawaoU3B7qSbTt9EhD03SMfndk1LP23ZW/b5D0psDptI0GmpJgyyeemr1p
         zMwQ==
X-Gm-Message-State: APjAAAU89OeOgmgMBlOSHeSRjQzosQHmQfUekX8VOk7OsbWMSynEu8qF
        MaScZRKS5EdeDI4rGueaZtQ=
X-Google-Smtp-Source: APXvYqyp126kfgX/+/caiBP7wrPmxVNCI3sSRqwmrY0Pa+HicCFiyx21pQuUpomz/apK6ky5G6zmXw==
X-Received: by 2002:aa7:8d50:: with SMTP id s16mr55203506pfe.96.1558743927987;
        Fri, 24 May 2019 17:25:27 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 11sm5738096pfu.155.2019.05.24.17.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 17:25:27 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe
 ordering
From:   Frank Rowand <frowand.list@gmail.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
References: <20190524010117.225219-1-saravanak@google.com>
 <06b479e2-e8a0-b3e8-567c-7fa0f1c5bdf6@gmail.com>
 <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
 <6d3995c1-e1e7-35ff-d091-501822c97ecd@gmail.com>
Message-ID: <0634ea45-2941-73fb-f8d8-b536e929a4a8@gmail.com>
Date:   Fri, 24 May 2019 17:25:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6d3995c1-e1e7-35ff-d091-501822c97ecd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/19 5:22 PM, Frank Rowand wrote:
> On 5/24/19 2:53 PM, Saravana Kannan wrote:
>> On Fri, May 24, 2019 at 10:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 5/23/19 6:01 PM, Saravana Kannan wrote:
> 
> < snip >
> 
>>> Another flaw with this method is that existing device trees
>>> will be broken after the kernel is modified, because existing
>>> device trees do not have the depends-on property.  This breaks
>>> the devicetree compatibility rules.
>>
>> This is 100% not true with the current implementation. I actually
>> tested this. This is fully backwards compatible. That's another reason
>> for adding depends-on and going by just what it says. The existing
>> bindings were never meant to describe only mandatory dependencies. So
>> using them as such is what would break backwards compatibility.
> 
> Are you saying that an existing, already compiled, devicetree (an FDT)
> can be used to boot a new kernel that has implemented this patch set?
> 
> The new kernel will boot with the existing FDT that does not have
> any depends-on properties?

I overlooked something you said in the email I replied to.  You said:

   "that depends-on becomes the source of truth if it exists and falls
   back to existing common bindings if "depends-on" isn't present"

Let me go back to look at the patch series to see how it falls back
to the existing bindings.

> 
> -Frank
> 

