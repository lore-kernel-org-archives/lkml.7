Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A352EC17498
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7716C21D81
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572965105;
	bh=O4MtmAdcO3FzgH6mOzo36io3Kk2jOXQ1C2kSxx9qcII=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=2tcTevhKsEU11NGZIf6/JX88G8hcuj1PlJQBJHLXoL6x2LiVmz1dqm3i5nhd02dZp
	 XhqSR9DUFym7bemlwVyOapd6eNH4YVxHclIJgslePP2hfJ5TH54M0dtmLSwIIkk2e2
	 2npA2TYt3/UT00o/kjMuJ7HyyGT5SwQ6tLocm2gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389535AbfKEOpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:45:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42985 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbfKEOpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:45:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id i185so17712841oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 06:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VWnis//m4WNFnlxLyNlHl8kK3/QSGA3JjJ79aEU0to4=;
        b=DaoxlrH9q8f7VCHjGeu+EM52lhWRyNzsdKcNSLlVI919X2J79nOoQI7JIhlywaQa9h
         ensrTq2YlUuY5oQpH5MWwsmyNmG+r9fngp6ZLi0YkCSGvxm4wDDY6vqiNizXtM4TfuiI
         Lr12OXEqSF6yK38Ln94IdqzBCXpOXNDZlVqEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VWnis//m4WNFnlxLyNlHl8kK3/QSGA3JjJ79aEU0to4=;
        b=t2bO4ZGJLsnquwO9Nin+8r/z3S/gF3Br5keCXNmJzmPenDE2C+xAoMey4htIxXYoyL
         2ze5sozDmjL+6JT/FCkyQ/NiQzRuvRBzVu893TZN4Do2krslFQeuafTqAN1xfpXWeSn7
         dvoS2n5cRATyKPH7bz+8mx/HZ7NpvDRhxkHucSWI4aPNBKRuIk/z5bJt+ZtjFtDXHNwF
         FPvz36YGvL3e6VDXNtt/rRhWryWVPhCMfy2CYYVksSXlxhy0tnguCL4lPXSh19IzfJT1
         Zi0ALdpN0eg9VdjxHzvydbQkVhpcpq0NSaMBW8mXc+1VX5njoL89Hvcm3vr/MBe/u8I6
         KLIw==
X-Gm-Message-State: APjAAAWyvEKkHG5YCzOT07rccrtX3hbJ82cef1p/9pXwgVrRzJv9zoXY
        O7zNK4XBJ252Gqs7a2BNJA904A==
X-Google-Smtp-Source: APXvYqwaQf3DBxvRDNzusDulEDuG9xrAmBVp2JvYuo/mCUCbGA+vq0YIswqjp7l2c7F5rwTAG08+JQ==
X-Received: by 2002:aca:f4c6:: with SMTP id s189mr1961325oih.63.1572965103115;
        Tue, 05 Nov 2019 06:45:03 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x16sm5732293oic.40.2019.11.05.06.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 06:45:02 -0800 (PST)
Subject: Re: linux-next: manual merge of the akpm tree with the kunit tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191105204526.32f19975@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4dcb9885-3094-88eb-9998-5edb87a3b4bf@linuxfoundation.org>
Date:   Tue, 5 Nov 2019 07:45:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105204526.32f19975@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 2:45 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm tree got conflicts in:
> 
>    MAINTAINERS
>    lib/Kconfig.debug
>    lib/Makefile
>    lib/list-test.c
> 
> between commit:
> 
>    ea2dd7c0875e ("lib/list-test: add a test for the 'list' doubly linked list")
> 
> from the kunit tree and patch:
> 
>    "lib/list-test.c: add a test for the 'list' doubly linked list"
> 
> from the akpm tree.
> 
> I fixed it up (I just assume that these are different versions of the
> same patch, so I just dropped the version in the akpm tree) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 

Right. Andrew and I discussed this patch and he is in the loop that
there is a new version of this patch and that it will be combined
with the Kunit patches in kselftest tree.

Please drop the patch from akpm and carry the fix if necessary.

thanks,
-- Shuah
