Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B080C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF5D2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LyHBZmOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgAIDLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 22:11:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42603 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIDLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:11:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so4722276qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 19:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnTY8CnU5oshbR8rdx81dOOrMPgQQX1DVF27rged5H8=;
        b=LyHBZmOKZ0euELTEe/dueyKGBnppDCBT3eoR7FrtlyB8OgX+MYcJx6MCmbOJqOm5Fu
         HlFlr/KaRxMMgws5aaxYI1uCELna+fnKeuNueYhPgfXgCrPLdaU1vpi9Tk02VY1HN/d7
         YiHor2YIS5m/oZaupSQbf4rwgvIdQ0oU0UlbSGlvz9TXKFEiET+YI+dbtN1qy4FdQHF/
         gA3ngkIc6wujirBb/NJlcV2OjfW8wKmxgNSD2Ed6ufuqmpCLgR5NnjrLDu8AoxSzbQkI
         IxD1nTGg2cBX9SG6TpFwc7SJJrA382Iqjm53s19MXrR2LOmCaYs+KoOZkFY25HJYbn6+
         y3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnTY8CnU5oshbR8rdx81dOOrMPgQQX1DVF27rged5H8=;
        b=gsF6/+LoyFj1SrIDUZpKa4EOkoLHE/0c3g85syxIK3RfACbJvwI3lNTNy2/o9Sd2Cn
         JD3jcsGD90p8/FOuKFU6OIigFXPUy7kWkcwOaBfCycvxm6Lk6DcLxjOJrKDp6nXOot67
         sH6GqkjSoSULT90mgnb8Oq+tnzbUwEG3lomp8pXa5L1y4qKcBuBrmF/3PcPwAv9N31nJ
         SDf/K173H3Z1+K8GweNhWHqcmRqPUNkWNo85MQrNY3bIKWmzG/661kavXOF8XcRjKC/d
         U5vS8yLmzXaYLfVI2i8SaUKqtQQdhH021uo7kHFbf8i4xHNECBp4fqGNs0RqaXfCp0nR
         NqzA==
X-Gm-Message-State: APjAAAXmtRo3u/psPzOvOo4Rvy2Jz1Y55UKhKhQ8sSeSjI6ejSE/ZwqD
        +3TMNZFAfiCcP02pdafb4/ZsAjQ3I5ZGhitulYs/fw==
X-Google-Smtp-Source: APXvYqxH9+3t7y/aLEdJpTNDT5TwazELLQ86HW6a34SlwoRD/9/0Sdf0UohLKFoTv8iQ87Il6nQA3wvpYz5jUAy5Ra8=
X-Received: by 2002:ae9:eb56:: with SMTP id b83mr7295612qkg.123.1578539466382;
 Wed, 08 Jan 2020 19:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20200108024035.17524-1-greentime.hu@sifive.com> <mvmk162z6g5.fsf@suse.de>
In-Reply-To: <mvmk162z6g5.fsf@suse.de>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Thu, 9 Jan 2020 11:10:54 +0800
Message-ID: <CAHCEeh+SVzXrK3wRBgBZfDAHZON+Zi8CiKgNbwqeJKZKosOZDQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: to make sure the cores in .Lsecondary_park
To:     Andreas Schwab <schwab@suse.de>
Cc:     Gt <green.hu@gmail.com>, greentime@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 4:41 PM Andreas Schwab <schwab@suse.de> wrote:
>
> The subject is missing a verb.
>
> riscv: make sure the cores stay looping in .Lsecondary_park
>

Thank you, Andreas.
I will send v3 to fix this. :)
