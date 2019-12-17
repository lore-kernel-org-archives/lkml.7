Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA7AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8FE206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3MO13fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfLQNjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:39:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36818 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfLQNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:39:05 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so4612850pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gQB/ChgAWQAu7G8p8psPdHNZa+37XvUfN0MT2cx9AJw=;
        b=C3MO13fg4kp2wcV2fZP/7YYtFp8l8UWm0p9xA1Bos9vl/PuNhwOyCdzuykCwsdhhhJ
         mZVLQ25wX6+IU13xBaSHVYujN1KaGKj+EwXi5VXyWAyk/Sn8ZxDT5eh614WxXIWBfFr/
         W+KWUrHuAh6SV7u1dycxa1nAXZe19I+H/iUqhSOaey/IWw2YAmXFcx/jG4z+exbMNm5S
         IdOxzZtEZb+d0bj47FE+4xVVHlH8AWZGfYeMU1ukivBeOTNLCyYAxorH8BuDT+BYwoEG
         +rjAKa5iqifn4uqo7wVcN6hfF2mznO2cj6skjB9x5kbOJqADfajGEBSUBSnzodCdeCgv
         LUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gQB/ChgAWQAu7G8p8psPdHNZa+37XvUfN0MT2cx9AJw=;
        b=BEGxPQoMaMt7tVBYkexUBanlTNdYee8YcKZrT7pYWnOX+Ls5/r4K0IuJAxDziTzZGA
         m+vCP7TXDt3XnPBtn1gE/4MI45hoMUzExbRBLCQrSOeGu421SuTlLu5LTuwzMwhA/iXp
         rW8HAfZZ5gKChp3ykEyPymUkMfM+XC5MLCFax6JfoHvllbE1TSXnu/KkzRrb/jPBD0F5
         k96BVZ0i7NqGjUhTHlfQdhesAOuVHf0fpAGf4hyJes3qDl7w6s5sj2flH4PHKZXvUNRv
         JtU4ZYzCTvxT36Jw63AUMTfo8Li0LqEFIrYagKfHiZhQoKDDfDxcTMUihv4k9Qzzlc8r
         7GEw==
X-Gm-Message-State: APjAAAXv0VYLYIHBydmQaoPCvv1psu2yXzEFb+9B1RcoceCNYFKP5KoW
        8+vV+jEJ/J0BRmd4Oa6YKrNB/gj+H50=
X-Google-Smtp-Source: APXvYqxF6nDsn2S+SZ2JsyXauAy4vKm2CsBjNVueBRjJRtIGiRQUsnU+9dwPP0IoTdHioTk8H/3j/g==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr21807077pll.341.1576589944270;
        Tue, 17 Dec 2019 05:39:04 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.134? ([2402:f000:1:1501:200:5efe:a66f:8b86])
        by smtp.gmail.com with ESMTPSA id d2sm3675360pja.1.2019.12.17.05.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 05:39:03 -0800 (PST)
Subject: Re: [BUG] ALSA: seq: a possible sleep-in-atomic-context bug in
 snd_virmidi_dev_receive_event()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, rfontana@redhat.com,
        gregkh@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
References: <db47108d-3967-6760-3de2-17bf60741bc2@gmail.com>
 <s5hh81z9iob.wl-tiwai@suse.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <1583e474-55e3-ec13-f8c9-029bb23971bb@gmail.com>
Date:   Tue, 17 Dec 2019 21:39:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <s5hh81z9iob.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/17 21:37, Takashi Iwai wrote:
> On Tue, 17 Dec 2019 14:24:21 +0100,
> Jia-Ju Bai wrote:
>> The driver may sleep while holding a read lock.
>> The function call path (from bottom to top) in Linux 4.19 is:
>>
>> sound/core/seq/seq_memory.c, 96:
>>      copy_from_user in snd_seq_dump_var_event
>> sound/core/seq/seq_virmidi.c, 97:
>>      snd_seq_dump_var_event in snd_virmidi_dev_receive_event
>> sound/core/seq/seq_virmidi.c, 88:
>>      _raw_read_lock in snd_virmidi_dev_receive_event
> This can't happen.  snd_virmidi_dev_receive_event() takes
> conditionally either read_lock or rw_sem depending on the atomic
> argument.  And the data including user-space pointer is handled always
> with atomic=1, hence down_read() is used instead of read_lock() here.
>

Okay, thanks for the explanation.


Best wishes,
Jia-Ju Bai
