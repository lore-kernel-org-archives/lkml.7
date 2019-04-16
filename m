Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC13C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE31206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="CtJojajV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfDPQnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:43:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55297 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbfDPQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:43:03 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so34067856itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIz8ijQrhvRzPfkEdEIR0rNqSCetnprJPdAFgmNCiB0=;
        b=CtJojajVZcaAcibm+2qJdA3D1bkb2URL1mecCcCYzQ5zC0sbt49LTdbFcmulwhyuTk
         hvvT/KLSA8cRzn1I09tmuDPp8k1c7wUSSgeTbQNjz6NyFRht8/c55THph02h/QYs7eE+
         oAS2JP86sYJ7qb2XoHSV3qVM1lG8JxZD9/bd4bg/YkPy0IHtxeNN9LRD/0nbPoobjqw3
         PmZqwNbP0ydodP3P9g9IOtQwj46bwLtxKatMtm8sL74Wq42SjZi7R4Zwh66+uANVihu8
         kN0zXiJZebzb9ubVVkp8x94zvjMumGEmE7UhcWGK00OU+UjodL9W51CvsMnyhhnVVQjA
         L/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIz8ijQrhvRzPfkEdEIR0rNqSCetnprJPdAFgmNCiB0=;
        b=aNvC9JsMOv2Wbmcok7vAGlQf1KCzL7UDFJDf+IgDRXweo6KFcEToisAByMg0/rXnX+
         UOfa2U427qfD/+/jGggN1poWpmmnijC7DMO66Imcki9+ww0UyjuRmLztaRQHHU6YKRKp
         28/zjjHg/7kjFOZfDifcEL52WtdleMC1B45Ra41CSOX2c9kA6dfRQaiA3sgYF9lKcc3b
         G9IZJmYnRQpv0QBSE4j9aSJtRYBqAOfY8UeaUWJSTCC85zC+Z3CZIMkdYxVFxXGouTNm
         kNiIbX0AfQlVi3juL3UnCeVs+Bi4RXxl3vEQRZ+IOCHnprk1OaBotcbaetMlB27fiAJE
         dp5g==
X-Gm-Message-State: APjAAAVzOYSJXNf7QEuixoABMYOSw3GzKuhXetNmJm7HelxkQozbmcVH
        LZZsUFYSre3YnDSuGmCcRLSMIr28A+VSCRCztIjnYg==
X-Google-Smtp-Source: APXvYqzbdfiSc6MRaB/Y4fQbEFJ2XKakwbIIewcpPBYe5YGxrG0BMyO6/gvaK0f7myT1LwYBwTAMZc4SczNsFiw0xgM=
X-Received: by 2002:a24:c685:: with SMTP id j127mr28210577itg.21.1555432982757;
 Tue, 16 Apr 2019 09:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOesGMiuGK-Sbqo2z=1ab070JONav1LF82MRRLCdX-4+14_XZA@mail.gmail.com>
 <20190411031540.ehezr6kq7ouobpzx@ast-mbp.dhcp.thefacebook.com>
 <CAOesGMgiPB=7FE7tXXHes7WSLfByyPxirOStoH21NZqMwaUihQ@mail.gmail.com>
 <20190415104109.64d914f3@gandalf.local.home> <CAGXu5j+KPVRcOJ3Ue9ZQF93GyaDhvCnFCvJ_C3WKCx2=SNdDyg@mail.gmail.com>
 <20190416083306.5646a687@gandalf.local.home> <20190416124939.GB6027@kroah.com>
 <20190416130440.GA7944@localhost> <f8b15e31-1aab-ab2c-d44d-47325faab67d@opersys.com>
 <20190416094509.1af6326b@gandalf.local.home> <20190416142240.GA31920@kroah.com>
 <20190416104346.10cca21f@gandalf.local.home>
In-Reply-To: <20190416104346.10cca21f@gandalf.local.home>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 16 Apr 2019 09:42:51 -0700
Message-ID: <CAOesGMjRPoy4JO24rNZHORpSN0Hg53ajHKZNM15YDCkDah=+6A@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Provide in-kernel headers to make extending kernel easier
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 7:43 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 16 Apr 2019 16:22:40 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> > If I make /sys/kernel/config.gz be the same thing as /proc/config.gz
> > will you fix up 'make localmodconfig' to use it?  :)
>
> Sure.

Doing a link to the new location is probably best, just like
/proc/device-tree is today.


-Olof
