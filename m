Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2842A207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLtR10TY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfLCWsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:48:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41091 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbfLCWrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:47:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so2305914pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 14:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TqgN2iJjOXxie883Mhqea6U14ESjoMu4kL/R78rVdw=;
        b=XLtR10TY5HvNYaSa6cai3/R9FYzleQQZz2svZyL8tOK87YQA912V1ym4Hv9zSZTa4W
         XsYLsdsxIIeqUmKaaTyXJdXq5ZIMsdtz+qAW2aJArY3lZQzq/8XMkxXKMLduQdGguwWQ
         tEyyhc1m8FNszdEx+TWMqK02tQGLsYRH7qEoztNCUWj2XYpGsKHNu+2K9gLUBTSzkpQg
         cL0sHoa58B89n343/NyL3Q5aK/piEHaXyVdmqwAxoUlwff0wlzeadqsQ5m97SN9ss//N
         WQpKd+LYhfVNyvGjsitB44ASs9L0mP1g554ne1GdBkVgiDiXqQvNshl3HDgwl4vsoLUr
         Y7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TqgN2iJjOXxie883Mhqea6U14ESjoMu4kL/R78rVdw=;
        b=gAjH4PVLtu99BKHDBBK+XHQ7cHurRVYmG7PqURAH/oUVW51tgJPiZJ0RdKJJ2JJ1nd
         aHcTbDMu8Zw47SK4movsNbicxEvFUGe4yhjhelVMErVXawxEpsDQW0H61QF4aldhGNsb
         cV49LUwxZn3KLBVuxBJ0MFWIJjPm+4BMt158zydMURZayGkojUb9Muv9paR4Ywqqd7x4
         qIbfmpIU/YfpsGxhkpMZd8kKywuxrhnNV8NWpY84SyI+u+NL/V0LjI0I2P84H9yLWdJU
         Az7fz+4PZuEhm/z0mr/2GtPVih2RjBtcq8rE/4vmdY1nuHkH/gQIO+fgkfxfrm4sgEni
         ZsDQ==
X-Gm-Message-State: APjAAAVsZgDqlCKdZX490upi0YyQrmjZ8Bc5PCB77cB3pktb4XrSj30T
        woazIJ0cctFkU9T9p+x7SroMbXNHOzp6wu7UYAWtsA==
X-Google-Smtp-Source: APXvYqxzyBp784JSAxM/nOyG953YC2qIJk8I3LZCsWw1NC/8F92n1+h9oQjRuIVvcrvMxxIyY3GenyseDH3/qhHb7BI=
X-Received: by 2002:a63:480f:: with SMTP id v15mr32786pga.201.1575413270868;
 Tue, 03 Dec 2019 14:47:50 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-6-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575374868-32601-6-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:47:39 -0800
Message-ID: <CAFd5g47BXKat2Hty01WHz6eJj3WOjbeJ3pYqimaf2wQPm7Eibw@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 4:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Making kunit itself buildable as a module allows for "always-on"
> kunit configuration; specifying CONFIG_KUNIT=m means the module
> is built but only used when loaded.  Kunit test modules will load
> kunit.ko as an implicit dependency, so simply running
> "modprobe my-kunit-tests" will load the tests along with the kunit
> module and run them.
>
> Co-developed-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
