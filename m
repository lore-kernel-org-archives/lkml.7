Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91672C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CB720857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="bpaUmZJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfCTGPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:15:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34662 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCTGPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:15:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id n6so13409554qkf.1;
        Tue, 19 Mar 2019 23:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWKNpWqJj2bgyX/RvDs5r8eBtX/6dyDOyXm4vIm3YNM=;
        b=bpaUmZJTdTY0sH72rJNDoT3sn6E2xuowcmtl4PoH1iFA7OFZgJX1jZ2NAQeUr8/UUE
         MGTnu8R1svqbX97nQAr/uzyEwk78ryGFnUR0P4jbsMmcLQsWSVuxdrNbJX+95HTu9lGW
         ECuuB/gAmGPmkuXFvO7vRoCp7uX6phb09quUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWKNpWqJj2bgyX/RvDs5r8eBtX/6dyDOyXm4vIm3YNM=;
        b=UQ4M9p7uHcw1ihRarf7cPCYuDrETaPY/9TqDcNbomPPvMTJ7WXorMZ7HVZk1yLkUn3
         nJdWfjNHY4CKKSN2/G+3U2r5f9kENStVBBrCQVYa1HZUpQ7O7Kb4A9Y+3N8wj/b+m+mL
         c3sRR41OkrtRl6AkoscJl9XYRbdkAYuq1gSZ86AoTHmwEClD3lnNKdwKVNcNwvjYLDxI
         QUgxdaEjZtyJ7LBTK2olC52r/E+0I9MeUPanYWUpRYos0i8r/9TKfbsiZrVOGk6JHl6m
         fG/reh0yf5iMVNVkGYQevJANAQ7nz3fcx1fu9aqs9IFzk0HiJ761FhifNsHQZeugh6lq
         s0pg==
X-Gm-Message-State: APjAAAVN8Zr+6rT6MiQ+bg8k7CskqTsHfH+roTWARh0+bECYmmN2Fnw4
        LJC31BxWrcxHRw64psB7u5rSeiYaNpfAUOiTVgNxjQ==
X-Google-Smtp-Source: APXvYqy2vtQ+qxNTcKNaWXaMzTXI2iES2XZA6BJUZqbaTYTXnL0p1065VNg9YTLQc7DcL9U5P2ej9z+NBtRbbKgho80=
X-Received: by 2002:a37:4b0c:: with SMTP id y12mr5170838qka.127.1553062542555;
 Tue, 19 Mar 2019 23:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <1553029318-31703-1-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1553029318-31703-1-git-send-email-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 20 Mar 2019 06:15:30 +0000
Message-ID: <CACPK8XfyaQaum1fdOFrH=Uymq7VS7EvDYQJwxhsASSu_-9MBCQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: occ: Fix power sensor indexing
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 at 21:04, Eddie James <eajames@linux.ibm.com> wrote:
>
> In the case of power sensor version 0xA0, the sensor indexing overlapped
> with the "caps" power sensors, resulting in probe failure and kernel
> warnings. Fix this by specifying the next index for each power sensor
> version.
>
> Fixes: 54076cb ("hwmon (occ): Add sensor attributes and register ...")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

You forgot to cc stable:

cc: stable@vger.kernel.org # 4.21

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
