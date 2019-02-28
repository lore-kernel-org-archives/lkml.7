Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D80C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625D22171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/5BRdn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfB1NhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:37:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43961 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfB1Ng7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:36:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so9738311pfh.10;
        Thu, 28 Feb 2019 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a3AqRhMrNpVeWu1Nx144n9UWxTiUVrOQHIP09Wz9urk=;
        b=O/5BRdn/C9P4+XcYix3s4eKZmmgFdLBv4nwuvEaliJtWhaylDqLPXOkBqo3AQhyGku
         BGo8S4xaYpJCSqNkzrxl8rm5SWNeulyrRplbVBWrwvKG5EzAXJxr17uKgoiEgCoe1sbL
         FzPCJEnBelk0bIT0RHt7CRz99CmRH0k2cHY3aMaUqKpo4PcSG5zhfzqYWaFtyZml/8tt
         96xKv1hczt4mQReF+qRyVjZGitQhVDuX6apyOGazR2cIJ+6gZ1RoZlxPPkWcwpp4ks0m
         kkUBDVnO8md5Ty9ZjLDdCukpA/caSgCiU1bQaCLctKpoW7/F3r2eukN630YtDqwtyKzW
         2lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a3AqRhMrNpVeWu1Nx144n9UWxTiUVrOQHIP09Wz9urk=;
        b=mldgImGKiayTadma6s+BzhkyIZkpInKtvCpSDdab55xgivEWpPI3DoMyqgCP2iUr9G
         XuDvYAFedEVtb70qE+tWcOE6NMDWPOGV6JAWDKhVk1E3odfGTaSTEormgEIeREJBLrs4
         4TjKtZ04a2UvI/xB8qDuYCxV80Pj3bqAcY7b9jRrWhb6QvXi0IN9YlOpYRz9P0jvpu6G
         ww7wacLobWhGpa4TuUldDdGrax7LkxSEwBf0FS7KA1NEKMm5KcbuJdpVrRGfxV0I3DZw
         l2ILA9YqOQWMrQVzl3Z+tx7DEKGps1RWDRFQafAljAbzmQfRFsRUsfe3SIN2mZz/qEJc
         3dOg==
X-Gm-Message-State: AHQUAubc9lJzH9p8Dn2J1djrwn79aoTGZ2GwE3EWzHuwjLoKGqpt/GnW
        z0LMFanxySINNnpYT/z8D8k19Fxj
X-Google-Smtp-Source: AHgI3IYX9dAhGvPJWa4iFxSAs4SjjY+KCLIVCgV/5r+Y8vH6kOqPtKirMUXcAG63NC95/IAsLsH7bg==
X-Received: by 2002:a65:4784:: with SMTP id e4mr8407661pgs.12.1551361018375;
        Thu, 28 Feb 2019 05:36:58 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id p11sm54804222pfi.10.2019.02.28.05.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:36:57 -0800 (PST)
Subject: Re: [PATCH v7 1/7] ARM: trusted_foundations: Support L2 cache
 maintenance
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190228131707.2592-1-digetx@gmail.com>
 <20190228131707.2592-2-digetx@gmail.com>
 <20190228132748.s2woduoycm7igfub@shell.armlinux.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ba215d63-ffaa-5be6-c43f-fdb845b1d6b7@gmail.com>
Date:   Thu, 28 Feb 2019 16:36:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228132748.s2woduoycm7igfub@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.02.2019 16:27, Russell King - ARM Linux admin пишет:
> On Thu, Feb 28, 2019 at 04:17:01PM +0300, Dmitry Osipenko wrote:
>> +#ifdef CONFIG_CACHE_L2X0
>> +static void tf_cache_write_sec(unsigned long val, unsigned int reg)
>> +{
>> +	u32 l2x0_way_mask = 0xff;
>> +
>> +	switch (reg) {
>> +	case L2X0_CTRL:
>> +		if (l2x0_saved_regs.aux_ctrl & BIT(16))
> 
> And bit 16 is what?  We have definitions in one of the headers you've
> added above, please use them.  Thanks.
> 

Good catch, I missed that there is a definition for that bit. I'll make a v8 soon'ish, please let me know if there is anything else to be addressed. Yours r-b and a-b will be appreciated.
