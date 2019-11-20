Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83709C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548DD223D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XE3eYNar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKTB5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:57:44 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:37254 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKTB5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:57:44 -0500
Received: by mail-qk1-f173.google.com with SMTP id e187so19902407qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 17:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=jDLYL+zBe4kreijHVGC8TNgtqSKIWy0jlSmvFFF1wow=;
        b=XE3eYNarcfPSYm9f+g9Svrep/XeafIOM6otEnnSlC2RmjZGnO3N/k496JOpdpWzMB/
         HHVsh6HuL7MBfdqEWd80aeHe8TMnsc2WnXvWuZ1I7R1B+JvoKa0MrrQRZ2K7vQSBdfTU
         CsCGSQPTDV9/bkYMAE9dOGSGd7Iv+27Kd74U9MFKxa3/zkXE1Q9Dd99CeALch/N1GG76
         rGG0ah/Im8iCmQMxvKmXqmm4alUxEKwyrNa+ZoWxoNp/ae1g3il95HJLQ1jxKi80ItqH
         MQt1BTIIlWZkcv+EvQpPyrmSuklqPYvo/u2kpLy/OhJaJnjqon5TD3vnH4GZLFbdJ1H4
         PmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=jDLYL+zBe4kreijHVGC8TNgtqSKIWy0jlSmvFFF1wow=;
        b=Ug9UaNFoiqNw0T6abNahS6IHxaz1MWrIOgnisdFx2ZBsZjbZwL5Gvrs6IdciXB9DOn
         IuvhDriJ2yAMGubVziBhoxXg5/YY4O/dt4lV3c6OKqIcGac6KX1vqrvG/8Ld4dtqk4JD
         mDWnk6DOpVOcgQn4D0Ksyfp1gcO9GOsR6mpa4mDtvoc0gnDS1behvfHET7VkCHIAChL7
         /R8JlfnFJvRXgmkb3QcbxHBJJBsRbXmsg+ubOpHK/jS8n1BElRVK2tQ061LOMqKeKqZo
         VmjX5X+BwCfsxZvHgxMtYMCHQKVic76T2e+VUUHB4r75IWACCnDk+UDi92hKf++mZaQR
         cvhA==
X-Gm-Message-State: APjAAAUnh4lvBdRLlHZskGD9IOhvhg4CGaBX7nBPCtQf4eRIHAnJdbNW
        NTWUnIK4CBwVhdxjrtSOJyGBHC032OA+mUe5FQ23F5uA
X-Google-Smtp-Source: APXvYqxGGyIXJ2afy9maPHp0aKxd0uhUW+6mA0F6Rw5OkLcYe0amj160qW/Gxu/ndP9Pqtl5ER8it9mgZtdysvm9tQs=
X-Received: by 2002:ae9:e501:: with SMTP id w1mr263813qkf.271.1574215061060;
 Tue, 19 Nov 2019 17:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20191119233047.5447495C0DE7@us180.sjc.aristanetworks.com>
In-Reply-To: <20191119233047.5447495C0DE7@us180.sjc.aristanetworks.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Tue, 19 Nov 2019 17:57:30 -0800
Message-ID: <CA+HUmGi_7b1Ywt4dqhqkDds4La=fuAmGaYLGOZHS1+4qrMLaCQ@mail.gmail.com>
Subject: Re: Kernel panic when reading /sys/firmware/acpi/tables/data/BERT
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Francesco Ruggeri <fruggeri@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 3:30 PM Francesco Ruggeri <fruggeri@arista.com> wrote:
>
> If I run
>
> for ((i=0; i<10; i++))
>         do for ((j=0; j<1000000; j++))
>                 do cat /sys/firmware/acpi/tables/data/BERT >/dev/null
>         done &
> done
>
> I see this panic in 5.3.11. I see a similar panic in 4.19.84.
>

The issue seems to be that acpi_os_map_cleanup does not execute under
mutex_lock(&acpi_ioremap_lock), so more than one process may end up
freeing the same map.
I will prepare a patch.

Francesco Ruggeri
