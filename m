Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21D3C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E17215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkB71Mbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfI3QEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:04:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49761 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731865AbfI3QEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569859469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fd8RCdIiuKuPAIKnpR2Fl7ZAb8x8CWgSMRglFknIiPs=;
        b=LkB71Mbllss2uTfblXRf1wpX+YBDN7PC9RTB2dvw/64qR/ipG6eoyMEFhU3l3rbEJg0ePC
        59SCadDqYG9TyDx/Y2pRIHA+4xQou8TDaZMleBmBWY0LYzV6QzHK+uhP2oAKuqEctSPJQK
        jCz3gBKkYUyiAHbNmqv7wMUQa0Nvse8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-xtDpy1yLOVyxta937xgY6Q-1; Mon, 30 Sep 2019 12:04:27 -0400
Received: by mail-io1-f72.google.com with SMTP id g126so31283522iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MJ7SI1Xeajmimsl+pPSYeFks4KQPimMlL+Exps8iuEw=;
        b=jvT4t4R464Evxc7TccecvHeSYcHyF9c2XEpDOqNx5yi/P2sPUEyjTvS6iSrVn2bmyy
         QhR44RA2OO8zTkT1+cqdxC3tRf6ITWF/Fm9Hu7s4H/vQPcS3N5xeU+QiG78p7Hv87/V/
         lIvdyvqIG1E2e46mtTPSj/8AdcHS1Ye23yA/PqEz0BaGd91JCpciHmlalHQT7MsxqZvz
         5VovA3OcgiwoV+xBFNuzKRqcEauUhYRLhK2qRHuBuNT5IEB983Lls0SdrhBwIWp9UDgL
         sdPEEjE/RrzHeaE4C5uOo5jwcbyvVV6f7DHxQAI08HJIxUOL+KF//+k8zh/Sa+hklvFZ
         VJgA==
X-Gm-Message-State: APjAAAWQfSUYm6q/pwikVcLsNjxDr4uOmmVrbGpAMSAoT3R5rZL7rvBR
        I1Svg9vIdmKQEcoxSvj0AWXNDf1vdWgAvugcyUPc1GI2ssZ/lYPJFBJ59F6W40IAMyiOQBvYkGZ
        0o0c345XHRN7OOe95xFzBZyP4
X-Received: by 2002:a6b:c402:: with SMTP id y2mr1074722ioa.136.1569859466685;
        Mon, 30 Sep 2019 09:04:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpBZOhdcOyM4zFSvj3LJcN+OeR0ytlxUwr+GnrbyPnz+9HcfQfNvuUsXP0YS6X4lWaoA1vWw==
X-Received: by 2002:a6b:c402:: with SMTP id y2mr1074687ioa.136.1569859466356;
        Mon, 30 Sep 2019 09:04:26 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id g15sm6266481ile.25.2019.09.30.09.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 09:04:25 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     adrien.mahieux@gmail.com,
        Marco Pagani <marco.pagani@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [ANNOUNCE] Real-time Linux Summit 2019: Schedule
Message-ID: <fd337639-f218-e632-d384-9858405531c9@redhat.com>
Date:   Mon, 30 Sep 2019 18:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: xtDpy1yLOVyxta937xgY6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here is the schedule of the 2019 edition of the Real-time Linux Summit, tha=
t
will take place on October 31st, in Lyon - France, along with ELCE 2019!

---------------------------------------------------------------------------=
----
9:00 =E2=80=93 9:30=09Opening Talk =E2=80=9CReal-time Linux: what is, what =
is not and what is
=09=09next!
=09=09Daniel Bristot de Oliveira, Red Hat.
9:30 =E2=80=93 10:15=09Real-time Linux in Financial Markets
=09=09Adrien Mahieux, Orness.

10:10 =E2=80=93 10:30=09Pause

10:30 =E2=80=93 11:15=09Supporting Real-Time Hardware Acceleration on Dynam=
ically
=09=09Reconfigurable SoC FPGAs
=09=09Marco Pagani, Scuola Superiore Sant=E2=80=99Anna =E2=80=93 Universit=
=C3=A9 de Lille.
11:15 =E2=80=93 12:00=09Real-time usage in the BeagleBone community
=09=09Drew Fustini, BeagleBoard.org Foundation.

12:00 =E2=80=93 13:30=09Lunch Pause

13:30 =E2=80=93 14:15=09Maintaining out of tree patches over the long term
=09=09Daniel Wagner, SuSe.
14:15 =E2=80=93 15:00=09Synthetic events and basic histograms
=09=09Steven Rostedt, WMware.

15:00 =E2=80=93 15:15=09Pause

15:15 =E2=80=93 16:00=09State of the PREEMPT_RT
=09=09Sebastian Andrzej Siewior, Linutronix GmbH.
16:00 =E2=80=93 16:45=09PREEMPT RT is Upstream! Q&A Session
=09=09Thomas Gleixner, Linutronix GmbH.

16:45 =E2=80=93 17:00=09Closing
---------------------------------------------------------------------------=
----

You can find more about the talks here:

http://bristot.me/real-time-linux-summit-2019-schedule/

-- Daniel

