Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B0DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D47020650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OePzI0s0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfJWARw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:17:52 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:42447 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJWARw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:17:52 -0400
Received: by mail-lf1-f45.google.com with SMTP id z12so14506982lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ6PtzJKXyCbE4QgSRCknBL+ktlMMVZMJTZlai7sfRo=;
        b=OePzI0s07XRspjzP6hpHptPYAZ91ykwFW/MOU3dwmxa7O3VXV8/w4u208iiiZRWJo7
         BF43iGHf6LVzyZbesaFS3xHd5qc3HWFUOcbJ/HwRDjUC2RoC3eGnfk2OmLfKkUjhDfs7
         pfeNOEQpIk2/TkZSNHdGXDE3Jpqmc3g4UtRqDHN5XfKtq/jMFSGLdA/DfuQ5uP2F4e70
         1iLnf+8oLxq6wsQwckvOMn6mkTVypJgxcw/tnv5eLJAB0DrznANAlyO04e3rnzau22oQ
         VTJl4vTTxCHgrmWHL9HTafweWh/kq0pzAX7RDMA8uY7gTVEQTtFKwuzknOPUI3+G0jv/
         phIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ6PtzJKXyCbE4QgSRCknBL+ktlMMVZMJTZlai7sfRo=;
        b=Vg8cUeZzjRCvTK4wPGJnZr8MFu1iNS+HHb5qx+BJebcmf9pL87vL2YSp3LOpRgsP3q
         EqTnFpKKq++bnS1s9yGve4rPqAZRpmEmfo8TGAsh9kNRSKCwE3ihZOqA4R4K9jmyG0Bu
         AQjmxc6gWmIwvnkEgNLwNt6oyeFZVHpuQOl6o+Y2RzHcaR/sPkWuLxKJKtmblRNF0Da6
         t/eYfpa0GUeBLvPGOFwKlyV7RZcXtZlGBbrFHZzoWbJjp9aSajNCwIPpAdxpVcIMaIp0
         VX5fLAjs9hglS6z7irvNfFMznIL939izRcvLq/V0g9xOp8O887vVSZcyHxjJskEBBq5X
         tuhA==
X-Gm-Message-State: APjAAAV+ydP8selFf36VNNkncjKlUjxdqvU+4XxS8gfOK89ML35tUPUo
        dC76ZZK2K4owX1a0NPX25tm4oevUbrmbS44ln5vFUg==
X-Google-Smtp-Source: APXvYqwhSkU3gwfa43CMQGaP9gD4LGrcVgE0palW4Riaoh2ocwxqd4w/qH5N/y3ru9WcGBG8F34YEwRT55n9prtCGRQ=
X-Received: by 2002:a19:ed16:: with SMTP id y22mr9369612lfy.166.1571789869408;
 Tue, 22 Oct 2019 17:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan>
 <8736gbbf2b.fsf@intel.com> <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
 <87h84q9pcj.fsf@intel.com> <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com>
 <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com>
 <CAL_quvTe_v9Vsbd0u4URitojmD-_VFeaOQ1BBYZ_UGwYWynjVA@mail.gmail.com>
 <87sgo3dasg.fsf@intel.com> <CACK8Z6FF1CBmti797sYWS51j-8ag-pSL9RJ2r9NDibXk2M=tEQ@mail.gmail.com>
In-Reply-To: <CACK8Z6FF1CBmti797sYWS51j-8ag-pSL9RJ2r9NDibXk2M=tEQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 22 Oct 2019 17:17:12 -0700
Message-ID: <CACK8Z6HvekrGkFpQ-gmSvZRrS3gq-B2P-T1ihmF3JhK5v4QboQ@mail.gmail.com>
Subject: Re: New sysfs interface for privacy screens
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Mat King <mathewk@google.com>, Sean Paul <seanpaul@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 5:14 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hi Folks,
>
> On Mon, Oct 7, 2019 at 11:13 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>
>> On Mon, 07 Oct 2019, Mat King <mathewk@google.com> wrote:
>> > That makes sense; just to confirm can a property be added or removed
>> > after the connector is registered?
>>
>> You need to create the property before registering the drm device. You
>> can attach/detach the property later, but I should think you know by the
>> time you're registering the connector whether it supports the privacy
>> screen or not.
>
>

I just posted a patch for this here:

https://lkml.org/lkml/2019/10/22/967

Would appreciate review and comments.

Thanks & Best Regards,

Rajat
>
>>
>>
>> BR,
>> Jani.
>>
>> --
>> Jani Nikula, Intel Open Source Graphics Center
