Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34317C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32242087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 22:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="D83qNIa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfHCWkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 18:40:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42598 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbfHCWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 18:40:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so81744782otn.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 15:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PnAF0cDT4FW6fygrxyjeBHNYfYv5JYH6/0TJwjf57E=;
        b=D83qNIa5PBWamlgp8wmv5d8Jv8sW3sgp43cF1YCh37xOULzF89TW9a1bIHRSH+++qI
         lXvZQrR2wOBvwSD5SLKxyj9mVt+UJale2LqAaat9EEFqAjUgwtgAdtFsFGmdHaedEDVn
         /PMtg14FoB6f2lpMwkSmib31/vaL3M9mAq9C2b55sMRpoZvBXqWDx/+5UkvdF4V8MjK8
         C9OPO3Fk4hSZL3Ld8JVSBIV92zWzowlk9PNIHGAhJILZBS/fMJB2M1gqC8fftattIwbE
         PSv+GJdhUgBmLk1lZYsXn7CwqVnJSOsMbDLbR+H1vAXO55oX5v49NDqY/3RTgoIN7A1a
         qG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PnAF0cDT4FW6fygrxyjeBHNYfYv5JYH6/0TJwjf57E=;
        b=MpDC6jUfUUTX4KJ6We+DZmdhwXWzpN7J0By0qlRHAJK6sGjmFgAal1DVPBxiDbDexj
         D231s96xzxspWJOV1M4KHbZ/6tPlMVtS4Ar3ZxXQ9I8fm30tNHZ+P8JmYVMnjAjbF8Il
         kmSgFf0VZ61Wcc2CsKBc/3+3MNXdmLTeDitsOFIBFfkuH2vJjLRILXSAHNcDc/1pQiDk
         A21CTBDtQKtILezqfB4LGyNOp/nwV4p8uBuf4j9NmlDLWEPmTaXKyU3ewb4TXtoWV5fv
         dttQU7l+WbFZ36bFczqCj8zWKKjM+1coZoJUcouxzVFNkmEuk8XW2qD6J+eXZzH3UNIN
         aOzA==
X-Gm-Message-State: APjAAAWYj3XiebQf7pXoXdH8Y2ioZc6q1+bf3Gp+aVkvn8ZwN454JT5I
        bntEh0xY1DlqJF9eLytC/UttGMAlkoT/ntiMkWM=
X-Google-Smtp-Source: APXvYqxb2Y5awtaM3qAadatWBkFPpS8SJ8iIicCMByvpBw8ugltNVEw40uTziaiRSS/D+QO+KMWz+BLIhidCE5z4s9M=
X-Received: by 2002:a9d:5f02:: with SMTP id f2mr21903585oti.148.1564872014330;
 Sat, 03 Aug 2019 15:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
 <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
 <CAJZ5v0ioPioGBNBjiK-i5eydT9AGU3JvOBAy8L0zvs3kQNF35Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0ioPioGBNBjiK-i5eydT9AGU3JvOBAy8L0zvs3kQNF35Q@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Sat, 3 Aug 2019 15:40:03 -0700
Message-ID: <CANA+-vDYh4a74ve1NZkybbcqpQZK-8tTGVK6+Nqgv0yvqg-Dgg@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
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

On Thu, Aug 1, 2019 at 3:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Aug 1, 2019 at 11:45 PM Tri Vo <trong@android.com> wrote:
> >
> > On Thu, Aug 1, 2019 at 1:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Tri Vo (2019-08-01 12:50:25)
> > > > On Wed, Jul 31, 2019 at 4:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > >
> > > > > Quoting Rafael J. Wysocki (2019-07-31 16:10:38)
> > > > > > On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
> > > > > > >
> > > > > > > >
> > > > > > > > So why wouldn't something like this suffice:
> > > > > > > >
> > > > > > > > dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > > > >                                 wakeup_source_groups, "wakeup:%s", ws->name);
> > > > > > > >
> > > > > > > > ?
> > > > > > >
> > > > > > > ws->name is inherited from the device name. IIUC device names are not
> > > > > > > guaranteed to be unique. So if different devices with the same name
> > > > > > > register wakeup sources, there is an error.
> > > > > >
> > > > > > OK
> > > > > >
> > > > > > So I guess the names are retained for backwards compatibility with
> > > > > > existing user space that may be using them?
> > > > > >
> > > > > > That's kind of fair enough, but having two different identification
> > > > > > schemes for wakeup sources will end up confusing.
> > > > >
> > > > > I understand your concern about the IDA now. Thanks for clarifying.
> > > > >
> > > > > How about we name the devices 'wakeupN' with the IDA when they're
> > > > > registered with a non-NULL device pointer and then name them whatever
> > > > > the name argument is when the device pointer is NULL. If we have this,
> > > > > we should be able to drop the name attribute in sysfs and figure out the
> > > > > name either by looking at the device name in /sys/class/wakeup/ if it
> > > > > isn't 'wakeupN', or follow the symlink to the device in /sys/devices/
> > > > > and look at the parent device name there.
> > > >
> > > > This makes it difficult for userspace to query the name a wakeup
> > > > source, as it now has to first figure out if a wakeup source is
> > > > associated with a device or not. The criteria for that is also
> > > > awkward, userspase has to check if directory path contains "wakeupN",
> > > > then it's a virtual wakeup source.
> > >
> > > I think you mean if it doesn't match wakeupN then it's a virtual wakeup
> > > source?
> >
> > Yes
> > >
> > > >
> > > > IMO it's cleaner to consistently have /sys/class/wakeup/wakeupN/name
> > > > for every wakeup source.
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
> OK, whatever.
>
> Let's use the IDA as originally proposed and retain the names for
> backwards compatibility only.
>
> Maybe just allocate the ID at the wakeup source object creation time
> already (ISTR that you did that before attempting to create a virtual
> device for the wakeup source).

Yes, allocating the ID when creating the wakeup source object makes
sense. However, kernel/power/wakelock.c allocates its wakeup sources
manually. I imagine we don't want these IDs to be created in more than
one place.

Making wakelock.c only use wakeup_source_*() family of functions when
dealing with wakeup sources  might be a worthwhile change though. Then
we won't have to worry about ID allocation in wakelock.c. WDYT?

Also, it sounds like we all agree with "/sys/class/wakeup/wsN/" path
and "/sys/class/wakeup/wsN/name" attribute for each wakeup source,
right?
