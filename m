Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F68AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D650720828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9ojobur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfH0Oab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:30:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43584 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfH0Oaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:30:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so19023447wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=p83Skcb28sZgDYz2+LArg9KtzzoTO/pqlqaaYMaERPA=;
        b=C9ojoburBdyvrO1W5OhNR5GqHXpb9J4P4Xz3l86a9+do5x+tVxsWmUP6zRnTza8Eum
         ljIYpXV+Sq7Xbs0G6VgDp9xBnL+CehiSwqGQFeiH/LU65vSk/mKB2pkk99UMTFYGnZTC
         moTXPwu/tT0TePeE35OywxxibJmQyZ3RvsFmI9pgQgl1pG1B6wK4Eb6aymhyhbFhD2Jt
         QNb1lTVh8758nEsl3kpo4rR6I/+Po7LJ42fNnF8oVuHmorZcXSCdVcxPxo8y3yQ9bzRk
         B/uSlWo+9tjaSvWyHBCHQ5fpS0sarVV+qEB8eDBrbmLfAW78DOZST+BX1KJNtcDOnhqs
         sKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=p83Skcb28sZgDYz2+LArg9KtzzoTO/pqlqaaYMaERPA=;
        b=LgL7qWHuDOayfEBiD1hq+y5SzyPVYORZNRySh0bHz1pIiZSeMq0PX5fH/RGPyuXMqn
         4thn9arMj7IPznC4cPrYhIe6LL674zSeALigdAnmOy1/GlhI5wd6XB8EFHdnRYDFp4sV
         0BirmZIfO4m55Cj/cnT3BJeDm7To6MDAfMxg/1oxrCahAoN0/cCG52otFVkA4gE6qgx/
         41fEPzT0YG1nOXtkSo7N4ZbQAsB1yJY0W1OBtqrT3tj9/XFrFt5OHCda3b6hn0BXIi8b
         fYWo1Bs0ao7eUH5/HL08/6pwJQgaE0Gf6bPb6vrvSicYCwLvIvP37Vxed4AJcY6D0gVK
         78DQ==
X-Gm-Message-State: APjAAAWrd0f6zM6EehPRgQ/+N5zs3Xn6YVT6DpK5PIS8gWI5lU7yTNyr
        oh+O3LR5kDq4z23jRsRATd/OvzlZFqA=
X-Google-Smtp-Source: APXvYqxBtyc6svJ8Xu3LT43sJMkaWOZO8khDahH9sqRD8n2Bz4iEEvBHOI9aCz41C2J6FWOFJiQnnA==
X-Received: by 2002:adf:e801:: with SMTP id o1mr30684004wrm.45.1566916228410;
        Tue, 27 Aug 2019 07:30:28 -0700 (PDT)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id w13sm40657283wre.44.2019.08.27.07.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 07:30:27 -0700 (PDT)
References: <20190825055429.18547-1-gregkh@linuxfoundation.org> <20190827133611.GE23584@kadam> <20190827134557.GA25038@kroah.com>
User-agent: mu4e 1.2.0; emacs 27.0.50
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     driverdev-devel@linuxdriverproject.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] staging: move greybus core out of staging
In-reply-to: <20190827134557.GA25038@kroah.com>
Date:   Tue, 27 Aug 2019 15:30:21 +0100
Message-ID: <m3d0gqisua.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue 27 Aug 2019 at 14:45, Greg Kroah-Hartman wrote:
> On Tue, Aug 27, 2019 at 04:36:11PM +0300, Dan Carpenter wrote:
>> I can't compile greybus so it's hard to run Smatch on it...  I have a
>> Smatch thing which ignores missing includes and just tries its best.
>> It mostly generates garbage output but a couple of these look like
>> potential issues:
>
> Why can't you compile the code?
>

I think we are missing includes in some of the
greybus header files.

>
>> drivers/staging/greybus/operation.c:379 gb_operation_message_alloc() warn: check 'message_size' for integer overflows 'kzalloc()'
>
> That should be checked on line 368, right?
>
>> drivers/staging/greybus/light.c:1256 gb_lights_request_handler() warn: 'light->channels' double freed
>> drivers/staging/greybus/light.c:1256 gb_lights_request_handler() warn: 'light->name' double freed
>
> I don't understand this warning, how are these potentially double freed?
>
> And the light.c file isn't moving out of drivers/staging/ just yet :)
>

I will take a look at this also.

Cheers,
   Rui
