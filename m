Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85D0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DCF20870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=opersys-com.20150623.gappssmtp.com header.i=@opersys-com.20150623.gappssmtp.com header.b="K4yJeduj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfDPNco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:32:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39729 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDPNcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:32:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so23249538qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opersys-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=odSzkSdVVDMrp1iglvGJ98S0QhuDfS3FFnuPWo+DzR0=;
        b=K4yJedujazT2+D+W9M8CKJXdHM9f/3FSMY6OheDldEQWbCObFCvm4Lf6AbI8QTSCbq
         ubogMNCLIohdc6raGbdJjeDzggOf3HizDPVW7OEqVTMwDaXikLuOq3UKF+xhH/jVpBG7
         c2FVfY4WOzt/qr0EaKtvmFLYW4iF/b/RWrLIXHBIJiQxvLzfLFVaamkesPNQZJEH+o0S
         wqCSnzi9E5yObzyn0vk7AFkTt+pQHWJJsiAah5HnAShVVG9LoGp6kD1RUU23vXnkFU23
         Ki8czyDVGTxkNqNGQog0ImEXt7+hiinfsqtxwKjdF9vCoq15Py5ThddHvK5+trJCsPIg
         24Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odSzkSdVVDMrp1iglvGJ98S0QhuDfS3FFnuPWo+DzR0=;
        b=JBo5bYZ7g4diKd02Kbs2o+IQhcj+LINE1MWDeWK2ge5Jwk1B5OyB4rFkKbHGyhpIdD
         ZcRk6PWpLL+cAFWTTPzqMtPpYmpfjmjZPTayq3p3wwVZU247M2WRzmyahfbYJz0EeLH1
         WCyvGVzRka7vGgWvjLqIF9QIdn2z31eN9J91TFOT+tNnlcEhKVg+6asZT+FDa+U0IoBM
         qV/QWpyTh6PeMc4kCaruBsOYVpVLa7KIuKJUCoZsvP/88caT7y7NnQmlSZ+p9EFBZbIT
         05hgNlDJWKk1w51xVzdr61s/qR5HgCagTua6LGwZzz1I5n0K1jmc7Tuvh33SYa6bqCOD
         vndQ==
X-Gm-Message-State: APjAAAVDBPj3Tbr5sY92IRTDA7s0Wz60adLbZqY/K5nzR4LAz0wF3QZN
        a1OO++JGj7ahs61gBDdrL05SDA==
X-Google-Smtp-Source: APXvYqxD0HykBfgqSujMPqpSlE//rIZ8FZFAlS443Hv16nxhyHBLBDmKI6+MSFoG/v1WhVjthz/R/w==
X-Received: by 2002:ac8:1c2c:: with SMTP id a41mr67533327qtk.292.1555421561844;
        Tue, 16 Apr 2019 06:32:41 -0700 (PDT)
Received: from [192.168.202.103] (modemcable170.15-70-69.static.videotron.ca. [69.70.15.170])
        by smtp.googlemail.com with ESMTPSA id n41sm37858449qtf.63.2019.04.16.06.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:32:39 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] Provide in-kernel headers to make extending kernel
 easier
To:     Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Manoj Rao <linux@manojrajarao.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Yonghong Song <yhs@fb.com>
References: <20190408203601.GF133872@google.com>
 <CAOesGMibHCuMPCYkc8V++Z2Kuf3YQf_OjYn18GvDgzTy6ubV=g@mail.gmail.com>
 <CAJWu+or0hWce9+7aEfTHoOR8cptRbzHYVL-bPdJWGZH20dbo7Q@mail.gmail.com>
 <CAOesGMiuGK-Sbqo2z=1ab070JONav1LF82MRRLCdX-4+14_XZA@mail.gmail.com>
 <20190411031540.ehezr6kq7ouobpzx@ast-mbp.dhcp.thefacebook.com>
 <CAOesGMgiPB=7FE7tXXHes7WSLfByyPxirOStoH21NZqMwaUihQ@mail.gmail.com>
 <20190415104109.64d914f3@gandalf.local.home>
 <CAGXu5j+KPVRcOJ3Ue9ZQF93GyaDhvCnFCvJ_C3WKCx2=SNdDyg@mail.gmail.com>
 <20190416083306.5646a687@gandalf.local.home>
 <20190416124939.GB6027@kroah.com> <20190416130440.GA7944@localhost>
From:   Karim Yaghmour <karim.yaghmour@opersys.com>
Message-ID: <f8b15e31-1aab-ab2c-d44d-47325faab67d@opersys.com>
Date:   Tue, 16 Apr 2019 09:32:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416130440.GA7944@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/19 9:04 AM, Joel Fernandes wrote:
> On Tue, Apr 16, 2019 at 02:49:39PM +0200, Greg Kroah-Hartman wrote:
>> On Tue, Apr 16, 2019 at 08:33:06AM -0400, Steven Rostedt wrote:
>>> On Mon, 15 Apr 2019 22:50:10 -0500
>>> Kees Cook <keescook@chromium.org> wrote:
>>>
>>>> On Mon, Apr 15, 2019 at 9:41 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>> I agree with this assessment. We shouldn't use config.gz as precedence
>>>>> for this solution. config.gz should have been in debugfs to begin with,
>>>>> but I don't believe debugfs was around when config.gz was introduced.
>>>>> (Don't have time to look into the history of the two).
>>>>
>>>> I don't agree with this: /proc/config.gz is used by a lot of tools
>>>> that do sanity-check of running systems. This isn't _debugging_...
>>>> it's verifying correct kernel builds. It's a fancy version of checking
>>>> /proc/version.
>>>>
>>>
>>> Then we should perhaps make a new file system call tarballs ;-)
>>>
>>>   /sys/kernel/tarballs/
>>>
>>> and place everything there. That way it removes it from /proc (which is
>>> the worse place for that) and also makes it something other than debug.
>>> That's what I did for tracefs.
>>
>> As horrible as that suggestion is, it does kind of make sense :)
>>
>> We can't put this in debugfs as that's only for debugging and systems
>> should never have that mounted for normal operations (users want to
>> build ebpf programs), and /proc really should be for processes but that
>> horse is long left the barn.
>>
>> But, I'm willing to consider putting this either in a system-fs-like
>> filesystem, or just in sysfs itself, we do have /sys/kernel/ to play
>> around in if the main objection is that we should not be cluttering up
>> /proc with stuff like this.
>>
> 
> I am ok with the suggestion of /sys/kernel for the archive. That also seems
> to fit well with the idea that the headers are kernel related and probably
> belong here more strictly speaking, than /proc.

This makes sense. And if it alleviates concerns regarding extending 
/proc ABIs then might as well switch to this.

Olof, what do you think of this?

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour
