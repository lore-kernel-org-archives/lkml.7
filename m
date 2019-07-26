Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82405C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5466D22CBD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Puc8e40e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfGZPc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:32:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46806 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389457AbfGZPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:32:22 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so105546755iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xg5b8BlVT1CecDZYXkFG2LcPfV6yetu3UFLFNO/Imrs=;
        b=Puc8e40edWWISfZ8FP/VLFn6j+uAaOByUyxtX2s7TDS+HB8gHUQULp0VysTKwlA6BB
         4PGg05qDUKpMutISbKsAUBwMRhf43PJmcHblr7DmjsX2Vb7av9ObZSXjoRpRj0/Ep2jU
         LeGcdpZ86VLS2LU2vuyp2X9YKTva2NEqGz+hx6DAPwUxtXS8LbL2L3xUOXieKY9fuOtb
         5JFVE2FzJzKHipRZE57oRZTXnPS0v7EeZqldZs/fgrhpKMaJ5ezOpdHyhbMItiTBNHiv
         l1itArkAsCSFPivOpR5Jnrnu+Y+306lCqNa8ptJQS3SMHJE0QRPLsmAQ9MibFwtzcU6C
         0APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xg5b8BlVT1CecDZYXkFG2LcPfV6yetu3UFLFNO/Imrs=;
        b=CtMW3ujGMo0/yUDVUhi+5fXLYpRg2wpVoVe2T+U/bZ9lJPvI1WTagkfx4v2G8066ci
         zaGe0qr9bmO9Qkac3HMtzVMMRM8VoHYVDIt7ZfIE7BQi3NOCSQyZTYihE7zbp7L0EVdW
         CZfkGfkPu7C7ROkKaha6u46lq3Uk0CHpbffQFU2JUQxSHqbH1L4/jZ27ukRA1a65xOOI
         p+jx5eWlc2MQ4b1h7O1J/J8MlEPjYcmJW7XgFQ7p712bVcwwoK4r/bJwUaSzdgTJr+Jl
         /ACAQiKdhgcHxcg+C3YNyduv+SatUVtRA8W3nSCDCdNauNaXntn8hLUbOyE1qBzqsKNU
         tGxQ==
X-Gm-Message-State: APjAAAXe7iU5dhPZHt+tH7fwzSPhHHYlF1btAgQbD1yTIUwRUQFSBb8d
        SbyHrAErQbPjrB8T0rR7TtIihzHo/9NBXILVE1NZ+Q==
X-Google-Smtp-Source: APXvYqytvqDwtW9OW9SfYMiBWE74iHuPdV6mU7d7Xi0IhVBU5SL2atvFz+UX757RpvwAOwI6qAEtRlGFrSDwmdeIAKM=
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr63896312iok.144.1564155141743;
 Fri, 26 Jul 2019 08:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <1ada9248-6406-1afb-2b37-a25a1c3d6e03@oracle.com>
 <6d1a7a20-a420-7e3b-2dde-e924717012d9@oracle.com> <CAPhKKr9rAAf=47MLp2-sMkw9ns=a96ck=g-si8yVYsDeg_h_dQ@mail.gmail.com>
In-Reply-To: <CAPhKKr9rAAf=47MLp2-sMkw9ns=a96ck=g-si8yVYsDeg_h_dQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Jul 2019 17:32:10 +0200
Message-ID: <CACT4Y+a_Qqf6soROcL==NAk+nKD-rTp1ynZd6dow4Chb7MqmzA@mail.gmail.com>
Subject: Re: LPC 2019 distros microconference proposal: "Distros and Syzkaller
 - Why bother?"
To:     Dhaval Giani <dhaval.giani@gmail.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sasha Levin <sashal@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tim.bird@sony.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 5:21 PM Dhaval Giani <dhaval.giani@gmail.com> wrote:
>
> Adding a bunch of people.
>
> On Fri, Jul 26, 2019, 8:06 AM George Kennedy <george.kennedy@oracle.com> wrote:
>>
>> + <dhaval.giani@gmail.com>
>>
>> On 7/26/2019 10:48 AM, George Kennedy wrote:
>> > I have proposed "Distros and Syzkaller - Why bother?" for the LPC 2019
>> > distros microconference.
>> >
>> > I am curious as to how other distros are using Syzkaller and if there
>> > are ways for us to collaborate.
>> >
>> > I am curious how Syzkaller fits into the distro's development cycle,
>> > release cycle and if it is part
>> > of the distro's Continuous Integration (CI) process?
>> >
>> > Any insights would be appreciated.
>> >
>> > Thank you,
>> > George Kennedy


Cool! Will try to be there.

Note syzbot also tests LTS releases now:
https://syzkaller.appspot.com/linux-4.14
https://syzkaller.appspot.com/linux-4.19
Though, results are only delivered to
https://groups.google.com/forum/#!forum/syzkaller-lts-bugs

We could test some distro trees as well with the relevant configs.
Details are discussable.
