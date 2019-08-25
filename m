Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D93C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C6A2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfHYSB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbfHYSB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:01:28 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 916EC4E924
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 18:01:28 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id u3so8266937edm.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 11:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VuPnmNJDurZKvFGRfxNmSSRX0Kf/p44Qiikbipwhkj8=;
        b=DPR5CxqVD+Om1oh19cDGQmEenlS1C3k0S2JNRxiimtNBXmI26P7LNeBeNgWeb97EZI
         k6PT1PTp4B6oJ/YDHX9PuoJXwW2zUwqIoQKibGT5LFaeTNuu/7gYHqbw9lneGUlwAgb6
         O1d4iX0SuCb/SKciyTyATDs4S/cRHXtYDv7DC2CIK2UwYshP43V/stfCRKcynajxh3y+
         Nv8zshfUaNFQWpLXnUt/ZWYJaUqFTlyEPe3jDdoh+zQoyIvjsn5IKWRSGAzvkQfAz7k5
         KMC+6CKZDkAlVVIglRVgsGkPHdqtJqqMU8QbvdGZO50yho8J1xy8l6Fuc7XBLtWHySis
         uYdw==
X-Gm-Message-State: APjAAAUWoayyhwplqhtSfTffACWcilqfDf70rggTYIe2lNVa/eU98O2j
        czY+WMJgiSgtsPA6jrk7Sb19imNU1L3575P9y9i8pa01f6GJjUjLkBGkBFtMXd9MIYogYy0Mg8W
        jGOgmQpFZZukQ5pWWtNVWSCcp
X-Received: by 2002:a17:907:217b:: with SMTP id rl27mr13385275ejb.154.1566756087094;
        Sun, 25 Aug 2019 11:01:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwdanELqZCMBQliTrwXuwFFf3bENMI0wKgiY7G4ECMVkDTHUjx65hs/OfIYn/w8wQyzEXadrA==
X-Received: by 2002:a17:907:217b:: with SMTP id rl27mr13385263ejb.154.1566756086903;
        Sun, 25 Aug 2019 11:01:26 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x12sm2375442eje.1.2019.08.25.11.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 11:01:25 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the crypto tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190823131442.5a84a475@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce5be2de-5e6c-b571-fffe-99888f7cf3a5@redhat.com>
Date:   Sun, 25 Aug 2019 20:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823131442.5a84a475@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-08-19 05:14, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the crypto tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in lib/crypto/libsha256.o
> see include/linux/module.h for more information
> 
> Presumably introduced by commit
> 
>    01d3aee86625 ("crypto: sha256 - Make lib/crypto/sha256.c suitable for generic use")

Yeah my bad, I did not think about this getting build as a module.

I will submit a followup patch fixing this.

Regards,

Hans
