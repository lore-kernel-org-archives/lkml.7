Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698D7C32751
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328C2205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nV0Fe6DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfG3Xll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:41:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42631 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3Xlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:41:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so30650725pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=RMtoPUl/RBYxxF03isIZZU4IT1wOKxVP33QmvRDz/ZM=;
        b=nV0Fe6DYSKBdcNqNdo1iXt1Hv+gkVK2XCcgjEk752BmeGLbxX29B4Mxq5L1EAXRGWK
         W+h6WjYs6BehJZOgMvjXrAvmlJop+v4+xLUrcBQDS/VKBYghFXbETqosCbimtU83/KbR
         JmAzi3Wj8kKUHkUCo3P6mZiY0GGDONRUk6XBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=RMtoPUl/RBYxxF03isIZZU4IT1wOKxVP33QmvRDz/ZM=;
        b=JWnvWzd4w6rH4hulXMrkNaQqi2NGGzOgPB7NDtcuYQnY+3F6IKDYUmvi9m+xIMM+Jy
         OIsqVfGG6ZiiAla25KDrtU0QhQspX/1zCKG4ULHiiKPdL0AVr3gTuPylcZUNAzFBZGZo
         lMZ5ZjYZJhqK2fEJCeKSFSWWX6WfOM02KkMdwAnjcqaLrMz2eqWXX0RpikznzKT3RrCH
         5Agu0CAqjP5aDolu3+aWMBodfRTMZGuSQRRmQMUhxRV+m7QdPa4yZ0rR0WrXUckVXDuX
         m6AuwVxH4QDnmFQYLcZUPJPwNTlNbfIKWCxS+z6nZjUhnBjHA5wbVv9gLZW5UwI5UGUY
         FWWg==
X-Gm-Message-State: APjAAAWqaZObC4mnfMeNpKV7UjgfdS+riSAQ9EWNahzQPFxUIh+VR/o/
        vZhD/JbC8uvm3RITqErPsPsdsw==
X-Google-Smtp-Source: APXvYqxjbGPcuBRGJOZm+FKR9TKRPf48qmHS4nFRcAbHsbDDS9ilpXBtpCakxkHuXxb7JqvqeeEppw==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr61452134pgp.424.1564530099848;
        Tue, 30 Jul 2019 16:41:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v7sm25844316pff.87.2019.07.30.16.41.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 16:41:39 -0700 (PDT)
Message-ID: <5d40d5b3.1c69fb81.6047f.1cc3@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0hj+e3+LZ+J1eOAT2REQne_J6aAXzkKVb0tJM4u9u--Rw@mail.gmail.com>
References: <20190730024309.233728-1-trong@android.com> <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com> <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com> <2085893.cJkfNvi94x@kreacher> <5d40c41f.1c69fb81.ac63f.947f@mx.google.com> <CAJZ5v0hj+e3+LZ+J1eOAT2REQne_J6aAXzkKVb0tJM4u9u--Rw@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 16:41:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2019-07-30 16:05:55)
> On Wed, Jul 31, 2019 at 12:26 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rafael J. Wysocki (2019-07-30 15:17:55)
> > > On Tuesday, July 30, 2019 8:48:09 PM CEST Stephen Boyd wrote:
> > > >
> > > > Using the same prefix for the class and the device name is quite co=
mmon.
> > > > For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> > > > extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN=
. The
> > > > class name could be changed to wakeup_source perhaps (i.e.
> > > > /sys/class/wakeup_source/wakeupN)?
> > >
> > > Alternatively /sys/class/wakeup/wsN
> > >
> >
> > Or /sys/class/wakeup/eventN? It's your bikeshed to paint.
>=20
> So actually the underlying problem here is that device_wakeup_enable()
> tries to register a wakeup source and then attach it to the device to
> avoid calling possibly sleeping functions under a spinlock.

Agreed, that is one problem.

>=20
> However, it should be possible to call wakeup_source_create(name)
> first, then attach the wakeup source to the device (after checking for
> presence), and then invoke wakeup_source_add() (after dropping the
> lock).  If the wakeup source virtual device registration is done in
> wakeup_source_add(), that should avoid the problem altogether without
> having to introduce extra complexity.

While reordering the code to do what you describe will fix this specific
duplicate name problem, it won't fix the general problem with reusing
device names from one bus on a different bus/class. We can run into the
same problem when two buses name their devices the same name and then we
attempt to attach a wakeup source to those two devices. Or we can have a
problem where a virtual wakeup is made with the same name, and again
we'll try to make a duplicate named device. Using something like 'event'
or 'wakeup' or 'ws' as the prefix avoids this problem and keeps things
clean.

We should probably avoid letting the same virtual wakeup source be made
with the same name anyway, because userspace will be confused about what
virtual wakeup it is otherwise. I concede that using the name of the
wakeup source catches this problem without adding extra code.

Either way, I'd like to see what you outline implemented so that we
don't need to do more work than is necessary when userspace writes to
the file. I just don't want to see us need to change the name of the
wakeup device later on and then add a 'name' attribute to the class so
that we can avoid name collisions due to various buses controlling the
string we use to create the name of the wakeup device.

