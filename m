Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FCFC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A00620665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silverblocksystems-net.20150623.gappssmtp.com header.i=@silverblocksystems-net.20150623.gappssmtp.com header.b="RSLcPoae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfHAMYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:24:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35867 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHAMYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:24:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so51796648qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silverblocksystems-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0fBH6l9BLYbOCzrs817yKQIIa9zIlv8DLrTZC4IffaM=;
        b=RSLcPoaeJAAfB67bUYIqah/OaGmFpMbgJwj7DV167LybGd7QKyr8uQMAQ5hbwPP5fe
         oDVhneA/BOjmAHr8YDUq6d4XcMhrqAnpK4A5/Ly5Oj3y3XkcS+4C+OuOqyoRREuQJ2Jw
         +G1n1TNnBpvr2TgvlgvNy3eXYmhsaCCwtoE/s6gz2LkDZCqv+R9fgqCd8nTUg/rFi5q2
         /lXNMgdJfU+3uxbjquwY05kN1LBZlSgte1TIJ71mQwqhi2VrOXSVR+Chx1kEPupNzUUJ
         kEqvfuj7W+9SjYdrKiOMb3QhAqZqHZM/PCqvNMnPba7g9hQf6t2zs/ZG95arhXt0cFRF
         QS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0fBH6l9BLYbOCzrs817yKQIIa9zIlv8DLrTZC4IffaM=;
        b=NAJLyulq3BJdg7sJv16rJCQyq2uHoFOFxowmjgeHOOBOuL12lxowlehg1WrKsoUQZt
         4gnS5qoPXQxddobHMUx66MtgQWATvsZ26vdAsYxJ3vE4+D4M7EvNIxUPnSCyhdcR0BHL
         KzrTM551ZYfEmDgm+iXgCrix13owcT9CgECSQNvJUdgFYxIy3Nr2UQYGm9fgJo59J7LJ
         +vfU6dj/bOx1GI4mSRGVK999yMwwRpNAcHlhypRETriUO+GjeGPjGbW1JVc5amHWiBHu
         YR/zz/1u0W9nNYiGSZAbiibZRARg/9tZUdLQaIAV6mz/iYyPeBjFlukcWf5ofvUBR19Z
         Qjxw==
X-Gm-Message-State: APjAAAUD2/usTnrEK8i77TLhka6e/7DLlGlgUbVT4tj5IdMx+3NFyGi2
        BMuICcRh4EX6dXCWpUWU18c=
X-Google-Smtp-Source: APXvYqzkeNPzSavZYxUiinFMf15Rmke7hDUbYCslQnV5GTuD3Ej7QWvc13oXJOLjhttmRXoNhgIpfw==
X-Received: by 2002:a05:620a:1310:: with SMTP id o16mr1144022qkj.196.1564662264096;
        Thu, 01 Aug 2019 05:24:24 -0700 (PDT)
Received: from localhost.localdomain (static-72-9-14-85.md.cpe.atlanticbb.net. [72.9.14.85])
        by smtp.gmail.com with ESMTPSA id r189sm31309054qkc.60.2019.08.01.05.24.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 05:24:23 -0700 (PDT)
Message-ID: <7970f0e30d1eb83e7067225d07b923863bf1ac50.camel@silverblocksystems.net>
Subject: Re: [PATCH 4/5] media/ivtv: Reduce default FIFO priority
From:   Andy Walls <andy@silverblocksystems.net>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Date:   Thu, 01 Aug 2019 08:24:22 -0400
In-Reply-To: <20190801111541.858088180@infradead.org>
References: <20190801111348.530242235@infradead.org>
         <20190801111541.858088180@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter:

On Thu, 2019-08-01 at 13:13 +0200, Peter Zijlstra wrote:
> The ivtv driver creates a FIFO-99 thread by default, reduce this to
> FIFO-1.
> 
> FIFO-99 is the very highest priority available to SCHED_FIFO and
> it not a suitable default; it would indicate the ivtv work is the
> most important work on the machine.

ivtv based boards are legacy, convential PCI boards.  At this point,
these old boards are generally installed in boxes dedicated to video
capture (e.g. MythTV setups) or boxes dedicated to capturing VBI
information, like closed captioning, for business intelligence.

For boxes dedicated to video or VBI capture, the ivtv work may very
well be close to the most important work on the machine, to avoid
dropping video frames or VBI data.


> FIFO-1 gets it above all OTHER tasks, which seems high enough lacking
> better justification.

I agree that FIFO-99 is the wrong default level.

However, in my opinion, threads responsible for real time data
acquisition should have higher priority than the other kernel driver
threads normally running at FIFO-50.

How about FIFO-51 as the default?

Regards,
Andy

> Cc: Andy Walls <awalls@md.metrocast.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/media/pci/ivtv/ivtv-driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/media/pci/ivtv/ivtv-driver.c
> +++ b/drivers/media/pci/ivtv/ivtv-driver.c
> @@ -738,7 +738,7 @@ static void ivtv_process_options(struct
>   */
>  static int ivtv_init_struct1(struct ivtv *itv)
>  {
> -	struct sched_param param = { .sched_priority = 99 };
> +	struct sched_param param = { .sched_priority = 1 };
>  
>  	itv->base_addr = pci_resource_start(itv->pdev, 0);
>  	itv->enc_mbox.max_mbox = 2; /* the encoder has 3 mailboxes (0-
> 2) */
> 
> 

