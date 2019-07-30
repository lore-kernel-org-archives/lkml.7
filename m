Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3931FC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB5F206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lf0JpW9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfG3W0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:26:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35360 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388170AbfG3W0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:26:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so30589934pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=wtE8Qs6WxdqfhKDtqY7NOxwIx8qnuciqL0xbnCEtDy8=;
        b=lf0JpW9ckD66UO7/vIhzs7MO0L2BH0pJ2Z5wVAUptbQ4zwlT/dfgE/gLqdt+cmnojs
         eUO2YzcXwrTXe7Qq62KIBCw8xgJP4qmKQ199TOALlhH/RuZTJhJEcw2tjBIj33yD74kd
         jREJt4lJCLk8a3jx4NXibqd00INprbu8qPUhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=wtE8Qs6WxdqfhKDtqY7NOxwIx8qnuciqL0xbnCEtDy8=;
        b=SMJVR1CNF4RdZh8PE2C6t0S8luJFdCG+VOHDPGqigjgEc5KZU5DScUtCbYvv/OCTyQ
         UN588ttpaVnc24bzlXGdAIpxOTNXznyvHJtkMk8rxvF3LBNsuHKMyspg07FwiIiQuTPd
         IzfTVfxYypCXUKyvvcWsCV+DaDS/Q/sjhPpwSo8tPRIkAejnDtmD6n5ifS3PvHiHtN8N
         G5g5a10fY3WmzwM0Faz+nDLz/HPr7frcSb6oh3ZG6EWxLbSYUOeCsxRRdh4DRSc4jT5k
         WVy1KD/HakybZIzJjrL/Ox/p7jf+hTYs9wALsfnT60ViZO2gLT9kl8tFAZz7F1LGBt9B
         a6zw==
X-Gm-Message-State: APjAAAXEHd/OMV8J0lj2Ge7mmH30oUZQVWhguaYC/uFK+ba8pHzoIqnO
        MpnE3aBT1v1TtgmASyxbafQ0zbb+sGjsnQ==
X-Google-Smtp-Source: APXvYqzmCGgbSxYYdExQZf0zV20cq2S0wbI4IzmWdNg3JbAP1ExccOW0hF6cMcASAqTVi42DsD6p4Q==
X-Received: by 2002:a63:8a49:: with SMTP id y70mr16015123pgd.271.1564525599777;
        Tue, 30 Jul 2019 15:26:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm107068280pgg.27.2019.07.30.15.26.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:26:39 -0700 (PDT)
Message-ID: <5d40c41f.1c69fb81.ac63f.947f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2085893.cJkfNvi94x@kreacher>
References: <20190730024309.233728-1-trong@android.com> <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com> <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com> <2085893.cJkfNvi94x@kreacher>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 15:26:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2019-07-30 15:17:55)
> On Tuesday, July 30, 2019 8:48:09 PM CEST Stephen Boyd wrote:
> > Quoting Tri Vo (2019-07-30 11:39:34)
> > > On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
> > > >
> > > > On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> > > > > - Device registering the wakeup source is now the parent of the w=
akeup source.
> > > > >   Updated wakeup_source_register()'s signature and its callers ac=
cordingly.
> > > >
> > > > And I really don't like these changes.  Especially having "wakeup"
> > > > twice in the path.
> > >=20
> > > I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?
> >=20
> > Using the same prefix for the class and the device name is quite common.
> > For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> > extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
> > class name could be changed to wakeup_source perhaps (i.e.
> > /sys/class/wakeup_source/wakeupN)?
>=20
> Alternatively /sys/class/wakeup/wsN
>=20

Or /sys/class/wakeup/eventN? It's your bikeshed to paint.

