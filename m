Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3411C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C446D20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfDQH4m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:56:42 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58906 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731041AbfDQH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:56:41 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x3H7uf2M007492
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 03:56:41 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x3H7uZal006486
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 03:56:41 -0400
Received: by mail-qk1-f197.google.com with SMTP id a188so20194161qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=XRal/KDUMxotBEJcVsOP5tkbeKLtAGY+Cmt6EWYQpMM=;
        b=jbz731YqMsZjunrs3nxcXYyIPuWij+QN7J6OLvurUwJQ/PmmWzxTRS6hbLfTmBo0/w
         3TugCpdNpjyDO31oan4n5I1e8iUjuN9HahpWI4jVAR6G0GszNgeIzVy5qz6Lyz+ATkX6
         GxcdedRdCP4F/ss/X/XdOHclPdoCgW8xJranTY9vdGPyj3ZcyvTiKh2HFR8XyaJQhaJB
         79O0rPnF1xUAfJ+9EeRNeBJWz+QWtLewHdcgy9+vh9KOu7vaDyEw5H3xQoQuiHd6UYYt
         TlqYGN6TsVwjcI43BHjNwTvpiEPCXzDIiQdo/mwbzOI6p2uOBsK+WetZjuNzmmn+o9Vq
         5vdg==
X-Gm-Message-State: APjAAAVt6UJAlJvyn00PSg2ulX1LxuWMc1z52n2M+oeYIZQIIEP4ga3I
        Yv72fp2icvZJPTJO8ziAypLaIAVvl4ViTtnkX1VcBDEItLRvtEDaWgHGHeWt1sh8hq8kacSAhM3
        3WmLKMkMaLnSm73+vXaapY/MUUPBHePufjVQ=
X-Received: by 2002:a0c:897b:: with SMTP id 56mr69182567qvq.55.1555487795564;
        Wed, 17 Apr 2019 00:56:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3ecN7jlhMZcM6t9DP1Pb6KVPvEg1Z5z9gv4RNYB7Cf+vCWGvu0HZ0lbB759a1mHlUIjeVrA==
X-Received: by 2002:a0c:897b:: with SMTP id 56mr69182550qvq.55.1555487795257;
        Wed, 17 Apr 2019 00:56:35 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::1a7])
        by smtp.gmail.com with ESMTPSA id y34sm35037616qta.96.2019.04.17.00.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 00:56:34 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     =?utf-8?Q?=421=430=448=430?=
         =?utf-8?Q?_=41A=43E=432=442=443=43D=435=43D=43A=43E?= 
        <alexander198961@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
cc:     kernelnewbies@kernelnewbies.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Need advice about do we need this if condition
In-reply-to: <CANtEx+B4_-7Kfq6Gur1xHcXnTYRq8ZN=Qqs2X=h-ZJuFFF7LbQ@mail.gmail.com>
References: <CANtEx+B4_-7Kfq6Gur1xHcXnTYRq8ZN=Qqs2X=h-ZJuFFF7LbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Wed, 17 Apr 2019 03:56:33 -0400
Message-ID: <19402.1555487793@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 08:25:22 +0300

(Adding Al Viro and the linux-fsdevel lists, as at the very least, the manpage
for the syscall needs some clarification...)

> hello I am trying to fix https://bugzilla.kernel.org/show_bug.cgi?id=202935

So - convince us that it's in fact a "bug" and not a restriction.

> I found cause
> https://github.com/torvalds/linux/blob/master/fs/cifs/cifsfs.c#L1076 not
> sure is it correct to remove such condition ?

Does the CIFS protocol support copying from a file to another location in the
same file? Was it intended to work on *any* filesystem?

(For that matter, the manpage for the syscall is unclear on whether having both
file descriptors open on the same file is OK or not - for bonus ambiguity
points, there's exactly zero discussion of what happens if source and
destination overlap destructively).

