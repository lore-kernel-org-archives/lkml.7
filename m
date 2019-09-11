Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB77AC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1B42085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0chkhS9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfIKVdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 17:33:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44232 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfIKVdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 17:33:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so14505991pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DsFXUPgRutPXmGGMf6+fmS0OQQ0zQi2gyRsiD/6RStE=;
        b=0chkhS9V7SJc5WBafiyjn+EWvaleVWrxem2VVzunzpD42z84NdJX39C3I691SwHLGo
         2KVovLH2VHrBryT8qU5NN1s+2HvQH5EnNkJNOmp52JF5ZEakIEkm8xb8LE6JwF2a1A0O
         CvtujzWiryQA45+MLLOj5V1AxzlVlDEv/+HfqintD2GaSgqVXSTrMt3tqgQhnM0mxmBx
         W2BmI9dhSgPSY+XUld+WdRN6CeXGqA+AShe+c/p1HHfExzgo9btn+jWbK/je768mnsrH
         NIsik8MxDU0LsB+oHIIud5gvampwx+mjg6kd4rG1+ar9d+H/uH7RU8z7dYRa8Q0w2MC7
         wGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DsFXUPgRutPXmGGMf6+fmS0OQQ0zQi2gyRsiD/6RStE=;
        b=cOVHUAGCUpzRCn1vyAUXE2Kur+fWrEZ0OwOvX2Q7UwM6AevRXe2RYmNWba1/zXTATZ
         2yWLddAeHOSYWhBMV3mVRlM9hRkmtSpefr+occGLvF5Q2ItgqNJ5v+x8PLN7rso0aByp
         9Xnq3Q9fnW9GPVnrtJasTyCXYiFmhBKxFgj+HPv40S0lWrKbtgMR++Q1tqVZC5ec78cg
         9WoRsGEYL1ikavyG7bF75ANom08TsLS/580omyq7vCs034B/MMpwA/lCpfHwjcwnyxSC
         uGMvYnYceHUcO1VuyCsansPrngXyCXMDasqV2ZIZ8K9JiyeHXt5pQL2f3F/DbShEWBu9
         Qbhg==
X-Gm-Message-State: APjAAAUeEYntkN0YUmZF7fwE4nUF5TNoS1eGLqtTshLoO6JdDkYVpvUp
        V/8WLs6a+92GkG6oGM9T2qnWsQ==
X-Google-Smtp-Source: APXvYqxRaVPnqJzRyo0NK0QcLae/GUpZA1QmEYJm+Ha49qfk3N6hJSSt8f3FKGBt5MFHWYA3zAkGZg==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr8043323pjb.30.1568237591597;
        Wed, 11 Sep 2019 14:33:11 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.160])
        by smtp.gmail.com with ESMTPSA id x9sm17417308pgp.75.2019.09.11.14.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 14:33:10 -0700 (PDT)
Subject: Re: [PATCH v2] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     Gabriel C <nix.or.die@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>
References: <CAEJqkgjJEHmTT3N42BXkeb+2mDbteE1YwW25cgUpMk7A_sOWzg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6a47a06d-f8f1-1865-1919-5ede359d0b10@kernel.dk>
Date:   Wed, 11 Sep 2019 15:33:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgjJEHmTT3N42BXkeb+2mDbteE1YwW25cgUpMk7A_sOWzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 3:21 PM, Gabriel C wrote:
>   Booting with default_ps_max_latency_us >6000 makes the device fail.
>   Also SUBNQN is NULL and gives a warning on each boot/resume.
>    $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
>      subnqn    : (null)
> 
>   I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
>   To be sure is not a Laptop issue only, I tested the device on
>   my server board too with the same results.
>   ( with 2x,4x link on the board and 4x on a PCI-E card ).
> 
>   Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
>   Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

For some reason your commit message is indented. Additionally, your
patch is whitespace damaged. So this won't apply anywhere.

-- 
Jens Axboe

