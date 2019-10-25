Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8C621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FE/GwmYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633136AbfJYQpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:45:22 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:41570 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633128AbfJYQo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:44:26 -0400
Received: by mail-io1-f50.google.com with SMTP id r144so3133265iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FnNCWhzA8wzAQcW3IvtMxmOw0mIYmbzhbuz8jcog3z0=;
        b=FE/GwmYd89R7oOACf+gouF5/sDJA7KfixcIXlgu0Zy2xBlflmjGhsPtumrOF2/chO7
         ukgC7RpX2WU0ieTsoaIEsugTNO9IxVY55sHdmI8YDpkuFlrYNj3TJ3Yyh4TkMX3TEZVP
         euzKnHoQXH1CnnfPJ8ycKy7wwlV1V2ytUcp0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FnNCWhzA8wzAQcW3IvtMxmOw0mIYmbzhbuz8jcog3z0=;
        b=BsOBYqkTHOOoF2Fhfv1CvF5Txw5hzvMVybFX0/aafm/XL5D+X4bMZ6JEXrY9iBS7Qv
         aYlQ9Uj5E8HCgW3czZvqCa5+aoPzgK+5s5eJ6m1dWUpYe5M7QIigELHuMYR+mFGVe/6e
         46FTE9etaqE8NQvCrjYKsw0qvFE07XZE7Lu9CLaz96rv/ec8ZC7qTyMqCOm/S940nys8
         qrr9TH1t/+JRWy/DbuOfyNyhTLsPCkfhfrpD8evxcEbwiri3+F5CXIxTcY6wqRP1mCtK
         QZEWctaVidBIbZXIE2d5IacD9tyGT1tch9H9st5Ps2oi9klKtLnc38/tR+pMwGmYNeKa
         xtSA==
X-Gm-Message-State: APjAAAWjOZSm2AvsSzrB2JMnrjmQrBjB8+9LNKlxoGEkZZIbQWcK9rAu
        fqNtiANXCpCCxJmrzyEBbt3cIKuG+JY=
X-Google-Smtp-Source: APXvYqzP8GKYf3afoh8mhYdPI2JomVxqd6O3RME4/XD3F4xGkvoh25XmFLWreE9g1CWnRhhAHXuWyQ==
X-Received: by 2002:a6b:bd86:: with SMTP id n128mr4460174iof.214.1572021862432;
        Fri, 25 Oct 2019 09:44:22 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id l64sm150973ilh.2.2019.10.25.09.44.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:44:21 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id s75so2422623ilc.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:44:20 -0700 (PDT)
X-Received: by 2002:a92:d101:: with SMTP id a1mr5273789ilb.142.1572021860411;
 Fri, 25 Oct 2019 09:44:20 -0700 (PDT)
MIME-Version: 1.0
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Oct 2019 09:44:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uui+a6TS85VNv3XVApq7xYifd8m_ZTmShTC2jeGEO4jg@mail.gmail.com>
Message-ID: <CAD=FV=Uui+a6TS85VNv3XVApq7xYifd8m_ZTmShTC2jeGEO4jg@mail.gmail.com>
Subject: Please pick ("LSM: SafeSetID: Stop releasing uninitialized ruleset")
 to 5.3 stable
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you're still taking things for 5.3 stable, I humbly request picking
up commit 21ab8580b383 ("LSM: SafeSetID: Stop releasing uninitialized
ruleset").  While bisecting other problems this crash tripped me up
and I would have been able to bisect faster had the fix been in
linux-stable.  Only kernel 5.3 is affected.

For reference, the crash for me looked like:

Call trace:
 __call_rcu+0x2c/0x1ac
 call_rcu+0x28/0x34
 safesetid_file_write+0x344/0x350
 __vfs_write+0x54/0x18c
 vfs_write+0xcc/0x18c
 ksys_write+0x7c/0xe4
 __arm64_sys_write+0x20/0x2c
 el0_svc_common+0x9c/0x14c
 el0_svc_compat_handler+0x28/0x34
 el0_svc_compat+0x8/0x10

Thanks much.

-Doug
