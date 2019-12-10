Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FEAC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAEC20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RykeHNFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfLJJnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:43:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJJnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575971003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+9gHLFclc8eGt+cU05OJPVI/o5eh55h38LcdsgaD/w=;
        b=RykeHNFVEsUhchl4Ei1Zyn3jMBZwLKUo/JS9C0vPevzh6KMJ9mzNUfsG4SWWLQieNqt5BC
        /4365xqWqOJIDCFTWmjCTar0mynFOgt8lQR5Y0zNE5HDnGU6Xad4fh30MjTJcosCMiVlpO
        G/p2NGPOXSJSkDosDtC5ekwEPKA+T00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-SRu-jkZMPA6kkcPg2ysLbQ-1; Tue, 10 Dec 2019 04:43:21 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so8698797wrr.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+9gHLFclc8eGt+cU05OJPVI/o5eh55h38LcdsgaD/w=;
        b=Ih1WRC1HfbQLp2QAjShh+uO17pkJyCTDaek54OY+YbzEMYOVpHWtR4rEZf/8W6HutW
         ZgfGHMPkrNiw3qLm59R453biAniAgWz8fAYmWri29MEMYYW8njaVRq51dtAwW0t229Im
         lvSN5kSQZqfyYgIMvIsvGfsdClCq8IhUsakogxg3mDo3hcfcHUn8/bZ2x1O1QfDv4ZVY
         tTUVJVwdIJ16u4FW3tZ+hBEy6ujPN9pGV2cO3rx3esmG4HzU++PLlyKnrFifjTgkdGtY
         zUjgPfFoSj0rEtZnkP/5euqiOF5NOO9oZaCZWw/s9umAl715Tlyjxhqy5ea4d99U3hEd
         +/EA==
X-Gm-Message-State: APjAAAVljO4hmVuKQyx+3j+BJv5smsqZeWG6LPtpDttDuU6ipyeRNGwE
        RSwq6vJLW9eKwfUxNfyhFllQH2Z1K2qt+pP89/QJUST5oOwjwq+fA1OPeQw6eYzuVde6C3G/VEZ
        Qs5KltwUkjsauQMuA+inyPEy1
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr3986775wmi.37.1575970999954;
        Tue, 10 Dec 2019 01:43:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeB/265O6c03O2Y44pel5nEJWfsWRBNWO+Wh+zKrzCGpUdazhsyNsnPr0e8H+FzTQolpxaYw==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr3986749wmi.37.1575970999761;
        Tue, 10 Dec 2019 01:43:19 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m3sm2619952wrs.53.2019.12.10.01.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:43:18 -0800 (PST)
Subject: Re: [PATCH 0/2] ata: ahci: Add shutdown handler
To:     Hanna Hawa <hhhawa@amazon.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
References: <20191209163209.26284-1-hhhawa@amazon.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a6eb4bf8-547d-54de-1f25-fbe9c715cde5@redhat.com>
Date:   Tue, 10 Dec 2019 10:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209163209.26284-1-hhhawa@amazon.com>
Content-Language: en-US
X-MC-Unique: SRu-jkZMPA6kkcPg2ysLbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 09-12-2019 17:32, Hanna Hawa wrote:
> This series introduced AHCI shutdown handler for AHCI PCIe driver, to
> disable host controller DMA and interrupts in order to avoid potentially
> corrupting or otherwise interfering with a new kernel being started with
> kexec.
> 
> Part of this patch move the common part between platform and pcie
> drivers to libahci.c.

Series looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> Hanna Hawa (2):
>    ata: libahci: move ahci platform shutdown function to libahci
>    ata: ahci: Add shutdown handler
> 
>   drivers/ata/ahci.c             |  9 +++++++++
>   drivers/ata/ahci.h             |  1 +
>   drivers/ata/libahci.c          | 33 +++++++++++++++++++++++++++++++++
>   drivers/ata/libahci_platform.c | 20 +-------------------
>   4 files changed, 44 insertions(+), 19 deletions(-)
> 

