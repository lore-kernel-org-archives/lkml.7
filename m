Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFA9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEEF218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDEEbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:31:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43410 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEEbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:31:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so2541224pfd.10;
        Thu, 04 Apr 2019 21:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xNrjygPawER0nXIQek615IGO8nihez3HuMMu39W34wU=;
        b=a0zOMu1F6YsVLWmWhpIZye6Bo75BtPN1mS5YV7/TKi2NAZluwVtjILsJlfKZCXiefO
         BkM1qeoQyrDeOZtE9GvHKJkrJFQma+CirIOc7h9sCnnzdNrUkubuAKSUfkviVRGXJa51
         oZdPRcfE96cDhxeuK38fqfd4mhoG1kdj59R3UP78XsSiUyYu3azu6023yZrdTXFlbfHl
         FjXPeWEn2kD2T6BTU4ItK5aGjFlZ/RCnJJs3aYs3lYpNB57uFPBHdf6Ca8T0iHraOsE9
         q2SxVDl3G0iKyHAesW6y8Q5HCTAFlvVQg8p/jfB32Rv+N+ECBAly9QELvLDWSNiRHCWq
         DwYw==
X-Gm-Message-State: APjAAAWMyBR01/HHTDOd9ZUYrwBlGw7fpF961MIjf5O+FqCVHRyL8fg2
        W8g6uNif80hyHdK3V87Rylw=
X-Google-Smtp-Source: APXvYqxLF2yDPEH5s1YJyh9a0/1We4IQfgfjqtRcDaxJVC9zrxK1pBF9e9hisulNp3J/3ZW7mLuwZQ==
X-Received: by 2002:a65:6389:: with SMTP id h9mr9918114pgv.398.1554438660457;
        Thu, 04 Apr 2019 21:31:00 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id a6sm29120680pfn.181.2019.04.04.21.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 21:30:58 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the scsi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190405142347.1f264cdf@canb.auug.org.au>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a1d4b608-a077-a757-9407-5cde4681e3af@acm.org>
Date:   Thu, 4 Apr 2019 21:30:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190405142347.1f264cdf@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 8:25 PM, Stephen Rothwell wrote:
> Hi James,
> 
> After merging the scsi tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> drivers/scsi/lpfc/lpfc_nvme.c:2140:1: warning: 'lpfc_nvme_lport_unreg_wait' defined but not used [-Wunused-function]
>   lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>    3999df75bccb ("scsi: lpfc: Declare local functions static")
> 
> It use is guarded by IS_ENABLED(CONFIG_NVME_FC).

I will have a closer look at this tomorrow.

Bart.


