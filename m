Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E3AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C785F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/WtPb9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfFMPKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:10:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36733 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732318AbfFMNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:54:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so8186481plr.3;
        Thu, 13 Jun 2019 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k1fNE049DTfXgGWWUqWAwYEgHBQ84ikvVzBsFwy2GPY=;
        b=P/WtPb9bwIVvUnb47NZz9MDVk0S5pa3We4G1bnQ0oTMOs1h0z4l6DGpv6n67LKu81n
         4VuSbCfzK+lQOJnXUVZS5H/l4kN9gD1iSkcVNsH1mBYK+CNBWH+bEZG80YJwKGya2tfN
         4lWYbNIgfYNeMwpuix64JeY/AHbl+ZIaqZ5vfJCvlRTntFFH+uSYWjLuNlEZS1aqbCui
         70CRpO8+PvFXBEjNsLEUFbS7grXFf4zm4IHjRACsZqyJSFbQEAAJakaWK5gJJ6cg4aU9
         aaRiVnW9NQMTSEamqYfO3OfgfrqskFiwrG5ANjs56Rat3/2oJPQ49QRXxhWcDCbWkeTA
         kDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k1fNE049DTfXgGWWUqWAwYEgHBQ84ikvVzBsFwy2GPY=;
        b=CMqa4Pu2S1d1m+zc38bRKhYTnlhWqtJFuzjjV9VCz1wulba9B/2lEefJMTmpHqp5r+
         XO4wK9nn3YBLZS7+wcqvQ7GrGUubbU+zJTAbMB0RT5+IUKAtLrKRF3MvFJGfEjL9IWRG
         DSNThG5hiLalMdhX2tjEXh94ypu+X+hc+8HMfgt6MH/zcRM/uR1ldiBgP8Sn4oFSNh3m
         /cMWOvMoF8JmqiySrSa/GZlDYNKLNqUl+71kMiUe66HI4VD+gyItPHBzQoejoBW1pibD
         mCy4UAFCbNPT5rZpWmvhHscVVXPp5ky3z8zD+HP5T4WLzjlIVrg2r4JqCWB6KneRyBxB
         6poA==
X-Gm-Message-State: APjAAAVRsgU+HMH8q3mDeKAMngSubhLEKT4dsP02uZuUdBfXPiUnRyb4
        8dmmViNdXrq8c3B+Sr8A7Vs=
X-Google-Smtp-Source: APXvYqwTxKLbkx3r+G4M/1tEC8W5Ozu37HwjHiuqY1NaKgtT3O/EKUqqXflt7/cL1JeWGyGWkSL7FQ==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr81392362plr.79.1560434048958;
        Thu, 13 Jun 2019 06:54:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f3sm23255pjo.31.2019.06.13.06.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:54:07 -0700 (PDT)
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
To:     Fredrik Noring <noring@nocrew.org>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, JuergenUrban@gmx.de
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net> <20190611133223.GA30054@roeck-us.net>
 <20190611172654.GA2602@sx9> <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
Date:   Thu, 13 Jun 2019 06:54:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613134033.GA2489@sx9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fredrik,

On 6/13/19 6:40 AM, Fredrik Noring wrote:
> Hi Guenter,
> 
>> I don't think I'll have time to do that anytime soon. Not that I know what
>> exactly to look for in the first place.
> 
> I can confirm that there is a problem with mass storage devices and these
> local memory patches.
> 

Thanks for the confirmation. Do you see the problem only with the
ohci-sm501 driver or also with others ?

Thanks,
Guenter
