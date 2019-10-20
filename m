Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53ACA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D290721928
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 21:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJUGRtmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfJTVUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 17:20:51 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:46407 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfJTVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 17:20:50 -0400
Received: by mail-qk1-f179.google.com with SMTP id e66so10483632qkf.13;
        Sun, 20 Oct 2019 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0cfeEk/rZCT/lWAV5tNuz4UT5CqAr3iTPpAyuFztMlo=;
        b=FJUGRtmZd+s3X1DEKVkSTKA9n+Ba2Iygdz8f8q3iyZnuDtEyJIzYuagk2mBJuixWuO
         gDtxHS3l9aLQN+26q3xJXWPKeY5Cu2OHqS+kriv9ya7Sc0HbJtTpmTgq4VXSfbeqMXTH
         zZpfe1nDSDIjs/0DGa93Y4bpZXZdd604OQBgsQQnZV+5h6YM50GnWVqDp5q9XRDy2Fud
         hdkWDUrBKikFtANXnMTL+2hHG1o0ogBYlw2wfJNWYP1H2CHtk9eN9rXeTQ1J+RvGUNK1
         hJEgpERdWLqs9V6IbXy/St0JIWv27jMWmB0D8uR8l1ajE4/QJ5+B7o/hv/EACb7FzeWQ
         Sa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0cfeEk/rZCT/lWAV5tNuz4UT5CqAr3iTPpAyuFztMlo=;
        b=DZbKW98JzvIbdRoI3aaGYaqt9XZF+5ZYA7Igq11E57RsL2SEx6gidekHUO4l+XvmCa
         IqZKUg37mPWgOd8tmSgPYaNnUsL/egGxfyWw2ikV6eMeac50002QJgdZzdXK3fZdizh3
         3qsIuPLGI2DVMt2pJQ8lMTwng4Pi62Uju2gF9KM8Wb8nQwWVv+AZTONa6Q2qHsEjI/SC
         1UOLJoVGmItoB3LzROV1mCu+WAxZTddb/F7TS5W0OSj91s4keb6y2q6W0SR4bmzBKuYl
         Yn6xwi+kXNq2ecLpbsyXn8NrIsvARGePXGwPQfn75MmQL84HQabl7mCXnNO5G+4KCnuR
         Jx0g==
X-Gm-Message-State: APjAAAXTP/DBexWCgExvFlqjiHs4+fS/tl4PAzCTvfS/uUebrjzTJefp
        WJSPTb+AAzEWx23n0YhxqUx9utQ+Vi8=
X-Google-Smtp-Source: APXvYqzysfmBWWsbW26FD9DjTCHGl2oUsfHeobv4rY74O5Wo6+KpkhL3puPiWdtE3xSg5Vzjbn636Q==
X-Received: by 2002:a05:620a:952:: with SMTP id w18mr19659837qkw.165.1571606447845;
        Sun, 20 Oct 2019 14:20:47 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t127sm5856896qkf.43.2019.10.20.14.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 14:20:47 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 20 Oct 2019 17:20:45 -0400
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Audioengine D1 sampling rate get issue
Message-ID: <20191020212045.GA2458076@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, there seems to be a bug in my Audioengine D1's (0x2912:0x30c8) firmware.

When setting sampling rate, the kernel produces these warning messages:
[168840.944226] usb 3-2.2: current rate 4500480 is different from the runtime rate 44100
[168854.930414] usb 3-2.2: current rate 8436480 is different from the runtime rate 48000
[168905.185825] usb 3-2.1.2: current rate 30465 is different from the runtime rate 96000

This comes from set_sample_rate_v1 in sound/usb/clock.c, which reads out
the rate after setting it to check if it worked.

This device appears to return the sampling rate in big-endian format
instead of the USB spec's little-endian.

i.e.,
44100 == 0x00ac44, 4500480 == 0x44ac00
48000 == 0x00bb80, 8436480 == 0x80bb00
96000 == 0x017700,   30465 == 0x007701

It doesn't seem to cause any actual issues, but the messages are
annoying, and I'm wondering if others have seen this, or is it's
specific to my device's revision or something, and if it should be added
to snd_usb_get_sample_rate_quirk.
