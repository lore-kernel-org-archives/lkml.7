Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D95C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C0C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qPeJj8KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbfDRGjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:39:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37857 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfDRGjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:39:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so721407pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nY+EP2R9METKYDuku3g6nVrECtlVH8EVx2p8MKZ118k=;
        b=qPeJj8KNRZcPDLVMnDM575b8I8uxbwGFOuzY1O3nklzeCIIQBISrbzJ1N2wdOOVj+/
         I2IJoL0wlUjVDUzGjZyXUMsftii3pT3o2enK8JGO4UOPTEQsNXyaxFXIXnFoUE+/hCXC
         czjEDUc/+Pf6wCKACtzH7LS3kSMb4SIBPrxSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nY+EP2R9METKYDuku3g6nVrECtlVH8EVx2p8MKZ118k=;
        b=dQwnuS/Ohbf9fMiDfti9JMEGSDgQwR8QBXM4Hw6mF4rQE7bRI9kgBsE1M/c2J/Xzgl
         w+U2j69h2Rg+mkRJxnbj/b0DZ0TtKux01/TGlZt+gTHJ0l86OIbrmROa8cobkMub9gq3
         99DR93/8iq0dcTnMJlfc/OGZvK8mODVGElgYN9/zZ9Ncb237zS/ghnwYzAeBZ9hT2qdA
         1IqsVyZ9Y3jRWzqOau8nzf6CiPVpp1lvoZibZte8Eg7pYsjreTJQIW5rygbUyoZ72RJX
         lx3byi0d4fj6oWJf8CBqQTmZ6Imo2zKfgrN9RTTVurjnMfESpD3gOn+/No3hSluDOjNC
         rV5g==
X-Gm-Message-State: APjAAAVEDc1TbQcp9NM8vn65ZfhRTrmWKumqM4y7UhRlsBMO9aN00s5K
        DTjoSPpcJqwIssnHzJLaFnRrJw==
X-Google-Smtp-Source: APXvYqxZQNAupenw4ViEZhxPwMbqUfoM1c99inLaaEY0blftbhWIrmuvbI2M9nVCeRWQyuAGrPHrpw==
X-Received: by 2002:a63:3857:: with SMTP id h23mr85072995pgn.305.1555569540173;
        Wed, 17 Apr 2019 23:39:00 -0700 (PDT)
Received: from localhost (124-171-99-108.dyn.iinet.net.au. [124.171.99.108])
        by smtp.gmail.com with ESMTPSA id o81sm1603642pfa.156.2019.04.17.23.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 23:38:59 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr <cmr@informatik.wtf>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the running kernel image
In-Reply-To: <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com> <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
Date:   Thu, 18 Apr 2019 16:38:54 +1000
Message-ID: <87zhonyg01.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

>> +		If CONFIG_LOCK_DOWN_KERNEL is enabled, the kernel can be
>> +		moved to a more locked down state at runtime by writing to
>> +		this attribute. Valid values are:
>> +
>> +		integrity:
>> +			The kernel will disable functionality that allows
>> +			userland to modify the running kernel image, other
>> +			than through the loading or execution of appropriately
>> +			signed objects.
>> +
>> +		confidentiality:
>> +			The kernel will disable all functionality disabled by
>> +			the integrity mode, but additionally will disable
>> +			features that potentially permit userland to obtain
>> +			confidential information stored within the kernel.
>
> [+ linuxppc, mpe, dja, cmr]
>
> I'm thinking about whether we should lock down the powerpc xmon debug 
> monitor - intuitively, I think the answer is yes if for no other reason 
> than Least Astonishment, when lockdown is enabled you probably don't 
> expect xmon to keep letting you access kernel memory.
>
> Semantically though, xmon is not a userspace process - it's in kernel 
> and reads debug commands/outputs debug data directly from/to the 
> console. Is that a threat vector that this series cares about?

I guess there are 2 ways you could think about lockdown:

 - It adds a security boundary between the kernel and UID 0, so that
   userland cannot compromise the integrity/confidentiality of the
   locked down kernel.

 - It is a bundle of related security boundaries so that the
   integrity/confidentiality of a running, locked down kernel cannot be
   compromised, even by a privileged, physically present user.

You're right that techincally xmon is in the kernel and on the console
rather than in userland, so it doesn't fall within the first concept of
lockdown. But I think usecases for lockdown tend to expect something
more like the second concept.

IOW, lockdown is a trapdoor - once you've locked down a kernel, you
can't get out of lockdown (except by rebooting). xmon would allow you to
get out of the trapdoor, so I think it should be restricted by lockdown.

Regards,
Daniel

>
>
> -- 
> Andrew Donnellan              OzLabs, ADL Canberra
> andrew.donnellan@au1.ibm.com  IBM Australia Limited
