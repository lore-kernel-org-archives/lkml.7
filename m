Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1315C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E6B2070A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLCLgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:36:00 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45107 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCLf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:35:59 -0500
Received: by mail-pg1-f180.google.com with SMTP id k1so1553535pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 03:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gP/z6K4jCHvYsAcghHiZTSQpx8ZK1mQxXi1pu5kEz0U=;
        b=RDAfRIsyh20symVpYcfjszvrbKlS8PPd4Q9q2/1wpP+xYm1/YZckDEr+Jr/Fjrajic
         NncSr4g7BCJQNGvPcFHn5ZvAEzncYSpgR2UpGn1vHgqUGSnYFJgOveqNf2QrRXPECf4g
         6DH3pq6geedpukFlCCQ0JDsuZA41PiW2W4qpT1s4EyqaO0Wgi1kixCu4aN1yQ3CpprYH
         ciSLcP1vGk9qi7zKq5yyE+O20XfwAye8HHWBZ2F85nqlzX2jgrLeVv+ahkVMmwPehypb
         bU1sqF3Dngwx6B1EhjKQKXW5kyZuSYDcNE5T9FihtdIqdH6R+dl+piihcv/RWA9yygCe
         xA7Q==
X-Gm-Message-State: APjAAAVT1846p9x3QUjNyoRDmD35raOBfEkLSQfPY/GPl8DPgvL67Tj4
        Pebx+VQhodAFwwIfjgIvJagWtdz7l6UNBYbc
X-Google-Smtp-Source: APXvYqy0DZW0ahex5whkLwAz+voaRa+spEZOkzTwHvMlk7cei7yOsph/4PKQpwcVbHsOjL5ByHj0qA==
X-Received: by 2002:a63:5725:: with SMTP id l37mr5052299pgb.247.1575372958716;
        Tue, 03 Dec 2019 03:35:58 -0800 (PST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id x2sm3263474pgc.67.2019.12.03.03.35.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 03:35:58 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id g4so1409355pjs.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 03:35:58 -0800 (PST)
X-Received: by 2002:a17:90b:244:: with SMTP id fz4mr5081153pjb.27.1575372958142;
 Tue, 03 Dec 2019 03:35:58 -0800 (PST)
MIME-Version: 1.0
From:   Angel Shtilianov <kernel@kyup.com>
Date:   Tue, 3 Dec 2019 13:35:47 +0200
X-Gmail-Original-Message-ID: <CAJM9R-JLiqRKcmyHh9ad8fJmqxo=E_Hf9soCEiLMniDpG5uK3Q@mail.gmail.com>
Message-ID: <CAJM9R-JLiqRKcmyHh9ad8fJmqxo=E_Hf9soCEiLMniDpG5uK3Q@mail.gmail.com>
Subject: Double fault crash on Linux-5.1.21
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
I have a very strange crash with kernel 5.1.21
This has happened several times with kernel 5.x, but this time I have
collected a usable crash dump.
The process in question seems to be dying - in its task_struct it has set:
  exit_signal = 17,
  pdeath_signal = 0,
Any ideas how to debug it are highly appreciated. Please, help.
Here is the complete crash backtrace:
https://pastebin.com/FF3rn1CZ

--
Best regards,
Angel Shtilianov
