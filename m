Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BB1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DA820693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJAq4qg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbfG3SsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:48:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34991 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbfG3SsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:48:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so30324700pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=z+31YRcGYKxlw4zSSmAToPPt3gVT1HPAnO6GnYlbMZo=;
        b=TJAq4qg2C4MBQbkD/CTjGokwpAKEzdcOAFM3jCYS+mlBvSYxgOUsD6++v8VwgpaaYf
         SnCgoasoMjxoVS0Oq099Bjly5HzPXJFsePK4WjeTg3GfZPjMPTBd6HL1yDn6dDWty9zB
         TYGgUam3ePk5GjM3kr1xPw56i9qyvhK8YjlW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=z+31YRcGYKxlw4zSSmAToPPt3gVT1HPAnO6GnYlbMZo=;
        b=APs9sb5b56ex9y/bl96xdkuyMXZE/kotlvuItOB+EPDgZS8FILQYzwsekLQwOsLjDb
         gOjOXLVar0XDJrX4QdmxNRxk0Khp+3cGXLJPUZ1AewS4ih5OiXLTnccN4nO5fR2vqL4g
         bAmdBJk0jbnv4xgxRzj1pXjRr19OumZrJ1+w7VjtGLeA2gPpNgp56dzrHGr577Kov1H5
         BCqvD9T3qhrDExhnSpYYdPHFfBdLniyIbV+38N5OAuu1hEe204evnOjiHKwJ6QaUsubY
         c1QHDLa9A/Ul08zetHhHq6iYqxpKndMR5vXUlJ0BxjGYD8qsuBxxY6wvBwyiWFYFDh5n
         G0Rg==
X-Gm-Message-State: APjAAAUYYsE7DSXpkywDuzHFb/ahzKjKbYHlVa1pvPLTmxZTxBz+8MxD
        XOG7drcTFLZL5WV5vPHRZtTjJg==
X-Google-Smtp-Source: APXvYqxAVgwtF+7Gc1/v2YuISir9lkLsH3N699o/8YpjsdFSEKU1zdqtP5clNwyMIyol+CT08586/g==
X-Received: by 2002:a62:3445:: with SMTP id b66mr43403564pfa.246.1564512490944;
        Tue, 30 Jul 2019 11:48:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n140sm68012721pfd.132.2019.07.30.11.48.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:48:10 -0700 (PDT)
Message-ID: <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
References: <20190730024309.233728-1-trong@android.com> <CAJZ5v0jJn=vHdYExbzwRAMsk=Ad5bhvOAvHEXe-FHOj2R4Gwig@mail.gmail.com> <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
To:     "Rafael J. Wysocki" <rafael@kernel.org>, Tri Vo <trong@android.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 11:48:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tri Vo (2019-07-30 11:39:34)
> On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> >
> > On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> > > - Device registering the wakeup source is now the parent of the wakeu=
p source.
> > >   Updated wakeup_source_register()'s signature and its callers accord=
ingly.
> >
> > And I really don't like these changes.  Especially having "wakeup"
> > twice in the path.
>=20
> I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?

Using the same prefix for the class and the device name is quite common.
For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
class name could be changed to wakeup_source perhaps (i.e.
/sys/class/wakeup_source/wakeupN)?

