Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D0C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1CC20578
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfHZJJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:09:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730398AbfHZJJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:09:27 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1691581F07
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:09:27 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id z2so9226931ede.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0e8rI6csadbpI9hF/1H0WuciLZJiYzd48jgfPspvsFs=;
        b=W5Ja3E5SN2QVWEZbvOOpzTtHbf0x+LpBx9TCPaHm2eoXhJoZWAC3IPV76VwR1xPNAL
         gcaAAxnoVpBTElTZfscSXJ5CtN6/fBKhET/UQROw4yJv8VnwJnCZcV8s4wrXNU0CzD83
         3VmRBrDoUBiWA2ifSJgK0xA9fDNPf/E0aTZ29YISx62W2zPWc3GjN2X1r5TwxA1UNJMb
         FWxbe6p4Dch2yZNCZiG/mkSTmORzh/HVA7tUZu6i93fQ54aTjuNrE6dSpj+hHTJ0WdQj
         I/WPPZwZi0hs2xfHcKNKnu/s7n3d2B/kjyHWNnBtUZ6t4Y52Q9+FI9LKAgNA3Q4eNnq8
         Iz1A==
X-Gm-Message-State: APjAAAVUvksCV7guRWEkIgfl9DEbgO7PbWmBNswywHmN6fRlMvdPyz9X
        cxa2hA/mauBTbGBILwxz4IA40z0zs/xWx+HhX7jZ+ik0ukX5pdR39rfdL4co99UXuvLQ0/ZzGr/
        RxCURa+/Nrev8tYLzAEKahcsG
X-Received: by 2002:a17:906:5282:: with SMTP id c2mr15163044ejm.259.1566810565519;
        Mon, 26 Aug 2019 02:09:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyp2vfIUvIpKKX1pS84n5oMSQ3uHxvsZ2FZQ1JSa8hTE/fMToPfSu8EKVTRzGNrm5Nkkj3CMg==
X-Received: by 2002:a17:906:5282:: with SMTP id c2mr15163037ejm.259.1566810565379;
        Mon, 26 Aug 2019 02:09:25 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w19sm1168567edt.41.2019.08.26.02.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 02:09:24 -0700 (PDT)
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
To:     Daniel Drake <drake@endlessm.com>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20190824210426.16218-1-katsuhiro@katsuster.net>
 <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
 <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eeee149c-4d9b-8b2e-780b-a41e2c87ec02@redhat.com>
Date:   Mon, 26 Aug 2019 11:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-08-19 04:53, Daniel Drake wrote:
> On Mon, Aug 26, 2019 at 1:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 24-08-19 23:04, Katsuhiro Suzuki wrote:
>>> This patch limits Headphone mixer volume to 4 from 7.
>>> Because output sound suddenly becomes very loudly with many noise if
>>> set volume over 4.
> 
> That sounds like something that should be limited in UCM.
> 
>> Higher then 4 not working matches my experience, see this comment from
>> the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :
>>
>> # Set HP mixer vol to -6 dB (4/7) louder does not work
>> cset "name='Headphone Mixer Volume' 4"
> 
> What does "does not work" mean more precisely?

IIRC garbled sound.

> I checked the spec, there is indeed something wrong in the kernel driver here.
> The db scale is not a simple scale as the kernel source suggests.
> 
> Instead it is:
> 0000 – -12dB
> 0001 – -10.5dB
> 0010 – -9dB
> 0011 – -7.5dB
> 0100 – -6dB
> 1000 – -4.5dB
> 1001 – -3dB
> 1010 – -1.5dB
> 1011 – 0dB
> 
> So perhaps we can fix the kernel to follow this table and then use UCM
> to limit the volume if its too high on a given platform?

Yes that sounds like the right thing to do. Katsuhiro can you confirm that
using this table allows using the full scale ? note that the full scale now
has 9 steps rather then 8.

Regards,

Hans

