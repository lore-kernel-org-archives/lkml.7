Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AECC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E367B20714
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X++VSGfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKWNoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:44:05 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46427 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfKWNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:44:04 -0500
Received: by mail-oi1-f169.google.com with SMTP id n14so9072062oie.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 05:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9KeyRkpDZVKgACFsR86ZLUtYw0/zMx2nBt8gsEy4VkY=;
        b=X++VSGflwEacfUteQZIrH4O+VY073wTqPChEwiGpiCNbfMGWfQ7SrOYVbdZnqzxkcs
         TUveITXphURovJtfOpl7td3VAE1VQ2QZsAclBKF6vlgC0fNV/yPo/A9Lefsr2OUdiSlC
         3i7Gsd5ebfkbof+l14anms0ppG+bGH7h5/lQZisinFXBEKaEc7HJuXkJ8kLV/ivQjTPI
         RbNG2P7vgohYR+djCErOz+k2JiEUsYUn4doqZAMP2Mj6W6avck/T5lwbGfKS7MQIAQWK
         Mq6DWjZkFHOm/ipUlrJqi3PorXQBh/RlLb1vNj3MT5MlwTieUFKAgSJQ+dMErCEaMSRv
         qfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9KeyRkpDZVKgACFsR86ZLUtYw0/zMx2nBt8gsEy4VkY=;
        b=nfmUGcRjk4au4c9EMvOqjvOZamuiDOGzfn7/hiNxt0F4E4lQRI/Gd8l4uE4y3y4RPB
         Mu1z6t8CyMY3gpWYNYTW6AZRRb9sDtK+ArysRxrEdFonXgGLDH+/iyjYte2FzNNUxDCv
         +Gz+2MQCgL+k8vI9z939J78AkBbT6sqXPcyndHP+Tq4xmLRBmi+gRbwE7u/D0QNa8yiE
         t05/iZYpS//IPI6u2CwN1vm1HH+oQqsrUvh/b0gKvuqMFt82PJFHtqolaU/vfbdWywNT
         TpX8XXniMff3Vqbik8ZckOOcd5jrlY3t3iw5oLQAEwKeQJj1+FrdPmKt8qrQ/tn1Nmbz
         SOJw==
X-Gm-Message-State: APjAAAXBZOhRQoFbLPmVSCHS+EeJMMHkaFbT2bg512YSTW6CVUH6JF20
        MPa2VuIsKjfjuVjasEVfCueJ6wFgH7/IVJkdYlGerw==
X-Google-Smtp-Source: APXvYqy57ozjfyz55OtkaCDAITVuP1W4gEDRGwYptJN4CDtHKb9D9TmNPM58tH8hzlWYYl/gxNABPr4/KOR8mky9YAY=
X-Received: by 2002:a05:6808:2:: with SMTP id u2mr16609433oic.24.1574516643786;
 Sat, 23 Nov 2019 05:44:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:384:0:0:0:0:0 with HTTP; Sat, 23 Nov 2019 05:44:02 -0800 (PST)
In-Reply-To: <20191120205119.41cd5989@Phenom-II-x6.niklas.com>
References: <CAKR_QVLJZPDfjbQ4CBDv62ok0qG4jq_M_Baq6eaot6GzrKMMwA@mail.gmail.com>
 <20191120205119.41cd5989@Phenom-II-x6.niklas.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Sat, 23 Nov 2019 14:44:02 +0100
Message-ID: <CAKR_QVKahv4jZcK7k+kCKUuMz0UQJ-FFmT6Uc_p+3dYPXJ=9OQ@mail.gmail.com>
Subject: Re: [RFC] why do sensors break CPU scaling
To:     David Niklas <Hgntkwis@vfemail.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019, David Niklas <Hgntkwis@vfemail.net> wrote:
> On Wed, 20 Nov 2019 21:42:12 +0100
> Tom Psyborg <pozega.tomislav@gmail.com> wrote:
>> Hi
>>
>> Recently I've needed to set lowest CPU scaling profile, running ubuntu
>> 16.04.06 I used standard approach - echoing powersave to
>> /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor.
>> This did not work as the
>> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq kept returning
>> max scaling freq.
>>
>> During testing of ubuntu 19.10 I've found that the above approach
>> actually does work, but as long as there are no xsensors (or just
>> sensors from cli) being run.
>> cpuinfo_cur_freq in this case was returning variable values +- 1% of
>> around 1.4GHz.
>> As soon as I issue sensors command cpuinfo_cur_freq jumps to 3.5GHz
>> for a fraction of second and returns back to 1.4GHz afterwards. If
>> running xsensors it keeps bouncing between 1.4 and 3.5GHz all the
>> time.
>>
>> Rebooted back to 16.04.6 and was able to set lowest CPU scaling freq
>> as well, but issuing sensors command here once just breaks CPU scaling
>> that now remains at about 3.5GHz.
>> It can be set to lowest scaling freq again without rebooting but it
>> needs to change scaling_governor for all cores to something else and
>> then back to powersave.
>>
>> Why is this happening, shouldn't sensors command just read temp/fan
>> values without writing to any of the CPU control registers?
>
> I don't know if the maintainers will notice your email, but I did. I
> don't guarantee that they'll notice or help you, but this should assist
> you in writing a proper question.
> You need to include the output of uname -a on both ubuntu boxes. The
> output of:
> dpkg -l xsensors
> dpkg -l lm-sensors

this is on 16.04.6

whtw46ww4@I5576:~$ uname -a
Linux I5576 4.15.0-51-generic #55~16.04.1-Ubuntu SMP Thu May 16
09:24:37 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
whtw46ww4@I5576:~$ dpkg -l xsensors
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                                          Version
       Architecture                Description
+++-=============================================-===========================-===========================-===============================================================================================
ii  xsensors                                      0.70-3
       amd64                       hardware health information viewer
whtw46ww4@I5576:~$ dpkg -l lm-sensors
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                                          Version
       Architecture                Description
+++-=============================================-===========================-===========================-===============================================================================================
ii  lm-sensors                                    1:3.4.0-2
       amd64                       utilities to read
temperature/voltage/fan sensors


>
> The information on which processor you own and the motherboard and
> it's BIOS version just in case.
>
> This is just my understanding and it might be wrong, but the CPU is
> probably accessed to do the request to the fan values and so it ramps up
> expecting to have to deal with a more intense workload (which is exactly
> what Ryzen and several newer Intel processors are supposed to do), and so
> you're seeing expected behavior.

I don't think that is the case here, since I can run any kind of more
demanding app than xsensors is, even compile software with -j 5
(multithread) and CPU clocks don't exceed 1.40GHz. Only on xsensors
launch CPU clocks are reset.

Regards, Tom
