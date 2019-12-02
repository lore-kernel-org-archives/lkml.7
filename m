Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA58C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F185A206E1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="BE3iq2Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfLBNDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:03:09 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:35082 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBNDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:03:08 -0500
Received: by mail-qk1-f170.google.com with SMTP id v23so24600129qkg.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 05:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xRuuEGyAGanfoy5q3F5NENsdAyWJMeRKdcgAZk8b6w=;
        b=BE3iq2ZpIuCgwFcVamFkvW6pUOOlIbNrDoXwl5ZnUJwCxEaS36mYpKu6PGWDIGXD8d
         5nAj61ijp6j6BYbZddjD+1sCYLcYEb+mGXY+FCkE7cf/ux3am9ehp6A1HvgW9JuV/2AX
         AnFCV936pC7voJqDkfJ72Tp6qVf6oHWEZyYpXgXHqErwaE3Ro9MAkn+PlGwmKFTNMMbe
         PWccpVy75BSs0X0jzjZLIcHUwjQWKn8Aj6e7eCH0666MV8zLbPsW/RDvkFmXMRH0lhl7
         jf0NftCbxgY3/H7e/mEbLg6b0gSbqCpAFkzeUf7utSKUEjIV9cg1ieHzETt7tzujlf7Z
         evyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xRuuEGyAGanfoy5q3F5NENsdAyWJMeRKdcgAZk8b6w=;
        b=nlr2uU0LSiyFVlWOPZRJvdC5apuPvmO1bIW0C7PiC0TwtyasJdClz8KIIIWRJPwPfQ
         7C4f6Jq8kG16R7PwegFMfLok/09fEDIPindFl97BhVm0FIHJkJ2G3IKgrefDSYrj9Pkh
         f1ugPCoEG0Cdw8N8VlMJLuZR7mnxzFRHa/nWYSsfgKxWEdO1gwqg1aeS6elYipg++NmP
         fadIItjdH856lpKpwSiaedqDGqEofCS4xEoGRIpaM75IAkhAkW9W8mwipKBY8BWoXsbk
         Pi5Aj6KnZpywbn4CxrU3OllYsXxZXPXOWi7XOltkgvf40ZfGoI9/LGG1hXHL02jnDtsq
         8yzw==
X-Gm-Message-State: APjAAAUNMazoPeQCBd1oNsNilen0XsoFOLyMHIj/o9JEsat8ciaPpXdF
        yB25Vg2UCohwt1U+ehbd340crbvaANkfzbEDaAdVHg==
X-Google-Smtp-Source: APXvYqxltmbW6yD4IujggvoIjL/CEqI/VBXGaRoEomUUHm6dM6wNDlC3eKlhd0Zv9T5JH91OBtiddPWWM2XLu/kzmR0=
X-Received: by 2002:ae9:e714:: with SMTP id m20mr29726503qka.403.1575291786620;
 Mon, 02 Dec 2019 05:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20191201094246.GA3799322@kroah.com> <20191201193649.GA9163@debian>
 <20191202075848.GA3892895@kroah.com>
In-Reply-To: <20191202075848.GA3892895@kroah.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Mon, 2 Dec 2019 18:32:30 +0530
Message-ID: <CAG=yYwn3nYn2CmV7BWOJdBWicYPuK2DwBgz6p=bDC9nWOt6vqA@mail.gmail.com>
Subject: Re: Linux 5.4.1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 1:28 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> You tested the performance of what?
i tested the performance of  5.4.0 and 5.4.1

> And 5.4.1 is faster?
>
and it seems to me that 5.4.1 is faster than 5.4.0
-- 
software engineer
rajagiri school of engineering and technology
