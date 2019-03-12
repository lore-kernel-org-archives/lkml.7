Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C1BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4312075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="tFsn1ZDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCLKoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:44:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37057 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfCLKoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:44:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id a17so1842187ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIj90pWLEmlEg8U2Xh+N/uvzqc1HNFSeSIfyT8/bc8w=;
        b=tFsn1ZDeuaItfV7dUwzlX7eT975AhCxSmO2eKa4fTHyVM8CFnkZLyt3hPdwoNjQkMR
         jMgq0/3xbn6qhYuFGz+eyWLCqqDFd/2CTRBjLSr36Rns1c5i8daXxxH4+zhVtDQUK3q5
         M2xNAPzwSSRXYpUb1ZjHwGTfSAjn0wzlLBFm1LXawqExYa4FDVjQDqt0XvBk66f9Y/j9
         vaCBHakFBM4rzp40UZ64jZapknltWmZBJqriskn/QV3vv8+3ug9nrjo4LZDD+wN2BqV5
         rmb60ePQUv2UwUzd8jqn4BxLBbtRraVA1mE8+e4KDi6p1qngXmhp0j7MIe8i5HPQTqaR
         tdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nIj90pWLEmlEg8U2Xh+N/uvzqc1HNFSeSIfyT8/bc8w=;
        b=HlNs3j7rafagD3Rqgnys6RnZY9SpzHLvhNMraQhksW33Ia7arJmOxg/LwIzugb4P7R
         MlzZkxGy8POq7TgaUUY5ku0Yj2rHlx47aY7HayOXXHsZSPYFyJ+yvVM6DmRZC55F1LnF
         8qTBW89aqs+yfJ23qGB93NmiG9ygskYO5fiUgTIJ9nolr2XiJLYcipn6OfWNvJf3d6av
         qd/FxnQN3UOOCceLzmdo/J7FD12lHPJ+yBAF/v4ZEZhi8XhTL65DdO8yipkN07oqPPQK
         UxAcMiyN5bqrStd4/SMXO0VzmOcruD7H0v8cpEgyHYDPeC9E454FBcRFXipXdDGN2F69
         bCwQ==
X-Gm-Message-State: APjAAAWAZNLKyb1r9oDM5kkUdaOOC8U+HU9tAvJQ9gfvFmAskt+h5OBt
        tyH7Z9zVumpIIIaeIQ0FEM5damKQQWE=
X-Google-Smtp-Source: APXvYqypODsCDOeqnJ2r7d7CW9cYOfEYyrWI/nG/cbsFEtDAHGq5EtYiXFGJmlsxMLtpPUhM1I8Iyg==
X-Received: by 2002:a2e:208a:: with SMTP id g10mr19610706lji.135.1552387462065;
        Tue, 12 Mar 2019 03:44:22 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.176])
        by smtp.gmail.com with ESMTPSA id 21sm1288042ljw.95.2019.03.12.03.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 03:44:21 -0700 (PDT)
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     axboe@kernel.dk, b.zolnierkie@samsung.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
 <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
 <20190312104102.GA28302@Red>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1387821f-20d2-672f-5a7d-f7c2c4334dee@cogentembedded.com>
Date:   Tue, 12 Mar 2019 13:44:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190312104102.GA28302@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 01:41 PM, LABBE Corentin wrote:

>>> When playing with a virtual SPARC machine with qemu, I found that the
>>> IDE emulated device was not probing with the ata/pata_oldpiix driver.
>>
>>    Correctly, it should probe with ata_piix,
>>
>>> But with the old ide/piix, it was probed.> 
>>> This is due to this PCI devid was not migrated from the old ide/piix.
>>
>>    It wasn't on purpose -- the IDE driver supports the original PIIX
>> incorrectly.
>>
> 
> Hello
> 
> What about removing this old driver totally if it dont work ?

   It supports the later Intrel controllers OK, just the original PIIX support
is buggy.

> Regards

MBR, Sergei
