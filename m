Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC7CC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13A0215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578079815;
	bh=wiLakP/FPmTkrU6E4UixqLxtXOH/FVOZJ+CziMsFK7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C5QPnpbZPsnY+J0bU47U8D+tegjpK81N5yp8p0SIRrkDrl1xf99qEFfqaEr4zL3o5
	 wvFCJiyazYFUR0tvDqorLsr67TYKiO7lfOM85ztUsq/8xLKVmecHQf0gszZ6vhEiDy
	 vs3e4sykFj4snh9O5Pka2QzGFS5eCqzxzOBxt/oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgACTaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:30:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40215 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgACTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:30:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so44838738ljk.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 11:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFXcXk/rWc+vZDd2lXOSRdfqK7Rx+9AcujMvsOnCZcQ=;
        b=H1MIzm6Oi4jSBscmLV49r9Nd5HT6nc6bvrco9VvwbKlzMSopWLEIAGe6hSQb7cvv9P
         cip/Cxk8S5U7lhfpRoBFf8HeyyrOu6N9/Nrl1mnD3DgILx8h5/RFBbeGmAVeWDKR8rbY
         hm/i7+uHQDHv5J8iclqo1WiLmqKxGLcnr6544=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFXcXk/rWc+vZDd2lXOSRdfqK7Rx+9AcujMvsOnCZcQ=;
        b=FcSAb+3/TZb5uG/95GbHp+zmmGDwIIHf3l+UWiS9Q/i7IZ4skxAkn86WuF6Qt4j7Dc
         3eAA4QXecAD2VZcpP1vIMAIjGgjb8O7fHib5Oq/YvX+WYKuwm4cFOwmy8ootbs4A/rLo
         kwo1xaM+1hQ/WWiHaZIaE9yn7l5SEu3bMmI7WEAhI49BYu6+I77uRGgHaQGWsKXROLvW
         dR6PIe8xImQYh7+yn129mDrw2+PHqgJ1Ujta/gJ4C0bIJX90ky3v886ET5MYix8tPL6m
         wmsfG1TNC01M5V9qSj4HEUHiAcWESP2nw3Wl8w2u3CRNKi6wuVuYIRHJlJFNp3u0o8yS
         l4jA==
X-Gm-Message-State: APjAAAVDx9S33LwKZD1NEnkD+YeWmgQmfnnw4WAkxCjP0O2pf6ObnbiL
        y1IwfucAyjMcsgfVJpLPoy5Qp8ZzmI0=
X-Google-Smtp-Source: APXvYqyg8neA4gtgmFzZRSeorIE1zUzwIWYNPKZHSjMdYKx3xGKF+83ElSmmRZjQJ3yIfEGgGZLYBg==
X-Received: by 2002:a2e:95c4:: with SMTP id y4mr53054806ljh.38.1578079811164;
        Fri, 03 Jan 2020 11:30:11 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b19sm20426433ljk.25.2020.01.03.11.30.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 11:30:10 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id i23so32532852lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 11:30:10 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr51941142lfo.134.1578079440587;
 Fri, 03 Jan 2020 11:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20200102215829.911231638@linuxfoundation.org> <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
 <CAK8P3a1+Srey_7cUd0xfaO8HdMv5tkUcs6DeDXzcUKkUD-DnGQ@mail.gmail.com>
 <CAK8P3a24EkUXTu-K2c-5B3w-LZwY7zNcX0dZixb3gd59vRw_Kw@mail.gmail.com>
 <20200103154518.GB1064304@kroah.com> <CAK8P3a00SpVfSE5oL8_F_8jHdg_8A5fyEKH_DWNyPToxack=zA@mail.gmail.com>
 <a2fc8b36-c512-b6dd-7349-dfb551e348b6@oracle.com> <8283b231-f6e8-876f-7094-d3265096ab9a@oracle.com>
 <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com> <c5c3b8c8-1dfe-2433-630c-06dbfb3d318b@mageia.org>
In-Reply-To: <c5c3b8c8-1dfe-2433-630c-06dbfb3d318b@mageia.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jan 2020 11:23:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgV_YN9az2XBX=xr_DGQiUEqwjtMXkmj-w12j58NQxneQ@mail.gmail.com>
Message-ID: <CAHk-=wgV_YN9az2XBX=xr_DGQiUEqwjtMXkmj-w12j58NQxneQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/191] 5.4.8-stable review
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, LTP List <ltp@lists.linux.it>,
        Jan Stancek <jstancek@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 11:11 AM Thomas Backlund <tmb@mageia.org> wrote:
>
> Does not seem to exist in public git yet, maybe you forgot to push ?

Not "forgot", but I've pulled a couple of other things, and done my
usual build tests etc. I tend batch up the pulls and pushes a bit,
sorry for not making that clear.

But I've pushed it all out now.

           Linus
