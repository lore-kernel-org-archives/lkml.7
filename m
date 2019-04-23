Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DE621738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OrOly8o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfDWNzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:55:09 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:43216 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfDWNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:55:09 -0400
Received: by mail-pg1-f176.google.com with SMTP id z9so7644372pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=luZOP+M2Br1z6JjqvbCNY8qb9/6fC4RpgjiwRzb9+fM=;
        b=OrOly8o89edT05ye0GoFYglLRnhBVI2iEJom83aUVZS3azbqR0BfYsNQg4K3yNldrW
         +g9wz3kH6GRB7RS2YOWrcjSEk7Gkz5xGOpOn3S5JlJ9yqedh5+FDEaOx6yFF2FOL93Px
         FIRoMpMW0yTRsShbBKv395hY1iGxcyovrjcYARVsJPMJ9qXkWeWpwfUDYZFgbmAb3LPU
         ZsZAuh6gYD/3ZCG1WQAZXGjhLrxl2Xa5WBWpw3u+6v4/6RZ11a5a5rXP3UX2r1W4Hdf5
         SHtN7SU1zX6LMJbFBE787Gn7MHSfRNeowo4R7N358R1cdG2asO7DgvsbxhL43Eheda5h
         PS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=luZOP+M2Br1z6JjqvbCNY8qb9/6fC4RpgjiwRzb9+fM=;
        b=Ofi2AxrWTczP3a2jP/lUQ7mvl1arMmRvzsKc40E4xwUQAtS5ys+drNBsbr3pbcTScY
         8wp3Df2N8r39UWWz8lX+6A0UXa9InWH0PHKrvP5toYI4o9Kjxx4d8L/jWpHNjmFAJpBq
         aDwBE+hYvCkW901/Ao7BSf1EfiTqNsBm3xcTCAzAx6y05iuJe2pAxOBdzZSu038w2HKH
         qBmqlTGhMZqgbtp1mASXE66C+MyL4d3gVXuFsXW1hY4yArJCzMuGpwA08q1Jwh3ODZKv
         rSUAcGEgPFgNtTLmZoYhGcXgbcmKX77iToKs2VXksJ+ZhuDBU5f70JbP7Loy/4L01xaD
         hykg==
X-Gm-Message-State: APjAAAVFBbArJjnIkIy8Ap2wcfrV3+NdOyATOA3J32XLZvb2roLnC9Uw
        4J2le3guT2FRBqTmSoN5yHw7fQ==
X-Google-Smtp-Source: APXvYqyPSeybmMUZTM8bgnWD06hCQaiW8B7Q9aMgFMFTf9FftneTu4UxQjo9GJ4QdLhH6QuMuxEgvg==
X-Received: by 2002:a65:60c7:: with SMTP id r7mr19209315pgv.191.1556027708285;
        Tue, 23 Apr 2019 06:55:08 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm21933247pff.105.2019.04.23.06.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 06:55:07 -0700 (PDT)
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
Date:   Tue, 23 Apr 2019 07:55:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423102239.GA15531@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 4:22 AM, Pavel Machek wrote:
> Hi!
> 
>>> It boots ok (unlike mainline -- I'm debugging that), and I can suspend
>>> and resume... but then cursor in X is moving and I can talk to
>>> applications cached in memory, but any access to disk hangs.
>>
>> Mainline problem was identified.
>>
>> But resume is still broken. I took advantage of fact that I can still
>> do cached commands, and got complete dmesg. I'm attaching it.
> 
> Still broken in 0418. Ideas would be welcome at this point.

Bisect it?

-- 
Jens Axboe

