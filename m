Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E59DECE587
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FABA215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RQNzOyfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfJBAzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:55:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33138 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfJBAzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:55:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so2898880pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 17:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DDsLE/BVSvW2ad3pzPsUne4j3kAv3DTYOSaOyiuU1vs=;
        b=RQNzOyfEw0J+eQ9dS8vs9E6pylLYp/Ngw7gRmrVGdNyY2VIjuZTok2HmqbBPbl9IN5
         MXPXS/P/CxMO5/k4p1IgI3QV+EWJ3qo9yjjLnndW0ebYkxINoWM0Utr4LR7TrCVhcrfe
         FacFXdH6Hs8c1Ev8EtUnt4TM7hpQNDSsV1IYsYvFJf2QhGmyNqw4F6rnrgqVXRSZGMmL
         gQMHDKPUdzHqyOkhT0XaR4S/wjTy+zCTpP4GR0peM1YFvfxF9K7Yk8cazGZS6nOpcvlb
         qd9ZJ4EVUjISgOyhvn2hzz+laPFuc33brFh1rTvOFzXZHokCByCvhO72cGcQiLo9kKDm
         tHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DDsLE/BVSvW2ad3pzPsUne4j3kAv3DTYOSaOyiuU1vs=;
        b=F04KRJgrLzCZre2F+rIgqcz7LiIEGEEY9DGl2wsKPYHAgLA9ENXLgqngqEaJLfvh9j
         o59c2dtb+IHVQJPYOXPEzji8co7ggYHxnM5AGKiuhK2yAgdUvgnC3W/mSJN4t83bsJ2a
         JWQKdaLtI5rs+RtS6PWpXneJGamYabygsGrETag3+h+05RIjA0pSEcF/dXSJ0UG6xe1I
         L2cUN/RMJMNDZMzzhThaq0qgJXeIIzpBnaFtYH1q8fmWBzjVOEpm9oOx3INTkksoZ7Hn
         vFW9fTfJZsmqNVjL8vQaxek26Tf3cHSM13wYIkgA5Zxa4lv8lwThvfolW3+ir5oj6opR
         yshg==
X-Gm-Message-State: APjAAAUpu/kJhldAipjU1Az6XRlggrz7yx0QWixWqB6XZ9MNxKcGGVC0
        Yn+ffdK4Kl7W7QnT/BfFjSG9AbnF9PKhpw==
X-Google-Smtp-Source: APXvYqw7rkTFtEmZJ7JOM2Ir9iOI1H5xXEco5/xFDhmBX+XL1WhzRIbgcmK6r3KXj4olzvZLIXPwzg==
X-Received: by 2002:a62:5c82:: with SMTP id q124mr1389925pfb.177.1569977747497;
        Tue, 01 Oct 2019 17:55:47 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e3sm3281565pjs.15.2019.10.01.17.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 17:55:46 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
To:     Song Liu <liu.song.a23@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <cover.1568994791.git.esyr@redhat.com>
 <CAPhsuW5CvJNRP5OO_M6XVd9q0x-CH9eADWR5oqdJP20eFScCFw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87d4b42f-7aa2-5372-27e4-a28e4c724f37@kernel.dk>
Date:   Tue, 1 Oct 2019 18:55:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5CvJNRP5OO_M6XVd9q0x-CH9eADWR5oqdJP20eFScCFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 5:12 PM, Song Liu wrote:
> On Fri, Sep 20, 2019 at 8:58 AM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>>
>> Hello.
>>
>> This is a small fix of a typo (or, more specifically, some remnant of
>> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
>> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
>> with "H" is used in man page and everywhere else, it's probably worth
>> to make the name used in the fcntl.h UAPI header in line with it.
>> The two follow-up patches update usage sites of this constant in kernel
>> to use the new spelling.
>>
>> The old name is retained as it is part of UAPI now.
>>
>> Changes since v2[1]:
>>   * Updated RWF_WRITE_LIFE_NOT_SET constant usage
>>     in drivers/md/raid5-ppl.c:ppl_init_log().
>>
>> Changes since v1[2]:
>>   * Changed format of the commit ID in the commit message of the first patch.
>>   * Removed bogus Signed-off-by that snuck into the resend of the series.
> 
> Applied to md-next.

I think the core fs change should core in through a core tree, then
the md bits can go in at will after that.

-- 
Jens Axboe

