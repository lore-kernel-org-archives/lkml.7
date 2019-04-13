Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704D6C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7082075B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okbhh2NE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDMIS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:18:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45155 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfDMIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:18:26 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so10550068iom.12;
        Sat, 13 Apr 2019 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ro/8oi0cBPQmJgI9XTWitEPaTVc12w+RDDTdqm88BUk=;
        b=okbhh2NEli8PWXSrT8/+i+684bKpFkhEK4PZmycjsgVERYjhh/AX6RtCb98pOVa8SF
         k0LEwZ8N2q+5XPUK2rnkWZDkH3Pd2F4eFBBL3FuEsqvotRi1Ur9RRFT8PmqKmSOuYIyn
         r2+f6Irt5kEV5vT3PZPX5YrJQ3lZyJN4jy2WRWFj2eTu3ImnD3mNgIg+IDh/MFyFol2a
         OnpESkGb52xEsVg2i6OR0gJXeg7+xQV2XUYODkmRKzJyAsU0YQjkX8CKZhP8ovaE281b
         zn6LdmKSmMf0MyyD0pbuAVli5rnNLnDja+4NydqxFazZzcdMPkrexj0qXpprAZSMQBV1
         z15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ro/8oi0cBPQmJgI9XTWitEPaTVc12w+RDDTdqm88BUk=;
        b=hpsMPszap1JuyN1u3AlzzujKRQtUKhhtlvFzgZpAReaMMjtBa6dBTDJ8c6G9Yrr09Z
         yeVYjvNzbkeFQR9w7HypMT0eQnrzJSuZwCt7v3o6tlvmupjsGiTGHW+FMrpqDKiqOV32
         /AxB//Oe9dxtZXHsTLpz5SM5gf6M4c1xWYP7b+daan5LWFRchN6DLIMMZMU/LNtf3MU8
         8x6w39m59ULsgpTDEmO7VVO5QCmM0IxujbgPbl7elCk+w/CpHeZmbG3QzP1fqEyXGtnn
         CQib57PjLFzzjmBzCzXtwbLLjJf2b4tJAWoZltu+L6sJAdxwL0p475xkl+d4288UCn9U
         AP3w==
X-Gm-Message-State: APjAAAURhcP5hiYrtqFLIkiebU3FRxLh0BpGYGSjUvCZgBCbwYc4Kfe1
        pVtfDiKd0RgEKoSES07LcVbpYfRtAeJrShBPh1w=
X-Google-Smtp-Source: APXvYqx256zEOW1mkGiGQjarrjQlBXFGWzQVwTBU0vjQBGi81bF1WWeZPf3UjvsjzdRF3S6jMyZICn8heuCmbRgZWFY=
X-Received: by 2002:a5e:d701:: with SMTP id v1mr42960664iom.276.1555143505617;
 Sat, 13 Apr 2019 01:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org> <20190404080647.8173-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190404080647.8173-1-daniel.lezcano@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 13 Apr 2019 01:18:14 -0700
Message-ID: <CAHQ1cqHXK8HHXCj0FtZUtCzafYCYdOkdHm_wA6_NqN8q=iB-yQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] thermal/drivers/of: Add a get_temp_id callback function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:07 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Currently when we register a sensor, we specify the sensor id and a data
> pointer to be passed when the get_temp function is called. However the
> sensor_id is not passed to the get_temp callback forcing the driver to
> do extra allocation and adding back pointer to find out from the sensor
> information the driver data and then back to the sensor id.
>
> Add a new callback get_temp_id() which will be called if set. It will
> call the get_temp_id() with the sensor id.
>
> That will be more consistent with the registering function.
>

Tested both patches on i.MX8MQ, seem to work as expected.

Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks,
Andrey Smirnov
