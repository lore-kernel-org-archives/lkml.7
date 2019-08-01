Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2785C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76783206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="k32ozRW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbfHAWox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:44:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33034 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390009AbfHAWox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:44:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id u15so55344537oiv.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z19NwBBdlIkZbbmAdrU9bSR86zfLlrJIzkv4N57qplI=;
        b=k32ozRW15p+q3FqanD6ih08gd2KoUftSnAlKaDETCL8bT79KMYjAZj2SCzlsv9lwm1
         KG2PG9tOJKVdogB3N1ZiDEW9/0oXpC0t0qjHboE4/UCexMg6vA3DLYuldrIBqTnoSUBq
         1YVpGFsFiW8Sg49HO5nUf9TGa70p5SGi1l9tlndyN6H7Iv/jojiymW+w78CeU4kCOIaW
         SzSYN94Vp+Sq7vzLl0nTaa1rwtppnFCi26XgKbVPEWeyC6PAjvAC4vVCi1wa/zAWMksU
         Cyx9WvHiO6ZZhnNZHARfrtxF4AWgZkmY+RFkTB2N6UpiiDOXPd/NUFviWIEKl0W8WfGQ
         VI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z19NwBBdlIkZbbmAdrU9bSR86zfLlrJIzkv4N57qplI=;
        b=b/Zj+ihnympY1EtKJwdezol1BM51/5De87omDISfc9mhW1SA7BYzy2fxxLscoWjwfW
         3GRqhgJaqEd8bRrOd/d5v88qKU2RQ2jq9x334puCt5qjhdZcfjgL1wQ6SLdtLbZAYNPP
         GUEbad28GT2Dm0+92VMTspnGMqF1luvnXknP6m/+Tlo6bdohZeVRSsIH6Fr56AqlrZfF
         LXnECADkgKgUQpGsgR8aDp+s99/Be9SdpleEJ8UoC6mhOyRnzV5+KcpEfu2wFZBqQA5h
         Q0eCIB13NfJ2s1kmupWaLpgAhsrXQxqbvNwFANFqR8zfUbtAE6eo73Bg4FCemaniolj9
         0HRg==
X-Gm-Message-State: APjAAAVX/YHtHyFDGcfdUAmQxCs3zkH4ZyODj0y3Wn7D2INZmG/vwJLr
        WVw9mgrQCNbRbSRTtjnbrqwYVsNRkwNgn4M+OaFqUg==
X-Google-Smtp-Source: APXvYqzL6Tgyg2JWP92iL6t03/Io4jUVU0O6z3DswEQ2kaYVSaQlvoL2++34ELuEnWw6x6VL/opZYgm88z8ZoUdO8v4=
X-Received: by 2002:aca:af55:: with SMTP id y82mr759314oie.172.1564699491791;
 Thu, 01 Aug 2019 15:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
 <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
 <5d4363ae.1c69fb81.b621e.65ed@mx.google.com>
In-Reply-To: <5d4363ae.1c69fb81.b621e.65ed@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Thu, 1 Aug 2019 15:44:40 -0700
Message-ID: <CANA+-vBi6j5FSsfdqNZ7zQmH2OzsAEMyz=39-y-ygagscR7ZEA@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 3:11 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Tri Vo (2019-08-01 14:44:52)
> > On Thu, Aug 1, 2019 at 1:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > >
> > > I don't find it awkward or difficult. Just know what the name of the
> > > /sys/class/wakeup/ path is and then extract the name from there if it
> > > doesn't match wakeupN, otherwise read the 'device' symlink and run it
> > > through basename.
> >
> > The concern was that having both "id" and "name" around might be
> > confusing. I don't think that making the presence of "name"
> > conditional helps here. And we have to maintain additional logic in
> > both kernel and userspace to support this.
> >
> > Also, say, userspace grabs a wakelock named "wakeup0". In the current
> > patch, this results in a name collision and an error. Even assuming
> > that userspace doesn't have ill intent, it still needs to be aware of
> > "wakeupN" naming pattern to avoid this error condition.
> >
> > All wakeup sources in the /sys/class/wakeup/ are in the same namespace
> > regardless of where they originate from, i.e. we have to either (1)
> > inspect the name of a wakeup source and make sure it's unique before
> > using it as a directory name OR (2) generate the directory name on
> > behalf of whomever is registering a wakeup source, which I think is a
> > much simpler solution.
>
> Ok. If the device name is going to be something generic like 'wakeupN',
> then we need to make sure that the wakeup source name is unique.

If we could easily make sure that wakeup source names are unique, then
we wouldn't need to generate "wakeupN" ids :)

> Otherwise, I'm not able to see how userspace will differentiate between
> two of the same named wakelocks. Before this patch the wakeup source
> name looks to have been used for debugging, but now it's being used
> programmatically to let userspace act upon it somehow. Maybe it's for
> debug still, but I could see how userspace may want to hunt down the
> wakelock that's created in userspace and penalize or kill the task
> that's waking up the device.

Two wakelocks can't have the same name. So they are still
distinguishable from userspace. However, there is still no way to
figure out from userspace which process created which wake lock.
That's a weakness of /sys/power/wake_lock API, independent of this
patch.
>
> I see that wakelock_lookup_add() already checks the list of wakelock
> wakeup sources, but I don't see how I can't create an "alarmtimer"
> wakelock again, but this time for userspace, by writing into
> /sys/power/wake_lock.

Behind the scenes, writing "alarmtimer" to /sys/power/wake_lock
creates a wakeup source named "alarmtimer", which in turn creates a
directory /sys/class/wakeup/alarmtimer (in you patch), which is likely
already created by alarmtimer. This leads to an error. The error is
resolved if wakeup source's sysfs entry is /sys/class/wakeup/wakeupN
instead.
>
> What happens with namespaces here BTW? Can a wakelock be made in one
> namespace and that is the same name as another wakelock in a different
> namespace? Right now it doesn't look possible because of the global name
> matching, but it probably makes sense to support this? Maybe we just
> shouldn't make anything in sysfs for wake sources that can be any random
> name created from the wakelock path right now. I don't see how it can be
> traced back to the process that created it in any reasonable way.

It should be OK if we don't use the arbitrary wakelock name in the
path, but instead use the generated id "wakeupN".
