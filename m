Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC08CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD44205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zZwfq7Ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfDPMyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:54:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43417 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfDPMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:54:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so22227991wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=BWcySk8lamrhc4WU6Qx5+eZxxYcv/c18X8bZQyRjsbM=;
        b=zZwfq7OuHxPyiqfcQ7YcGvUz5xjCaWEnu78yMbQ3XYsNfD5euPduUbilgr1Frj8JPH
         4FnJEskn288kFf+VjDtM9Ch/PtgvBFFBN9XpH2eIyNvwTUsFKIFaE/JvR5szFdqGzaKK
         uS++4cf4n8BRlwYYir8tp8OuZHVk0hjQPO2d6/12iWQdIQ6ICKZ57EzrborewtWSTy0b
         LITQkGO8ftOGqnTEvWxwoplitCKOR1y1zWH+E5nfqj2ofnGck9lx+y7vcZnbLbFaRf4n
         qFYT66OqVDDb8jO+3UMphDkmVeJcc+K3F+q8yw8DaEj9DpOgTIOdtuEOBgvTBKNxcTcb
         Em2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BWcySk8lamrhc4WU6Qx5+eZxxYcv/c18X8bZQyRjsbM=;
        b=rUd761dnhbWA0olUtXSr1F9zFd7nIkeA+RNoU6pfHNTJV7j4YgMDD4aguMj1V3jpwg
         rp79qLXHLvVqt30aJtcmSdTKSlHQxY6faBJZJdlPH3zm/4EzK4smTt4LyW0b0Gi0HmE+
         K9BlhZETP030v7mHgJ8iky+qNLzwnop416uCCR5VJxp21XGDGcVQ5qwzpqh8ktm7WIZj
         0RrMxghJOucRkDtcvaaaoC2lIRrP65405bj2765dtqYJ/ZHqOwbPRGalym5mht88JQRQ
         cnN62MXpj3DbIZ5AcFn3YZjxMBBysux6kIYhlrakkE8HK+H9LNY/YacM0YYWGl2HZ7VU
         +a0Q==
X-Gm-Message-State: APjAAAU4aBTDsDOkIfFiagAw4z392MwxQPJhYwXFrZ7zl1aQIpjfx6h4
        fINudt7xZikj6P+jweGNCqPj6w==
X-Google-Smtp-Source: APXvYqwjxhSBx1TQ0FwTkVlCv/EHY0lNAyfkS4Y0o4l7oQyDSydMPBBrfXyDWborgrE/yo6wEUuYxA==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr23823774wru.104.1555419246257;
        Tue, 16 Apr 2019 05:54:06 -0700 (PDT)
Received: from [10.1.3.153] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j22sm156020113wrd.91.2019.04.16.05.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 05:54:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] iio: Add PAT9125 optical tracker sensor
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
References: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
 <1554456870-8104-4-git-send-email-amergnat@baylibre.com>
 <20190407112024.6297cbfa@archlinux>
From:   Alexandre <amergnat@baylibre.com>
Message-ID: <79862457-ac69-06bd-17e3-571fc763534b@baylibre.com>
Date:   Tue, 16 Apr 2019 14:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407112024.6297cbfa@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On 4/7/19 12:20, Jonathan Cameron wrote:
> Hi Alexandre,
>
> So I have no problem with this as an IIO driver, but for devices that
> are somewhat 'on the edge' I always like to get a clear answer to the
> question: Why not input?
>
> I would also argue that, to actually be 'useful' we would typically need
> some representation of the 'mechanicals' that are providing the motion
> being measured.  Looking at the datasheet this includes, rotating shafts
> (side or end on), disk edges and flat surface tracking (mouse like).
>
> That's easy enough to do with the iio in kernel consumer interface. These
> are similar to when we handle analog electronic front ends.
>
> I you can, please describe what it is being used for in your application
> as that may give us somewhere to start!
>
> + CC Dmitry and linux-input.

I developed this driver to detect the board movement which can't be 
detected by accelerometer (very slow motion). I admit this use case can 
be handled by an input, and I'm agree with you, PAT9125 driver could be 
an input. But, like you said, this chip is able to track different kind 
of motion, and additionally have an interrupt GPIO, so using it like 
input limit the driver potential. This chip is designed to work in 
industrial measurement or embedded systems, and the IIO API match with 
these environments, so it's the best way to exploit the entire potential 
of this chip.

As I understand (from 
https://www.kernel.org/doc/html/v4.12/input/event-codes.html#mice ), 
mouse driver must report values when the device move. This feature 
souldn't be mandatory for an optical tracker driver, specially for cases 
where user prefers to use buffer or poll only when he need data.

> If 1 or 2, I would suggest that you provide absolute position to
> Linux.  So add the value to a software counter and provide that.
> 32 bits should be plenty of resolution for that.
I can't provide absolute position, only relative. Do you mean using 
input driver to do that ? If not, how is built the position data?

> Silly question for you.  What happens if you set the delta values to 0?
> Do we get an interrupt which is effectively data ready?
> If we do, you might want to think about a scheme where that is an option.
> As things currently stand we have a confusing interface where changing this
> threshold effects the buffered data output.   That should only be the
> case if this interface is for a trigger, not an event.

I'm not sure to understand your question. Is it possible to read delta_x 
and delta_y = 0 in special/corner case because internal value continue 
to be updated after toggled motion_detect pin (used for IRQ) until 
values registers are read and then motion_detect pin is released:

  * Chip move (i.e. +2 on X axis and 0 on Y axis)
  * Motion_detect IRQ trigger and internal reg value is updated (i.e.
    delta_x = 2 and delta_y = 0)
  * GPIO IRQ handled but read_value isn't executed yet (timing reason)
  * Chip move back to it origin point (i.e. -2 on X axis and 0 on Y axis)
  * Motion_detect IRQ still low because it hasn't been reset by read
    value and internal reg value is updated (i.e. delta_x = 0 and
    delta_y = 0)
  * Read_value is executed, we get delta values = 0.

> If it is actually not possible to report the two channels separately
> then don't report them at all except via the buffered interface and
> set the available scan masks so that both are on.
I found a way to keep the consistency between delta x and delta y 
(without losing data). The first part is to reset a value only when user 
read it (also when it's buffered). The second part is to add the new 
value to the old value. With these two mechanism, X and Y will always be 
consistent:

  * as possible during a move.
  * perfectly when move is finished.


Regards,

Alexandre

