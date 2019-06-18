Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB7C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A412085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfFRD2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 23:28:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34758 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRD2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 23:28:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so6796743pfc.1;
        Mon, 17 Jun 2019 20:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dc068kFuuIDX3bGg/sCi/c8aRklky+fPiCT3Bn0V2CM=;
        b=CqUOzNFarhQhckbVeXTInm8kvIikJv5FHB3cvjDtzc9fN77KdX4VI8aRNBcMpNtZk6
         yrfKiXgxtDgwVeJIdCKb+LnCdMRnwuDXlzXc8alMoIIDpiWwhhkmr09luJeD7b8ZB7E4
         4huTT7xBmJjBFGYM/A3vUtyQSOZ7gBSYJb5la3VSU69/XdvMxhOCgVG0wzNWl3l1b62N
         71rvK3VzxsnG9mHGDoSEeHfg22qYP/C7RlNTQNLhcLmimTiLqbf6uoANhrg2XDWYJJMx
         R3qsZydEhtH+2s9OdwBRJ5Pe7pfZ80eHATaonSol1aKDKHxksZeG8FjowMsSTZLJ1oX6
         tXWA==
X-Gm-Message-State: APjAAAWO3HY2ZzY7bu8HcT0VGqzh0o6j5MrsZ2kQKx0yJ79a+dS/PIzy
        dNTVMzW0tLPmEjBftTDprXI=
X-Google-Smtp-Source: APXvYqzFvZOkWoL4GkYyvTKa/4MObDC4loXp4hKkIH+TitLiXG81PqkNQSkJUmfreMSelPYhx10S9w==
X-Received: by 2002:a62:29c7:: with SMTP id p190mr116173105pfp.218.1560828483791;
        Mon, 17 Jun 2019 20:28:03 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:c193:fa16:d79e:155e])
        by smtp.gmail.com with ESMTPSA id u2sm678123pjv.30.2019.06.17.20.28.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 20:28:02 -0700 (PDT)
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
To:     dgilbert@interlog.com, Marc Gonzalez <marc.w.gonzalez@free.fr>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
 <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
 <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <da579578-349e-1320-0867-14fde659733e@acm.org>
Date:   Mon, 17 Jun 2019 20:28:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 5:35 PM, Douglas Gilbert wrote:
> For sg3_utils:
> 
> $ find . -name '*.c' -exec grep "/proc/scsi" {} \; -print
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sg_read.c
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sgp_dd.c
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sgm_dd.c
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sg_dd.c
>                  "'echo 1 > /proc/scsi/sg/allow_dio'\n", q_len, 
> dirio_count);
> ./testing/sg_tst_bidi.c
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./examples/sgq_dd.c
>  
> That is 6 (not 38) by my count.

Hi Doug,

This is the command I ran:

$ git grep /proc/scsi | wc -l
38

I think your query excludes scripts/rescan-scsi-bus.sh.

Bart.
