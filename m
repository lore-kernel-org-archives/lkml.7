Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68510C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C41320838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSyw9bKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405438AbfIFX2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:28:37 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:42930 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405045AbfIFX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:28:37 -0400
Received: by mail-ua1-f48.google.com with SMTP id w16so2597202uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xDCSU428Xsh7Yot66CpvIMuEHse1mAhlVsIc53JymOo=;
        b=tSyw9bKtT8ggvc0FhTq4VAUFOShmx/ic/kw9fumQ8k9ab7YmWjN6wBLxb/msNgWZXr
         saUb2oEGXHoWJ8wIo1rwJP6NqxStvFI9G7E1hqJwb8RxHb5zVisgnJemmv5iUe6w5L05
         nwEzdt68xMUFgWpR0lqumrS8oTHyK4K/ZXHFRFNcT+MtTmmhS6D6sd29hCu7jcoa+ddX
         0Oj7mIsFmvFeEWUPqPMZOcbNNBZhZ3uoMdvk3VfQjTNTLfjUkDjyF9cj0ZbEQuT0IvUQ
         bv4kxT9yHfougjN2Sj6hsVMz4WigRWrA0htsfL7FmUnzC2PKWESEzOcaWn0bIEaEGLYh
         0L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xDCSU428Xsh7Yot66CpvIMuEHse1mAhlVsIc53JymOo=;
        b=VTIp0rQtlZShPaj7rPJIu4qsvHKbATAShRLlu6RghNrwaFPQzVDNxRqZLogVKXTiwW
         Y4jJDfwhlmY/u49lFcCTTYZBPL/hRAHcFlkBH8PbQggBDrdNMWJlS3WReudOGsZqBvXi
         VGKEdHcSrGjaCY5n1rB/T6Ss1+Z0dSckoiznbUjRjq2arGRBu36L94egkHob+xCpAkb6
         +v6clQ2yPiT4pR8X8xudo18PSeClNWJPSmRTtgU/7KiD4wUcgA1ksU+ID631974frMQc
         kB90hNKXS36eHTRqOvVjvuQXYIUe1LVPouVyg2qF/UdbnjDCUVyi040ZoXaoEc1Rwmrj
         vBOg==
X-Gm-Message-State: APjAAAXsug56f8Cqkft9N/o8Cb8utRKEkqGgaV3eJFmKnPcC3gBPs1zM
        EzjKSyXwB26RonGp/j+8gmq++e6ND5kDq7iD3OMptQ==
X-Google-Smtp-Source: APXvYqwOX3CGPujd+JjSY3EvnESuyJ5Q4Qafk9MdblQnnLqfhLbk3VO/E2daFgcNkF9AwjCU/W7aeyWSEaHO41o7Nm0=
X-Received: by 2002:ab0:210f:: with SMTP id d15mr5814755ual.129.1567812515651;
 Fri, 06 Sep 2019 16:28:35 -0700 (PDT)
MIME-Version: 1.0
From:   Theodore Dubois <tbodt@google.com>
Date:   Fri, 6 Sep 2019 16:28:24 -0700
Message-ID: <CAN3rvwA+Dnqj4O79f6rNfO50VjbAC3YwJ7CW2ze2aBLzkSJRgQ@mail.gmail.com>
Subject: perf_event wakeup_events = 0
To:     a.p.zijlstra@chello.nl
Cc:     linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The man page for perf_event_open(2) says that recent kernels treat a 0
value for wakeup_events the same as 1, which I believe means it will
notify after a single sample. However, strace on perf(1) shows that it
uses wakeup_events=0, and it's definitely not waking up on every
sample (it seems to be waking up every few seconds.)
tools/perf/design.txt says "Normally a notification is generated for
every page filled". Is the documentation wrong, or am I
misunderstanding something?

~Theodore
