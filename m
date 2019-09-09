Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A0D2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me4OldsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403782AbfIIKYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:24:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43723 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbfIIKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:24:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so8856109pfo.10;
        Mon, 09 Sep 2019 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFxkLcFM2L005t3DbZeSiC0sSOohu++hNPyvW86VTOY=;
        b=me4OldsRdLm3WspCc/Ie3BJ9OqOB5YsmhJzfiSb2X6o5smZWYH3KbVuqVlQEfxWLoa
         jxryGnd+bLE6ctTjLgnpa5NknlTfGDpwoANw1MYtxA+4Yzb/t0OlAU0M+t3TncgIN9qk
         HGwpE0tUZBPHFenA3Z9PMGL6ePZoNl8iWgBmKyWDZgPK0nWwE9Yul3KUpQOpnGV5sKDd
         cljYozQzpw56pbzovoOCEUCyAV5WTsX4ATNd8BW6s4yHf+v/uYdFGe+6VzR8TJilXEC9
         rfR0sSFUwF7CRVf9O2HkgbqQ0GiOKiSx8maGo6ysYe3u8hrlLay6jkjqssGtvj/6Es4F
         wALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFxkLcFM2L005t3DbZeSiC0sSOohu++hNPyvW86VTOY=;
        b=tZcOvLraJJkYCXPchux01vGGBMX9EDmRmVKtUVQdcdp7NBWy0rsqt22Acl4CBlJcuB
         +lX+ueHTcw2zNbeKc4xc2nRM9TpWrrYKYST2U6d3XWgRVjFCBztXggruLD5i7gZ9PWmh
         8ScWA4mZOA20S/INf3dd0LSf8MZr5ZbJUyG4JUv/vbQpUshyrWHqJ6kVtBkVvSaBqK3b
         G0esUZZdpV+7mHjCnHjA9alMeluPdoTKAxHIa7r8dq3YEwa4tKOukNPQV1RZMNbaCz5k
         JPQlHNC7m98/1XcuC3I1ehZpDhNPa1C+rk2bKCao/TDm4DpX0KzGCbW8x4PCwHNBhoxb
         Y+xQ==
X-Gm-Message-State: APjAAAUq4HuPMKh5hsexAajTW3SC8o55XmD7Y2jxgzUWffx2CLalbb9W
        o8nslOSamQGsKdRv1B8qgnKlFbr7cIzCVgMhft0=
X-Google-Smtp-Source: APXvYqwa6nj2RuFgUw1eBSPyZZvBn4m/PGDfUSeR4Z7mJ3wLGj4Puu2HUHymcWkIB+XWhH7GOss3sAuiN3DJbLJZd9A=
X-Received: by 2002:aa7:86c8:: with SMTP id h8mr22887681pfo.241.1568024677885;
 Mon, 09 Sep 2019 03:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
 <20190905233748.6822-2-srinivas.pandruvada@linux.intel.com>
 <780a3faf-9e44-64f4-a354-bdee39af3af5@redhat.com> <20190906134655.GU2680@smile.fi.intel.com>
 <6b576770a4bbe6c24ea524083dec5a16bf3c9e94.camel@linux.intel.com>
 <b8c7bd1204f7b4f75a5bccec4d7c41b1225928f7.camel@linux.intel.com>
 <CAHp75Vc9xMPW38Toh2jKv9YYYNV16837aAcXKMP6WaM-L8zcSQ@mail.gmail.com> <c6e4cedc4886fd689b3ff1df413ce62aa52cc544.camel@linux.intel.com>
In-Reply-To: <c6e4cedc4886fd689b3ff1df413ce62aa52cc544.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Sep 2019 13:24:27 +0300
Message-ID: <CAHp75VfzyyAXscYdSm7BoAZ9ViFiX7fpYkA_pPaTh3Q+Mn9fHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power/x86/intel-speed-select: Display core
 count for bucket
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 8, 2019 at 5:43 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Sat, 2019-09-07 at 21:18 +0300, Andy Shevchenko wrote:
> > On Fri, Sep 6, 2019 at 10:47 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:

> > It seems not applicable on top of tools patch series I had applied
> > before.
> I have rebased on the top of your review branch and resent.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko
